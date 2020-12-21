// Copyright (C) 2020 Intel Corporation
// SPDX-License-Identifier: Apache-2.0
//

#include "plaidml_ops.hpp"
#include "plaidml_util.hpp"

#include "ngraph/opsets/opset.hpp"
#include "ngraph/opsets/opset3.hpp"

#include "plaidml/op/op.h"

using namespace plaidml;          // NOLINT[build/namespaces]
using namespace InferenceEngine;  // NOLINT[build/namespaces]

namespace {

template <typename T>
std::vector<T> cast_constant_operand(size_t operand_idx, ngraph::Node* layer) {
  auto* ngraph_const = ngraph::as_type<ngraph::op::Constant>(layer->get_input_node_ptr(operand_idx));
  if (ngraph_const) {
    return ngraph_const->cast_vector<T>();
  } else {
    THROW_IE_EXCEPTION << "Dynamically-sized Range operation not currently supported by PlaidML plugin; all of start, "
                          "stop, and step must be Constants.";
  }
}

}  // namespace

namespace PlaidMLPlugin {

void registerRange() {
  registerOp("range", [](const Context& ctx) {
    auto* layer = ngraph::as_type<ngraph::opset3::Range>(ctx.layer);
    auto start = cast_constant_operand<float>(0, layer)[0];
    auto stop = cast_constant_operand<float>(1, layer)[0];
    auto step = cast_constant_operand<float>(2, layer)[0];
    std::vector<float> range_data;
    if (step == 0) {
      THROW_IE_EXCEPTION << "Range requires non-zero step value";
    }
    if (step > 0) {
      float curr_val = start;
      while (curr_val < stop) {
        range_data.push_back(curr_val);
        curr_val += step;
      }
    } else {
      float curr_val = start;
      while (curr_val > stop) {
        range_data.push_back(curr_val);
        curr_val += step;
      }
    }

    auto size = range_data.size();
    TensorShape shape(DType::FLOAT32, {static_cast<int64_t >(size)});
    Buffer buffer(shape);
    buffer.copy_from(range_data.data());
    return edsl::make_tuple(edsl::Constant(buffer, "range_tensor"));
  });
}

}  // namespace PlaidMLPlugin