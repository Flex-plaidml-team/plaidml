// Copyright 2020, Intel Corporation
#include <map>
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
#include "mlir/include/mlir/IR/Builders.h"
#include "mlir/include/mlir/IR/Function.h"
#include "mlir/include/mlir/IR/Region.h"
#include "mlir/include/mlir/Support/LogicalResult.h"
#include "pmlc/conversion/gpu_to_vulkan/pass_detail.h"
#include "pmlc/conversion/gpu_to_vulkan/passes.h"
#include "pmlc/dialect/vulkan/ir/ops.h"
#include "pmlc/util/logging.h"

namespace pmlc::conversion::gpu_to_vulkan {

namespace gpu = mlir::gpu;
namespace vulkan = pmlc::dialect::vulkan;

using mlir::ArrayRef;
using mlir::CallOp;
using mlir::FuncOp;
using mlir::FunctionType;
using mlir::LogicalResult;
using mlir::MemRefType;
using mlir::MLIRContext;
using mlir::OpBuilder;
using mlir::StringRef;
using mlir::Type;
using mlir::UnrankedMemRefType;

namespace {

/// A pass to convert gpu launch op to vulkan dialect ops. main operation is
/// build vulkan pipeline, create device buffer for pipeline. reduce memory
/// copy.
class ConvertGpuToVulkan : public ConvertGpuToVulkanBase<ConvertGpuToVulkan> {
public:
  void runOnOperation();

  LogicalResult createInitVulkan(FuncOp op);

  LogicalResult createDeInitVulkan(FuncOp op);

  LogicalResult createSubmit(FuncOp op);

  LogicalResult createVkBuffer(FuncOp op);

  LogicalResult convertLaunchFucOp(FuncOp op);

