// Copyright 2020, Intel Corporation
#include <memory>
#include <vector>

#include "mlir/Conversion/GPUToVulkan/ConvertGPUToVulkanPass.h"
#include "mlir/Dialect/GPU/GPUDialect.h"
#include "mlir/Dialect/LLVMIR/LLVMDialect.h"
#include "mlir/Dialect/SPIRV/SPIRVOps.h"
#include "mlir/Dialect/SPIRV/Serialization.h"
#include "mlir/Dialect/StandardOps/IR/Ops.h"
#include "mlir/IR/Attributes.h"
#include "mlir/IR/Builders.h"
#include "mlir/IR/Function.h"
#include "mlir/IR/Module.h"
#include "mlir/IR/PatternMatch.h"
#include "mlir/IR/StandardTypes.h"
#include "mlir/Pass/Pass.h"
#include "mlir/Support/LogicalResult.h"
#include "mlir/Transforms/DialectConversion.h"
#include "llvm/ADT/SmallString.h"

#include "pmlc/conversion/gpu_to_vulkan/pass_detail.h"
#include "pmlc/conversion/gpu_to_vulkan/passes.h"
#include "pmlc/dialect/vulkan/ir/ops.h"
#include "pmlc/util/logging.h"

namespace pmlc::conversion::gpu_to_vulkan {

namespace gpu = mlir::gpu;
namespace spirv = mlir::spirv;
namespace LLVM = mlir::LLVM;
namespace vulkan = pmlc::dialect::vulkan;
using mlir::applyPartialConversion;
using mlir::ArrayRef;
using mlir::CallOp;
using mlir::ConversionTarget;
using mlir::failure;
using mlir::FuncOp;
using mlir::FunctionType;
using mlir::Location;
using mlir::LogicalResult;
using mlir::MemRefType;
using mlir::MLIRContext;
using mlir::ModuleOp;
using mlir::OpBuilder;
using mlir::OpRewritePattern;
using mlir::OwningRewritePatternList;
using mlir::PatternRewriter;
using mlir::SmallString;
using mlir::SmallVector;
using mlir::StringRef;
using mlir::success;
using mlir::Type;
using mlir::UnrankedMemRefType;
using mlir::Value;

namespace {

/// Rewrites gpu.launch_func operation to be contained inside
/// comp.schedule_func. Creates new execution environment before function,
/// then allocates required memory on device. After scheduling function
/// creates memory reads and wait for completion. Finally deallocates
/// device memory and destroys execution environment.
struct RewriteLaunchFunc : public mlir::OpRewritePattern<gpu::LaunchFuncOp> {
  RewriteLaunchFunc(mlir::MLIRContext *context)
      : mlir::OpRewritePattern<gpu::LaunchFuncOp>(context)) {}

  mlir::LogicalResult
  matchAndRewrite(gpu::LaunchFuncOp op,
                  mlir::PatternRewriter &rewriter) const override;

  mlir::LogicalResult
  allocateDeviceMemory(mlir::PatternRewriter &rewriter, mlir::Location location,
                       mlir::Value execEnv, const mlir::ValueRange &host,
                       std::vector<mlir::Value> &device) const;
};

/// Converts memrefs in gpu function signature to reside in memory
/// spaces supported by execution environment.
struct ConvertGpuFunc : public mlir::OpConversionPattern<gpu::GPUFuncOp> {
  ConvertGpuFunc(mlir::MLIRContext *context)
      : mlir::OpConversionPattern<gpu::GPUFuncOp>(context) {}

