//
// Created by liyangling on 8/20/20.
//

#pragma once

#include "mlir/Dialect/StandardOps/IR/Ops.h"

namespace pmlc::dialect::pxa {

mlir::TruncateIOp truncITypeTransformation(mlir::TruncateIOp op);

} // namespace pmlc::dialect::pxa
