// Copyright (C) 2021 Intel Corporation
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

// This function is modified from the compute_padding_and_output_size function in plaidml/op/lib/ops.cc in the future.
std::pair<int, int> compute_padding(        //
    const int& input_size,                  //
    const int& filter_size,                 //
    int stride,                             //
    plaidml::op::AutoPadMode autopad_mode,  //
    int pad_lo,                             //
    int pad_hi,                             //
    int dilation,                           //
    int data_dilation,                      //
    bool use_ceil_for_output_shape) {
  // Effective input and filter sizes are the sizes after dilations are
  // accounted for. So a 4x3 filter dilated by (3, 2) has an effective filter
  // size of 10 and 5 for its 2 spatial dims

  int I_eff = (data_dilation * (input_size - 1)) + 1;  // Effective Input Size
  int F_eff = (dilation * (filter_size - 1)) + 1;      // Effective Filter Size
  int ceil_term =
      use_ceil_for_output_shape ? stride - 1 : 0;  // TODO: Will need to confirm that this is the intended behavior
  if (autopad_mode == plaidml::op::AutoPadMode::EXPLICIT) {
    return std::pair<int, int>(pad_lo, pad_hi);
  }
  if (autopad_mode == plaidml::op::AutoPadMode::VALID) {
    return std::pair<int, int>(0, 0);
  }
  if (autopad_mode == plaidml::op::AutoPadMode::SAME_LOWER || autopad_mode == plaidml::op::AutoPadMode::SAME_UPPER) {
    int lower_term = (autopad_mode == plaidml::op::AutoPadMode::SAME_LOWER) ? 1 : 0;
    int output_size((I_eff + stride - 1 + ceil_term) / stride);
    int pads = std::max(0, (output_size - 1) * stride + F_eff - I_eff);
    int pad_begin((pads + lower_term) / 2);
    int pad_end(pads - pad_begin);
    return std::pair<int, int>(pad_begin, pad_end);
  }
  THROW_IE_EXCEPTION << "Unexpected autopadding mode.";
}

}  // namespace

namespace PlaidMLPlugin {

void registerBinaryConvolution() {
  registerOp("BinaryConvolution", [](const Context& ctx) {
    auto* layer = ngraph::as_type<ngraph::opset4::BinaryConvolution>(ctx.layer);
    IE_ASSERT(ctx.operands.size() == 2);
    auto I = ctx.operands.at(0);
    auto rank = I.rank();
    std::vector<int> input_sizes;
    for (auto input_size : layer->get_input_shape(0)) {
      input_sizes.push_back(input_size);
    }
    std::vector<int> filter_sizes;
    for (auto filter_size : layer->get_input_shape(1)) {
      filter_sizes.push_back(filter_size);
    }
    std::vector<int> strides;
    for (auto stride : layer->get_strides()) {
      strides.push_back(stride);
    }
    std::vector<int> dilations;
    for (auto dilation : layer->get_dilations()) {
      dilations.push_back(dilation);
    }
    std::vector<int> data_dilations(rank - 2, 0);
    std::vector<int> pad_begins;
    for (auto pad_begin : layer->get_pads_begin()) {
      pad_begins.push_back(pad_begin);
    }
    std::vector<int> pad_ends;
    for (auto pad_end : layer->get_pads_end()) {
      pad_ends.push_back(pad_end);
    }
    auto mode = layer->get_mode();
    IE_ASSERT(mode == ngraph::op::v1::BinaryConvolution::BinaryConvolutionMode::XNOR_POPCOUNT);
    auto one = cast(edsl::Tensor(1), DType::INT32);
    auto minus_one = cast(edsl::Tensor(-1), DType::INT32);

    std::vector<int64_t> filter_long_sizes;
    for (auto i = 0; i < rank; ++i) {
      filter_long_sizes.push_back(static_cast<int64_t>(filter_sizes[i]));
    }
    TensorShape filter_shape(DType::FLOAT32, filter_long_sizes);
    auto filter_vec = cast_constant_operand<float>(1, layer);
    Buffer filter_buffer(filter_shape);
    filter_buffer.copy_from(filter_vec.data());
    edsl::Tensor filter_tensor = edsl::Constant(filter_buffer, "filter");
    filter_tensor = edsl::select(filter_tensor == 0, minus_one, one);

    auto autopad_mode = to_plaidml(layer->get_auto_pad());
    std::vector<int> manual_padding_begin(rank, 0), manual_padding_end(rank, 0);

    for (auto i = 0; i < rank - 2; ++i) {
      std::pair<int, int> pads = compute_padding(input_sizes[i + 2], filter_sizes[i + 2], strides[i], autopad_mode,
                                                 pad_begins[i], pad_ends[i], dilations[i], data_dilations[i], false);
      manual_padding_begin[i + 2] = pads.first;
      manual_padding_end[i + 2] = pads.second;
    }

    auto pad_value = layer->get_pad_value();
    int padding = static_cast<int>(pad_value);
    edsl::Tensor Pad = edsl::index({edsl::TensorDim(1)}, 0) + padding;
    edsl::Tensor input_tensor = op::explicit_padding(I, manual_padding_begin, manual_padding_end)
                                    .mode(plaidml::op::PadMode::CONSTANT)
                                    .padval(Pad);
    input_tensor = edsl::select(input_tensor == 0, minus_one, one);

    auto result = op::convolution(input_tensor, filter_tensor)
                      .strides(strides)
                      .dilations(dilations)
                      .autopad_mode(plaidml::op::AutoPadMode::VALID)
                      .input_layout(plaidml::op::TensorLayout::NCX)
                      .filter_layout(plaidml::op::TensorLayout::KCX);

    return edsl::make_tuple(result);
  });
}

}  // namespace PlaidMLPlugin