  mlir::LogicalResult
  matchAndRewrite(gpu::GPUFuncOp op, mlir::ArrayRef<mlir::Value> operands,
                  mlir::ConversionPatternRewriter &rewriter) const override {
    // main func insert vulkan ops;
    // Vk_InitVulkanCall, Vk_SubmitCommandBuffers, Vk_DeinitVulkan
    // TODO implement vulkan ops of build func.
    if (!op.isKernel()) {
      mlir::Location loc = op.getLoc();
      auto blockHead = op.getOperation().getRegion(0).front();
      rewriter.setInsertionPointToStart(blockHead);
      rewriter.create<vulkan::InitVulkanCall>(loc);
      op.walk([=](gpu::ReturnOp op) {
        rewriter.setInsertionPoint(op);
        rewriter.create<vulkan::SubmitCommandBuffers>(loc);
        rewriter.create<vulkan::DeinitVulkan>(loc);
      });
      return mlir::success();
    }

    // if it's kernel func, convert memrefs
    mlir::TypeConverter converter;
    // Default pass-through conversion.
    converter.addConversion([](mlir::Type type) { return type; });
    // Change memrefs memory space if not supported by execution environment.
    converter.addConversion([&](mlir::MemRefType type) -> mlir::MemRefType {
      if (execEnvType.supportsMemorySpace(type.getMemorySpace()))
        return type;
      return mlir::MemRefType::Builder(type).setMemorySpace(
          execEnvType.getDefaultMemorySpace());
    });

    mlir::TypeConverter::SignatureConversion signatureConversion(
        op.getNumArguments());

    if (mlir::failed(converter.convertSignatureArgs(op.getArgumentTypes(),
                                                    signatureConversion)))
      return mlir::failure();

    if (mlir::failed(rewriter.convertRegionTypes(&op.body(), converter,
                                                 &signatureConversion)))
      return mlir::failure();

    rewriter.updateRootInPlace(op, [&] {
      op.setType(rewriter.getFunctionType(
          signatureConversion.getConvertedTypes(), {}));
    });

    return mlir::success();
  }
};

mlir::LogicalResult
RewriteLaunchFunc::matchAndRewrite(gpu::LaunchFuncOp op,
                                   mlir::PatternRewriter &rewriter) const {
  // organize pipeline for each gpu kernel.
  mlir::Location loc = op.getLoc();
  rewriter.setInsertionPoint(op);

  // Create VulkanLaunchKernelAction.
  auto execEnvOp = rewriter.create<vulkan::CreateVulkanLaunchKernelAction>(loc);
  mlir::Value execEnv = execEnvOp.getResult();

  // Create VulkanLaunchKernelAction.
  auto execEnvOp = rewriter.create<vulkan::SetLaunchKernelAction>(loc);
  mlir::Value execEnv = execEnvOp.getResult();

  // Create VulkanLaunchKernelAction.
  auto execEnvOp = rewriter.create<vulkan::AddVulkanLaunchActionToSchedule>(loc);
  mlir::Value execEnv = execEnvOp.getResult();

  // Allocate memory on device for memory operands.
  std::vector<mlir::Value> newOperands;
  if (mlir::failed(allocateDeviceMemory(rewriter, loc, execEnv, op.operands(),
                                        newOperands)))
    return mlir::failure();

  // Remove original launch operation.
  rewriter.eraseOp(op.getOperation());

  return mlir::success();
}

mlir::LogicalResult RewriteLaunchFunc::allocateDeviceMemory(
    mlir::PatternRewriter &rewriter, mlir::Location loc, mlir::Value execEnv,
    const mlir::ValueRange &host, std::vector<mlir::Value> &device) const {
  device.reserve(host.size());
  for (mlir::Value hostArg : host) {
    mlir::Value newArg = hostArg;

    if (auto memRefType = hostArg.getType().dyn_cast<mlir::MemRefType>()) {
      if (!execEnvType.supportsMemorySpace(memRefType.getMemorySpace())) {
        mlir::MemRefType newMemRefType =
            mlir::MemRefType::Builder(memRefType)
                .setMemorySpace(execEnvType.getDefaultMemorySpace());
        auto allocOp =
            rewriter.create<comp::Alloc>(loc, newMemRefType, execEnv, hostArg);
        newArg = allocOp.getResult();
      }
    }

    device.push_back(newArg);
  }
  return mlir::success();
}

class BindBufferLowering : public OpRewritePattern<CallOp> {
public:
  using OpRewritePattern<CallOp>::OpRewritePattern;

  LogicalResult matchAndRewrite(CallOp op,
                                PatternRewriter &rewrite) const override {
    rewrite.replaceOpWithNewOp<pmlc::dialect::vulkan::Alloc>(
        op, rewrite.getType<pmlc::dialect::vulkan::BufferType>());
    return success();
  }
};

/// A pass to convert gpu launch op to vulkan launch call op, by creating a
/// SPIR-V binary shader from `spirv::ModuleOp` using `spirv::serialize`
/// function and attaching binary data and entry point name as an attributes to
/// created vulkan launch call op.
class ConvertGpuToVulkan : public ConvertGpuToVulkanBase<ConvertGpuToVulkan> {
public:
  void runOnOperation();

private:

  llvm::DenseMap<Value, llvm::SmallVector<uint64_t, 2>> bufferMap;
};

void ConvertGpuToVulkan::runOnOperation() {

  // TODO convert this to gpulaunchFunc pattern
  getOperation().walk(
      [this](gpu::LaunchFuncOp op) { convertGpuLaunchFunc(op); });

  mlir::ConversionTarget target(getContext());
  target.addLegalDialect<comp::VkDialect>();
  target.addLegalDialect<gpu::GPUDialect>();
  target.addLegalDialect<spirv::SPIRVDialect>();
  target.addIllegalOp<gpu::LaunchOp>();
  target.addIllegalOp<gpu::LaunchFuncOp>();
  target.addDynamicallyLegalOp<gpu::GPUFuncOp>(
      [=](gpu::GPUFuncOp op) -> bool { return op.isKernel(); });

  // TODO if add memory buffer transfer tag, open this.
  //  target.addDynamicallyLegalOp<gpu::GPUFuncOp>([=](gpu::GPUFuncOp op) ->
  //  bool {
  //    if (!op.isKernel())
  //      return true;
  //    for (auto arg : op.getArguments()) {
  //      if (auto memRefType =
  //              arg.getType().dyn_cast_or_null<mlir::MemRefType>()) {
  //        if (!execEnvType.supportsMemorySpace(memRefType.getMemorySpace()))
  //          return false;
  //      }
  //    }
  //    return true;
  //  });

  // Setup rewrite patterns.
  mlir::OwningRewritePatternList patterns;
  populateGpuToVulkanPatterns(&getContext(), patterns);

  // Run the conversion.
  if (mlir::failed(
          mlir::applyPartialConversion(getOperation(), target, patterns)))
    signalPassFailure();
}

} // namespace

void populateGpuToVulkanPatterns(mlir::MLIRContext *context,
                                 mlir::OwningRewritePatternList &patterns) {
  patterns.insert<ConvertGpuFunc>(ctx);
  patterns.insert<RewriteLaunchFunc>(ctx);
  patterns.insert<BindBufferLowering>(ctx);
}

std::unique_ptr<mlir::Pass> createConvertGpuToVulkanPass() {
  return std::make_unique<ConvertGpuToVulkan>();
}

} // namespace pmlc::conversion::gpu_to_vulkan
