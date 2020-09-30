// Copyright 2020, Intel Corporation
#pragma once

#include <memory>

#include "mlir/Pass/PassRegistry.h"
#include "mlir/Support/LogicalResult.h"

namespace mlir {
class MLIRContext;
class ModuleOp;
class OwningRewritePatternList;
class Pass;
} // namespace mlir

namespace pmlc::conversion::vulkan_to_llvm {

void populateVulkanToPatterns(mlir::MLIRContext *context,
                              mlir::OwningRewritePatternList &patterns);

std::unique_ptr<mlir::Pass> createConvertVulkanTollvmPass();

/// Generate the code for registering conversion passes.
#define GEN_PASS_REGISTRATION
#include "pmlc/conversion/vulkan_to_llvm/passes.h.inc"

} // namespace pmlc::conversion::comp_to_llvm
