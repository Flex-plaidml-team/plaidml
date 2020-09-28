// Copyright 2020, Intel Corporation
#include "pmlc/conversion/vulkan_to_llvm/passes.h"

#include "mlir/Dialect/GPU/GPUDialect.h"
#include "mlir/Dialect/LLVMIR/LLVMDialect.h"
#include "mlir/Dialect/SPIRV/SPIRVOps.h"
#include "mlir/Dialect/SPIRV/Serialization.h"
#include "mlir/Dialect/StandardOps/IR/Ops.h"
#include "mlir/IR/PatternMatch.h"
#include "mlir/Support/LogicalResult.h"
#include "mlir/Transforms/DialectConversion.h"

#include "pmlc/conversion/comp_to_llvm/pass_detail.h"
#include "pmlc/conversion/comp_to_llvm/utils.h"
#include "pmlc/dialect/comp/ir/dialect.h"

namespace pmlc::conversion::vulkan_to_llvm {

namespace vulkan = pmlc::dialect::vulkan;
namespace gpu = mlir::gpu;
namespace LLVM = mlir::LLVM;
namespace spirv = mlir::spirv;

using mlir::ArrayRef;
using mlir::CallOp;
using mlir::failure;
using mlir::FuncOp;
using mlir::FunctionType;
using mlir::Location;
using mlir::LogicalResult;
using mlir::MemRefType;
using mlir::ModuleOp;
using mlir::OpBuilder;
using mlir::SmallString;
using mlir::SmallVector;
using mlir::StringRef;
using mlir::success;
using mlir::Type;
using mlir::UnrankedMemRefType;
using mlir::Value;

static constexpr const char *kSPIRVBinary = "SPIRV_BIN";
static constexpr const char *kPrint_memref_f32 = "print_memref_f32";
static constexpr const char *kInitVulkan = "initVulkan";
static constexpr const char *kDeinitVulkan = "deinitVulkan";
static constexpr const char *kSubmitCommandBuffers = "submitCommandBuffers";
static constexpr const char *kCreateVulkanLaunchKernelAction =
    "createVulkanLaunchKernelAction";
static constexpr const char *kSetVulkanLaunchKernelAction =
    "setVulkanLaunchKernelAction";
static constexpr const char *kCreateVulkanMemoryTransferAction =
    "createVulkanMemoryTransferAction";
static constexpr const char *kAddVulkanLaunchActionToSchedule =
    "addVulkanLaunchActionToSchedule";

static constexpr const char *kBindBufferBFloat16 = "bindBufferBFloat16";
static constexpr const char *kBindBufferFloat16 = "bindBufferFloat16";
static constexpr const char *kBindBufferFloat32 = "bindBufferFloat32";
static constexpr const char *kBindBufferFloat64 = "bindBufferFloat64";

// These functions are signless, meaning they apply to both signed and unsigned
// integers
static constexpr const char *kBindBufferInteger8 = "bindBufferInteger8";
static constexpr const char *kBindBufferInteger16 = "bindBufferInteger16";
static constexpr const char *kBindBufferInteger32 = "bindBufferInteger32";
static constexpr const char *kBindBufferInteger64 = "bindBufferInteger64";

static constexpr const int kByteBits = 8;

namespace {

class ConvertVulkanTollvm
    : public ConvertVulkanTollvmBase<ConvertVulkanTollvm> {
public:
  void runOnOperation();
};

void ConvertVulkanTollvm::runOnOperation() {
  mlir::ModuleOp module = getOperation();
  // Serialize SPIRV kernels.
  BinaryModulesMap modulesMap;
  if (mlir::failed(serializeSpirvKernels(module, modulesMap)))
    return signalPassFailure();
  // Populate conversion patterns.
  mlir::MLIRContext *context = &getContext();
  mlir::TypeConverter typeConverter;
  mlir::OwningRewritePatternList patterns;
  populateCommonPatterns(context, typeConverter);
  populateCompToOclPatterns(context, modulesMap, typeConverter, patterns);
  // Set conversion target.
  mlir::ConversionTarget target(*context);
  target.addLegalDialect<LLVM::LLVMDialect>();
  target.addLegalDialect<mlir::StandardOpsDialect>();
  target.addIllegalDialect<comp::COMPDialect>();
  if (mlir::failed(mlir::applyPartialConversion(module, target, patterns)))
    signalPassFailure();
  // Insert runtime function declarations.
  addCommonFunctionDeclarations(module);
  addOclFunctionDeclarations(module);
}

/// A pass to convert gpu launch op to vulkan launch call op, by creating a
/// SPIR-V binary shader from `spirv::ModuleOp` using `spirv::serialize`
/// function and attaching binary data and entry point name as an attributes to
/// created vulkan launch call op.
template <typename Op>
class ConvertVulkanOpBasePattern : ::mlir::OpConversionPattern<Op> {
public:
  ConvertVulkanOpBasePattern(mlir::MLIRContext *context)
      : ::mlir::OpConversionPattern<Op>(context) {}

private:
  /// Creates a SPIR-V binary shader from the given `module` using
  /// `spirv::serialize` function.
  LogicalResult createBinaryShader(ModuleOp module,
                                   std::vector<char> &binaryShader);

