// Copyright (C) 2021 Intel Corporation
// SPDX-License-Identifier: Apache-2.0
//

#include "plaidml_ops.hpp"

#include "ngraph/opsets/opset.hpp"
#include "ngraph/opsets/opset1.hpp"

#include "plaidml/op/op.h"

using namespace plaidml;          // NOLINT[build/namespaces]
using namespace InferenceEngine;  // NOLINT[build/namespaces]

namespace PlaidMLPlugin {

void registerLogicalXor() {
  registerOp("LogicalXor", [](const Context& ctx) {
    IE_ASSERT(ctx.operands.size() == 2);
    // cast to bool and use bitwise xor for now
    auto A = edsl::cast(ctx.operands.at(0), plaidml::DType::BOOLEAN);
    auto B = edsl::cast(ctx.operands.at(1), plaidml::DType::BOOLEAN);
    return edsl::make_tuple(A ^ B);
  });
}

}  // namespace PlaidMLPlugin
