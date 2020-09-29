// Copyright 2020, Intel Corporation
#pragma once

#include <memory>

namespace pmlc::conversion::gpu_to_vulkan {

std::unique_ptr<mlir::Pass> createConvertGpuToVulkanPass();

/// Generate the code for registering conversion passes.
#define GEN_PASS_REGISTRATION
#include "pmlc/conversion/gpu_to_vulkan/passes.h.inc"

} // namespace pmlc::conversion::gpu_to_vulkan
