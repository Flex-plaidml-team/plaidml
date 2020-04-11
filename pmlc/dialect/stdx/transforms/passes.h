// Copyright 2020 Intel Corporation

#pragma once

#include <functional>
#include <memory>

namespace mlir {
class Pass;
} // namespace mlir

namespace pmlc::dialect::stdx {

std::unique_ptr<mlir::Pass> createBoundsCheckPass();

} // namespace pmlc::dialect::stdx