// Copyright (C) 2021 Intel Corporation
// SPDX-License-Identifier: Apache-2.0
//

#include "plaidml_ops.hpp"
#include "plaidml_util.hpp"

#include "ngraph/opsets/opset.hpp"
#include "ngraph/opsets/opset5.hpp"

#include "plaidml/op/op.h"

using namespace plaidml;          // NOLINT[build/namespaces]
using namespace InferenceEngine;  // NOLINT[build/namespaces]

namespace PlaidMLPlugin {

void registerDeformablePSROIPooling() {
  registerOp("DeformablePSROIPooling", [](const Context& ctx) {
    // auto* layer = ngraph::as_type<ngraph::opset5::DeformablePSROIPooling>(ctx.layer);
    // IE_ASSERT(ctx.operands.size() == 3);
    auto I = ctx.operands.at(0);  // Input
    // auto C = ctx.operands.at(1);       // Coords
    // auto OFF = ctx.operands.at(2);     // Offsets
    auto O = op::slice(I).add_dim(0, 1).add_dim(0, 2).add_dim(0, 2).add_dim(0, 2);
    return edsl::make_tuple(O);
  });
}

}  // namespace PlaidMLPlugin
