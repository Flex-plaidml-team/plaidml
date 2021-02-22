// Copyright (C) 2021 Intel Corporation
// SPDX-License-Identifier: Apache-2.0
//

#include <limits>

#include "ngraph/opsets/opset5.hpp"
#include "plaidml/op/op.h"
#include "plaidml_ops.hpp"
#include "plaidml_util.hpp"

using namespace plaidml;          // NOLINT[build/namespaces]
using namespace InferenceEngine;  // NOLINT[build/namespaces]

namespace PlaidMLPlugin {

namespace {

op::RecurrentSequenceDirection to_plaidml(ngraph::op::RecurrentSequenceDirection direction) {
  switch (direction) {
    case ngraph::op::RecurrentSequenceDirection::FORWARD: {
      return op::RecurrentSequenceDirection::FORWARD;
    }
    case ngraph::op::RecurrentSequenceDirection::REVERSE: {
      return op::RecurrentSequenceDirection::REVERSE;
    }
    case ngraph::op::RecurrentSequenceDirection::BIDIRECTIONAL: {
      return op::RecurrentSequenceDirection::BIDIRECTIONAL;
    }
    default:
      // TODO: Verify these are the unsupported types
      THROW_IE_EXCEPTION << "Unsupported Recurrent Sequence Direction";
  }
}

edsl::Value unidirectional_rnn(edsl::Tensor X, edsl::Tensor H, edsl::Tensor W, edsl::Tensor R, edsl::Tensor B,
                               std::vector<int64_t>& seq_lengths, int64_t batch_size, int64_t input_size,
                               int64_t hidden_size, std::string activation, float clip, int64_t start, int64_t end,
                               int64_t step) {
  auto should_clip = (clip > 0.f) && (clip != std::numeric_limits<float>::infinity());

  std::vector<edsl::Tensor> O_batched;
  std::vector<edsl::Tensor> H_batched;
  for (int i = 0; i < batch_size; i++) {
    edsl::Tensor Ht = op::slice(H).add_dim(i).add_dim(0).add_dim(0, hidden_size);
    auto seq_length = seq_lengths.at(i);
    std::vector<edsl::Tensor> O_seq;
    for (int j = start; j != end + step; j += step) {
      if (j < seq_length) {
        auto Xij = op::slice(X).add_dim(i).add_dim(j).add_dim(0, input_size);
        auto Hij = op::dot(Xij, op::transpose(W)) + op::dot(Ht, op::transpose(R)) + B;
        Ht = clip_activation(activation, should_clip, clip, Hij);
        // TODO: weight tensor for output is NOT given
        O_seq.push_back(op::unsqueeze(Ht, {0, 1, 2}));
      } else {
        O_seq.push_back(op::unsqueeze(edsl::Tensor(0), {0, 1, 2}));
      }
    }
    O_batched.push_back(op::concatenate(O_seq, 2));
    H_batched.push_back(op::unsqueeze(Ht, {0, 1}));
  }
  auto O = op::concatenate(O_batched, 0);
  auto Ho = op::concatenate(H_batched, 0);
  return edsl::make_tuple(O, Ho);
}
}  // namespace

void registerRnnSequence() {
  registerOp("RnnSequence", [](const Context& ctx) {
    IE_ASSERT(ctx.operands.size() == 6);
    auto* layer = ngraph::as_type<ngraph::opset5::RNNSequence>(ctx.layer);
    auto X = ctx.operands.at(0);                                  // input tensor
    auto H0 = ctx.operands.at(1);                                 // initial hidden state tensor
    auto seq_lengths = cast_constant_operand<int64_t>(2, layer);  // real sequence length for each batch element
    auto W = ctx.operands.at(3);                                  // weight tensor [hidden_size, input_size]
    auto R = ctx.operands.at(4);                                  // recurrence weight tensor [hidden_size, input_size]
    auto B = ctx.operands.at(5);                                  // bias tensor [hidden_size]

    auto activations = layer->get_activations();
    auto activation = activations.at(0);
    auto activations_alpha = layer->get_activations_alpha();
    auto activations_beta = layer->get_activations_beta();

    auto clip = layer->get_clip();
    auto direction = to_plaidml(layer->get_direction());
    auto hidden_size = layer->get_hidden_size();

    auto X_shape = X.compute_shape().sizes();
    auto batch_size = X_shape[0];
    auto max_length = X_shape[1];
    auto input_size = X_shape[2];

    switch (direction) {
      case op::RecurrentSequenceDirection::FORWARD: {
        return unidirectional_rnn(X, H0, W, R, B, seq_lengths, batch_size, input_size, hidden_size, activation, clip, 0,
                                  max_length, 1);
      }
      case op::RecurrentSequenceDirection::REVERSE: {
        return unidirectional_rnn(X, H0, W, R, B, seq_lengths, batch_size, input_size, hidden_size, activation, clip,
                                  max_length - 1, 0, -1);
      }
      case op::RecurrentSequenceDirection::BIDIRECTIONAL: {
        auto result_forward = unidirectional_rnn(X, H0, W, R, B, seq_lengths, batch_size, input_size, hidden_size,
                                                 activation, clip, 0, max_length - 1, 1);
        auto O_forward = result_forward.as_tuple().at(0).as_tensor();
        auto H_forward = result_forward.as_tuple().at(1).as_tensor();
        auto result_reverse = unidirectional_rnn(X, H0, W, R, B, seq_lengths, batch_size, input_size, hidden_size,
                                                 activation, clip, max_length - 1, 0, -1);
        auto O_reverse = result_reverse.as_tuple().at(0).as_tensor();
        auto H_reverse = result_reverse.as_tuple().at(1).as_tensor();
        auto O = op::concatenate({O_forward, O_reverse}, 1);
        auto Ho = op::concatenate({H_forward, H_reverse}, 1);
        return edsl::make_tuple(O, Ho);
      }
      default:
        std::runtime_error("Unsupported recurrent sequence direction.");
    }
  });
}  // namespace

}  // namespace PlaidMLPlugin
