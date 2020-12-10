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

template <typename T>
std::vector<T> cast_constant_operand(size_t operand_idx, ngraph::Node* layer) {
  auto* ngraph_const = ngraph::as_type<ngraph::op::Constant>(layer->get_input_node_ptr(operand_idx));
  if (ngraph_const) {
    return ngraph_const->cast_vector<T>();
  } else {
    THROW_IE_EXCEPTION << "Dynamic slicing not currently supported by PlaidML plugin; all of begin, end, and stride "
                          "must be Constants.";
  }
}

std::tuple<edsl::Tensor, int, int> crop_resized(edsl::Tensor I, std::vector<float>& coord, std::string method,
                                                int64_t pooled_h, int64_t pooled_w) {
  auto x_1 = coord[0];
  auto y_1 = coord[1];
  auto x_2 = coord[2];
  auto y_2 = coord[3];

  auto roi_width = std::max(x_2 - x_1, 1.0f);
  auto roi_height = std::max(y_2 - y_1, 1.0f);

  int kernel_h = static_cast<int>(std::floor(roi_height / pooled_h));
  int kernel_w = static_cast<int>(std::floor(roi_width / pooled_w));

  edsl::Tensor w_tensor, h_tensor;
  edsl::InterpolationMode interpolation_mode;
  if (method != "bilinear") {
    h_tensor = edsl::index({edsl::TensorDim(pooled_h)}, 0) * kernel_h + static_cast<int>(x_1);
    w_tensor = edsl::index({edsl::TensorDim(pooled_w)}, 0) * kernel_w + static_cast<int>(y_1);
    interpolation_mode = edsl::InterpolationMode::NEAREST;
  } else {
    h_tensor = edsl::cast(edsl::index({edsl::TensorDim(pooled_h)}, 0), DType::FLOAT32) * kernel_h + x_1;
    w_tensor = edsl::cast(edsl::index({edsl::TensorDim(pooled_w)}, 0), DType::FLOAT32) * kernel_w + y_1;
    interpolation_mode = edsl::InterpolationMode::LINEAR;
  }

  auto gather_w = edsl::gather(I, w_tensor).axis(3).interpolationMode(interpolation_mode);
  auto gather_h = edsl::gather(gather_w, h_tensor).axis(2).interpolationMode(interpolation_mode);

  return std::make_tuple(gather_h, kernel_h, kernel_w);
}

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

    // TODO those are actually n*1 dims. we have to slice them to 1*1.
    auto batch_id = edsl::gather(coords, edsl::index({edsl::TensorDim(1)}, 0)).axis(1);
    auto x_1 = edsl::gather(coords, edsl::index({edsl::TensorDim(1)}, 0) + 1).axis(1);
    auto y_1 = edsl::gather(coords, edsl::index({edsl::TensorDim(1)}, 0) + 2).axis(1);
    auto x_2 = edsl::gather(coords, edsl::index({edsl::TensorDim(1)}, 0) + 3).axis(1);
    auto y_2 = edsl::gather(coords, edsl::index({edsl::TensorDim(1)}, 0) + 4).axis(1);
    if (method == "max") {
      auto x1 = edsl::round(x_1 * spatial_ratio);
      auto y1 = edsl::round(y_1 * spatial_ratio);
      auto x2 = edsl::round(x_2 * spatial_ratio);
      auto y2 = edsl::round(y_2 * spatial_ratio);
      auto roi_width = edsl::select(y2 - y1 + 1 < 1, edsl::Tensor{1}, y2 - y1 + 1);
      auto roi_height = edsl::select(x2 - x1 + 1 < 1, edsl::Tensor{1}, x2 - x1 + 1);
      auto bin_size_h = roi_height / pooled_height;
      auto bin_size_w = roi_width / pooled_width;

      auto x_indices = edsl::index({edsl::TensorDim(pooled_width)}, 0) * bin_size_w + x_1;
      auto y_indices = edsl::index({edsl::TensorDim(pooled_height)}, 0) * bin_size_h + y_1;

      for (int i = 0; i < pooled_height; i++) {
      }
      for (int j = 0; j < pooled_width; j++) {
      }
    } else if (method == "bilinear") {
    }

    //    const static int BOX_ELEMENT_SIZE = 5;
    //    auto coords_box = cast_constant_operand<float>(1, layer);
    //    IE_ASSERT((coords_box.size() % BOX_ELEMENT_SIZE) == 0);
    //
    //    std::vector<edsl::Tensor> ROI_pools;
    //    // 2D input tensor of shape [NUM_ROIS, 5] describing box
    //    for (auto index = coords_box.begin(); index != coords_box.end(); index += BOX_ELEMENT_SIZE) {
    //      // consisting of 5 element tuples: [batch_id, x_1, y_1, x_2, y_2]
    //      auto batch_id = *index;
    //      std::vector<float> coord(index + 1, index + BOX_ELEMENT_SIZE);
    //      // translate ROI coordinates from their input spatial scale to the scale used when pooling
    //      for (int i = 1; i < coord.size(); i++) {
    //        coord[i] *= spatial_ratio;
    //      }
    //      auto batch_indices = edsl::index({edsl::TensorDim(1)}, 0) + batch_id;
    //      auto slice_I = edsl::gather(I, batch_indices).axis(0);
    //
    //      edsl::Tensor ROI_tensor;
    //      int kernel_height;
    //      int kernel_width;
    //      std::tie(ROI_tensor, kernel_height, kernel_width) =
    //          crop_resized(slice_I, coord, method, pooled_height, pooled_width);
    //
    //      auto pooled_tensor = op::pool(ROI_tensor,                     //
    //                                    op::PoolMode::MAX,              //
    //                                    {kernel_height, kernel_width},  //
    //                                    {kernel_height, kernel_width},  //
    //                                    op::AutoPadMode::VALID,         //
    //                                    {},                             //
    //                                    op::TensorLayout::NCX);
    //
    //      ROI_pools.push_back(pooled_tensor);
    //    }
    //
    //    auto O = op::concatenate(ROI_pools, 0);
    auto O = I;
    return edsl::make_tuple(O);
  });
}
}  // namespace PlaidMLPlugin
