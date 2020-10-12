// Copyright 2020, Intel Corporation
#ifndef __PMLC_CONVERSION_COMP_TO_VULKANCALL_PASSES__
#define __PMLC_CONVERSION_COMP_TO_VULKANCALL_PASSES__

include "mlir/Pass/PassBase.td"

def ConvertCompToVulkanCall : Pass<"pmlc-convert-comp-to-vulkanCall", "mlir::ModuleOp"> {
  let summary = "Convert comp operations to Vulkan runtime calls";
  let constructor = "pmlc::conversion::comp_to_vulkanCall::createConvertCompToVulkanCallPass()";
  let dependentDialects = [
    "mlir::LLVM::LLVMDialect",
    "mlir::StandardOpsDialect"
  ];
}

#endif // __PMLC_CONVERSION_COMP_TO_VULKANCALL_PASSES__
