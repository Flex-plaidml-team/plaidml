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

template <typename T>
Buffer makeBuffer(DType dtype, const std::vector<int64_t>& dims, const std::vector<T>& data) {
  TensorShape shape(dtype, dims);
  Buffer buffer(shape);
  buffer.copy_from(data.data());
  return buffer;
}

template <typename T>
edsl::Tensor indices_generator(T start_point, int64_t len, int stride, DType dtype, std::string name) {
  std::vector<T> indices(len);
  for (int64_t i = 0; i < len; i++) {
    indices[i] = static_cast<T>(start_point + stride * i);
  }
  return edsl::Constant(makeBuffer(dtype, {len}, indices), name);
}

std::tuple<edsl::Tensor, int, int> crop_resized(edsl::Tensor& I, std::vector<float>& coord, std::string method,
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
    h_tensor = indices_generator(static_cast<int>(x_1), pooled_h, kernel_h, DType::INT32, "indices_h");
    w_tensor = indices_generator(static_cast<int>(y_1), pooled_w, kernel_w, DType::INT32, "indices_w");
    interpolation_mode = edsl::InterpolationMode::NEAREST;
  } else {
    h_tensor = indices_generator(x_1, pooled_h, kernel_h, DType::FLOAT32, "indices_h");
    w_tensor = indices_generator(y_1, pooled_h, kernel_w, DType::FLOAT32, "indices_w");
    interpolation_mode = edsl::InterpolationMode::LINEAR;
  }

  auto gather_w = edsl::gather(I, w_tensor).axis(3).interpolationMode(interpolation_mode);
  auto gather_h = edsl::gather(gather_w, h_tensor).axis(2).interpolationMode(interpolation_mode);

  return std::make_tuple(gather_h, kernel_h, kernel_w);
}

}  // namespace

namespace PlaidMLPlugin {

void registerROIPooling() {
  registerOp("ROIPooling", [](const Context& ctx) {
    auto* layer = ngraph::as_type<ngraph::opset4::ROIPooling>(ctx.layer);
    IE_ASSERT(ctx.operands.size() == 2);
    auto I = ctx.operands.at(0);
    auto I_shape = I.compute_shape().sizes();

    auto pooled_shape = layer->get_output_size();
    auto pooled_height = static_cast<int64_t >(pooled_shape[0]);
    auto pooled_width = static_cast<int64_t >(pooled_shape[1]);
    auto spatial_ratio = layer->get_spatial_scale();
    auto method = layer->get_method();

    const static int BOX_ELEMENT_SIZE = 5;
    auto coords_box = cast_constant_operand<float>(1, layer);
    IE_ASSERT((coords_box.size() % BOX_ELEMENT_SIZE) == 0);

    std::vector<edsl::Tensor> ROI_pools;
    // 2D input tensor of shape [NUM_ROIS, 5] describing box
    for (auto index = coords_box.begin(); index != coords_box.end(); index += BOX_ELEMENT_SIZE) {
      // consisting of 5 element tuples: [batch_id, x_1, y_1, x_2, y_2]
      auto batch_id = *index;
      std::vector<float> coord(index + 1, index + BOX_ELEMENT_SIZE);
      // translate ROI coordinates from their input spatial scale to the scale used when pooling
      for (int i = 1; i < coord.size(); i++) {
        coord[i] *= spatial_ratio;
      }

      auto slice_I = op::unsqueeze(op::slice(I)                  //
                                       .add_dim(batch_id)        //
                                       .add_dim(0, I_shape[1])   //
                                       .add_dim(0, I_shape[2])   //
                                       .add_dim(0, I_shape[3]),  //
                                   {0});

      edsl::Tensor ROI_tensor;
      int kernel_height;
      int kernel_width;
      std::tie(ROI_tensor, kernel_height, kernel_width) =
          crop_resized(slice_I, coord, method, pooled_height, pooled_width);

      auto pooled_tensor = op::pool(ROI_tensor,                     //
                                    op::PoolMode::MAX,              //
                                    {kernel_height, kernel_width},  //
                                    {kernel_height, kernel_width},  //
                                    op::AutoPadMode::VALID,         //
                                    {},                             //
                                    op::TensorLayout::NCX);

      ROI_pools.push_back(pooled_tensor);
    }

    auto O = op::concatenate(ROI_pools, 0);
    return edsl::make_tuple(O);
  });
}
}  // namespace PlaidMLPlugin
