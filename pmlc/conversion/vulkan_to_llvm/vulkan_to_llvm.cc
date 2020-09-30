// Copyright 2020, Intel Corporation
#include "pmlc/conversion/vulkan_to_llvm/passes.h"

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
#include "mlir/Pass/Pass.h"
#include "mlir/Support/LogicalResult.h"
#include "mlir/Transforms/DialectConversion.h"
#include "llvm/ADT/SmallSet.h"
#include "llvm/ADT/SmallString.h"

#include "mlir/include/mlir/Support/LogicalResult.h"
#include "pmlc/conversion/vulkan_to_llvm/pass_detail.h"
#include "pmlc/dialect/vulkan/ir/ops.h"
#include "llvm/include/llvm/ADT/ArrayRef.h"

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
  /// Declares all needed runtime functions.
  void declareVulkanFunctions(mlir::Location loc);

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

  LLVM::LLVMType llvmVoidType;
  LLVM::LLVMType llvmPointerType;
  LLVM::LLVMType llvmInt32Type;
  LLVM::LLVMType llvmInt64Type;

  mlir::Type getMLIRFloat32Type() { return mlirFloat32Type; }
  mlir::Type getMLIRIndexType() { return mlirIndexType; }

  mlir::Type mlirFloat32Type;
  mlir::Type mlirIndexType;

  struct mlirTypeComparator {
    bool operator()(mlir::Type x, mlir::Type y) const {
      return x.getTypeID().getAsOpaquePointer() >
             y.getTypeID().getAsOpaquePointer();
    }
  };

  llvm::SmallSet<const char *, 4> optionalSymbols;
  llvm::SmallSet<mlir::Type, 4, mlirTypeComparator> bufferElementTypes;
};

