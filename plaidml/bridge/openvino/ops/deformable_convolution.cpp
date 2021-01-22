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
using namespace edsl;

namespace PlaidMLPlugin {

size_t compute_padding_before(size_t input_size, size_t off_size, size_t filter_size, size_t stride,
                              plaidml::op::AutoPadMode autopad_mode, size_t pad_before, size_t pad_end,
                              size_t dilation) {
  size_t f = (dilation * (filter_size - 1)) + 1;
  if (autopad_mode == plaidml::op::AutoPadMode::EXPLICIT) {
    return pad_before;
  }
  if (autopad_mode == plaidml::op::AutoPadMode::VALID) {
    return 0;
  }
  if (autopad_mode == plaidml::op::AutoPadMode::SAME_LOWER || autopad_mode == plaidml::op::AutoPadMode::SAME_UPPER) {
    size_t lower_term = (autopad_mode == plaidml::op::AutoPadMode::SAME_LOWER) ? 1 : 0;
    size_t max = 0;
    if (((off_size - 1) * stride + f - input_size) > 0) {
      max = (off_size - 1) * stride + f - input_size;
    }
    pad_before = (max + lower_term) / 2;
    return pad_before;
  }
  THROW_IE_EXCEPTION << "Unexpected autopadding mode.";
}

size_t compute_output_size(size_t input_size, size_t filter_size, size_t stride, plaidml::op::AutoPadMode autopad_mode,
                           size_t pad_lo, size_t pad_hi, size_t dilation) {
  auto I_eff = input_size;
  auto F_eff = (dilation * (filter_size - 1)) + 1;
  if (autopad_mode == plaidml::op::AutoPadMode::EXPLICIT) {
    size_t output_size = ((I_eff + pad_lo + pad_hi - F_eff + stride) / stride);
    return output_size;
  }
  if (autopad_mode == plaidml::op::AutoPadMode::VALID) {
    size_t output_size = ((I_eff - F_eff + stride) / stride);
    return output_size;
  }
  if (autopad_mode == plaidml::op::AutoPadMode::SAME_LOWER || autopad_mode == plaidml::op::AutoPadMode::SAME_UPPER) {
    size_t output_size = ((I_eff + stride - 1) / stride);
    return output_size;
  }
  THROW_IE_EXCEPTION << "Unexpected autopadding mode.";
}

void registerDeformableConvolution() {
  registerOp("DeformableConvolution", [](const Context& ctx) {
    auto* layer = ngraph::as_type<ngraph::opset4::DeformableConvolution>(ctx.layer);
    DType precision = to_plaidml(layer->get_output_element_type(0));
    IE_ASSERT(ctx.operands.size() == 3);
    auto I = ctx.operands.at(0);
    auto OFF = ctx.operands.at(1);
    auto F = ctx.operands.at(2);
    auto G = layer->get_group();
    auto DG = layer->get_deformable_group();
    auto* input_constant_operand = ngraph::as_type<ngraph::op::Constant>(ctx.layer->get_input_node_ptr(2));
    if (input_constant_operand == nullptr) {
      THROW_IE_EXCEPTION << "Filter need to be constant node.";
    }
    // Compute shape of each tensor.
    auto I_shape = I.compute_shape().sizes();
    auto OFF_shape = OFF.compute_shape().sizes();
    auto F_shape = F.compute_shape().sizes();
    // Get dimension.
    auto N = I_shape[0];
    auto CI = I_shape[1];
    auto CO = F_shape[0];
    // Throw exception
    if (CI % G != 0 || CO % G != 0 || CI % DG != 0 || OFF_shape[1] % DG != 0) {
      THROW_IE_EXCEPTION << "Incorrected shape for DeformableConvolution.";
    }
    auto rank = I.rank();
    // Get autopad_mode.
    auto autopad_mode = to_plaidml(layer->get_auto_pad());
    // Compute manual_padding.
    std::vector<size_t> manual_padding;
    if (autopad_mode == plaidml::op::AutoPadMode::EXPLICIT) {
      for (auto pad : layer->get_pads_begin()) {
        manual_padding.push_back(pad);
      }
      for (auto pad : layer->get_pads_end()) {
        manual_padding.push_back(pad);
      }
      while (manual_padding.size() < 2 * (rank - 2)) {
        manual_padding.push_back(0);
      }
    } else {
      while (manual_padding.size() < 2 * (rank - 2)) {
        manual_padding.push_back(0);
      }
    }
    // Get the strides.
    std::vector<size_t> strides;
    for (auto stride : layer->get_strides()) {
      strides.push_back(stride);
    }
    // Get the dilations.
    std::vector<size_t> dilations;
    for (auto dilation : layer->get_dilations()) {
      dilations.push_back(dilation);
    }
    // Compute input_sizes.
    std::vector<size_t> input_sizes;
    for (auto i = 2; i < rank; ++i) {
      input_sizes.push_back(I_shape[i]);
    }
    // Compute off_sizes.
    std::vector<size_t> off_sizes;
    for (auto i = 2; i < rank; ++i) {
      off_sizes.push_back(OFF_shape[i]);
    }
    // Compute filter_sizes.
    std::vector<size_t> filter_sizes;
    for (auto i = 2; i < rank; ++i) {
      filter_sizes.push_back(F_shape[i]);
    }
    // Compute pad_before for each dimention.
    std::vector<size_t> pad_befores;
    for (auto i = 0; i < rank - 2; ++i) {
      auto pad_before = compute_padding_before(input_sizes[i], off_sizes[i], filter_sizes[i], strides[i], autopad_mode,
                                               manual_padding[i], manual_padding[i + rank - 2], dilations[i]);
      pad_befores.push_back(pad_before);
    }
    // Compute the shape of output.
    std::vector<size_t> output_sizes;
    for (auto i = 0; i < rank - 2; ++i) {
      auto output_size = compute_output_size(input_sizes[i], filter_sizes[i], strides[i], autopad_mode,
                                             manual_padding[i], manual_padding[i + rank - 2], dilations[i]);
      output_sizes.push_back(output_size);
    }
    // Compute filter spatial size;
    auto F_spatial_size = 1;
    for (auto i = 0; i < F_shape.size() - 2; ++i) {
      F_spatial_size *= F_shape[i + 2];
    }
    // Validate the shape of offset.
    for (auto i = 0; i < rank - 2; ++i) {
      if (output_sizes[i] != OFF_shape[i + 2]) {
        THROW_IE_EXCEPTION << "Incorrected shape for DeformableConvolution.";
      }
    }
    if (OFF_shape[1] != (OFF_shape.size() - 2) * DG * F_spatial_size) {
      THROW_IE_EXCEPTION << "Incorrected shape for DeformableConvolution.";
    }
    // Compute deformable convolution.
    if (rank == 3) {
      // Get the dimension's length of each tensor.
      auto H = I_shape[2];
      auto H_F = F_shape[2];
      auto H_OFF = OFF_shape[2];
      auto f_size = H_F;
      // Define shape.
      TensorShape shape(precision, {1});
      // Define index.
      size_t n, g, dg, co, h_off, h_f, ci, h, c_off_h;
      // Define Tensor.
      edsl::Tensor offset_h, new_h, input, kernel, input_select_1;
      edsl::Tensor index_n, index_new_h, index_co, index_ci, index_h_f;
      Buffer buffer_0(shape);
      buffer_0.copy_from(std::vector<float>({static_cast<float>(0)}).data());
      auto input_select_0 = Constant(buffer_0, "input_select_0");
      // Compute DeformableConvolution.
      edsl::Tensor single_result;
      edsl::Tensor concat_axis_0(0);
      for (n = 0; n < N; ++n) {
        edsl::Tensor concat_axis_g(0);
        for (g = 0; g < G; ++g) {
          edsl::Tensor concat_axis_1(0);
          for (co = 0; co < CO / G; ++co) {
            edsl::Tensor concat_axis_2(0);
            for (h_off = 0; h_off < H_OFF; ++h_off) {
              single_result = edsl::Tensor(0);
              for (h_f = 0; h_f < H_F; ++h_f) {
                for (ci = 0; ci < CI / G; ++ci) {
                  // Compute the index of input tensor.
                  h = h_off * strides[0] + h_f * dilations[0] - pad_befores[0];
                  // Compute dg.
                  dg = (ci + g * (CI / G)) / (CI / DG);
                  // Compute the index of deformable tensor.
                  c_off_h = h_f + dg * f_size;
                  // Get the offset of each dimension.
                  offset_h = op::slice(OFF).add_dim(n).add_dim(c_off_h).add_dim(h_off);
                  // Compute the new index of input tensor.
                  new_h = h + offset_h;
                  // Define buffer.
                  Buffer buffer_n(shape), buffer_ci(shape), buffer_co(shape), buffer_h_f(shape);
                  // Convert index to constant tensor.
                  buffer_n.copy_from(std::vector<float>({static_cast<float>(n)}).data());
                  index_n = Constant(buffer_n, "index_n");
                  buffer_ci.copy_from(std::vector<float>({static_cast<float>(ci + CI / G)}).data());
                  index_ci = Constant(buffer_ci, "index_ci");
                  index_new_h = new_h;
                  // Get the input value by linear interpolation.
                  input = edsl::gather(I, index_n).axis(0);
                  input = edsl::gather(input, index_ci).axis(1);
                  input_select_1 =
                      edsl::gather(input, index_new_h).axis(2).interpolationMode(edsl::InterpolationMode::LINEAR);
                  input = select(new_h < cast(edsl::Tensor(0), DType::FLOAT32) ||
                                     new_h > cast(edsl::Tensor(H - 1), DType::FLOAT32),
                                 input_select_0, input_select_1);
                  // Convert index to constant tensor.
                  buffer_co.copy_from(std::vector<float>({static_cast<float>(co + CO / G)}).data());
                  index_co = Constant(buffer_co, "index_co");
                  buffer_h_f.copy_from(std::vector<float>({static_cast<float>(h_f)}).data());
                  index_h_f = Constant(buffer_h_f, "index_h_f");
                  // Get the filter value.
                  kernel = edsl::gather(F, index_co).axis(0);
                  kernel = edsl::gather(kernel, index_ci).axis(1);
                  kernel = edsl::gather(kernel, index_h_f).axis(2);
                  single_result = single_result + input * kernel;
                }
              }
              // Concatenate  tensor along third axis.
              single_result = op::reshape(single_result, make_tuple<size_t>({1, 1, 1}));
              if (concat_axis_2.rank() != 3) {
                concat_axis_2 = single_result;
              } else {
                concat_axis_2 = op::concatenate({concat_axis_2, single_result}, 2);
              }
            }
            // Concatenate  tensor along second axis.
            if (concat_axis_1.rank() != 3) {
              concat_axis_1 = concat_axis_2;
            } else {
              concat_axis_1 = op::concatenate({concat_axis_1, concat_axis_2}, 1);
            }
          }
          // Concatenate  tensor along group.
          if (concat_axis_g.rank() != 3) {
            concat_axis_g = concat_axis_1;
          } else {
            concat_axis_g = op::concatenate({concat_axis_g, concat_axis_1}, 1);
          }
        }
        // Concatenate  tensor along first axis.
        if (concat_axis_0.rank() != 3) {
          concat_axis_0 = concat_axis_g;
        } else {
          concat_axis_0 = op::concatenate({concat_axis_0, concat_axis_g}, 0);
        }
      }
      auto O = concat_axis_0;
      return edsl::make_tuple(O);
    } else if (rank == 4) {
      // Get the dimension's length of each tensor.
      auto H = I_shape[2];
      auto W = I_shape[3];
      auto H_F = F_shape[2];
      auto W_F = F_shape[3];
      auto H_OFF = OFF_shape[2];
      auto W_OFF = OFF_shape[3];
      auto f_size = H_F * W_F;
      // Define shape.
      TensorShape shape(precision, {1});
      // Define index.
      size_t n, g, dg, co, h_off, w_off, h_f, w_f, ci, h, w, c_off_h, c_off_w;
      // Define Tensor.
      edsl::Tensor offset_h, offset_w, new_h, new_w, input, kernel, input_select_1;
      edsl::Tensor index_n, index_new_h, index_new_w, index_co, index_ci, index_h_f, index_w_f;
      Buffer buffer_0(shape);
      buffer_0.copy_from(std::vector<float>({static_cast<float>(0)}).data());
      auto input_select_0 = Constant(buffer_0, "input_select_0");
      // Compute DeformableConvolution.
      edsl::Tensor single_result;
      edsl::Tensor concat_axis_0(0);
      for (n = 0; n < N; ++n) {
        edsl::Tensor concat_axis_g(0);
        for (g = 0; g < G; ++g) {
          edsl::Tensor concat_axis_1(0);
          for (co = 0; co < CO / G; ++co) {
            edsl::Tensor concat_axis_2(0);
            for (h_off = 0; h_off < H_OFF; ++h_off) {
              edsl::Tensor concat_axis_3(0);
              for (w_off = 0; w_off < W_OFF; ++w_off) {
                single_result = edsl::Tensor(0);
                for (h_f = 0; h_f < H_F; ++h_f) {
                  for (w_f = 0; w_f < W_F; ++w_f) {
                    for (ci = 0; ci < CI / G; ++ci) {
                      // Compute the index of input tensor.
                      h = h_off * strides[0] + h_f * dilations[0] - pad_befores[0];
                      w = w_off * strides[1] + w_f * dilations[1] - pad_befores[1];
                      // Compute dg.
                      dg = (ci + g * (CI / G)) / (CI / DG);
                      // Compute the index of deformable tensor.
                      c_off_h = 2 * (w_f + h_f * W_F) + dg * 2 * f_size;
                      c_off_w = c_off_h + 1;
                      // Get the offset of each dimension.
                      offset_h = op::slice(OFF).add_dim(n).add_dim(c_off_h).add_dim(h_off).add_dim(w_off);
                      offset_w = op::slice(OFF).add_dim(n).add_dim(c_off_w).add_dim(h_off).add_dim(w_off);
                      // Compute the new index of input tensor.
                      new_h = h + offset_h;
                      new_w = w + offset_w;
                      // Define buffer.
                      Buffer buffer_n(shape), buffer_ci(shape), buffer_co(shape), buffer_h_f(shape), buffer_w_f(shape);
                      // Convert index to constant tensor.
                      buffer_n.copy_from(std::vector<float>({static_cast<float>(n)}).data());
                      index_n = Constant(buffer_n, "index_n");
                      buffer_ci.copy_from(std::vector<float>({static_cast<float>(ci + CI / G)}).data());
                      index_ci = Constant(buffer_ci, "index_ci");
                      index_new_h = new_h;
                      index_new_w = new_w;
                      // Get the input value by bilinear interpolation.
                      input = edsl::gather(I, index_n).axis(0);
                      input = edsl::gather(input, index_ci).axis(1);
                      input_select_1 =
                          edsl::gather(input, index_new_h).axis(2).interpolationMode(edsl::InterpolationMode::LINEAR);
                      input_select_1 = edsl::gather(input_select_1, index_new_w)
                                           .axis(2)
                                           .interpolationMode(edsl::InterpolationMode::LINEAR);
                      input = select(new_h < cast(edsl::Tensor(0), DType::FLOAT32) ||
                                         new_h > cast(edsl::Tensor(H - 1), DType::FLOAT32) ||
                                         new_w < cast(edsl::Tensor(0), DType::FLOAT32) ||
                                         new_w > cast(edsl::Tensor(W - 1), DType::FLOAT32),
                                     input_select_0, input_select_1);
                      // Convert index to constant tensor.
                      buffer_co.copy_from(std::vector<float>({static_cast<float>(co + CO / G)}).data());
                      index_co = Constant(buffer_co, "index_co");
                      buffer_h_f.copy_from(std::vector<float>({static_cast<float>(h_f)}).data());
                      index_h_f = Constant(buffer_h_f, "index_h_f");
                      buffer_w_f.copy_from(std::vector<float>({static_cast<float>(w_f)}).data());
                      index_w_f = Constant(buffer_w_f, "index_w_f");
                      // Get the filter value.
                      kernel = edsl::gather(F, index_co).axis(0);
                      kernel = edsl::gather(kernel, index_ci).axis(1);
                      kernel = edsl::gather(kernel, index_h_f).axis(2);
                      kernel = edsl::gather(kernel, index_w_f).axis(3);
                      single_result = single_result + input * kernel;
                    }
                  }
                }
                // Concatenate  tensor along fourth axis.
                single_result = op::reshape(single_result, make_tuple<size_t>({1, 1, 1, 1}));
                if (concat_axis_3.rank() != 4) {
                  concat_axis_3 = single_result;
                } else {
                  concat_axis_3 = op::concatenate({concat_axis_3, single_result}, 3);
                }
              }
              // Concatenate  tensor along third axis.
              if (concat_axis_2.rank() != 4) {
                concat_axis_2 = concat_axis_3;
              } else {
                concat_axis_2 = op::concatenate({concat_axis_2, concat_axis_3}, 2);
              }
            }
            // Concatenate  tensor along second axis.
            if (concat_axis_1.rank() != 4) {
              concat_axis_1 = concat_axis_2;
            } else {
              concat_axis_1 = op::concatenate({concat_axis_1, concat_axis_2}, 1);
            }
          }
          // Concatenate  tensor along group.
          if (concat_axis_g.rank() != 4) {
            concat_axis_g = concat_axis_1;
          } else {
            concat_axis_g = op::concatenate({concat_axis_g, concat_axis_1}, 1);
          }
        }
        // Concatenate  tensor along first axis.
        if (concat_axis_0.rank() != 4) {
          concat_axis_0 = concat_axis_g;
        } else {
          concat_axis_0 = op::concatenate({concat_axis_0, concat_axis_g}, 0);
        }
      }
      auto O = concat_axis_0;
      return edsl::make_tuple(O);
    } else if (rank == 5) {
      // Get the dimension's length of each tensor.
      auto H = I_shape[2];
      auto W = I_shape[3];
      auto D = I_shape[4];
      auto H_F = F_shape[2];
      auto W_F = F_shape[3];
      auto D_F = F_shape[4];
      auto H_OFF = OFF_shape[2];
      auto W_OFF = OFF_shape[3];
      auto D_OFF = OFF_shape[4];
      auto f_size = H_F * W_F * D_F;
      // Define shape.
      TensorShape shape(precision, {1});
      // Define index.
      size_t n, g, dg, co, h_off, w_off, d_off, h_f, w_f, d_f, ci, h, w, d, c_off_h, c_off_w, c_off_d;
      // Define Tensor.
      edsl::Tensor offset_h, offset_w, offset_d, new_h, new_w, new_d, input, kernel, input_select_1;
      edsl::Tensor index_n, index_new_h, index_new_w, index_new_d, index_co, index_ci, index_h_f, index_w_f, index_d_f;
      Buffer buffer_0(shape);
      buffer_0.copy_from(std::vector<float>({static_cast<float>(0)}).data());
      auto input_select_0 = Constant(buffer_0, "input_select_0");
      // Compute DeformableConvolution.
      edsl::Tensor single_result;
      edsl::Tensor concat_axis_0(0);
      for (n = 0; n < N; ++n) {
        edsl::Tensor concat_axis_g(0);
        for (g = 0; g < G; ++g) {
          edsl::Tensor concat_axis_1(0);
          for (co = 0; co < CO / G; ++co) {
            edsl::Tensor concat_axis_2(0);
            for (h_off = 0; h_off < H_OFF; ++h_off) {
              edsl::Tensor concat_axis_3(0);
              for (w_off = 0; w_off < W_OFF; ++w_off) {
                edsl::Tensor concat_axis_4(0);
                for (d_off = 0; d_off < D_OFF; ++d_off) {
                  single_result = edsl::Tensor(0);
                  for (h_f = 0; h_f < H_F; ++h_f) {
                    for (w_f = 0; w_f < W_F; ++w_f) {
                      for (d_f = 0; d_f < D_F; ++d_f) {
                        for (ci = 0; ci < CI / G; ++ci) {
                          // Compute the index of input tensor.
                          h = h_off * strides[0] + h_f * dilations[0] - pad_befores[0];
                          w = w_off * strides[1] + w_f * dilations[1] - pad_befores[1];
                          d = d_off * strides[2] + d_f * dilations[2] - pad_befores[2];
                          // Compute dg.
                          dg = (ci + g * (CI / G)) / (CI / DG);
                          // Compute the index of deformable tensor.
                          c_off_h = 3 * (d_f + w_f * D_F + h_f * W_F * D_F) + dg * 3 * f_size;
                          c_off_w = c_off_h + 1;
                          c_off_d = c_off_h + 2;
                          // Get the offset of each dimension.
                          offset_h =
                              op::slice(OFF).add_dim(n).add_dim(c_off_h).add_dim(h_off).add_dim(w_off).add_dim(d_off);
                          offset_w =
                              op::slice(OFF).add_dim(n).add_dim(c_off_w).add_dim(h_off).add_dim(w_off).add_dim(d_off);
                          offset_d =
                              op::slice(OFF).add_dim(n).add_dim(c_off_d).add_dim(h_off).add_dim(w_off).add_dim(d_off);
                          // Compute the new index of input tensor.
                          new_h = h + offset_h;
                          new_w = w + offset_w;
                          new_d = d + offset_d;
                          // Define buffer.
                          Buffer buffer_n(shape), buffer_ci(shape), buffer_co(shape), buffer_h_f(shape),
                              buffer_w_f(shape), buffer_d_f(shape);
                          // Convert index to constant tensor.
                          buffer_n.copy_from(std::vector<float>({static_cast<float>(n)}).data());
                          index_n = Constant(buffer_n, "index_n");
                          buffer_ci.copy_from(std::vector<float>({static_cast<float>(ci + CI / G)}).data());
                          index_ci = Constant(buffer_ci, "index_ci");
                          index_new_h = new_h;
                          index_new_w = new_w;
                          index_new_d = new_d;
                          // Get the input value by bilinear interpolation.
                          input = edsl::gather(I, index_n).axis(0);
                          input = edsl::gather(input, index_ci).axis(1);
                          input_select_1 = edsl::gather(input, index_new_h)
                                               .axis(2)
                                               .interpolationMode(edsl::InterpolationMode::LINEAR);
                          input_select_1 = edsl::gather(input_select_1, index_new_w)
                                               .axis(2)
                                               .interpolationMode(edsl::InterpolationMode::LINEAR);
                          input_select_1 = edsl::gather(input_select_1, index_new_d)
                                               .axis(2)
                                               .interpolationMode(edsl::InterpolationMode::LINEAR);
                          input = select(new_h < cast(edsl::Tensor(0), DType::FLOAT32) ||
                                             new_h > cast(edsl::Tensor(H - 1), DType::FLOAT32) ||
                                             new_w < cast(edsl::Tensor(0), DType::FLOAT32) ||
                                             new_w > cast(edsl::Tensor(W - 1), DType::FLOAT32) ||
                                             new_d < cast(edsl::Tensor(0), DType::FLOAT32) ||
                                             new_d > cast(edsl::Tensor(D - 1), DType::FLOAT32),
                                         input_select_0, input_select_1);
                          // Convert index to constant tensor.
                          buffer_co.copy_from(std::vector<float>({static_cast<float>(co + CO / G)}).data());
                          index_co = Constant(buffer_co, "index_co");
                          buffer_h_f.copy_from(std::vector<float>({static_cast<float>(h_f)}).data());
                          index_h_f = Constant(buffer_h_f, "index_h_f");
                          buffer_w_f.copy_from(std::vector<float>({static_cast<float>(w_f)}).data());
                          index_w_f = Constant(buffer_w_f, "index_w_f");
                          buffer_d_f.copy_from(std::vector<float>({static_cast<float>(d_f)}).data());
                          index_d_f = Constant(buffer_d_f, "index_d_f");
                          // Get the filter value.
                          kernel = edsl::gather(F, index_co).axis(0);
                          kernel = edsl::gather(kernel, index_ci).axis(1);
                          kernel = edsl::gather(kernel, index_h_f).axis(2);
                          kernel = edsl::gather(kernel, index_w_f).axis(3);
                          kernel = edsl::gather(kernel, index_d_f).axis(4);
                          single_result = single_result + input * kernel;
                        }
                      }
                    }
                  }
                  single_result = op::reshape(single_result, make_tuple<size_t>({1, 1, 1, 1, 1}));
                  // Concatenate  tensor along fifth axis.
                  if (concat_axis_4.rank() != 5) {
                    concat_axis_4 = single_result;
                  } else {
                    concat_axis_4 = op::concatenate({concat_axis_4, single_result}, 4);
                  }
                }
                // Concatenate  tensor along fourth axis.
                if (concat_axis_3.rank() != 5) {
                  concat_axis_3 = concat_axis_4;
                } else {
                  concat_axis_3 = op::concatenate({concat_axis_3, concat_axis_4}, 3);
                }
              }
              // Concatenate  tensor along third axis.
              if (concat_axis_2.rank() != 5) {
                concat_axis_2 = concat_axis_3;
              } else {
                concat_axis_2 = op::concatenate({concat_axis_2, concat_axis_3}, 2);
              }
            }
            // Concatenate  tensor along second axis.
            if (concat_axis_1.rank() != 5) {
              concat_axis_1 = concat_axis_2;
            } else {
              concat_axis_1 = op::concatenate({concat_axis_1, concat_axis_2}, 1);
            }
          }
          // Concatenate  tensor along group.
          if (concat_axis_g.rank() != 5) {
            concat_axis_g = concat_axis_1;
          } else {
            concat_axis_g = op::concatenate({concat_axis_g, concat_axis_1}, 1);
          }
        }
        // Concatenate  tensor along first axis.
        if (concat_axis_0.rank() != 5) {
          concat_axis_0 = concat_axis_g;
        } else {
          concat_axis_0 = op::concatenate({concat_axis_0, concat_axis_g}, 0);
        }
      }
      auto O = concat_axis_0;
      return edsl::make_tuple(O);
    } else {
      THROW_IE_EXCEPTION << "Higher dimensions are not supported for now.";
    }
  });
}

}  // namespace PlaidMLPlugin
