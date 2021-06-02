// Copyright (C) 2021 Intel Corporation
// SPDX-License-Identifier: Apache-2.0
//

#include "plaidml_ops.hpp"
#include "plaidml_util.hpp"

#include "ngraph/opsets/opset.hpp"
#include "ngraph/opsets/opset1.hpp"

#include "plaidml/op/op.h"

using namespace plaidml;          // NOLINT[build/namespaces]
using namespace InferenceEngine;  // NOLINT[build/namespaces]

namespace PlaidMLPlugin {

void registerDeformablePSROIPooling() {
  registerOp("DeformablePSROIPooling", [](const Context& ctx) {
    IE_ASSERT(ctx.operands.size() == 10 || ctx.operands.size() == 11);
    auto has_offset = ctx.operands.size() == 11;
    auto* layer = ngraph::as_type<ngraph::opset1::DeformablePSROIPooling>(ctx.layer);
    auto data = ctx.operands.at(0);
    auto rois = ctx.operands.at(1);
    edsl::Tensor offsets;
    if (has_offset) {
      offsets = ctx.operands.at(2);
    }
    auto output_dim = layer->get_output_dim();
    auto group_size = static_cast<int>(layer->get_group_size());
    auto spatial_scale = layer->get_spatial_scale();
    auto mode = layer->get_mode();
    auto spatial_bins_x = layer->get_spatial_bins_x();
    auto spatial_bins_y = layer->get_spatial_bins_y();
    auto trans_std = layer->get_trans_std();
    auto part_size = layer->get_part_size();

    auto rois_shape = rois.compute_shape().sizes();
    auto num_rois = rois_shape[0];
    rois = edsl::round(rois);
    auto roi_idx = edsl::index({edsl::TensorDim(2)}, 0) + 1;
    // Left top ROI corner - x1, y1
    edsl::Tensor roi_lt = edsl::gather(rois, roi_idx).axis(1);
    roi_lt = roi_lt * spatial_scale - 0.5f;
    roi_lt = op::tile(roi_lt, {1, output_dim * group_size * group_size});
    roi_lt = edsl::reshape(roi_lt, {num_rois * output_dim * group_size * group_size, 2});
    // Right bottom ROI corner - x2, y2
    edsl::Tensor roi_rb = edsl::gather(rois, roi_idx + 2).axis(1);
    roi_rb = (roi_rb + 1.0f) * spatial_scale - 0.5f;
    roi_rb = op::tile(roi_rb, {1, output_dim * group_size * group_size});
    roi_rb = edsl::reshape(roi_rb, {num_rois * output_dim * group_size * group_size, 2});

    auto roi_sizes = op::maximum(roi_rb - roi_lt, edsl::Tensor(0.1f));
    auto bin_sizes = roi_sizes / group_size;  // (#rois * output_dim * group_size * group_size, 2)

    auto bin_group_gap = edsl::index({edsl::TensorDim(group_size), edsl::TensorDim(1)}, 0);
    auto bin_w_gap = op::tile(bin_group_gap, {group_size});
    auto bin_h_gap = edsl::reshape(op::tile(bin_group_gap, {1, group_size}), {group_size * group_size, 1});
    auto bin_gap = op::concatenate({bin_w_gap, bin_h_gap}, 1);
    bin_gap = op::tile(bin_gap, {num_rois * output_dim});

    auto bin_lt_indices = roi_lt + bin_gap * bin_sizes;

    if (has_offset) {
    }

    auto zero_idx = edsl::index({edsl::TensorDim(1)}, 0);
    edsl::Tensor bin_width = edsl::gather(bin_sizes, zero_idx).axis(1);
    edsl::Tensor bin_height = edsl::gather(bin_sizes, zero_idx + 1).axis(1);
    auto sub_bin_width = bin_width / static_cast<float>(spatial_bins_x);
    auto sub_bin_height = bin_height / static_cast<float>(spatial_bins_y);

    auto spatial_bin_x_idx = edsl::index({edsl::TensorDim(spatial_bins_x), 1}, 0);
    spatial_bin_x_idx = edsl::tile(spatial_bin_x_idx, {spatial_bins_y});
    auto spatial_bin_y_idx = edsl::index({edsl::TensorDim(spatial_bins_y), 1}, 0);
    spatial_bin_y_idx = op::tile(spatial_bin_y_idx, {1, spatial_bins_x});
    spatial_bin_y_idx = op::reshape(spatial_bin_y_idx, {spatial_bins_x * spatial_bins_y, 1});
    spatial_bins = op::concatenate({spatial_bins_x, spatial_bins_y}, 1);
    spatial_bins = op::tile(spatial_bins, {num_rois * output_dim * group_size * group_size});

    auto total_sub_bins = num_rois * output_dim * group_size * group_size * spatial_bins_x * spatial_bins_y;
    bin_lt_indices = op::tile(bin_lt_indices, {1, spatial_bins_x * spatial_bins_y});
    bin_lt_indices = edsl::reshape(bin_lt_indices, {num_rois * output_dim * group_size * group_size, 2});
    auto sub_bin_indices = bin_lt_indices + spatial_bins;

    auto batch_idx = edsl::gather(rois, zero_idx).axis(1);
    batch_idx = op::tile(batch_idx, {1, output_dim * group_size * group_size * spatial_bins_x * spatial_bins_y});
    batch_idx = edsl::reshape(batch_idx, {num_rois * output_dim * group_size * group_size, 1});

    // Implicit restriction:  num of input data channel > group_size * group_size
    auto channels_in = edsl::index({edsl::TensorDim(group_size * group_size), edsl::TensorDim(1)}, 0);
    channels_in = op::tile(channels_in, {num_rois * output_dim, spatial_bins_x * spatial_bins_y});
    channels_in = edsl::reshape(channels_in, {total_sub_bins, 1});

    sub_bin_indices = op::concatenate({batch_idx, channels_in, sub_bin_indices});  // (num_total_sub_bins, 4)
    edsl::Tensor sub_bins = op::gatherND(data, sub_bin_indices).interpolationMode(InterpolationMode::LINEAR);
    sub_bins =
        edsl::reshape(sub_bins, {num_rois * output_dim * group_size * group_size, spatial_bins_x * spatial_bins_y});
    auto bins = op::sum(sub_bins, edsl::make_tuple(1));

    auto roi_score_maps = op::reshape(bins, {num_rois, output_dim, group_size, group_size});
    return edsl::make_tuple(roi_score_maps);
  });
}
}  // namespace PlaidMLPlugin
