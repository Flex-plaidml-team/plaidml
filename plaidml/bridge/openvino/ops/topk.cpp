// Copyright (C) 2020 Intel Corporation
// SPDX-License-Identifier: Apache-2.0
//

#include "plaidml_ops.hpp"
#include "plaidml_util.hpp"

#include "ngraph/opsets/opset.hpp"
#include "ngraph/opsets/opset4.hpp"

#include "plaidml/op/op.h"

using namespace plaidml;          // NOLINT[build/namespaces]
using namespace InferenceEngine;  // NOLINT[build/namespaces]

namespace {

edsl::Tensor sort_tensor(edsl::Tensor &I, const edsl::Tensor &indices){
  return ;
}

}  // namespace

namespace PlaidMLPlugin {

void registerTopK() {
  registerOp("TopK", [](const Context& ctx) {
    auto* layer = ngraph::as_type<ngraph::opset4::TopK>(ctx.layer);
    IE_ASSERT(ctx.operands.size() == 1);
    auto I = ctx.operands.at(0);
    auto axis = layer->get_axis();

    auto mode = layer->get_mode();
    edsl::SortDirection direction;
    switch (mode) {
      case ngraph::op::TopKMode::MAX:
        direction = edsl::SortDirection::DESC;
        break;
      case ngraph::op::TopKMode::MIN:
        direction = edsl::SortDirection::ASC;
        break;
      default:
        THROW_IE_EXCEPTION << "Invalid topk sort_mode";
    }
    auto out_index = edsl::argsort(I, axis, direction);

    auto k = layer->get_k();
    auto sort_type = layer->get_sort_type();
    edsl::Tensor k_index = edsl::gather(out_index, edsl::index({edsl::TensorDim(k)}, 0)).axis(axis);
    edsl::Tensor slice_I = edsl::gather(I, edsl::index({edsl::TensorDim(k)}, 0)).axis(axis);

    edsl::Tensor out_tensor, out_indices;
    auto sort_out = [&]() {
      std::vector<edsl::TensorDim> dims(slice_I.rank());
      slice_I.bind_dims(dims);
      for (auto i = 0; i < slice_I.rank(); i++) {
        out_tensor = edsl::gather(slice_I, edsl::index({dims[i]}, 0)).axis(i);
      }
      return out_tensor;
    };
    // TODO our problem is that we can only get sort indices but not sort it self.
    switch (sort_type) {
      case ngraph::op::TopKSortType::SORT_INDICES:
        k_index = edsl::argsort(k_index, axis, edsl::SortDirection::ASC);
        out_indices = k_index;
        out_tensor = sort_out();
        break;
      case ngraph::op::TopKSortType::SORT_VALUES:
        out_indices = k_index;
        out_tensor = sort_out();
        break;
      default:
        out_indices = k_index;
        out_tensor = sort_out();
    }

    return edsl::make_tuple(out_tensor, out_index);
  });
}

}  // namespace PlaidMLPlugin
