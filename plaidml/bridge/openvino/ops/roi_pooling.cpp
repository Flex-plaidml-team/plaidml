// Copyright (C) 2021 Intel Corporation
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

edsl::Tensor crop_max_pooling(edsl::Tensor I, const std::vector<float>& coord, int64_t pooled_h, int64_t pooled_w,
                              int height, int width) {
  auto roi_w_start = coord[0];
  auto roi_h_start = coord[1];
  auto roi_w_end = coord[2];
  auto roi_h_end = coord[3];

  float roi_width = std::max(roi_w_end - roi_w_start + 1, 1.0f);
  float roi_height = std::max(roi_h_end - roi_h_start + 1, 1.0f);

  float bin_size_h = roi_height / pooled_h;
  float bin_size_w = roi_width / pooled_w;

  edsl::Tensor pooled_tensor;
  for (auto i = 0; i < pooled_h; i++) {
    for (auto j = 0; j < pooled_w; j++) {
      // enlarge bin.
      int h1 = roi_h_start + std::floor(bin_size_h * i);
      int w1 = roi_w_start + std::floor(bin_size_w * j);
      int h2 = roi_h_start + std::ceil(bin_size_h * (i + 1));
      int w2 = roi_w_start + std::ceil(bin_size_w * (j + 1));

      // check border.
      auto start_h = std::min(std::max(h1, 0), height);
      auto start_w = std::min(std::max(w1, 0), width);
      auto end_h = std::min(std::max(h2, 0), height);
      auto end_w = std::min(std::max(w2, 0), width);

      // if start equal to end, we have to guarantee that index is at least one. and they are not over the border.
      auto slice_w_index = end_w - start_w > 0 ? end_w - start_w : 1;
      auto slice_h_index = end_h - start_h > 0 ? end_h - start_h : 1;
      auto h_index = start_h >= height ? height - 1 : start_h;
      auto w_index = start_w >= width ? width - 1 : start_w;
      auto h_tensor = edsl::index({edsl::TensorDim(slice_h_index)}, 0) + h_index;
      auto w_tensor = edsl::index({edsl::TensorDim(slice_w_index)}, 0) + w_index;
      auto gather_w = edsl::gather(I, w_tensor).axis(3);
      auto crop = static_cast<edsl::Tensor>(edsl::gather(gather_w, h_tensor).axis(2));

      // get max value from bin, then put it to pooled tensor.
      std::vector<edsl::TensorDim> dims(crop.rank());
      crop.bind_dims(dims);
      std::vector<edsl::TensorIndex> idx(crop.rank());
      edsl::Tensor bin_max = edsl::Contraction()
                                 .outShape({dims[0], dims[1], edsl::TensorDim(pooled_h), edsl::TensorDim(pooled_w)})
                                 .outAccess({idx[0], idx[1], edsl::TensorIndex(i), edsl::TensorIndex(j)})
                                 .max(crop(idx));
      pooled_tensor = (i == 0 && j == 0) ? bin_max : edsl::select(pooled_tensor > bin_max, pooled_tensor, bin_max);
    }
  }
  return pooled_tensor;
}

