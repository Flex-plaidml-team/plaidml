// Copyright 2020, Intel Corporation
#include "pmlc/conversion/comp_to_vulkanCall/passes.h"

#include "mlir/Dialect/GPU/GPUDialect.h"
#include "mlir/Dialect/LLVMIR/LLVMDialect.h"
#include "mlir/Dialect/SPIRV/SPIRVOps.h"
#include "mlir/Dialect/SPIRV/Serialization.h"
#include "mlir/Dialect/StandardOps/IR/Ops.h"
#include "mlir/IR/Attributes.h"
#include "mlir/IR/Builders.h"
#include "mlir/IR/Function.h"
#include "mlir/IR/Matchers.h"
#include "mlir/IR/Module.h"
#include "mlir/IR/PatternMatch.h"
#include "mlir/IR/StandardTypes.h"
#include "mlir/Support/LogicalResult.h"
#include "mlir/Transforms/DialectConversion.h"

#include "pmlc/conversion/comp_to_vulkanCall/pass_detail.h"
#include "pmlc/conversion/comp_to_vulkanCall/utils.h"
#include "pmlc/dialect/comp/ir/dialect.h"

namespace pmlc::conversion::comp_to_vulkanCall {

namespace comp = pmlc::dialect::comp;
namespace gpu = mlir::gpu;
namespace LLVM = mlir::LLVM;
namespace spirv = mlir::spirv;

static constexpr const char *kInitVulkan = "initVulkan";
static constexpr const char *kDeinitVulkan = "deinitVulkan";
static constexpr const char *kRun = "run";
static constexpr const char *kCreateVulkanLaunchKernelAction =
    "createVulkanLaunchKernelAction";
static constexpr const char *kSetVulkanLaunchKernelAction =
    "setVulkanLaunchKernelAction";
static constexpr const char *kCreateVulkanMemoryTransferAction =
    "createVulkanMemoryTransferAction";
static constexpr const char *kAddVulkanLaunchActionToSchedule =
    "addVulkanLaunchActionToSchedule";
static constexpr const char *kVkBarrier = "VkBarrier";
static constexpr const char *kVkWait = "VkWait";
static constexpr const char *kVkDealloc = "VkDealloc";
static constexpr const char *kVkRead = "VkRead";
static constexpr const char *kVkWrite = "VkWrite";
static constexpr const char *kVkScheduleFunc = "VkScheduleFunc";

static constexpr const char *kBindBufferBFloat16 = "bindBufferBFloat16";
static constexpr const char *kBindBufferFloat16 = "bindBufferFloat16";
static constexpr const char *kBindBufferFloat32 = "bindBufferFloat32";
static constexpr const char *kBindBufferFloat64 = "bindBufferFloat64";
static constexpr const char *kBindBufferInteger8 = "bindBufferInteger8";
static constexpr const char *kBindBufferInteger16 = "bindBufferInteger16";
static constexpr const char *kBindBufferInteger32 = "bindBufferInteger32";
static constexpr const char *kBindBufferInteger64 = "bindBufferInteger64";
static constexpr const int kByteBits = 8;

namespace {

const char *getBufferBindingFunc(mlir::Type elementType) {
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

class ConvertCompToVulkanCall : public ConvertCompToVulkanCallBase<ConvertCompToVulkanCall>{
public:
  void runOnOperation();
};

void ConvertCompToVulkanCall::runOnOperation() {
  mlir::ModuleOp module = getOperation();
  // Serialize SPIRV kernels.
  BinaryModulesMap modulesMap;
  if (mlir::failed(serializeSpirvKernels(module, modulesMap)))
    return signalPassFailure();
  // Populate conversion patterns.
  mlir::MLIRContext *context = &getContext();
  mlir::TypeConverter typeConverter, signatureConverter;
  mlir::OwningRewritePatternList patterns;
  populateCommonPatterns(context, typeConverter, signatureConverter, patterns);
  populateCompToVkPatterns(context, modulesMap, typeConverter, patterns);
  // Set conversion target.
  mlir::ConversionTarget target(*context);
  target.addLegalDialect<LLVM::LLVMDialect>();
  target.addLegalDialect<mlir::StandardOpsDialect>();
  target.addIllegalDialect<comp::COMPDialect>();
  target.addDynamicallyLegalOp<mlir::FuncOp>([&](mlir::FuncOp op) -> bool {
    return signatureConverter.isSignatureLegal(op.getType());
  });
  if (mlir::failed(mlir::applyPartialConversion(module, target, patterns)))
    signalPassFailure();
  // Insert runtime function declarations.
  addCommonFunctionDeclarations(module);
  addVkFunctionDeclarations(module);
}

template <class Op>
struct ConvertCompToVkBasePattern : ConvertCompOpBasePattern<Op> {
  ConvertCompToVkBasePattern(mlir::TypeConverter &typeConverter,
                             mlir::MLIRContext *context)
      : ConvertCompOpBasePattern<Op>(comp::ExecEnvRuntime::Vulkan,
                                     typeConverter, context) {}
};

/// Pattern for converting operation to llvm function call,
/// performing type conversions for results.
/// It can also handle variadic arguments when configured with
/// `varArg` and `nonVarArgs` constructor parameters.
template <class Op>
struct ConvertToFuncCallPattern : ConvertCompToVkBasePattern<Op> {
  ConvertToFuncCallPattern(mlir::StringRef funcName,
                           mlir::TypeConverter &typeConverter,
                           mlir::MLIRContext *context, bool varArg = false,
                           unsigned nonVarArgs = 0)
      : ConvertCompToVkBasePattern<Op>(typeConverter, context),
        funcName(funcName), varArg(varArg), nonVarArgs(nonVarArgs) {}

  mlir::LogicalResult
  matchAndRewrite(Op op, mlir::ArrayRef<mlir::Value> operands,
                  mlir::ConversionPatternRewriter &rewriter) const override;

  mlir::StringRef funcName;
  bool varArg;
  unsigned nonVarArgs;
};

using ConvertToInitVulkan = ConvertToFuncCallPattern<comp::CreateExecEnv>;
using ConvertToDeinitVulkan = ConvertToFuncCallPattern<comp::DestroyExecEnv>;
using ConvertToCommandBufferSubmit = ConvertToFuncCallPattern<comp::Submit>;

// TODO dont open those api on vulkan backend;
using ConvertWait = ConvertToFuncCallPattern<comp::Wait>;
using ConvertScheduleBarrier = ConvertToFuncCallPattern<comp::ScheduleBarrier>;
using ConvertDealloc = ConvertToFuncCallPattern<comp::Dealloc>;

/// Template pattern common for both comp::ScheduleRead and
/// comp::ScheduleWrite.
template <class Op>
struct ConvertScheduleReadWrite : ConvertCompToVkBasePattern<Op> {
  ConvertScheduleReadWrite(mlir::StringRef funcName,
                           mlir::TypeConverter &typeConverter,
                           mlir::MLIRContext *context)
      : ConvertCompToVkBasePattern<Op>(typeConverter, context),
        funcName(funcName) {}

  mlir::LogicalResult
  matchAndRewrite(Op op, mlir::ArrayRef<mlir::Value> operands,
                  mlir::ConversionPatternRewriter &rewriter) const override;

  mlir::StringRef funcName;
};

using ConvertScheduleRead = ConvertScheduleReadWrite<comp::ScheduleRead>;

using ConvertScheduleWrite = ConvertScheduleReadWrite<comp::ScheduleWrite>;

struct ConvertAlloc : ConvertCompToVkBasePattern<comp::Alloc> {
  using ConvertCompToVkBasePattern<comp::Alloc>::ConvertCompToVkBasePattern;

  mlir::LogicalResult
  matchAndRewrite(comp::Alloc op, mlir::ArrayRef<mlir::Value> operands,
                  mlir::ConversionPatternRewriter &rewriter) const override;

  static uint64_t numAlloc;
};

uint64_t ConvertAlloc::numAlloc = 0;

struct ConvertScheduleFunc : ConvertCompToVkBasePattern<comp::ScheduleFunc> {
  ConvertScheduleFunc(const BinaryModulesMap &modulesMap,
                      mlir::TypeConverter &typeConverter,
                      mlir::MLIRContext *context)
      : ConvertCompToVkBasePattern<comp::ScheduleFunc>(typeConverter, context),
        modulesMap(modulesMap) {}

  mlir::LogicalResult
  matchAndRewrite(comp::ScheduleFunc op, mlir::ArrayRef<mlir::Value> operands,
                  mlir::ConversionPatternRewriter &rewriter) const override;

  const BinaryModulesMap &modulesMap;
};

} // namespace

void populateCompToVkPatterns(mlir::MLIRContext *context,
                              const BinaryModulesMap &modulesMap,
                              mlir::TypeConverter &typeConverter,
                              mlir::OwningRewritePatternList &patterns) {
  // Populate type conversion patterns.
  LLVM::LLVMType llvmInt8Ptr = LLVM::LLVMType::getInt8PtrTy(context);
  typeConverter.addConversion(
      [=](comp::ExecEnvType execEnvType) -> mlir::Optional<mlir::Type> {
        return llvmInt8Ptr;
      });
  typeConverter.addConversion(
      [=](comp::EventType eventType) -> mlir::Optional<mlir::Type> {
        return llvmInt8Ptr;
      });
  patterns.insert<ConvertToInitVulkan>(kInitVulkan, typeConverter, context);
  patterns.insert<ConvertToDeinitVulkan>(kDeinitVulkan, typeConverter, context);
  patterns.insert<ConvertToCommandBufferSubmit>(kRun, typeConverter, context);

  patterns.insert<ConvertScheduleFunc>(modulesMap, typeConverter, context);
  patterns.insert<ConvertAlloc>(typeConverter, context);

  patterns.insert<ConvertDealloc>(kVkDealloc, typeConverter, context);
  patterns.insert<ConvertScheduleBarrier>(kVkBarrier, typeConverter, context,
                                          /*varArg=*/true, /*nonVarArgs=*/1);
  patterns.insert<ConvertWait>(kVkWait, typeConverter, context,
                               /*varArg=*/true, /*nonVarArgs=*/0);

  patterns.insert<ConvertScheduleRead>(kVkRead, typeConverter, context);
  patterns.insert<ConvertScheduleWrite>(kVkWrite, typeConverter, context);
}

void addVkFunctionDeclarations(mlir::ModuleOp &module) {
  mlir::Location loc = module.getLoc();
  mlir::OpBuilder builder(module.getBody()->getTerminator());
  mlir::MLIRContext *context = builder.getContext();
  LLVM::LLVMType llvmInt8Ptr = LLVM::LLVMType::getInt8PtrTy(context);
  LLVM::LLVMType llvmVoid = LLVM::LLVMType::getVoidTy(context);
  LLVM::LLVMType llvmInt32 = LLVM::LLVMType::getInt32Ty(context);
  LLVM::LLVMType llvmInt64Type = LLVM::LLVMType::getInt64Ty(context);
  mlir::Type mlirIndexType = builder.getIndexType();

  builder.create<LLVM::LLVMFuncOp>(
      loc, kInitVulkan,
      LLVM::LLVMType::getFunctionTy(llvmInt8Ptr, {llvmInt8Ptr},
                                    /*isVarArg=*/false));

  builder.create<mlir::FuncOp>(
      loc, kCreateVulkanLaunchKernelAction,
      mlir::FunctionType::get(
          {mlir::ArrayRef<mlir::Type>{llvmInt8Ptr, llvmInt8Ptr, llvmInt32,
                                      llvmInt8Ptr, mlirIndexType, mlirIndexType,
                                      mlirIndexType}},
          {}, context),
      mlir::ArrayRef<std::pair<mlir::Identifier, mlir::Attribute>>());

  builder.create<LLVM::LLVMFuncOp>(
      loc, kSetVulkanLaunchKernelAction,
      LLVM::LLVMType::getFunctionTy(llvmVoid, {llvmInt8Ptr, llvmInt32},
                                    /*isVarArg=*/false));

  builder.create<LLVM::LLVMFuncOp>(
      loc, kAddVulkanLaunchActionToSchedule,
      LLVM::LLVMType::getFunctionTy(llvmVoid, {llvmInt8Ptr},
                                    /*isVarArg=*/false));

  builder.create<LLVM::LLVMFuncOp>(
      loc, kRun,
      LLVM::LLVMType::getFunctionTy(llvmVoid, {llvmInt8Ptr},
                                    /*isVarArg=*/false));

  builder.create<LLVM::LLVMFuncOp>(
      loc, kDeinitVulkan,
      LLVM::LLVMType::getFunctionTy(llvmVoid, {llvmInt8Ptr},
                                    /*isVarArg=*/false));

  builder.create<LLVM::LLVMFuncOp>(
      loc, kCreateVulkanMemoryTransferAction,
      LLVM::LLVMType::getFunctionTy(llvmVoid,
                                    {llvmInt8Ptr, llvmInt64Type, llvmInt64Type,
                                     llvmInt64Type, llvmInt64Type},
                                    /*isVarArg=*/false));

  std::vector<std::pair<const char *, mlir::Type>> bindType{
      {kBindBufferBFloat16, builder.getBF16Type()},
      {kBindBufferFloat16, builder.getF16Type()},
      {kBindBufferFloat32, builder.getF32Type()},
      {kBindBufferFloat64, builder.getF32Type()},
      {kBindBufferInteger8, builder.getIntegerType(8)},
      {kBindBufferInteger16, builder.getIntegerType(16)},
      {kBindBufferInteger32, builder.getI32Type()},
      {kBindBufferInteger64, builder.getI64Type()}};

  for (auto func : bindType) {
    builder.create<mlir::FuncOp>(
        loc, func.first,
        mlir::FunctionType::get(
            {mlir::ArrayRef<mlir::Type>{
                llvmInt8Ptr, llvmInt32, llvmInt32, llvmInt32,
                mlir::UnrankedMemRefType::get(func.second, /*memorySpace=*/0)}},
            {}, context),
        mlir::ArrayRef<std::pair<mlir::Identifier, mlir::Attribute>>());
  }
}

template <class Op>
mlir::LogicalResult ConvertToFuncCallPattern<Op>::matchAndRewrite(
    Op op, mlir::ArrayRef<mlir::Value> operands,
    mlir::ConversionPatternRewriter &rewriter) const {
  op.dump();
  if (!this->isMatchingRuntime(op))
    return mlir::failure();

  mlir::SmallVector<mlir::Type, 1> convertedTypes;
  for (mlir::Type prevType : op.getOperation()->getResultTypes()) {
    convertedTypes.push_back(this->convertType(prevType));
  }

  if (!varArg) {
    rewriter.replaceOpWithNewOp<LLVM::CallOp>(
        op.getOperation(), convertedTypes, rewriter.getSymbolRefAttr(funcName),
        operands);
    return mlir::success();
  }

  mlir::SmallVector<mlir::Value, 1> newOperands(operands.begin(),
                                                operands.begin() + nonVarArgs);
  LLVM::LLVMType llvmInt32Ty =
      LLVM::LLVMType::getInt32Ty(rewriter.getContext());
  mlir::Value varArgsCnt = rewriter.create<LLVM::ConstantOp>(
      op.getLoc(), llvmInt32Ty,
      rewriter.getI32IntegerAttr(operands.size() - nonVarArgs));
  newOperands.push_back(varArgsCnt);
  newOperands.insert(newOperands.end(), operands.begin() + nonVarArgs,
                     operands.end());

  rewriter.replaceOpWithNewOp<LLVM::CallOp>(op.getOperation(), convertedTypes,
                                            rewriter.getSymbolRefAttr(funcName),
                                            newOperands);
  return mlir::success();
}

template <class Op>
mlir::LogicalResult ConvertScheduleReadWrite<Op>::matchAndRewrite(
    Op op, mlir::ArrayRef<mlir::Value> operands,
    mlir::ConversionPatternRewriter &rewriter) const {
  op.dump();
  if (!this->isMatchingRuntime(op))
    return mlir::failure();

  constexpr unsigned nonVarArgs = 3;
  mlir::SmallVector<mlir::Value, nonVarArgs + 2> castOperands(
      operands.begin(), operands.begin() + nonVarArgs);

  // Convert host memref to pointer.
  mlir::Value hostPtr =
      this->materializeConversion(rewriter, op.getLoc(), operands[0]);
  if (!hostPtr)
    return mlir::failure();
  castOperands[0] = hostPtr;

  // Add event dependencies as variadic operands.
  LLVM::LLVMType llvmInt32Ty =
      LLVM::LLVMType::getInt32Ty(rewriter.getContext());
  mlir::Value eventsCnt = rewriter.create<LLVM::ConstantOp>(
      op.getLoc(), llvmInt32Ty,
      rewriter.getI32IntegerAttr(operands.size() - nonVarArgs));
  castOperands.push_back(eventsCnt);
  castOperands.insert(castOperands.end(), operands.begin() + nonVarArgs,
                      operands.end());

  mlir::Type llvmEventType = this->convertType(op.getType());
  rewriter.replaceOpWithNewOp<LLVM::CallOp>(
      op.getOperation(), mlir::ArrayRef<mlir::Type>{llvmEventType},
      rewriter.getSymbolRefAttr(funcName), castOperands);
  return mlir::success();
}

mlir::LogicalResult
ConvertAlloc::matchAndRewrite(comp::Alloc op,
                              mlir::ArrayRef<mlir::Value> operands,
                              mlir::ConversionPatternRewriter &rewriter) const {
  op.dump();
  if (!isMatchingRuntime(op))
    return mlir::failure();

  mlir::Location loc = op.getLoc();

  LLVM::LLVMType llvmInt32Ty =
      LLVM::LLVMType::getInt32Ty(rewriter.getContext());

  mlir::Value descriptorSet = rewriter.create<LLVM::ConstantOp>(
      loc, llvmInt32Ty, rewriter.getI32IntegerAttr(0));
  auto buffer = op.hostMem();
  // Create LLVM constant for the descriptor binding index.
  mlir::Value descriptorBinding = rewriter.create<LLVM::ConstantOp>(
      loc, llvmInt32Ty, rewriter.getI32IntegerAttr(numAlloc++));

  auto memRefType = buffer.getType().dyn_cast_or_null<mlir::MemRefType>();
  if (!memRefType) {
    return mlir::failure();
  }

  auto shape = memRefType.getShape();
  uint32_t numElement = 1;
  for (auto dim : shape) {
    numElement *= dim;
  }

  auto elementType = memRefType.getElementType();
  uint32_t elementTypeSize =
      llvm::divideCeil(elementType.getIntOrFloatBitWidth(), kByteBits);

  mlir::Value bufferByteSize = rewriter.create<LLVM::ConstantOp>(
      loc, llvmInt32Ty,
      rewriter.getI32IntegerAttr(numElement * elementTypeSize));
  mlir::Value unrankedBuffer = rewriter.create<mlir::MemRefCastOp>(
      loc, buffer,
      mlir::UnrankedMemRefType::get(elementType, /*memorySpace=*/0));
  rewriter.create<mlir::CallOp>(
      loc, mlir::ArrayRef<mlir::Type>{},
      rewriter.getSymbolRefAttr(getBufferBindingFunc(elementType)),
      mlir::ArrayRef<mlir::Value>{operands[0], descriptorSet, descriptorBinding,
                                  bufferByteSize, unrankedBuffer});
  return mlir::success();
}

mlir::LogicalResult ConvertScheduleFunc::matchAndRewrite(
    comp::ScheduleFunc op, mlir::ArrayRef<mlir::Value> operands,
    mlir::ConversionPatternRewriter &rewriter) const {
  op.dump();
  if (!isMatchingRuntime(op))
    return mlir::failure();

  mlir::Location loc = op.getLoc();
  auto launchOp = mlir::cast<gpu::LaunchFuncOp>(op.body().front().front());
  std::string binaryName = launchOp.getKernelModuleName().str();
  std::string kernelName = launchOp.getKernelName().str();

  // Create kernel from serialized binary.
  if (modulesMap.count(binaryName) == 0)
    return mlir::failure();
  if (modulesMap.at(binaryName).kernelsNameMap.count(kernelName) == 0)
    return mlir::failure();

  mlir::Value binaryPtr, binaryBytes;
  getPtrToBinaryModule(rewriter, loc, modulesMap.at(binaryName), binaryPtr,
                       binaryBytes);
  mlir::Value namePtr = getPtrToGlobalString(
      rewriter, loc, modulesMap.at(binaryName).kernelsNameMap.at(kernelName));

  auto gridSize = launchOp.getGridSizeOperandValues();

  auto createCall = rewriter.create<LLVM::CallOp>(
      loc, mlir::ArrayRef<mlir::Type>{},
      rewriter.getSymbolRefAttr(kCreateVulkanLaunchKernelAction),
      mlir::ArrayRef<mlir::Value>{operands[0], binaryPtr, binaryBytes, namePtr,
                                  gridSize.x, gridSize.y, gridSize.z});
  createCall.dump();
  //  mlir::Value kernel = createCall.getResult(0);

  LLVM::LLVMType llvmInt32Ty =
      LLVM::LLVMType::getInt32Ty(rewriter.getContext());
  // Set kernel arguments.
  for (unsigned argI = 0; argI < launchOp.getNumKernelOperands(); ++argI) {
    mlir::Value subgroupSizeVal = rewriter.create<LLVM::ConstantOp>(
        loc, llvmInt32Ty, rewriter.getI32IntegerAttr(1));

    rewriter.create<LLVM::CallOp>(
        loc, mlir::ArrayRef<mlir::Type>{},
        rewriter.getSymbolRefAttr(kSetVulkanLaunchKernelAction),
        mlir::ArrayRef<mlir::Value>{operands[0], subgroupSizeVal});
  }
  // Set event dependencies. This is done with separate functions
  // on kernel as opposed to variadic argument in final function,
  // because dispatch sizes are index types prohibiting use of
  // llvm function and variadic arguments.
//  for (mlir::Value event : operands.slice(1)) {
//    event.dump();
  rewriter.create<LLVM::CallOp>(
      loc, mlir::ArrayRef<mlir::Type>{},
      rewriter.getSymbolRefAttr(kAddVulkanLaunchActionToSchedule),
      mlir::ArrayRef<mlir::Value>{operands[0]});
//  }

  mlir::Type llvmEventType = this->convertType(op.getType());
  rewriter.replaceOpWithNewOp<mlir::CallOp>(
      op.getOperation(), mlir::ArrayRef<mlir::Type>{llvmEventType},
      rewriter.getSymbolRefAttr(kVkScheduleFunc), mlir::ArrayRef<mlir::Value>{});
  return mlir::success();
}

std::unique_ptr<mlir::Pass> createConvertCompToVulkanCallPass() {
  return std::make_unique<ConvertCompToVulkanCall>();
}

} // namespace pmlc::conversion::comp_to_vulkanCall
