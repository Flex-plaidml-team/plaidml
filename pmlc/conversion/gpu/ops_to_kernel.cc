

#include "mlir/Dialect/GPU/GPUDialect.h"
#include "mlir/Dialect/GPU/Passes.h"
#include "mlir/Dialect/GPU/Utils.h"
#include "mlir/Dialect/StandardOps/IR/Ops.h"
#include "mlir/IR/BlockAndValueMapping.h"
#include "mlir/IR/Builders.h"
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
  void cloneOp(OpBuilder &builder, BlockAndValueMapping &cloningMap,
               Operation *op) {
    Operation *clone = builder.clone(*op, cloningMap);
    cloningMap.map(op->getResults(), clone->getResults());
    op->erase();
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
