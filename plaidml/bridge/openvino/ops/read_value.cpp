// Copyright (C) 2020 Intel Corporation
// SPDX-License-Identifier: Apache-2.0
//

#include "plaidml_ops.hpp"

#include "ngraph/opsets/opset3.hpp"

#include "ngraph/opsets/opset4.hpp"

#include "plaidml/op/op.h"

#include "plaidml/edsl/edsl.h"

#include "plaidml_util.hpp"

using namespace plaidml;          // NOLINT[build/namespaces]
using namespace InferenceEngine;  // NOLINT[build/namespaces]
using namespace ngraph;

namespace PlaidMLPlugin {

void registerReadValue() {
  registerOp("ReadValue", [](const Context& ctx) {
    auto* layer = ngraph::as_type<ngraph::opset3::ReadValue>(ctx.layer);
    IE_ASSERT(ctx.operands.size() == 1);
    auto I = ctx.operands.at(0);
    I = I + 0;  // Plaidml doesn't support return without operation
    // it can't work with it replace I = I+0 operation
    // auto C = I;
    auto variable_info = layer->get_variable()->get_info();
    auto variable_type = variable_info.data_type;
    auto variable_shape = variable_info.data_shape;
    auto variable_id = variable_info.variable_id;
    auto output_shape = layer->get_output_shape(0);
    auto output_type = layer->get_output_element_type(0);
    if (variable_id != layer->get_variable_id()) {
      THROW_IE_EXCEPTION << "Variables identifiers are inconsistent.";
    }
    // check type of output
    if (output_type != variable_type) {
      THROW_IE_EXCEPTION << "Output types are inconsistent.";
    }
    // check whether shape is a dynamic
    if (variable_shape.is_dynamic()) {
      THROW_IE_EXCEPTION << "Dynamic shapes not currently supported by PlaidML plugin.";
    }
    // check shape of the output
    auto shape = variable_shape.to_shape();
    if (shape != output_shape) {
      THROW_IE_EXCEPTION << "Output shapes are inconsistent.";
    }
    return edsl::make_tuple(I);
  });
}

}  // namespace PlaidMLPlugin
