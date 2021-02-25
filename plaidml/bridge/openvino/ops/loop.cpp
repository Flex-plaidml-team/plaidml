// Copyright (C) 2021 Intel Corporation
// SPDX-License-Identifier: Apache-2.0
//

#include "plaidml_ops.hpp"
#include "plaidml_util.hpp"

#include "ngraph/opsets/opset.hpp"
#include "ngraph/opsets/opset5.hpp"

#include "plaidml/op/op.h"

using namespace plaidml;  // NOLINT[build/namespaces]

namespace PlaidMLPlugin {

void registerLoop() {
  registerOp("loop", [](const Context& ctx) {
    auto* layer = ngraph::as_type<ngraph::opset5::Loop>(ctx.layer);
    IE_ASSERT(ctx.operands.size() == 2);
    auto paramVector = ctx.operands;

    auto loopCount = layer->get_num_iterations();
    auto body_ports = layer->get_special_body_ports();
    auto loop_body = layer->get_function();

    auto inputDes = layer->get_input_descriptions();
    auto outputDes = layer->get_output_descriptions();



    auto axes = get_axis_vector_from_constant_operand(1, ctx.layer);
    IE_ASSERT(axes.size() == 1);
    auto axis = axes[0];

    auto ndims = I.rank();
    std::vector<edsl::TensorDim> I_dims(ndims);
    std::vector<edsl::TensorIndex> I_idxs(ndims);
    std::vector<edsl::Tensor> Os;
    I.bind_dims(I_dims);
    auto O_dims = I_dims;
    auto split_size = I_dims[axis] / splits;
    O_dims[axis] = split_size;
    for (size_t i = 0; i < splits; i++) {
      auto O_idxs = I_idxs;
      O_idxs[axis] = I_idxs[axis] - i * split_size;
      Os.push_back(plaidml::edsl::Contraction().outShape(O_dims).outAccess(O_idxs).assign(I(I_idxs)));
    }
    return edsl::make_tuple(Os);
  });
}

}  // namespace PlaidMLPlugin
