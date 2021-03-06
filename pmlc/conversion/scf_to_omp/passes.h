// Copyright 2020, Intel Corporation

#pragma once

#include <memory>

namespace mlir {
class Pass;
} // namespace mlir

namespace pmlc::conversion::scf_to_omp {

std::unique_ptr<mlir::Pass> createLowerSCFToOpenMPPass();

/// Generate the code for registering conversion passes.
#define GEN_PASS_REGISTRATION
#include "pmlc/conversion/scf_to_omp/passes.h.inc"

} // namespace pmlc::conversion::scf_to_omp