edsl::Tensor bilinear_pooling(edsl::Tensor I, const std::vector<float>& coord, int64_t pooled_h, int64_t pooled_w,
                              int height, int width) {
  auto roi_w_start = coord[0];
  auto roi_h_start = coord[1];
  auto roi_w_end = coord[2];
  auto roi_h_end = coord[3];

  float roi_width = (roi_w_end - roi_w_start) * (width - 1);
  float roi_height = (roi_h_end - roi_h_start) * (height - 1);

  float roi_h_scale = roi_height / (pooled_h - 1);
  float roi_w_scale = roi_width / (pooled_w - 1);

  // get center point of every ROI bin.
  auto in_y = edsl::cast(edsl::index({edsl::TensorDim(pooled_h)}, 0), DType::FLOAT32) * roi_h_scale +
              roi_h_start * (height - 1);
  auto in_x =
      edsl::cast(edsl::index({edsl::TensorDim(pooled_w)}, 0), DType::FLOAT32) * roi_w_scale + roi_w_start * (width - 1);

  // get it's interpolation point.
  auto top_y_index = edsl::floor(in_y);
  auto bottom_y_index = edsl::ceil(in_y);
  auto left_x_index = edsl::floor(in_x);
  auto right_x_index = edsl::ceil(in_x);

  // check it border.
  auto h_border = edsl::cast(edsl::Tensor(height - 1), DType::FLOAT32);
  auto w_border = edsl::cast(edsl::Tensor(width - 1), DType::FLOAT32);
  bottom_y_index = edsl::select(bottom_y_index < h_border, bottom_y_index, h_border);
  right_x_index = edsl::select(right_x_index < w_border, right_x_index, w_border);

  // gather the interpolation point from feature map.
  auto get_pieces = [](edsl::Tensor temp, edsl::Tensor y, edsl::Tensor x) {
    auto gather_x = edsl::gather(temp, x).axis(3);
    auto gather_y = edsl::gather(gather_x, y).axis(2);
    return gather_y;
  };
  edsl::Tensor top_left = get_pieces(I, top_y_index, left_x_index);
  edsl::Tensor top_right = get_pieces(I, top_y_index, right_x_index);
  edsl::Tensor bottom_left = get_pieces(I, bottom_y_index, left_x_index);
  edsl::Tensor bottom_right = get_pieces(I, bottom_y_index, right_x_index);

  std::vector<edsl::TensorDim> dims(I.rank());
  I.bind_dims(dims);
  dims[2] = edsl::TensorDim(pooled_h);
  dims[3] = edsl::TensorDim(pooled_w);
  auto top = top_left + (top_right - top_left) * (in_x - left_x_index);
  auto bottom = bottom_left + (bottom_right - bottom_left) * (in_x - left_x_index);

  // final formula : output = top + (bottom - top) * (in_y - top_y_index)
  // we have to reshape mul operands.
  auto temp_shape = edsl::reshape(bottom - top, {dims[0], dims[1], dims[3], dims[2]});
  auto output = top + edsl::reshape(temp_shape * (in_y - top_y_index), dims);
  return output;
}

}  // namespace

namespace PlaidMLPlugin {

void registerROIPooling() {
  registerOp("ROIPooling", [](const Context& ctx) {
    auto* layer = ngraph::as_type<ngraph::opset4::ROIPooling>(ctx.layer);
    IE_ASSERT(ctx.operands.size() == 2);
    auto I = ctx.operands.at(0);

    auto pooled_shape = layer->get_output_size();
    auto pooled_height = static_cast<int64_t>(pooled_shape[0]);
    auto pooled_width = static_cast<int64_t>(pooled_shape[1]);
    auto spatial_ratio = layer->get_spatial_scale();
    auto method = layer->get_method();

    const static int BOX_ELEMENT_SIZE = 5;
    auto coords_box = cast_constant_operand<float>(1, layer);
    IE_ASSERT((coords_box.size() % BOX_ELEMENT_SIZE) == 0);

    auto shapes = I.compute_shape().sizes();
    auto height = shapes[2];
    auto width = shapes[3];

    std::vector<edsl::Tensor> ROI_pools;
    // 2D input tensor of shape [NUM_ROIS, 5] describing box
    for (auto index = coords_box.begin(); index != coords_box.end(); index += BOX_ELEMENT_SIZE) {
      // consisting of 5 element tuples: [batch_id, x_1, y_1, x_2, y_2]
      auto batch_id = *index;
      std::vector<float> coord(index + 1, index + BOX_ELEMENT_SIZE);

      auto batch_indices = edsl::index({edsl::TensorDim(1)}, 0) + batch_id;
      auto slice_I = edsl::gather(I, batch_indices).axis(0);

      edsl::Tensor pooled_tensor;
      if (method == "max") {
        // translate ROI coordinates from their input normalize scale to feature map scale.
        for (int i = 0; i < coord.size(); i++) {
          coord[i] = std::round(coord[i] * spatial_ratio);
        }
        pooled_tensor = crop_max_pooling(slice_I, coord, pooled_height, pooled_width, height, width);
      } else if (method == "bilinear") {
        // follow ngraph implementation, which doesn't use spatial_ratio in "bilinear" method.
        pooled_tensor = bilinear_pooling(slice_I, coord, pooled_height, pooled_width, height, width);
      } else {
        THROW_IE_EXCEPTION << "ROIPooling op currently only support 'max' and 'bilinear' method;";
      }
      ROI_pools.push_back(pooled_tensor);
    }

    auto O = op::concatenate(ROI_pools, 0);
    return edsl::make_tuple(O);
  });
}
}  // namespace PlaidMLPlugin
