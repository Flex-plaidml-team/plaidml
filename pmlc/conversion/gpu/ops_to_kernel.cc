

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

using namespace mlir; // NOLINT[build/namespaces]


namespace pmlc::conversion::gpu {
    namespace gpu = mlir::gpu;
    /// Pass that Construct new gpu.modules for operations defined between gpu.modules.
    ///
    /// This pass moves host operations between each two LaunchOps into a new LaunchOp to
    /// make them running on device.
    class HostOpsToGPUKernelPass : public HostOpsToGPUKernelPassBase<HostOpsToGPUKernelPass> {

    };

    std::unique_ptr<mlir::Pass> createHostOpsToGPUKernelPass() {
        return std::make_unique<HostOpsToGPUKernelPass>();
    }
}
