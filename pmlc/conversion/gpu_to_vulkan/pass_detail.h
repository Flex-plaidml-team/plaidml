// Copyright 2020, Intel Corporation
#pragma once

#include "mlir/Dialect/GPU/GPUDialect.h"
#include "mlir/Pass/Pass.h"

#include "pmlc/dialect/vulkan/ir/ops.h"

namespace pmlc::conversion::gpu_to_vulkan {

#define GEN_PASS_CLASSES
#include "pmlc/conversion/gpu_to_vulkan/passes.h.inc"

} // namespace pmlc::conversion::gpu_to_vulkan
