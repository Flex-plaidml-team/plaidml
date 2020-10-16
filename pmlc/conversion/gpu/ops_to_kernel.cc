

#include "mlir/Dialect/GPU/GPUDialect.h"
#include "mlir/Dialect/GPU/Passes.h"
#include "mlir/Dialect/GPU/Utils.h"
#include "mlir/Dialect/StandardOps/IR/Ops.h"
#include "mlir/IR/BlockAndValueMapping.h"
#include "mlir/IR/Builders.h"
#include "mlir/IR/StandardTypes.h"
#include "mlir/IR/SymbolTable.h"
#include "mlir/Transforms/RegionUtils.h"

#include "mlir/Dialect/SPIRV/SPIRVAttributes.h"
#include "mlir/Dialect/SPIRV/SPIRVOps.h"
#include "mlir/Dialect/SPIRV/Serialization.h"
#include "mlir/Dialect/SPIRV/TargetAndABI.h"

#include "pmlc/conversion/gpu/pass_detail.h"
#include "pmlc/util/tags.h"

#include <iostream>

using namespace mlir; // NOLINT[build/namespaces]

namespace pmlc::conversion::gpu {
namespace gpu = mlir::gpu;
using mlir::FuncOp;
using mlir::MemRefType;
using mlir::OpBuilder;
using mlir::SmallVector;
using mlir::Value;

/// Pass that Construct new gpu.modules for operations defined between
/// gpu.modules.
///
/// This pass moves host operations between each two LaunchOps into a new
/// LaunchOp to make them running on device.
class HostOpsToGPUKernelPass
    : public HostOpsToGPUKernelPassBase<HostOpsToGPUKernelPass> {
public:
  void runOnOperation() override {
    auto moduleOp = getOperation();
    OpBuilder builder(moduleOp.getContext());
    BlockAndValueMapping cloningMap;

    for (auto funcOp : moduleOp.getOps<FuncOp>()) {
      int numLaunchOp = 0;
      bool startCreatingLaunchOp = false;
      SmallVector<Operation *, 16> worklist;
      moduleOp.walk([&numLaunchOp](gpu::LaunchOp op) { numLaunchOp++; });
      if (numLaunchOp <= 1) {
        break;
      }
      std::cout << "!!! # LaunchOp is " << numLaunchOp << std::endl;
      for (auto &op : llvm::make_early_inc_range(funcOp.getOps())) {
        auto gpuLaunchOp = dyn_cast<gpu::LaunchOp>(op);
        auto allocOp = dyn_cast<mlir::AllocOp>(op);

        if (numLaunchOp == 0) {
          builder.setInsertionPoint(&op);
          cloneOp(builder, cloningMap, &op);
          continue;
        }

        if (gpuLaunchOp) {
          numLaunchOp--;
        }

        if (startCreatingLaunchOp) {
          if (allocOp == nullptr && gpuLaunchOp == nullptr) {
            worklist.push_back(&op);
          } else {
            checkOpsUses(builder, worklist);
            worklist.clear();
          }
        } else {
          if (gpuLaunchOp) {
            startCreatingLaunchOp = true;
          }
        }
      }

      numLaunchOp = 0;
      startCreatingLaunchOp = false;
      worklist.clear();
      moduleOp.walk([&numLaunchOp](gpu::LaunchOp op) { numLaunchOp++; });
      if (numLaunchOp <= 1) {
        break;
      }

      for (auto &op : llvm::make_early_inc_range(funcOp.getOps())) {
        auto gpuLaunchOp = dyn_cast<gpu::LaunchOp>(op);
        auto allocOp = dyn_cast<mlir::AllocOp>(op);

        if (numLaunchOp == 0) {
          builder.setInsertionPoint(&op);
          cloneOp(builder, cloningMap, &op);
          continue;
        }

        if (gpuLaunchOp) {
          numLaunchOp--;
        }

        if (startCreatingLaunchOp) {
          if (allocOp == nullptr && gpuLaunchOp == nullptr) {
            worklist.push_back(&op);
          } else {
            createLaunchOp(builder, cloningMap, worklist);
            worklist.clear();
          }
        } else {
          if (gpuLaunchOp) {
            startCreatingLaunchOp = true;
          }
        }
      }
    }
  }

private:
  mlir::Type getUnrankedMemRefType(Type elementType) {
    return UnrankedMemRefType::get(elementType, /*memorySpace=*/0);
  }

  void cloneOp(OpBuilder &builder, BlockAndValueMapping &cloningMap,
               Operation *op) {
    Operation *clone = builder.clone(*op, cloningMap);
    cloningMap.map(op->getResults(), clone->getResults());
    op->erase();
  }

  void checkOpsUses(OpBuilder &builder,
                    SmallVectorImpl<Operation *> &worklist) {

    auto resultUsedOutsideModule =
        [&](Value var, int numUses,
            SmallVectorImpl<Operation *> &worklist) -> bool {
      int useCount = 0;
      for (auto op : worklist) {
        for (auto operand : op->getOperands()) {
          if (operand == var) {
            useCount++;
          }
        }
      }
      return useCount < numUses;
    };

    auto loc = worklist.front()->getLoc();
    BlockAndValueMapping cloningMap;
    for (auto op : worklist) {
      auto result = op->getResult(0);
      int numUses = 0;
      for (auto &use : op->getUses()) {
        use.getOwner();
        numUses++;
      }
      if (resultUsedOutsideModule(result, numUses, worklist)) {
        builder.setInsertionPoint(worklist.front());
        auto memrefType = result.getType().cast<MemRefType>();
        auto allocOp = builder.create<AllocOp>(loc, memrefType);
        builder.setInsertionPointAfter(op);
        builder.create<StoreOp>(loc, result, allocOp);
        for (auto &use : op->getUses()) {
          auto useOp = use.getOwner();
          builder.setInsertionPointAfter(useOp);
          auto loadOp = builder.create<LoadOp>(loc, allocOp);
          cloningMap.map(op->getResult(0), loadOp.getResult());
          builder.clone(*useOp, cloningMap);
          useOp->erase();
        }
      }
    }
  }

  void createLaunchOp(OpBuilder &builder, BlockAndValueMapping &cloningMap,
                      SmallVectorImpl<Operation *> &worklist) {
    if (worklist.empty())
      return;
    builder.setInsertionPoint(worklist.front());
    auto loc = worklist.front()->getLoc();
    Value constantOne = builder.create<ConstantIndexOp>(loc, 1);
    auto launchOp = builder.create<gpu::LaunchOp>(loc, constantOne, constantOne,
                                                  constantOne, constantOne,
                                                  constantOne, constantOne);
    builder.setInsertionPointToEnd(&launchOp.body().front());
    builder.create<gpu::TerminatorOp>(loc);
    builder.setInsertionPointToStart(&launchOp.body().front());
    for (auto &hostOp : llvm::make_early_inc_range(worklist)) {
      cloneOp(builder, cloningMap, hostOp);
    }
  }
};

std::unique_ptr<mlir::Pass> createHostOpsToGPUKernelPass() {
  return std::make_unique<HostOpsToGPUKernelPass>();
}
} // namespace pmlc::conversion::gpu
