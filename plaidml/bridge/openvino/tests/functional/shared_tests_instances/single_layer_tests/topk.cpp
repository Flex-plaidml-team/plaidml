// Copyright (C) 2020 Intel Corporation
// SPDX-License-Identifier: Apache-2.0
//

#include <vector>

#include "single_layer_tests/topk.hpp"

using LayerTestsDefinitions::TopKLayerTest;

namespace {

const std::vector<InferenceEngine::Precision> netPrecisions = {InferenceEngine::Precision::FP32};

const std::vector<std::vector<size_t>> repeats = {
    {3, 3},
    {4, 3},
};

INSTANTIATE_TEST_CASE_P(smoke, TopKLayerTest,
                        ::testing::Combine(::testing::Values(1),                                     //
                                           ::testing::Values(0),                                     //
                                           ::testing::Values(ngraph::opset4::TopK::Mode::MAX),       // mode
                                           ::testing::Values(ngraph::opset4::TopK::SortType::NONE),  // sort
                                           ::testing::ValuesIn(netPrecisions),                       //
                                           ::testing::ValuesIn(netPrecisions),                       //
                                           ::testing::ValuesIn(netPrecisions),                       //
                                           ::testing::Values(1),                                     //
                                           ::testing::ValuesIn(repeats),                             //
                                           ::testing::Values(CommonTestUtils::DEVICE_PLAIDML)),      //
                        TopKLayerTest::getTestCaseName);

}  // namespace
