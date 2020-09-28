// Copyright 2020, Intel Corporation
#ifndef __PMLC_CONVERSION_VULKAN_TO_LLVM_PASSES__
#define __PMLC_CONVERSION_VULKAN_TO_LLVM_PASSES__

include "mlir/Pass/PassBase.td"

def ConvertVulkanTollvm : Pass<"pmlc-convert-vulkan-to-llvm", "mlir::ModuleOp"> {
  let summary = "Convert vulkan operations to vulkan runtime calls";
  let constructor = "pmlc::conversion::vulkan_to_llvm::createConvertVulkanTollvmPass()";
  let dependentDialects = [
    "mlir::LLVM::LLVMDialect",
    "mlir::StandardOpsDialect"
  ];
}

#endif // __PMLC_CONVERSION_VULKAN_TO_LLVM_PASSES__