void ConvertVulkanTollvm::declareVulkanFunctions(mlir::Location loc) {
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

void ConvertVulkanTollvm::runOnOperation() {
  getCachedTypes();
  mlir::ModuleOp module = getOperation();
  mlir::MLIRContext *context = &getContext();

  mlir::OwningRewritePatternList patterns;
  populateVulkanToPatterns(context, patterns);
  // Set conversion target.
  mlir::ConversionTarget target(*context);
  target.addLegalDialect<LLVM::LLVMDialect>();
  target.addLegalDialect<mlir::StandardOpsDialect>();
  //  target.addIllegalDialect<vulkan::VkDialect>();
  if (mlir::failed(mlir::applyPartialConversion(module, target, patterns)))
    signalPassFailure();
  // Insert runtime function declarations.
  declareVulkanFunctions(getOperation().getLoc());
}

/// A pass to convert gpu launch op to vulkan launch call op, by creating a
/// SPIR-V binary shader from `spirv::ModuleOp` using `spirv::serialize`
/// function and attaching binary data and entry point name as an attributes to
/// created vulkan launch call op.
template <typename Op>
class ConvertVulkanOpBasePattern : public mlir::OpConversionPattern<Op> {
public:
  ConvertVulkanOpBasePattern(mlir::MLIRContext *context)
      : mlir::OpConversionPattern<Op>(context) {}
};

class ConvertInitVulkanCall
    : public ConvertVulkanOpBasePattern<vulkan::InitVulkan> {
public:
  //  using OpConversionPattern<vulkan::InitVulkan>::OpConversionPattern;
  ConvertInitVulkanCall(mlir::MLIRContext *context)
      : ConvertVulkanOpBasePattern<vulkan::InitVulkan>(context) {}

  LogicalResult
  matchAndRewrite(vulkan::InitVulkan op, mlir::ArrayRef<mlir::Value> operands,
                  mlir::ConversionPatternRewriter &rewriter) const override {
    auto InstanceType = LLVM::LLVMType::getInt8PtrTy(op.getContext());
    rewriter.replaceOpWithNewOp<LLVM::CallOp>(
        op.getOperation(), mlir::ArrayRef<mlir::Type>{InstanceType},
        rewriter.getSymbolRefAttr(kInitVulkan), mlir::ArrayRef<Value>{});
    return mlir::success();
  }
};

class ConvertDeinitVulkan
    : public ConvertVulkanOpBasePattern<vulkan::DeinitVulkan> {
public:
  ConvertDeinitVulkan(mlir::MLIRContext *context)
      : ConvertVulkanOpBasePattern<vulkan::DeinitVulkan>(context) {}
  mlir::LogicalResult
  matchAndRewrite(vulkan::DeinitVulkan op, mlir::ArrayRef<mlir::Value> operands,
                  mlir::ConversionPatternRewriter &rewriter) const override {
    rewriter.replaceOpWithNewOp<LLVM::CallOp>(
        op.getOperation(), ArrayRef<Type>{},
        rewriter.getSymbolRefAttr(kDeinitVulkan), op.getOperand());
    return mlir::success();
  }
};

class ConvertSubmitCommandBuffers
    : public ConvertVulkanOpBasePattern<vulkan::SubmitCommandBuffers> {
public:
  ConvertSubmitCommandBuffers(mlir::MLIRContext *context)
      : ConvertVulkanOpBasePattern<vulkan::SubmitCommandBuffers>(context) {}
  mlir::LogicalResult
  matchAndRewrite(vulkan::SubmitCommandBuffers op,
                  mlir::ArrayRef<mlir::Value> operands,
                  mlir::ConversionPatternRewriter &rewriter) const override {
    rewriter.replaceOpWithNewOp<LLVM::CallOp>(
        op.getOperation(), ArrayRef<Type>{},
        rewriter.getSymbolRefAttr(kSubmitCommandBuffers), op.getOperand());
    return mlir::success();
  }
};

// TODO add create Vkbuffer API in vulkan runtime(include malloc and bind
//  buffer, then return vkbuffer)
class ConvertAlloc : public ConvertVulkanOpBasePattern<vulkan::Alloc> {
public:
  ConvertAlloc(mlir::MLIRContext *context)
      : ConvertVulkanOpBasePattern<vulkan::Alloc>(context) {}
  mlir::LogicalResult
  matchAndRewrite(vulkan::Alloc op, mlir::ArrayRef<mlir::Value> operands,
                  mlir::ConversionPatternRewriter &rewriter) const override {
    // TODO need provide alloc on runtime backend.
    return mlir::success();
  }
};

class ConvertShaderModule
    : public ConvertVulkanOpBasePattern<vulkan::CreateShaderModuleOp> {
public:
  ConvertShaderModule(mlir::MLIRContext *context)
      : ConvertVulkanOpBasePattern<vulkan::CreateShaderModuleOp>(context) {}
  mlir::LogicalResult
  matchAndRewrite(vulkan::CreateShaderModuleOp,
                  mlir::ArrayRef<mlir::Value> operands,
                  mlir::ConversionPatternRewriter &rewriter) const override;
};

// convert launchOp to llvm call, would split to serialize spirv module,
// createVulkanAction, setAction and addAction
// TODO add serialize module (find launchop-> spirv module), createAction, set
//  and add. need modify runtime API, specially change complex buffer map.
mlir::LogicalResult ConvertShaderModule::matchAndRewrite(
    vulkan::CreateShaderModuleOp, mlir::ArrayRef<mlir::Value> operands,
    mlir::ConversionPatternRewriter &rewriter) const {}

}; // namespace

// TODO add pattern for readfromdevice op and writetodevice op
void populateVulkanToPatterns(mlir::MLIRContext *context,
                              mlir::OwningRewritePatternList &patterns) {
  // Populate operation conversion patterns.
  patterns.insert<ConvertInitVulkanCall>(context);
  patterns.insert<ConvertSubmitCommandBuffers>(context);
  patterns.insert<ConvertDeinitVulkan>(context);
  patterns.insert<ConvertAlloc>(context);
  patterns.insert<ConvertShaderModule>(context);
}

std::unique_ptr<mlir::Pass> createConvertVulkanTollvmPass() {
  return std::make_unique<ConvertVulkanTollvm>();
}

} // namespace pmlc::conversion::vulkan_to_llvm
