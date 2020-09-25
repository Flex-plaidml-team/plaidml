// Copyright 2020, Intel Corporation
#ifndef __PMLC_CONVERSION_GPU_TO_VULKAN_PASSES__
#define __PMLC_CONVERSION_GPU_TO_VULKAN_PASSES__

include "mlir/Pass/PassBase.td"

def ConvertGpuToVulkan : Pass<"pmlc-convert-gpu-to-Vulkan", "mlir::ModuleOp"> {
  let summary = "Convert gpu operations to comp operations";
  let description = [{
    Wraps gpu.launch_func operations inside comp.schedule_func and adds
    necessary memory transfers between host and device.
    Execution environments are created seperately for each function launch.
    Converts all kernel function signatures to use memrefs in specified
    memory space.
  }];
  let constructor = "pmlc::conversion::gpu_to_vulkan::createConvertGpuToVulkanPass()";
//  let options = [
//    Option<"execEnvRuntime", "comp-execenv-runtime", "unsigned",
//           /*default=*/"0", "Runtime to use for gpu kernels.">,
//    Option<"execEnvMemorySpace", "comp-execenv-memory-space", "unsigned",
//           /*default=*/"0", "Memory space to use for data transferred to device.">
//  ];
  let dependentDialects = [
    "dialect::vulkan::VkDialect",
    "mlir::gpu::GPUDialect"
  ];
}

#endif // __PMLC_CONVERSION_GPU_TO_VULKAN_PASSES__
