// Copyright (C) 2020 Intel Corporation
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
    auto should_clip = (clip > 0.f) && (clip != std::numeric_limits<float>::infinity());
    auto direction = layer->get_direction();

    auto batch_size = X.compute_shape().sizes()[0];
    auto max_length = X.compute_shape().sizes()[1];
    auto input_size = X.compute_shape().sizes()[2];
    auto hidden_size = layer->get_hidden_size();
    switch (direction) {
      case ngraph::op::RecurrentSequenceDirection::FORWARD: {
        std::vector<edsl::Tensor> batched_output;
        std::vector<edsl::Tensor> batched_hidden;
        for (int i = 0; i < batch_size; i++) {
          edsl::Tensor Ht = op::slice(H0).add_dim(i).add_dim(0).add_dim(0, hidden_size);
          auto seq_length = seq_lengths.at(i);
          std::vector<edsl::Tensor> seq_output;
          for (int j = 0; j < max_length; j++) {
            if (j < seq_length) {
              auto Xij = op::slice(X).add_dim(i).add_dim(j).add_dim(0, input_size);
              auto Hij = op::dot(Xij, op::transpose(W)) + op::dot(Ht, op::transpose(R)) + B;
              Ht = clip_activation(activation, should_clip, clip, Hij);
              // TODO: weight tensor for output is NOT given
              seq_output.push_back(op::unsqueeze(Ht, {1, 1, 1, (int64_t)hidden_size}));
            } else {
              seq_output.push_back(op::unsqueeze(edsl::Tensor(0), {1, 1, 1, (int64_t)hidden_size}));
            }
          }
          batched_output.push_back(op::concatenate(seq_output, 2));
          batched_hidden.push_back(op::unsqueeze(Ht, {1, 1, (int64_t)hidden_size}));
        }
        auto O = op::concatenate(batched_output, 0);
        auto Ho = op::concatenate(batched_hidden, 0);
        return edsl::make_tuple(O, Ho);
      }
      case ngraph::op::RecurrentSequenceDirection::REVERSE: {
        std::vector<edsl::Tensor> batched_output;
        std::vector<edsl::Tensor> batched_hidden;
        for (int i = 0; i < batch_size; i++) {
          edsl::Tensor Ht = op::slice(H0).add_dim(i).add_dim(0).add_dim(0, hidden_size);
          auto seq_length = seq_lengths.at(i);
          std::vector<edsl::Tensor> seq_output;
          for (int j = max_length - 1; j >= 0; j++) {
            if (j < seq_length) {
              auto Xij = op::slice(X).add_dim(i).add_dim(j).add_dim(0, input_size);
              auto Hij = op::dot(Xij, op::transpose(W)) + op::dot(Ht, op::transpose(R)) + B;
              Ht = clip_activation(activation, should_clip, clip, Hij);
              // TODO: weight tensor for output is NOT given
              seq_output.push_back(op::unsqueeze(Ht, {1, 1, 1, (int64_t)hidden_size}));
            } else {
              seq_output.push_back(op::unsqueeze(edsl::Tensor(0), {1, 1, 1, (int64_t)hidden_size}));
            }
          }
          batched_output.push_back(op::concatenate(seq_output, 2));
          batched_hidden.push_back(op::unsqueeze(Ht, {1, 1, (int64_t)hidden_size}));
        }
        auto O = op::concatenate(batched_output, 0);
        auto Ho = op::concatenate(batched_hidden, 0);
        return edsl::make_tuple(O, Ho);
      }
      case ngraph::op::RecurrentSequenceDirection::BIDIRECTIONAL: {
        break;
      }
      default:
        std::runtime_error("Unsupported recurrent sequence direction.");
    }
  });
}

}  // namespace PlaidMLPlugin