  LogicalResult updateVkBuffer(FuncOp op);

private:
  mlir::Value VkInstance;
  llvm::DenseMap<mlir::Value, mlir::Value> VulkanBufferMap;
  std::map<gpu::LaunchFuncOp, std::vector<mlir::Value>> opBufferMap;
};

LogicalResult ConvertGpuToVulkan::createInitVulkan(FuncOp op) {
  OpBuilder builder(op.getContext());
  // find insert point, func head.
  mlir::Region &region = op.getOperation()->getRegion(0);
  builder.setInsertionPointToStart(&region.front());

  mlir::Location loc = op.getLoc();
  auto Init = builder.create<vulkan::InitVulkan>(
      loc, pmlc::dialect::vulkan::ShaderModuleType::get(op.getContext()));
  VkInstance = Init.getResult();
  return mlir::success();
}

LogicalResult ConvertGpuToVulkan::createSubmit(FuncOp op) {
  OpBuilder builder(op.getContext());
  mlir::Location loc = op.getLoc();

  // find insert point, func head.
  mlir::Region &region = op.getOperation()->getRegion(0);
  builder.setInsertionPoint(&region.front().back());
  builder.create<vulkan::SubmitCommandBuffers>(loc, VkInstance);
  return mlir::success();
}

LogicalResult ConvertGpuToVulkan::createDeInitVulkan(FuncOp op) {
  OpBuilder builder(op.getContext());
  mlir::Location loc = op.getLoc();

  // find insert point, func head.
  mlir::Region &region = op.getOperation()->getRegion(0);
  builder.setInsertionPoint(&region.front().back());
  builder.create<vulkan::DeinitVulkan>(loc, VkInstance);
  return mlir::success();
}

LogicalResult ConvertGpuToVulkan::createVkBuffer(FuncOp funcOp) {
  auto ctx = funcOp.getContext();
  OpBuilder builder(ctx);
  mlir::Location loc = funcOp.getLoc();

  funcOp.walk([&](gpu::LaunchFuncOp op) {
    std::vector<mlir::Value> mapVkBuffer;
    for (auto operand : op.getOperands()) {
      if (operand.getType().isa<MemRefType>()) {
        auto isBuildBuffer = VulkanBufferMap.find(operand);
        // if don't build buffer, build one.
        if (isBuildBuffer == VulkanBufferMap.end()) {
          builder.setInsertionPoint(op.getOperation());
          auto allocOp = builder.create<vulkan::Alloc>(
              loc, pmlc::dialect::vulkan::BufferType::get(ctx), VkInstance);

          auto buffer = allocOp.getResult();
          VulkanBufferMap[operand] = buffer;
        }
        mapVkBuffer.push_back(VulkanBufferMap[operand]);
      }
    }
    opBufferMap[op] = mapVkBuffer;
  });
  return mlir::success();
}

LogicalResult ConvertGpuToVulkan::convertLaunchFucOp(FuncOp op) {
  auto ctx = op.getContext();
  OpBuilder builder(ctx);
  mlir::Location loc = op.getLoc();

  op.walk([&](gpu::LaunchFuncOp launchFuncOp) {
    builder.setInsertionPoint(launchFuncOp);
    std::vector<mlir::Value> &v = opBufferMap[launchFuncOp];
    auto shaderModule = builder.create<vulkan::CreateShaderModuleOp>(
        loc, VkInstance, ArrayRef<mlir::Value>(v));

    // Add launch_func with new operands inside schedule_func.
    mlir::OpBuilder::InsertionGuard insertionGuard(builder);
    builder.createBlock(&shaderModule.body(), shaderModule.body().end());

    // Find kernel that operation launches.
    mlir::SymbolRefAttr kernelSymbol = launchFuncOp.kernel();
    auto kernelOp = mlir::SymbolTable::lookupNearestSymbolFrom<gpu::GPUFuncOp>(
        launchFuncOp.getOperation(), kernelSymbol);
    builder.create<gpu::LaunchFuncOp>(
        loc, kernelOp, launchFuncOp.getGridSizeOperandValues(),
        launchFuncOp.getBlockSizeOperandValues(), launchFuncOp.getOperands());

    launchFuncOp.erase();
  });
  return mlir::success();
}

LogicalResult ConvertGpuToVulkan::updateVkBuffer(FuncOp funcOp) {
  auto ctx = funcOp.getContext();
  OpBuilder builder(ctx);
  mlir::Location loc = funcOp.getLoc();

  funcOp.walk([&](mlir::Operation *op) {
    if (mlir::dyn_cast<mlir::LoadOp>(op)) {
      for (auto operand : op->getOperands()) {
        auto operandType = operand.getType();
        if (operandType.isa<MemRefType>()){
          auto isBuildBuffer = VulkanBufferMap.find(operand);
          if (isBuildBuffer != VulkanBufferMap.end()) {
            builder.setInsertionPoint(op);
            auto newOp = builder.create<vulkan::ReadFromDevice>(
                loc, operandType, VulkanBufferMap[operand], VkInstance);
            auto newOperand = newOp.getResult();
            op->setOperand(1, newOperand);
          }
        }
      }
    }
    if (mlir::dyn_cast<mlir::StoreOp>(op)) {
      for (auto operand : op->getOperands()) {
        auto operandType = operand.getType();
        if (operandType.isa<MemRefType>()){
          auto isBuildBuffer = VulkanBufferMap.find(operand);
          if (isBuildBuffer != VulkanBufferMap.end()) {
            builder.setInsertionPointAfter(op);
            builder.create<vulkan::WriteToDevice>(
                loc, vulkan::BufferType::get(ctx), VulkanBufferMap[operand],
                VkInstance);
          }
        }
      }
    }
  });
  return mlir::success();
}

void ConvertGpuToVulkan::runOnOperation() {
  // may have multi funcOp
  for (auto funcOp : getOperation().getOps<mlir::FuncOp>()) {
    if (mlir::failed(createInitVulkan(funcOp))) {
      return signalPassFailure();
    }
    if (mlir::failed(createSubmit(funcOp))) {
      return signalPassFailure();
    }
    if (mlir::failed(createDeInitVulkan(funcOp))) {
      return signalPassFailure();
    }
    if (mlir::failed(createVkBuffer(funcOp))) {
      return signalPassFailure();
    }
    if (mlir::failed(convertLaunchFucOp(funcOp))) {
      return signalPassFailure();
    }
    if (mlir::failed(updateVkBuffer(funcOp))) {
      return signalPassFailure();
    }
  }
}

} // namespace

std::unique_ptr<mlir::Pass> createConvertGpuToVulkanPass() {
  return std::make_unique<ConvertGpuToVulkan>();
}

} // namespace pmlc::conversion::gpu_to_vulkan
