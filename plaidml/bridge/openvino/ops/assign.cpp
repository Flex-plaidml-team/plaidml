// Copyright (C) 2020 Intel Corporation
// SPDX-License-Identifier: Apache-2.0
//

#include "plaidml_ops.hpp"

#include "ngraph/opsets/opset3.hpp"

#include "ngraph/opsets/opset4.hpp"

#include "plaidml/op/op.h"

#include "plaidml/edsl/edsl.h"

#include "ngraph/op/assign.hpp"
#include "ngraph/op/read_value.hpp"
#include "ngraph/ops.hpp"

using namespace plaidml;          // NOLINT[build/namespaces]
using namespace InferenceEngine;  // NOLINT[build/namespaces]
using namespace ngraph;

namespace PlaidMLPlugin {

void registerConcat() {
  registerOp("Assign", [](const Context& ctx) {
    auto* layer = ngraph::as_type<ngraph::opset3::Assign>(ctx.layer);
    IE_ASSERT(ctx.operands.size() == 1);
    auto I = ctx.operands.at(0);
    auto variable_info = layer->get_variable()->get_info();
    auto variable_id = layer->get_variable_id();
    auto variable_shape = variable_info.data_shape;
    auto shape = variable_shape.to_shape();
    auto variable_type = variable_info.data_type;
    auto input_shape = layer->get_input_shape(0);
    auto input_type = layer->get_input_element_type(0);
    // Check that whether the variable identifiers are consistent
    if (variable_id != variable_info.variable_id) {
      THROW_IE_EXCEPTION << "Variables identifiers are inconsistent.";
    }
    // Check that the type of the input are the same as declared in variable
    if (input_type != variable_type) {
      THROW_IE_EXCEPTION << "Input types are inconsistent.";
    }
    // Check that whether the shape is dynamic
    if (variable_shape.is_dynamic()) {
      THROW_IE_EXCEPTION << "Dynamic shapes not currently supported by PlaidML plugin.";
    }
    // Check that the shape of the input are the same as declared in variable
    if (input_shape != shape) {
      THROW_IE_EXCEPTION << "Input shapes are inconsistent.";
    }
    NodeVector start_nodes;
    for (const auto& input : layer->inputs()) {
      start_nodes.push_back(input.get_source_output().get_node_shared_ptr());
    }
    auto nodes = topological_sort(start_nodes);
    for (const auto& node : nodes) {
      if (auto read_value = as_type_ptr<ngraph::op::v3::ReadValue>(node)) {
        if (read_value->get_variable_id() == variable_id) {
          auto assign_input = layer->input(0);
          auto assign_src_output = assign_input.get_source_output();
          // read_value->set_argument(0, assign_src_output); //It doesn't work because the network occurs a circle
          // tensormap[read_value->get_name(), 0] = I; //It need tensormap's support;
        }
      }
    }
    return edsl::make_tuple(I);
  });
}

}  // namespace PlaidMLPlugin
