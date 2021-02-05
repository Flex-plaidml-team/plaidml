// Copyright (C) 2020 Intel Corporation
// SPDX-License-Identifier: Apache-2.0
//

#include <vector>

#include "common_test_utils/test_constants.hpp"
#include "single_layer_tests/rnn_sequence.hpp"

using namespace LayerTestsDefinitions;

namespace {
std::vector<ngraph::helpers::SequenceTestsMode> modes = {
    ngraph::helpers::SequenceTestsMode::CONVERT_TO_TI_MAX_SEQ_LEN_CONST,   //
    ngraph::helpers::SequenceTestsMode::CONVERT_TO_TI_RAND_SEQ_LEN_CONST,  //
    //    ngraph::helpers::SequenceTestsMode::PURE_SEQ,                          //
    //    ngraph::helpers::SequenceTestsMode::CONVERT_TO_TI_MAX_SEQ_LEN_PARAM,   //
    //    ngraph::helpers::SequenceTestsMode::CONVERT_TO_TI_RAND_SEQ_LEN_PARAM   //
};
std::vector<size_t> seq_length = {5, 10};
std::vector<size_t> batch = {1, 5};
std::vector<size_t> hidden_size = {1, 10};
std::vector<size_t> input_size = {1, 30};
std::vector<std::vector<std::string>> activations = {{"tanh"}, {"relu"}, {"sigmoid"}};
std::vector<float> clips = {0.f, 0.7f};
std::vector<ngraph::op::RecurrentSequenceDirection> directions = {
    ngraph::op::RecurrentSequenceDirection::FORWARD,       //
    ngraph::op::RecurrentSequenceDirection::REVERSE,       //
    ngraph::op::RecurrentSequenceDirection::BIDIRECTIONAL  //
};
std::vector<InferenceEngine::Precision> netPrecisions = {InferenceEngine::Precision::FP32};

INSTANTIATE_TEST_CASE_P(RNNCellCommon, RNNSequenceTest,
                        ::testing::Combine(                                       //
                            ::testing::ValuesIn(modes),                           //
                            ::testing::ValuesIn(seq_length),                      //
                            ::testing::ValuesIn(batch),                           //
                            ::testing::ValuesIn(hidden_size),                     //
                            ::testing::ValuesIn(input_size),                      //
                            ::testing::ValuesIn(activations),                     //
                            ::testing::ValuesIn(clips),                           //
                            ::testing::ValuesIn(directions),                      //
                            ::testing::ValuesIn(netPrecisions),                   //
                            ::testing::Values(CommonTestUtils::DEVICE_PLAIDML)),  //
                        RNNSequenceTest::getTestCaseName);

INSTANTIATE_TEST_CASE_P(smoke, RNNSequenceTest,
                        ::testing::Combine(                                                      //
                            ::testing::Values(modes[0]),                                         //
                            ::testing::Values(5),                                                //
                            ::testing::Values(3),                                                //
                            ::testing::Values(64),                                               //
                            ::testing::Values(32),                                               //
                            ::testing::Values("tanh"),                                           //
                            ::testing::Values(0.8f),                                             //
                            ::testing::Values(ngraph::op::RecurrentSequenceDirection::FORWARD),  //
                            ::testing::Values(InferenceEngine::Precision::FP32),                 //
                            ::testing::Values(CommonTestUtils::DEVICE_PLAIDML)),                 //
                        RNNSequenceTest::getTestCaseName);
}  // namespace
