// Copyright 2020, Intel Corporation
#ifndef __PMLC_GPU_KERNEL_OUTLINING_PASS__
#define __PMLC_GPU_KERNEL_OUTLINING_PASS__

include "mlir/Pass/PassBase.td"

def GpuKernelOutliningPass : Pass<"pmlc-kernel_outlining", "mlir::ModuleOp"> {
  let summary = "Outline gpu.launch bodies to kernel functions";
  let constructor = "pmlc::conversion::gpu::createGpuKernelOutliningPass()";
  let dependentDialects = [
    "mlir::gpu::GPUDialect",
    "mlir::spirv::SPIRVDialect"
  ];
}


def HostOpsToGPUKernelPass : Pass<"pmlc-host-ops-to-kernel", "mlir::ModuleOp"> {
  let summary = "Construct new gpu.modules for operations defined between gpu.modules";
  let constructor = "pmlc::conversion::gpu::createHostOpsToGPUKernelPass()";
  let dependentDialects = [
    "mlir::gpu::GPUDialect",
    "mlir::spirv::SPIRVDialect",
  ];
}

#endif // __PMLC_GPU_KERNEL_OUTLINING_PASS__
