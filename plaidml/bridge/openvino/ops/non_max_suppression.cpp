// Copyright (C) 2021 Intel Corporation
// SPDX-License-Identifier: Apache-2.0
//

#include "plaidml_ops.hpp"
#include "plaidml_util.hpp"

#include "ngraph/opsets/opset5.hpp"

#include "plaidml/op/op.h"

using namespace plaidml;  // NOLINT[build/namespaces]
using edsl::Tensor;
using ngraph::opset5::NonMaxSuppression;

namespace PlaidMLPlugin {

std::vector<Tensor> NMS(Tensor BOXES, Tensor SCORES, int32_t max_output_boxes_per_class, Tensor IOU_THRESHOLD,
                        Tensor SCORE_THRESHOLD, Tensor SOFT_NMS_SIGMA, bool center_point_box,
                        bool sort_result_descending, DType box_input_type, DType box_output_type, DType thres_type) {
  std::vector<int64_t> boxes_shape = BOXES.compute_shape().sizes();
  std::vector<int64_t> scores_shape = SCORES.compute_shape().sizes();
  int num_batches = boxes_shape[0];
  int num_boxes = boxes_shape[1];
  int box_size = 4;
  int num_classes = scores_shape[1];

  Tensor PIECE = edsl::cast(edsl::index({edsl::TensorDim(box_size)}, 0), box_input_type);
  Tensor ZERO = edsl::reshape(op::slice(PIECE).add_dims({0}), {edsl::TensorDim(1)});
  Tensor ZERO_INT = edsl::cast(ZERO, DType::INT32);
  Tensor ONE = edsl::reshape(op::slice(PIECE).add_dims({1}), {edsl::TensorDim(1)});
  Tensor ONE_INT = edsl::cast(ONE, DType::INT32);
  Tensor TWO = edsl::reshape(op::slice(PIECE).add_dims({2}), {edsl::TensorDim(1)});
  Tensor TWO_INT = edsl::cast(TWO, DType::INT32);
  Tensor NEG1 = -ONE;
  Tensor NEG1_INT = edsl::cast(NEG1, DType::INT32);

  std::vector<Tensor> boxes;
  std::vector<Tensor> scores;
  Tensor VALID_OUTPUTS = ZERO;
  Tensor IOU_AREAI;
  Tensor IOU_INTERSECTION_AREA_YGAP;
  Tensor IOU_INTERSECTION_AREA_XGAP;

  if (center_point_box) {
    TensorShape shape_mask(DType::FLOAT32, {1, 1, 4});
    std::vector<float> mask_y1 = {0, 1, 0, -0.5};
    Buffer buffer_mask_y1(shape_mask);
    buffer_mask_y1.copy_from(mask_y1.data());
    Tensor MASK_Y1 = edsl::cast(edsl::Constant(buffer_mask_y1, "mask_y1"), box_input_type);

    std::vector<float> mask_x1 = {1, 0, -0.5, 0};
    Buffer buffer_mask_x1(shape_mask);
    buffer_mask_x1.copy_from(mask_x1.data());
    Tensor MASK_X1 = edsl::cast(edsl::Constant(buffer_mask_x1, "mask_x1"), box_input_type);

    std::vector<float> mask_y2 = {0, 1, 0, 0.5};
    Buffer buffer_mask_y2(shape_mask);
    buffer_mask_y2.copy_from(mask_y2.data());
    Tensor MASK_Y2 = edsl::cast(edsl::Constant(buffer_mask_y2, "mask_y2"), box_input_type);

    std::vector<float> mask_x2 = {1, 0, 0.5, 0};
    Buffer buffer_mask_x2(shape_mask);
    buffer_mask_x2.copy_from(mask_x2.data());
    Tensor MASK_X2 = edsl::cast(edsl::Constant(buffer_mask_x2, "mask_x2"), box_input_type);

    std::vector<float> mask_w = {0, 0, 1, 0};
    Buffer buffer_mask_w(shape_mask);
    buffer_mask_w.copy_from(mask_w.data());
    Tensor MASK_W = edsl::cast(edsl::Constant(buffer_mask_w, "mask_w"), box_input_type);

    std::vector<float> mask_h = {0, 0, 0, 1};
    Buffer buffer_mask_h(shape_mask);
    buffer_mask_h.copy_from(mask_h.data());
    Tensor MASK_H = edsl::cast(edsl::Constant(buffer_mask_h, "mask_h"), box_input_type);

    IOU_AREAI = op::sum(BOXES * MASK_W, edsl::Value(2)) * op::sum(BOXES * MASK_H, edsl::Value(2));
    Tensor BOXES_Y1 = op::sum(BOXES * MASK_Y1, edsl::Value(2));
    Tensor BOXES_X1 = op::sum(BOXES * MASK_X1, edsl::Value(2));
    Tensor BOXES_Y2 = op::sum(BOXES * MASK_Y2, edsl::Value(2));
    Tensor BOXES_X2 = op::sum(BOXES * MASK_X2, edsl::Value(2));

    Tensor IOU_INTERSECTION_YMIN = op::maximum(op::unsqueeze(BOXES_Y1, {-1}), op::unsqueeze(BOXES_Y1, {-2}));
    Tensor IOU_INTERSECTION_XMIN = op::maximum(op::unsqueeze(BOXES_X1, {-1}), op::unsqueeze(BOXES_X1, {-2}));
    Tensor IOU_INTERSECTION_YMAX = op::minimum(op::unsqueeze(BOXES_Y2, {-1}), op::unsqueeze(BOXES_Y2, {-2}));
    Tensor IOU_INTERSECTION_XMAX = op::minimum(op::unsqueeze(BOXES_X2, {-1}), op::unsqueeze(BOXES_X2, {-2}));
    IOU_INTERSECTION_AREA_YGAP = IOU_INTERSECTION_YMAX - IOU_INTERSECTION_YMIN;
    IOU_INTERSECTION_AREA_XGAP = IOU_INTERSECTION_XMAX - IOU_INTERSECTION_XMIN;
  } else {
    TensorShape shape_mask(DType::FLOAT32, {1, 1, 4});
    std::vector<float> area_mask_y = {-1, 0, 1, 0};
    Buffer buffer_area_y(shape_mask);
    buffer_area_y.copy_from(area_mask_y.data());
    Tensor AREA_MASK_Y = edsl::cast(edsl::Constant(buffer_area_y, "area_mask_y"), box_input_type);

    std::vector<float> area_mask_x = {0, -1, 0, 1};
    Buffer buffer_area_x(shape_mask);
    buffer_area_x.copy_from(area_mask_x.data());
    Tensor AREA_MASK_X = edsl::cast(edsl::Constant(buffer_area_x, "area_mask_x"), box_input_type);

    TensorShape shape_mask_is(DType::FLOAT32, {1, 1, 1, 4});
    std::vector<float> intersection_mask_ymin = {1, 0, 0, 0};
    Buffer buffer_intersection_mask_ymin(shape_mask_is);
    buffer_intersection_mask_ymin.copy_from(intersection_mask_ymin.data());
    Tensor INTERSECTION_MASK_YMIN =
        edsl::cast(edsl::Constant(buffer_intersection_mask_ymin, "intersection_mask_ymin"), box_input_type);

    std::vector<float> intersection_mask_xmin = {0, 1, 0, 0};
    Buffer buffer_intersection_mask_xmin(shape_mask_is);
    buffer_intersection_mask_xmin.copy_from(intersection_mask_xmin.data());
    Tensor INTERSECTION_MASK_XMIN =
        edsl::cast(edsl::Constant(buffer_intersection_mask_xmin, "intersection_mask_xmin"), box_input_type);

    std::vector<float> intersection_mask_ymax = {0, 0, 1, 0};
    Buffer buffer_intersection_mask_ymax(shape_mask_is);
    buffer_intersection_mask_ymax.copy_from(intersection_mask_ymax.data());
    Tensor INTERSECTION_MASK_YMAX =
        edsl::cast(edsl::Constant(buffer_intersection_mask_ymax, "intersection_mask_ymax"), box_input_type);

    std::vector<float> intersection_mask_xmax = {0, 0, 0, 1};
    Buffer buffer_intersection_mask_xmax(shape_mask_is);
    buffer_intersection_mask_xmax.copy_from(intersection_mask_xmax.data());
    Tensor INTERSECTION_MASK_XMAX =
        edsl::cast(edsl::Constant(buffer_intersection_mask_xmax, "intersection_mask_xmax"), box_input_type);

    IOU_AREAI = op::sum(BOXES * AREA_MASK_Y, edsl::Value(2)) * op::sum(BOXES * AREA_MASK_X, edsl::Value(2));
    Tensor BOXES_A = edsl::reshape(
        BOXES, {edsl::TensorDim(num_batches), edsl::TensorDim(1), edsl::TensorDim(num_boxes), edsl::TensorDim(4)});
    Tensor BOXES_B = edsl::reshape(
        BOXES, {edsl::TensorDim(num_batches), edsl::TensorDim(num_boxes), edsl::TensorDim(1), edsl::TensorDim(4)});
    Tensor IOU_INTERSECTION_MAX = op::maximum(BOXES_A, BOXES_B);
    Tensor IOU_INTERSECTION_MIN = op::minimum(BOXES_A, BOXES_B);
    IOU_INTERSECTION_AREA_YGAP = op::sum(IOU_INTERSECTION_MIN * INTERSECTION_MASK_YMAX, edsl::Value(-1)) -
                                 op::sum(IOU_INTERSECTION_MAX * INTERSECTION_MASK_YMIN, edsl::Value(-1));
    IOU_INTERSECTION_AREA_XGAP = op::sum(IOU_INTERSECTION_MIN * INTERSECTION_MASK_XMAX, edsl::Value(-1)) -
                                 op::sum(IOU_INTERSECTION_MAX * INTERSECTION_MASK_XMIN, edsl::Value(-1));
  }
  Tensor IOU_INTERSECTION_AREA = edsl::select(IOU_INTERSECTION_AREA_YGAP > 0.0f, IOU_INTERSECTION_AREA_YGAP, ZERO) *
                                 edsl::select(IOU_INTERSECTION_AREA_XGAP > 0.0f, IOU_INTERSECTION_AREA_XGAP, ZERO);

  Tensor IOU_DENOMINATOR = op::unsqueeze(IOU_AREAI, {-1}) + op::unsqueeze(IOU_AREAI, {-2}) - IOU_INTERSECTION_AREA;

  Tensor IOU_DENOMINATOR_ZEROED = edsl::select(IOU_DENOMINATOR <= 0.0f, ZERO, 1.0f / IOU_DENOMINATOR);
  Tensor IOU = IOU_INTERSECTION_AREA * IOU_DENOMINATOR_ZEROED;  // num_batches * num_boxes * num_boxes

  Tensor WEIGHT = edsl::select(SOFT_NMS_SIGMA != 0.0f, -0.5f / SOFT_NMS_SIGMA, edsl::cast(ZERO, thres_type));

  TensorShape NODE_SHAPE(DType::FLOAT32, {1, 1, 2});  // 1, 1, 2

  std::vector<float> invalid_node_index = {-1, -1};
  Buffer buffer_invalid_node(NODE_SHAPE);
  buffer_invalid_node.copy_from(invalid_node_index.data());
  auto INVALID_NODE = edsl::Constant(buffer_invalid_node, "INVALID_NODE");  // 1*1*2*fp32

  int num_boxes_per_class = std::min(num_boxes, max_output_boxes_per_class);

  auto INDEX_B = edsl::index({edsl::TensorDim(num_batches), edsl::TensorDim(num_classes), edsl::TensorDim(1)}, 0);
  auto INDEX_C = edsl::index({edsl::TensorDim(num_batches), edsl::TensorDim(num_classes), edsl::TensorDim(1)}, 1);
  auto INDEX_BC = edsl::cast(op::concatenate({INDEX_B, INDEX_C}, 2), box_output_type);  // num_batch * num_class * 2

  Tensor NEW_SCORES =
      edsl::select(SCORES > cast(SCORE_THRESHOLD, box_input_type), SCORES, ZERO);  // num_batch * num_class * num_box

  // Select box
  for (int k = 0; k < num_boxes_per_class; k++) {
    // Select the box with largest score
    // The boxes may have same score
    Tensor CANDIDATE_INDEX = edsl::gather(edsl::argsort(NEW_SCORES, 2, edsl::SortDirection::DESC), ZERO_INT).axis(2);
    // Tensor SCORE = edsl::reshape(op::max(NEW_SCORES, edsl::Value(2)), {num_batches, num_classes, 1});
    Tensor SCORE =
        edsl::gather(NEW_SCORES, op::unsqueeze(CANDIDATE_INDEX, {-1})).mode(edsl::GatherMode::ND).batchDims(2);
    Tensor CURRENT_NODE = edsl::select(SCORE > 0.0f, INDEX_BC,
                                       edsl::cast(INVALID_NODE, box_output_type));  // num_batches * num_classes * 2

    // Update count of selected box
    Tensor VALID = op::sum(edsl::select(SCORE != 0.0f, ONE, ZERO));  // num_batches* num_classes * 1 --> 1
    VALID_OUTPUTS = VALID_OUTPUTS + VALID;

    // Add selected box to scores
    scores.push_back(edsl::cast(CURRENT_NODE, thres_type));
    SCORE = edsl::select(SCORE > 0.0f, SCORE, NEG1);
    scores.push_back(edsl::cast(SCORE, thres_type));

    // Set scores of current box and boxes which have IOU larger than threshold to zero
    // The scores can be same, use scatter to update current node
    Tensor NEW_SCORES_UPDATE =
        edsl::scatter(NEW_SCORES,
                      edsl::reshape(edsl::cast(CANDIDATE_INDEX, DType::INT32),
                                    {edsl::TensorDim(num_batches), edsl::TensorDim(num_classes), edsl::TensorDim(1)}),
                      op::broadcast(ZERO, {num_batches, num_classes, 1}, {0}))
            .axis(2)
            .mode(edsl::ScatterMode::UPDATE_ELT);  // 1 * num_classes * num_boxes
    NEW_SCORES = edsl::reshape(
        NEW_SCORES_UPDATE, {edsl::TensorDim(num_batches), edsl::TensorDim(num_classes), edsl::TensorDim(num_boxes)});

    Tensor IOU_CANDIDATE = edsl::gather(IOU, CANDIDATE_INDEX)
                               .mode(edsl::GatherMode::ND)
                               .batchDims(1);  // num_batches*num_classes*num_boxes
    // use >= to include suppose_hard_suppresion case
    NEW_SCORES = edsl::select(IOU_CANDIDATE >= cast(IOU_THRESHOLD, box_input_type), ZERO, NEW_SCORES);  // 1*1*num_boxes
    // NEW_SCORES = edsl::select(IOU_CANDIDATE == 1.0f, ZERO, NEW_SCORES);  // This shall replace scatter

    // Add selected box to boxes
    Tensor BOX_INDEX =
        edsl::select(SCORE > 0.0f, edsl::cast(CANDIDATE_INDEX, box_output_type), edsl::cast(NEG1, box_output_type));
    boxes.push_back(CURRENT_NODE);
    boxes.push_back(edsl::reshape(BOX_INDEX, {num_batches, num_classes, 1}));

    // update scores for current class
    Tensor SCALE = edsl::exp(IOU_CANDIDATE * IOU_CANDIDATE * edsl::cast(WEIGHT, box_input_type));
    NEW_SCORES = NEW_SCORES * SCALE;
    NEW_SCORES = edsl::select(NEW_SCORES > edsl::cast(SCORE_THRESHOLD, box_input_type), NEW_SCORES,
                              ZERO);  // remove unused value
  }

  VALID_OUTPUTS = edsl::cast(VALID_OUTPUTS, box_output_type);

  int num_results = num_batches * num_classes * num_boxes_per_class;
  // concatenate scores
  Tensor SCORES_RESULT = edsl::reshape(op::concatenate(scores, 2), {num_results, 3});
  // concatenate boxes
  Tensor BOXES_RESULT = edsl::reshape(op::concatenate(boxes, 2), {num_results, 3});

  if (sort_result_descending) {
    // Sort across batch
    Tensor SCORES_SLICE = edsl::gather(SCORES_RESULT, TWO_INT).axis(1);
    SCORES_SLICE = edsl::reshape(SCORES_SLICE, {edsl::TensorDim(num_results)});
    Tensor INDEXES = edsl::argsort(SCORES_SLICE, 0, edsl::SortDirection::DESC);

    SCORES_RESULT = edsl::gather(SCORES_RESULT, INDEXES).axis(0);
    BOXES_RESULT = edsl::gather(BOXES_RESULT, INDEXES).axis(0);
  } else {
    // Put all -1 to the end, we now just have -1 at end of each class
    edsl::TensorDim dst(num_results * 3);
    auto INDEX = edsl::index({dst}, 0);
    auto MAX = cast(Tensor{dst}, DType::INT32);
    SCORES_RESULT = edsl::reshape(SCORES_RESULT, {dst});
    BOXES_RESULT = edsl::reshape(BOXES_RESULT, {dst});
    Tensor NEG1_THRES = edsl::cast(Tensor(-1), thres_type);
    auto INDEX2 = edsl::select(SCORES_RESULT != NEG1_THRES, INDEX, MAX);
    auto INDEX3 = edsl::argsort(edsl::cast(INDEX2, DType::FLOAT32), 0);
    SCORES_RESULT = edsl::gather(SCORES_RESULT, INDEX3).axis(0);
    BOXES_RESULT = edsl::gather(BOXES_RESULT, INDEX3).axis(0);
    SCORES_RESULT = edsl::reshape(SCORES_RESULT, {num_results, 3});
    BOXES_RESULT = edsl::reshape(BOXES_RESULT, {num_results, 3});
  }

  return {BOXES_RESULT, SCORES_RESULT, VALID_OUTPUTS};
}

void registerNonMaxSuppression() {
  registerOp("NonMaxSuppression", [](const Context& ctx) {
    auto* layer = ngraph::as_type<NonMaxSuppression>(ctx.layer);
    // OPSET5 provides multiple templates, follow setup() choice now.
    IE_ASSERT(ctx.operands.size() == 6);
    auto BOXES = ctx.operands.at(0);
    auto SCORES = ctx.operands.at(1);
    auto MAX_OUTPUT_BOXES_PER_CLASS = ctx.operands.at(2);
    auto IOU_THRESHOLD = ctx.operands.at(3);
    auto SCORE_THRESHOLD = ctx.operands.at(4);
    auto SOFT_NMS_SIGMA = ctx.operands.at(5);
    bool center_point_box =
        layer->get_box_encoding() == ngraph::op::v5::NonMaxSuppression::BoxEncodingType::CENTER ? true : false;
    bool sort_result_descending = layer->get_sort_result_descending();

    auto* max_output_boxes_per_class_op = ngraph::as_type<ngraph::op::Constant>(ctx.layer->get_input_node_ptr(2));
    if (max_output_boxes_per_class_op == nullptr) {
      THROW_IE_EXCEPTION << "Dynamic output size for non_max_suppression not supported by PlaidML plugin now";
    }
    int32_t max_output_boxes_per_class = max_output_boxes_per_class_op->get_vector<int>()[0];

    DType box_input_type = to_plaidml(layer->get_input_element_type(0));
    DType box_output_type = to_plaidml(layer->get_output_type());
    DType thres_type = to_plaidml(layer->get_input_element_type(3));

    std::vector<Tensor> OUTPUTS =
        NMS(BOXES, SCORES, max_output_boxes_per_class, IOU_THRESHOLD, SCORE_THRESHOLD, SOFT_NMS_SIGMA, center_point_box,
            sort_result_descending, box_input_type, box_output_type, thres_type);

    return edsl::make_tuple(OUTPUTS);
  });
}

}  // namespace PlaidMLPlugin