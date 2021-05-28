// Copyright (C) 2021 Intel Corporation
// SPDX-License-Identifier: Apache-2.0
//

#include <math.h>

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
    auto with_offset = ctx.operands.size() == 11;
    auto* layer = ngraph::as_type<ngraph::opset1::DeformablePSROIPooling>(ctx.layer);
    auto data = ctx.operands.at(0);
    auto rois = ctx.operands.at(1);
    edsl::Tensor offsets;
    if (with_offset) {
      offsets = ctx.operands.at(2);
    }
    auto output_dim = layer.get_output_dim();
    auto group_size = layer.get_group_size();
    auto spatial_scale = layer.get_spatial_scale();
    auto mode = layer.get_mode();
    auto spatial_bins_x = layer.get_spatial_bins_x();
    auto spatial_bins_y = layer.get_spatial_bins_y();
    auto trans_std = layer.get_trans_std();
    auto part_size = layer.get_part_size();

    rois = edsl::round(rois);
    auto roi_idx = edsl::index({edsl::TensorDim(2)}, 0) + 1;
    edsl::Tensor roi_lt = edsl::gather(rois, roi_idx).axis(1);
    roi_lt = roi_lt * spatial_scale - 0.5f;
    edsl::Tensor roi_rb = edsl::gather(rois, roi_idx + 2).axis(1);
    roi_rb = (roi_rb + 1.0f) * spatial_scale - 0.5f;

    auto roi_sizes = op::maximum(roi_rb - roi_lt, 0.1f);
    auto bin_size = roi_sizes / group_size;
    auto zero_idx = edsl::index({edsl::TensorDim(1)}, 0);
    edsl::Tensor bin_width = edsl::gather(bin_size, zero_idx).axis(1);
    edsl::Tensor bin_height = edsl::gather(bin_size, zero_idx + 1).axis(1);

    if (with_offset) {

    }

    return edsl::make_tuple();
  });
}
}  // namespace PlaidMLPlugin
