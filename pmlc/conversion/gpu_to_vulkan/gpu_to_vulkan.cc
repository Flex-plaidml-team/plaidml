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

#include "mlir/include/mlir/IR/Block.h"
#include "pmlc/conversion/gpu_to_vulkan/pass_detail.h"
#include "pmlc/conversion/gpu_to_vulkan/passes.h"
#include "pmlc/dialect/vulkan/ir/ops.h"
#include "pmlc/util/logging.h"

namespace pmlc::conversion::gpu_to_vulkan {

namespace gpu = mlir::gpu;
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
      : mlir::OpRewritePattern<gpu::LaunchFuncOp>(context),
        bufferType(vulkan::BufferType::get(context)) {}

  mlir::LogicalResult
  matchAndRewrite(gpu::LaunchFuncOp op,
                  mlir::PatternRewriter &rewriter) const override;

  mlir::LogicalResult
  createScheduleFuncOp(mlir::PatternRewriter &rewriter, mlir::Location loc,
                       gpu::LaunchFuncOp op,
                       const mlir::ValueRange operands) const;

private:
  static llvm::DenseMap<::mlir::Value, ::mlir::Value> VulkanBufferMap;
  vulkan::BufferType bufferType;
};

mlir::LogicalResult RewriteLaunchFunc::createScheduleFuncOp(
    mlir::PatternRewriter &rewriter, mlir::Location loc, gpu::LaunchFuncOp op,
    mlir::ValueRange operands) const {
  // Find kernel that operation launches.
  mlir::SymbolRefAttr kernelSymbol = op.kernel();
  auto kernelOp = mlir::SymbolTable::lookupNearestSymbolFrom<gpu::GPUFuncOp>(
      op.getOperation(), kernelSymbol);
  if (!kernelOp)
    return mlir::failure();

  rewriter.setInsertionPoint(op);
  auto CreateShaderModuleOp =
      rewriter.create<vulkan::CreateShaderModuleOp>(loc, operands);

  // Add launch_func with new operands inside schedule_func.
  mlir::PatternRewriter::InsertionGuard insertionGuard(rewriter);
  rewriter.createBlock(&CreateShaderModuleOp.body(),
                       CreateShaderModuleOp.body().end());
  rewriter.create<gpu::LaunchFuncOp>(
      loc, kernelOp, op.getGridSizeOperandValues(),
      op.getBlockSizeOperandValues(), op.getOperands());
  return mlir::success();
}

mlir::LogicalResult
RewriteLaunchFunc::matchAndRewrite(gpu::LaunchFuncOp op,
                                   mlir::PatternRewriter &rewriter) const {
  // organize pipeline for each gpu kernel.
  mlir::Location loc = op.getLoc();
  rewriter.setInsertionPoint(op);

  std::vector<mlir::Value> deviceBuffers;
  for (auto operand : op.getOperands()) {
    if (operand.getType().isa<MemRefType>()) {
      auto isBuildBuffer = VulkanBufferMap.find(operand);
      // if don't build buffer, build one.
      if (isBuildBuffer == VulkanBufferMap.end()) {
        auto allocOp = rewriter.create<vulkan::Alloc>(loc, bufferType);
        auto buffer = allocOp.getResult();
        VulkanBufferMap[operand] = buffer;
      }
      deviceBuffers.push_back(VulkanBufferMap[operand]);
    }
  }

  // wrapper the launch_func op with the build vkBuffer.
  auto shaderOperands = mlir::ValueRange(deviceBuffers);
  createScheduleFuncOp(rewriter, loc, op, shaderOperands);

  //TODO CHECK all the store and load op, replace them with wirtebuffer and readbuffer.

  // Remove original launch operation.
  rewriter.eraseOp(op.getOperation());

  return mlir::success();
}

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
    if (op.isKernel()) {
      return mlir::failure();
    }
    mlir::Location loc = op.getLoc();
    ::mlir::Block &block = op.body().front();
    rewriter.setInsertionPointToStart(&block);
    rewriter.create<vulkan::InitVulkanCall>(loc);
    op.walk([&](gpu::ReturnOp op) {
      rewriter.setInsertionPoint(op);
      rewriter.create<vulkan::SubmitCommandBuffers>(loc);
      rewriter.create<vulkan::DeinitVulkan>(loc);
    });
    return mlir::success();
  }
};

/// A pass to convert gpu launch op to vulkan launch call op, by creating a
/// SPIR-V binary shader from `spirv::ModuleOp` using `spirv::serialize`
/// function and attaching binary data and entry point name as an attributes
/// to created vulkan launch call op.
class ConvertGpuToVulkan : public ConvertGpuToVulkanBase<ConvertGpuToVulkan> {
public:
  void runOnOperation();

private:
  llvm::DenseMap<Value, llvm::SmallVector<uint64_t, 2>> bufferMap;
};

void ConvertGpuToVulkan::runOnOperation() {
  mlir::ConversionTarget target(getContext());
  target.addLegalDialect<vulkan::VkDialect>();
  target.addLegalDialect<gpu::GPUDialect>();
  //  target.addLegalDialect<::mlir::spirv::SPIRVDialect>();
  target.addIllegalOp<gpu::LaunchOp>();
  target.addIllegalOp<gpu::LaunchFuncOp>();
  target.addDynamicallyLegalOp<gpu::GPUFuncOp>(
      [&](gpu::GPUFuncOp op) -> bool { return op.isKernel(); });

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
  patterns.insert<ConvertGpuFunc>(context);
  patterns.insert<RewriteLaunchFunc>(context);
}

std::unique_ptr<mlir::Pass> createConvertGpuToVulkanPass() {
  return std::make_unique<ConvertGpuToVulkan>();
}

} // namespace pmlc::conversion::gpu_to_vulkan