  /// Creates a LLVM global for the given `name`.
  Value createEntryPointNameConstant(StringRef name, uint64_t lauchFuncIndex,
                                     Location loc, OpBuilder &builder);

  /// bind gpu.launchOp buffers to Vulkan runtime.
  LogicalResult bindBuffers(Location loc, OpBuilder &builder,
                            gpu::LaunchFuncOp launchOp);

  /// Check and transfer VkBuffers when necessary.
  LogicalResult transferBuffers(Location loc, OpBuilder &builder,
                                gpu::LaunchFuncOp launchOp);

  /// Declares all needed runtime functions.
  void declareVulkanFunctions(Location loc);

  void getCachedTypes() {
    llvmVoidType = LLVM::LLVMType::getVoidTy(&getContext());
    llvmPointerType = LLVM::LLVMType::getInt8PtrTy(&getContext());
    llvmInt32Type = LLVM::LLVMType::getInt32Ty(&getContext());
    llvmInt64Type = LLVM::LLVMType::getInt64Ty(&getContext());

    OpBuilder builder(getOperation());
    mlirIndexType = builder.getIndexType();
    mlirFloat32Type = builder.getF32Type();
  }

  mlir::Type getUnrankedMemRefType(Type elementType) {
    return UnrankedMemRefType::get(elementType, /*memorySpace=*/0);
  }

  const char *getBufferBindingFunc(Type elementType) {
    if (elementType.isInteger(8)) {
      return kBindBufferInteger8;
    }
    if (elementType.isInteger(16)) {
      return kBindBufferInteger16;
    }
    if (elementType.isInteger(32)) {
      return kBindBufferInteger32;
    }
    if (elementType.isInteger(64)) {
      return kBindBufferInteger64;
    }
    if (elementType.isBF16()) {
      return kBindBufferBFloat16;
    }
    if (elementType.isF16()) {
      return kBindBufferFloat16;
    }
    if (elementType.isF32()) {
      return kBindBufferFloat32;
    }
    if (elementType.isF64()) {
      return kBindBufferFloat64;
    }
    return nullptr;
  }

  LLVM::LLVMType getLLVMVoidType() { return llvmVoidType; }
  LLVM::LLVMType getLLVMPointerType() { return llvmPointerType; }
  LLVM::LLVMType getLLVMInt32Type() { return llvmInt32Type; }
  LLVM::LLVMType getLLVMInt64Type() { return llvmInt64Type; }

  mlir::Type getMLIRFloat32Type() { return mlirFloat32Type; }
  mlir::Type getMLIRIndexType() { return mlirIndexType; }

  LLVM::LLVMType llvmVoidType;
  LLVM::LLVMType llvmPointerType;
  LLVM::LLVMType llvmInt32Type;
  LLVM::LLVMType llvmInt64Type;

  mlir::Type mlirFloat32Type;
  mlir::Type mlirIndexType;

  uint64_t numKernel = 0;
  uint64_t lauchFuncIndex = 0;
  mlir::Value vulkanRuntime;
  llvm::DenseMap<Value, llvm::SmallVector<uint64_t, 2>> bufferMap;

  struct mlirTypeComparator {
    bool operator()(mlir::Type x, mlir::Type y) const {
      return x.getTypeID().getAsOpaquePointer() >
             y.getTypeID().getAsOpaquePointer();
    }
  };

