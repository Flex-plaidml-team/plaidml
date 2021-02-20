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
        std::vector<edsl::Tensor> O_batched;
        std::vector<edsl::Tensor> H_batched;
        for (int i = 0; i < batch_size; i++) {
          edsl::Tensor Ht = op::slice(H0).add_dim(i).add_dim(0).add_dim(0, hidden_size);
          auto seq_length = seq_lengths.at(i);
          std::vector<edsl::Tensor> O_seq;
          for (int j = 0; j < max_length; j++) {
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
      case ngraph::op::RecurrentSequenceDirection::REVERSE: {
        std::vector<edsl::Tensor> O_batched;
        std::vector<edsl::Tensor> H_batched;
        for (int i = 0; i < batch_size; i++) {
          edsl::Tensor Ht = op::slice(H0).add_dim(i).add_dim(0).add_dim(0, hidden_size);
          auto seq_length = seq_lengths.at(i);
          std::vector<edsl::Tensor> O_seq;
          for (int j = max_length - 1; j >= 0; j--) {
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
      case ngraph::op::RecurrentSequenceDirection::BIDIRECTIONAL: {
        std::vector<edsl::Tensor> O_batched;
        std::vector<edsl::Tensor> H_batched;
        for (int i = 0; i < batch_size; i++) {
          edsl::Tensor Ht = op::slice(H0).add_dim(i).add_dim(0).add_dim(0, hidden_size);
          auto seq_length = seq_lengths.at(i);
          std::vector<edsl::Tensor> O_seq;
          for (int j = 0; j < max_length; j++) {
            if (j < seq_length) {
              auto Xij = op::slice(X).add_dim(i).add_dim(j).add_dim(0, input_size);
              auto Hij = op::dot(Xij, op::transpose(W)) + op::dot(Ht, op::transpose(R)) + B;
              Ht = clip_activation(activation, should_clip, clip, Hij);
              // TODO: weight tensor for output is NOT given, use Ht as Ot
              O_seq.push_back(op::unsqueeze(Ht, {0, 1, 2}));
            } else {
              O_seq.push_back(op::unsqueeze(edsl::Tensor(0), {0, 1, 2}));
            }
          }
          O_batched.push_back(op::concatenate(O_seq, 2));
          H_batched.push_back(op::unsqueeze(Ht, {0, 1}));
        }
        auto O_forward = op::concatenate(O_batched, 0);
        auto H_forward = op::concatenate(H_batched, 0);

        O_batched.clear();
        H_batched.clear();
        for (int i = 0; i < batch_size; i++) {
          edsl::Tensor Ht = op::slice(H0).add_dim(i).add_dim(1).add_dim(0, hidden_size);
          auto seq_length = seq_lengths.at(i);
          std::vector<edsl::Tensor> O_seq;
          for (int j = max_length - 1; j >= 0; j--) {
            if (j < seq_length) {
              auto Xij = op::slice(X).add_dim(i).add_dim(j).add_dim(0, input_size);
              auto Hij = op::dot(Xij, op::transpose(W)) + op::dot(Ht, op::transpose(R)) + B;
              Ht = clip_activation(activation, should_clip, clip, Hij);
              // TODO: weight tensor for output is NOT given, use Ht as Ot
              O_seq.push_back(op::unsqueeze(Ht, {0, 1, 2}));
            } else {
              O_seq.push_back(op::unsqueeze(edsl::Tensor(0), {0, 1, 2}));
            }
          }
          O_batched.push_back(op::concatenate(O_seq, 2));
          H_batched.push_back(op::unsqueeze(Ht, {0, 1}));
        }
        auto O_reverse = op::concatenate(O_batched, 0);
        auto H_reverse = op::concatenate(H_batched, 0);

        auto O = op::concatenate({O_forward, O_reverse}, 1);
        auto Ho = op::concatenate({H_forward, H_reverse}, 1);
        return edsl::make_tuple(O, Ho);
      }
      default:
        std::runtime_error("Unsupported recurrent sequence direction.");
    }
  });
}

}  // namespace PlaidMLPlugin
