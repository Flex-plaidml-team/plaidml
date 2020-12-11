// Copyright (C) 2020 Intel Corporation
// SPDX-License-Identifier: Apache-2.0
//

#include "ngraph/opsets/opset.hpp"
#include "ngraph/opsets/opset4.hpp"
#include "plaidml/op/op.h"
#include "plaidml_ops.hpp"
#include "plaidml_util.hpp"
#include <tuple>

using namespace plaidml;          // NOLINT[build/namespaces]
using namespace InferenceEngine;  // NOLINT[build/namespaces]

namespace {

/// if we only have start of point and end of point, we don't have method to interpolation them, so we can use them to
/// gather op. gather op need index, but we don't have much method to operate index.
edsl::Tensor interpolation_indices(edsl::Tensor start, edsl::Tensor end) {
  std::vector<edsl::Tensor> indices_pool;
  edsl::Tensor idx = start;
  while (true) {
    indices_pool.push_back(idx);
    // TODO there is no way, tensor binary operation can generate bool result.
    if (idx == end) {
      break;
    }
    idx = idx + 1;
  }
  return op::concatenate(indices_pool, 1);
}

}  // namespace

namespace PlaidMLPlugin {

void registerROIPooling() {
  registerOp("roi_pooling", [](const Context& ctx) {
    auto* layer = ngraph::as_type<ngraph::opset4::ROIPooling>(ctx.layer);
    IE_ASSERT(ctx.operands.size() == 2);
    auto I = ctx.operands.at(0);
    auto coords = ctx.operands.at(1);
    auto pooled_shape = layer->get_output_size();
    auto pooled_height = static_cast<int64_t>(pooled_shape[0]);
    auto pooled_width = static_cast<int64_t>(pooled_shape[1]);
    auto spatial_ratio = layer->get_spatial_scale();
    auto method = layer->get_method();

    auto zero_indices = edsl::index({edsl::TensorDim(1)}, 0);
    auto batch_id = edsl::gather(coords, zero_indices).axis(1);
    auto x_1 = edsl::gather(coords, zero_indices + 1).axis(1);
    auto y_1 = edsl::gather(coords, zero_indices + 2).axis(1);
    auto x_2 = edsl::gather(coords, zero_indices + 3).axis(1);
    auto y_2 = edsl::gather(coords, zero_indices + 4).axis(1);

    std::vector<edsl::Tensor> ROI_pools;
    auto num_ROI = coords.compute_shape().sizes()[0];
    for (int64_t i = 0; i < num_ROI; i++) {
      auto id = edsl::gather(coords, zero_indices + i).axis(0);
      auto pic = edsl::gather(I, id).axis(0);
      auto x1_roi = edsl::gather(x_1, zero_indices + i).axis(0);
      auto y1_roi = edsl::gather(y_1, zero_indices + i).axis(0);
      auto x2_roi = edsl::gather(x_2, zero_indices + i).axis(0);
      auto y2_roi = edsl::gather(y_2, zero_indices + i).axis(0);

      if (method == "max") {
        auto x1 = edsl::round(x1_roi * spatial_ratio);
        auto y1 = edsl::round(y1_roi * spatial_ratio);
        auto x2 = edsl::round(x2_roi * spatial_ratio);
        auto y2 = edsl::round(y2_roi * spatial_ratio);
        auto roi_width = edsl::select(y2 - y1 + 1 < 1, edsl::Tensor{1}, y2 - y1 + 1);
        auto roi_height = edsl::select(x2 - x1 + 1 < 1, edsl::Tensor{1}, x2 - x1 + 1);
        auto bin_size_h = roi_height / pooled_height;
        auto bin_size_w = roi_width / pooled_width;

        std::vector<edsl::Tensor> roi_pool;
        for (int i = 0; i < pooled_height; i++) {
          std::vector<edsl::Tensor> line;
          for (int j = 0; j < pooled_width; j++) {
            auto start_h = edsl::floor(i * bin_size_h);
            auto start_w = edsl::floor(j * bin_size_w);
            auto end_h = edsl::ceil((i + 1) * bin_size_h);
            auto end_w = edsl::ceil((j + 1) * bin_size_w);

            auto h_start = start_h + x1;
            auto w_start = start_w + y1;
            auto h_end = end_h + x2;
            auto w_end = end_w + y2;

            auto h_indices = interpolation_indices(h_start, h_end);
            auto w_indices = interpolation_indices(w_start, w_end);
            auto gather_w = edsl::gather(pic, w_indices).axis(3).interpolationMode(edsl::InterpolationMode::LINEAR);
            auto gather_h = edsl::gather(gather_w, h_indices).axis(2).interpolationMode(edsl::InterpolationMode::LINEAR);
            line.push_back(gather_h);
          }
          roi_pool.push_back(op::concatenate(line, 3));
        }
        ROI_pools.push_back(op::concatenate(roi_pool, 2));
      } else if (method == "bilinear") {
        auto roi_width = y2_roi - y1_roi;
        auto roi_height = x2_roi - x1_roi;

        auto roi_h_scale = roi_height / pooled_height;
        auto roi_w_scale = roi_width / pooled_width;

        auto h_tensor =
            edsl::cast(edsl::index({edsl::TensorDim(pooled_height)}, 0), DType::FLOAT32) * roi_h_scale + x_1;
        auto w_tensor = edsl::cast(edsl::index({edsl::TensorDim(pooled_width)}, 0), DType::FLOAT32) * roi_w_scale + y_1;

        auto gather_w = edsl::gather(pic, w_tensor).axis(3).interpolationMode(edsl::InterpolationMode::LINEAR);
        auto gather_h = edsl::gather(gather_w, h_tensor).axis(2).interpolationMode(edsl::InterpolationMode::LINEAR);
        ROI_pools.push_back(gather_h);
      }
    }
    auto O = op::concatenate(ROI_pools, 0);
    return edsl::make_tuple(O);
  });
}
}  // namespace PlaidMLPlugin