  llvm::SmallSet<mlir::Type, 4, mlirTypeComparator> bufferElementTypes;
  llvm::SmallSet<const char *, 4> optionalSymbols;
};

LogicalResult ConvertVulkanOpBasePattern::createBinaryShader(
    ModuleOp module, std::vector<char> &binaryShader) {
  SmallVector<uint32_t, 0> binary;
  uint64_t shader_index = 0;
  for (auto spirvModule : module.getOps<spirv::ModuleOp>()) {
    if (shader_index == lauchFuncIndex) {
      if (failed(spirv::serialize(spirvModule, binary))) {
        return failure();
      }
    }
    shader_index++;
  }
  binaryShader.resize(binary.size() * sizeof(uint32_t));
  std::memcpy(binaryShader.data(), reinterpret_cast<char *>(binary.data()),
              binaryShader.size());
  return success();
}

Value ConvertVulkanOpBasePattern::createEntryPointNameConstant(
    StringRef name, uint64_t lauchFuncIndex, Location loc, OpBuilder &builder) {
  SmallString<16> shaderName(name.begin(), name.end());
  // Append `\0` to follow C style string given that
  // LLVM::createGlobalString() won't handle this directly for us.
  shaderName.push_back('\0');

  std::string entryPointGlobalName =
      (name + "_spv_entry_point_name" + std::to_string(lauchFuncIndex)).str();
  return LLVM::createGlobalString(loc, builder, entryPointGlobalName,
                                  shaderName, LLVM::Linkage::Internal);
}

LogicalResult
ConvertVulkanOpBasePattern::bindBuffers(Location loc, OpBuilder &builder,
                                        gpu::LaunchFuncOp launchOp) {
  auto buffers = launchOp.operands();
  // Create LLVM constant for the descriptor set index.
  // Bind all memrefs to the `0` descriptor set, the same way as `GPUToSPIRV`
  // pass does.
  Value descriptorSet = builder.create<LLVM::ConstantOp>(
      loc, getLLVMInt32Type(), builder.getI32IntegerAttr(0));

  for (uint32_t bindIndex = 0; bindIndex < buffers.size(); bindIndex++) {
    auto buffer = buffers[bindIndex];
    // Create LLVM constant for the descriptor binding index.
    Value descriptorBinding = builder.create<LLVM::ConstantOp>(
        loc, getLLVMInt32Type(), builder.getI32IntegerAttr(bindIndex));
    if (auto memRefType = buffer.getType().dyn_cast_or_null<MemRefType>()) {
      auto shape = memRefType.getShape();
      uint32_t numElement = 1;
      for (auto dim : shape) {
        numElement *= dim;
      }

      auto elementType = memRefType.getElementType();
      bufferElementTypes.insert(elementType);
      uint32_t elementTypeSize =
          llvm::divideCeil(elementType.getIntOrFloatBitWidth(), kByteBits);

      Value bufferByteSize = builder.create<LLVM::ConstantOp>(
          loc, getLLVMInt32Type(),
          builder.getI32IntegerAttr(numElement * elementTypeSize));
      Value unrankedBuffer = builder.create<mlir::MemRefCastOp>(
          loc, buffer, getUnrankedMemRefType(elementType));
      builder.create<CallOp>(
          loc, ArrayRef<Type>{},
          builder.getSymbolRefAttr(getBufferBindingFunc(elementType)),
          ArrayRef<Value>{vulkanRuntime, descriptorSet, descriptorBinding,
                          bufferByteSize, unrankedBuffer});
      optionalSymbols.insert(getBufferBindingFunc(elementType));
    } else {
      return failure();
    }
  }
  return success();
}

LogicalResult
ConvertVulkanOpBasePattern::transferBuffers(Location loc, OpBuilder &builder,
                                            gpu::LaunchFuncOp launchOp) {
  auto buffers = launchOp.operands();
  for (size_t i = 0; i < buffers.size(); i++) {
    for (auto pair : bufferMap) {
      if (pair.first == buffers[i]) {
        Value dst_index = builder.create<LLVM::ConstantOp>(
            loc, getLLVMInt64Type(), builder.getI64IntegerAttr(lauchFuncIndex));
        Value dst_binding = builder.create<LLVM::ConstantOp>(
            loc, getLLVMInt64Type(), builder.getI64IntegerAttr(i));
        Value src_index = builder.create<LLVM::ConstantOp>(
            loc, getLLVMInt64Type(), builder.getI64IntegerAttr(pair.second[0]));
        Value src_binding = builder.create<LLVM::ConstantOp>(
            loc, getLLVMInt64Type(), builder.getI64IntegerAttr(pair.second[1]));

        builder.create<LLVM::CallOp>(
            loc, ArrayRef<Type>{},
            builder.getSymbolRefAttr(kCreateVulkanMemoryTransferAction),
            ArrayRef<Value>{vulkanRuntime, src_index, src_binding, dst_index,
                            dst_binding});
        optionalSymbols.insert(kCreateVulkanMemoryTransferAction);
      }
    }
    llvm::SmallVector<uint64_t, 2> second;
    second.append({lauchFuncIndex, i});
    bufferMap[buffers[i]] = second;
  }
  return success();
}

void ConvertVulkanOpBasePattern::declareVulkanFunctions(Location loc) {
  auto &ctx = getContext();
  ModuleOp module = getOperation();
  OpBuilder builder(module.getBody()->getTerminator());

  builder.create<LLVM::LLVMFuncOp>(
      loc, kInitVulkan,
      LLVM::LLVMType::getFunctionTy(getLLVMPointerType(), {},
                                    /*isVarArg=*/false));

  builder.create<FuncOp>(
      loc, kCreateVulkanLaunchKernelAction,
      FunctionType::get(
          {ArrayRef<Type>{getLLVMPointerType(), getLLVMPointerType(),
                          getLLVMInt32Type(), getLLVMPointerType(),
                          getMLIRIndexType(), getMLIRIndexType(),
                          getMLIRIndexType()}},
          {}, &ctx),
      ArrayRef<std::pair<mlir::Identifier, mlir::Attribute>>());

  builder.create<LLVM::LLVMFuncOp>(
      loc, kSetVulkanLaunchKernelAction,
      LLVM::LLVMType::getFunctionTy(getLLVMVoidType(),
                                    {getLLVMPointerType(), getLLVMInt32Type()},
                                    /*isVarArg=*/false));

  builder.create<LLVM::LLVMFuncOp>(
      loc, kAddVulkanLaunchActionToSchedule,
      LLVM::LLVMType::getFunctionTy(getLLVMVoidType(), {getLLVMPointerType()},
                                    /*isVarArg=*/false));

  builder.create<LLVM::LLVMFuncOp>(
      loc, kSubmitCommandBuffers,
      LLVM::LLVMType::getFunctionTy(getLLVMVoidType(), {getLLVMPointerType()},
                                    /*isVarArg=*/false));

  builder.create<LLVM::LLVMFuncOp>(
      loc, kDeinitVulkan,
      LLVM::LLVMType::getFunctionTy(getLLVMVoidType(), {getLLVMPointerType()},
                                    /*isVarArg=*/false));

  if (optionalSymbols.count(kPrint_memref_f32)) {
    builder.create<FuncOp>(
        loc, kPrint_memref_f32,
        FunctionType::get(
            {ArrayRef<Type>{getUnrankedMemRefType(getMLIRFloat32Type())}}, {},
            &ctx),
        ArrayRef<std::pair<mlir::Identifier, mlir::Attribute>>());
  }

  if (optionalSymbols.count(kCreateVulkanMemoryTransferAction)) {
    builder.create<LLVM::LLVMFuncOp>(
        loc, kCreateVulkanMemoryTransferAction,
        LLVM::LLVMType::getFunctionTy(getLLVMVoidType(),
                                      {getLLVMPointerType(), getLLVMInt64Type(),
                                       getLLVMInt64Type(), getLLVMInt64Type(),
                                       getLLVMInt64Type()},
                                      /*isVarArg=*/false));
  }

  for (auto bufferElementType : bufferElementTypes) {
    auto func = getBufferBindingFunc(bufferElementType);
    if (optionalSymbols.count(func)) {
      builder.create<FuncOp>(
          loc, func,
          FunctionType::get(
              {ArrayRef<Type>{getLLVMPointerType(), getLLVMInt32Type(),
                              getLLVMInt32Type(), getLLVMInt32Type(),
                              getUnrankedMemRefType(bufferElementType)}},
              {}, &ctx),
          ArrayRef<std::pair<mlir::Identifier, mlir::Attribute>>());
    }
  }
}

//template <class Op>
//struct ConvertToFuncCallPattern : ConvertCompToOclBasePattern<Op> {
//  ConvertToFuncCallPattern(mlir::StringRef funcName,
//                           mlir::TypeConverter &typeConverter,
//                           mlir::MLIRContext *context, bool varArg = false,
//                           unsigned nonVarArgs = 0)
//      : ConvertCompToOclBasePattern<Op>(typeConverter, context),
//        funcName(funcName), varArg(varArg), nonVarArgs(nonVarArgs) {}
//
//  mlir::LogicalResult
//  matchAndRewrite(Op op, mlir::ArrayRef<mlir::Value> operands,
//                  mlir::ConversionPatternRewriter &rewriter) const override;
//
//  mlir::StringRef funcName;
//  bool varArg;
//  unsigned nonVarArgs;
//};
//
//using ConvertCreateExecEnv = ConvertToFuncCallPattern<comp::CreateExecEnv>;
//using ConvertDestroyExecEnv = ConvertToFuncCallPattern<comp::DestroyExecEnv>;
//using ConvertDealloc = ConvertToFuncCallPattern<comp::Dealloc>;
//using ConvertScheduleBarrier = ConvertToFuncCallPattern<comp::ScheduleBarrier>;
//using ConvertSubmit = ConvertToFuncCallPattern<comp::Submit>;
//using ConvertWait = ConvertToFuncCallPattern<comp::Wait>;
//
///// Template pattern common for both comp::ScheduleRead and
///// comp::ScheduleWrite.
//template <class Op>
//struct ConvertScheduleReadWrite : ConvertCompToOclBasePattern<Op> {
//  ConvertScheduleReadWrite(mlir::StringRef funcName,
//                           mlir::TypeConverter &typeConverter,
//                           mlir::MLIRContext *context)
//      : ConvertCompToOclBasePattern<Op>(typeConverter, context),
//        funcName(funcName) {}
//
//  mlir::LogicalResult
//  matchAndRewrite(Op op, mlir::ArrayRef<mlir::Value> operands,
//                  mlir::ConversionPatternRewriter &rewriter) const override;
//
//  mlir::StringRef funcName;
//};
//
//using ConvertScheduleRead = ConvertScheduleReadWrite<comp::ScheduleRead>;
//using ConvertScheduleWrite = ConvertScheduleReadWrite<comp::ScheduleWrite>;
//
//struct ConvertAlloc : ConvertCompToOclBasePattern<comp::Alloc> {
//  using ConvertCompToOclBasePattern<comp::Alloc>::ConvertCompToOclBasePattern;
//
//  mlir::LogicalResult
//  matchAndRewrite(comp::Alloc op, mlir::ArrayRef<mlir::Value> operands,
//                  mlir::ConversionPatternRewriter &rewriter) const override;
//};
//
//struct ConvertScheduleFunc : ConvertCompToOclBasePattern<comp::ScheduleFunc> {
//  ConvertScheduleFunc(const BinaryModulesMap &modulesMap,
//                      mlir::TypeConverter &typeConverter,
//                      mlir::MLIRContext *context)
//      : ConvertCompToOclBasePattern<comp::ScheduleFunc>(typeConverter, context),
//        modulesMap(modulesMap) {}
//
//  mlir::LogicalResult
//  matchAndRewrite(comp::ScheduleFunc op, mlir::ArrayRef<mlir::Value> operands,
//                  mlir::ConversionPatternRewriter &rewriter) const override;
//
//  const BinaryModulesMap &modulesMap;
//};

struct ConvertInitVulkanCall
    : ConvertVulkanOpBasePattern<vulkan::InitVulkanCall> {
  ConvertInitVulkanCall(mlir::MLIRContext *context)
      : ConvertVulkanOpBasePattern<vulkan::InitVulkanCall>(context) {}
  mlir::LogicalResult
  matchAndRewrite(vulkan::InitVulkanCall op,
                  mlir::ArrayRef<mlir::Value> operands,
                  mlir::ConversionPatternRewriter &rewriter) const override {
    Location loc = launchOp.getLoc();
    rewriter.replaceOpWithNewOp<LLVM::CallOp>(
        loc, ArrayRef<Type>{getLLVMPointerType()},
        rewriter.getSymbolRefAttr(kInitVulkan), ArrayRef<Value>{});
    vulkanRuntime = initVulkanCall.getResult(0);
    return mlir::success();
  }
};

} // namespace

void populateVulkanToPatterns(mlir::MLIRContext *context,
//                              const BinaryModulesMap &modulesMap,
//                              mlir::TypeConverter &typeConverter,
                              mlir::OwningRewritePatternList &patterns) {
  // Populate operation conversion patterns.
  patterns.insert<ConvertInitVulkanCall>(kInitVulkan, context);
//  patterns.insert<ConvertSubmitCommandBuffers>(kOclDestroy, typeConverter,
//                                               context);
//  patterns.insert<ConvertDeinitVulkan>(kOclDealloc, typeConverter, context);
  //  patterns.insert<ConvertScheduleBarrier>(kOclBarrier, typeConverter,
  //  context,
  //                                          /*varArg=*/true,
  //                                          /*nonVarArgs=*/1);
  //  patterns.insert<ConvertSubmit>(kOclSubmit, typeConverter, context);
  //  patterns.insert<ConvertWait>(kOclWait, typeConverter, context,
  //                               /*varArg=*/true, /*nonVarArgs=*/0);
  //
  //  patterns.insert<ConvertScheduleRead>(kOclRead, typeConverter, context);
  //  patterns.insert<ConvertScheduleWrite>(kOclWrite, typeConverter, context);
  //
  //  patterns.insert<ConvertAlloc>(typeConverter, context);
  //  patterns.insert<ConvertScheduleFunc>(modulesMap, typeConverter, context);
}

//void addOclFunctionDeclarations(mlir::ModuleOp &module) {
//  mlir::Location loc = module.getLoc();
//  mlir::OpBuilder builder(module.getBody()->getTerminator());
//  mlir::MLIRContext *context = builder.getContext();
//  LLVM::LLVMType llvmInt8Ptr = LLVM::LLVMType::getInt8PtrTy(context);
//  LLVM::LLVMType llvmVoid = LLVM::LLVMType::getVoidTy(context);
//  LLVM::LLVMType llvmInt32 = LLVM::LLVMType::getInt32Ty(context);
//
//  if (!module.lookupSymbol(kOclCreate)) {
//    builder.create<LLVM::LLVMFuncOp>(
//        loc, kOclCreate,
//        LLVM::LLVMType::getFunctionTy(llvmInt8Ptr, {}, /*isVarArg=*/false));
//  }
//  if (!module.lookupSymbol(kOclDestroy)) {
//    builder.create<LLVM::LLVMFuncOp>(
//        loc, kOclDestroy,
//        LLVM::LLVMType::getFunctionTy(llvmVoid, {llvmInt8Ptr},
//                                      /*isVarArg=*/false));
//  }
//  if (!module.lookupSymbol(kOclAlloc)) {
//    builder.create<LLVM::LLVMFuncOp>(
//        loc, kOclAlloc,
//        LLVM::LLVMType::getFunctionTy(llvmInt8Ptr,
//                                      {llvmInt8Ptr, llvmInt32, llvmInt8Ptr},
//                                      /*isVarArg=*/false));
//  }
//  if (!module.lookupSymbol(kOclDealloc)) {
//    builder.create<LLVM::LLVMFuncOp>(
//        loc, kOclDealloc,
//        LLVM::LLVMType::getFunctionTy(llvmVoid, {llvmInt8Ptr, llvmInt8Ptr},
//                                      /*isVarArg=*/false));
//  }
//  if (!module.lookupSymbol(kOclRead)) {
//    builder.create<LLVM::LLVMFuncOp>(
//        loc, kOclRead,
//        LLVM::LLVMType::getFunctionTy(
//            llvmInt8Ptr, {llvmInt8Ptr, llvmInt8Ptr, llvmInt8Ptr, llvmInt32},
//            /*isVarArg=*/true));
//  }
//  if (!module.lookupSymbol(kOclWrite)) {
//    builder.create<LLVM::LLVMFuncOp>(
//        loc, kOclWrite,
//        LLVM::LLVMType::getFunctionTy(
//            llvmInt8Ptr, {llvmInt8Ptr, llvmInt8Ptr, llvmInt8Ptr, llvmInt32},
//            /*isVarArg=*/true));
//  }
//  if (!module.lookupSymbol(kOclCreateKernel)) {
//    builder.create<LLVM::LLVMFuncOp>(
//        loc, kOclCreateKernel,
//        LLVM::LLVMType::getFunctionTy(
//            llvmInt8Ptr, {llvmInt8Ptr, llvmInt8Ptr, llvmInt32, llvmInt8Ptr},
//            /*isVarArg=*/false));
//  }
//  if (!module.lookupSymbol(kOclSetKernelArg)) {
//    builder.create<LLVM::LLVMFuncOp>(
//        loc, kOclSetKernelArg,
//        LLVM::LLVMType::getFunctionTy(llvmVoid,
//                                      {llvmInt8Ptr, llvmInt32, llvmInt8Ptr},
//                                      /*isVarArg=*/false));
//  }
//  if (!module.lookupSymbol(kOclAddKernelDep)) {
//    builder.create<LLVM::LLVMFuncOp>(
//        loc, kOclAddKernelDep,
//        LLVM::LLVMType::getFunctionTy(llvmVoid, {llvmInt8Ptr, llvmInt8Ptr},
//                                      /*isVarArg=*/false));
//  }
//  if (!module.lookupSymbol(kOclScheduleFunc)) {
//    mlir::Type indexType = builder.getIndexType();
//    builder.create<mlir::FuncOp>(
//        loc, kOclScheduleFunc,
//        mlir::FunctionType::get({llvmInt8Ptr, llvmInt8Ptr, indexType, indexType,
//                                 indexType, indexType, indexType, indexType},
//                                {llvmInt8Ptr}, context));
//  }
//  if (!module.lookupSymbol(kOclBarrier)) {
//    builder.create<LLVM::LLVMFuncOp>(
//        loc, kOclBarrier,
//        LLVM::LLVMType::getFunctionTy(llvmInt8Ptr, {llvmInt8Ptr, llvmInt32},
//                                      /*isVarArg=*/true));
//  }
//  if (!module.lookupSymbol(kOclSubmit)) {
//    builder.create<LLVM::LLVMFuncOp>(
//        loc, kOclSubmit,
//        LLVM::LLVMType::getFunctionTy(llvmVoid, {llvmInt8Ptr},
//                                      /*isVarArg=*/false));
//  }
//  if (!module.lookupSymbol(kOclWait)) {
//    builder.create<LLVM::LLVMFuncOp>(
//        loc, kOclWait,
//        LLVM::LLVMType::getFunctionTy(llvmVoid, {llvmInt32},
//                                      /*isVarArg=*/true));
//  }
//}
//
//template <class Op>
//mlir::LogicalResult ConvertToFuncCallPattern<Op>::matchAndRewrite(
//    Op op, mlir::ArrayRef<mlir::Value> operands,
//    mlir::ConversionPatternRewriter &rewriter) const {
//  if (!this->isMatchingRuntime(op))
//    return mlir::failure();
//
//  mlir::SmallVector<mlir::Type, 1> convertedTypes;
//  for (mlir::Type prevType : op.getOperation()->getResultTypes()) {
//    convertedTypes.push_back(this->convertType(prevType));
//  }
//
//  if (!varArg) {
//    rewriter.replaceOpWithNewOp<LLVM::CallOp>(
//        op.getOperation(), convertedTypes, rewriter.getSymbolRefAttr(funcName),
//        operands);
//    return mlir::success();
//  }
//
//  mlir::SmallVector<mlir::Value, 1> newOperands(operands.begin(),
//                                                operands.begin() + nonVarArgs);
//  LLVM::LLVMType llvmInt32Ty =
//      LLVM::LLVMType::getInt32Ty(rewriter.getContext());
//  mlir::Value varArgsCnt = rewriter.create<LLVM::ConstantOp>(
//      op.getLoc(), llvmInt32Ty,
//      rewriter.getI32IntegerAttr(operands.size() - nonVarArgs));
//  newOperands.push_back(varArgsCnt);
//  newOperands.insert(newOperands.end(), operands.begin() + nonVarArgs,
//                     operands.end());
//
//  rewriter.replaceOpWithNewOp<LLVM::CallOp>(op.getOperation(), convertedTypes,
//                                            rewriter.getSymbolRefAttr(funcName),
//                                            newOperands);
//  return mlir::success();
//}
//
//template <class Op>
//mlir::LogicalResult ConvertScheduleReadWrite<Op>::matchAndRewrite(
//    Op op, mlir::ArrayRef<mlir::Value> operands,
//    mlir::ConversionPatternRewriter &rewriter) const {
//  if (!this->isMatchingRuntime(op))
//    return mlir::failure();
//
//  constexpr unsigned nonVarArgs = 3;
//  mlir::SmallVector<mlir::Value, nonVarArgs + 2> castOperands(
//      operands.begin(), operands.begin() + nonVarArgs);
//
//  // Convert host memref to pointer.
//  mlir::Value hostPtr =
//      this->materializeConversion(rewriter, op.getLoc(), operands[0]);
//  if (!hostPtr)
//    return mlir::failure();
//  castOperands[0] = hostPtr;
//
//  // Add event dependencies as variadic operands.
//  LLVM::LLVMType llvmInt32Ty =
//      LLVM::LLVMType::getInt32Ty(rewriter.getContext());
//  mlir::Value eventsCnt = rewriter.create<LLVM::ConstantOp>(
//      op.getLoc(), llvmInt32Ty,
//      rewriter.getI32IntegerAttr(operands.size() - nonVarArgs));
//  castOperands.push_back(eventsCnt);
//  castOperands.insert(castOperands.end(), operands.begin() + nonVarArgs,
//                      operands.end());
//
//  mlir::Type llvmEventType = this->convertType(op.getType());
//  rewriter.replaceOpWithNewOp<LLVM::CallOp>(
//      op.getOperation(), mlir::ArrayRef<mlir::Type>{llvmEventType},
//      rewriter.getSymbolRefAttr(funcName), castOperands);
//  return mlir::success();
//}
//
//mlir::LogicalResult
//ConvertAlloc::matchAndRewrite(comp::Alloc op,
//                              mlir::ArrayRef<mlir::Value> operands,
//                              mlir::ConversionPatternRewriter &rewriter) const {
//  if (!isMatchingRuntime(op))
//    return mlir::failure();
//
//  mlir::Location loc = op.getLoc();
//  mlir::MemRefType resultType = op.getType().cast<mlir::MemRefType>();
//
//  mlir::SmallVector<mlir::Value, 3> castOperands;
//  // Operand 0 - execution environment.
//  castOperands.push_back(operands[0]);
//  // Operand 1 - size of allocated memory in bytes.
//  auto shape = resultType.getShape();
//  uint32_t numElement = 1;
//  for (auto dim : shape)
//    numElement *= dim;
//  uint32_t elementTypeSize =
//      llvm::divideCeil(resultType.getElementTypeBitWidth(), 8);
//  mlir::Value bufferByteSize = rewriter.create<LLVM::ConstantOp>(
//      loc, LLVM::LLVMType::getInt32Ty(rewriter.getContext()),
//      rewriter.getI32IntegerAttr(numElement * elementTypeSize));
//  castOperands.push_back(bufferByteSize);
//  // Operand 2 - pointer to data on host or null.
//  if (operands.size() > 1) {
//    mlir::Value hostPtr = materializeConversion(rewriter, loc, operands[1]);
//    if (!hostPtr)
//      return mlir::failure();
//    castOperands.push_back(hostPtr);
//  } else {
//    LLVM::LLVMType llvmPointerType =
//        LLVM::LLVMType::getInt8PtrTy(rewriter.getContext());
//    mlir::Value nullPtr = rewriter.create<LLVM::NullOp>(loc, llvmPointerType);
//    castOperands.push_back(nullPtr);
//  }
//
//  mlir::Type llvmResultType = convertType(op.getType());
//  rewriter.replaceOpWithNewOp<LLVM::CallOp>(
//      op.getOperation(), mlir::ArrayRef<mlir::Type>{llvmResultType},
//      rewriter.getSymbolRefAttr(kOclAlloc), castOperands);
//  return mlir::success();
//}
//
//mlir::LogicalResult ConvertScheduleFunc::matchAndRewrite(
//    comp::ScheduleFunc op, mlir::ArrayRef<mlir::Value> operands,
//    mlir::ConversionPatternRewriter &rewriter) const {
//  if (!isMatchingRuntime(op))
//    return mlir::failure();
//
//  mlir::Location loc = op.getLoc();
//  auto launchOp = mlir::cast<gpu::LaunchFuncOp>(op.body().front().front());
//  std::string binaryName = launchOp.getKernelModuleName().str();
//  std::string kernelName = launchOp.getKernelName().str();
//  mlir::Type llvmEventType = convertType(op.getType());
//  LLVM::LLVMType llvmKernelType =
//      LLVM::LLVMType::getInt8PtrTy(rewriter.getContext());
//
//  // Create kernel from serialized binary.
//  if (modulesMap.count(binaryName) == 0)
//    return mlir::failure();
//  if (modulesMap.at(binaryName).kernelsNameMap.count(kernelName) == 0)
//    return mlir::failure();
//
//  mlir::Value binaryPtr, binaryBytes;
//  getPtrToBinaryModule(rewriter, loc, modulesMap.at(binaryName), binaryPtr,
//                       binaryBytes);
//  mlir::Value namePtr = getPtrToGlobalString(
//      rewriter, loc, modulesMap.at(binaryName).kernelsNameMap.at(kernelName));
//
//  auto createCall = rewriter.create<LLVM::CallOp>(
//      loc, mlir::ArrayRef<mlir::Type>(llvmKernelType),
//      rewriter.getSymbolRefAttr(kOclCreateKernel),
//      mlir::ArrayRef<mlir::Value>{operands[0], binaryPtr, binaryBytes,
//                                  namePtr});
//  mlir::Value kernel = createCall.getResult(0);
//
//  // Set kernel arguments.
//  for (unsigned argI = 0; argI < launchOp.getNumKernelOperands(); ++argI) {
//    mlir::Type llvmInt32Type =
//        LLVM::LLVMType::getInt32Ty(rewriter.getContext());
//    mlir::Value argIndex = rewriter.create<LLVM::ConstantOp>(
//        loc, llvmInt32Type, rewriter.getI32IntegerAttr(argI));
//    mlir::Value remappedArg =
//        rewriter.getRemappedValue(launchOp.getKernelOperand(argI));
//
//    rewriter.create<LLVM::CallOp>(
//        loc, mlir::ArrayRef<mlir::Type>{},
//        rewriter.getSymbolRefAttr(kOclSetKernelArg),
//        mlir::ArrayRef<mlir::Value>{kernel, argIndex, remappedArg});
//  }
//  // Set event dependencies. This is done with separate functions
//  // on kernel as opposed to variadic argument in final function,
//  // because dispatch sizes are index types prohibiting use of
//  // llvm function and variadic arguments.
//  for (mlir::Value event : operands.slice(1)) {
//    rewriter.create<LLVM::CallOp>(loc, mlir::ArrayRef<mlir::Type>{},
//                                  rewriter.getSymbolRefAttr(kOclAddKernelDep),
//                                  mlir::ArrayRef<mlir::Value>{kernel, event});
//  }
//
//  auto gridSize = launchOp.getGridSizeOperandValues();
//  auto blockSize = launchOp.getBlockSizeOperandValues();
//  // OpenCL takes as global work size number of blocks times block size,
//  // so multiplications are needed.
//  auto globalX = rewriter.create<mlir::MulIOp>(loc, gridSize.x, blockSize.x);
//  auto globalY = rewriter.create<mlir::MulIOp>(loc, gridSize.y, blockSize.y);
//  auto globalZ = rewriter.create<mlir::MulIOp>(loc, gridSize.z, blockSize.z);
//
//  mlir::SmallVector<mlir::Value, 8> scheduleArgs{
//      operands[0], kernel,      globalX,     globalY,
//      globalZ,     blockSize.x, blockSize.y, blockSize.z};
//  rewriter.replaceOpWithNewOp<mlir::CallOp>(
//      op.getOperation(), mlir::ArrayRef<mlir::Type>{llvmEventType},
//      rewriter.getSymbolRefAttr(kOclScheduleFunc), scheduleArgs);
//  return mlir::success();
//}

std::unique_ptr<mlir::Pass> createConvertVulkanTollvmPass() {
  return std::make_unique<ConvertVulkanTollvm>();
}

} // namespace pmlc::conversion::vulkan_to_llvm
