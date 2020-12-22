// Copyright (C) 2019 Intel Corporation
// SPDX-License-Identifier: Apache-2.0
//

#include <string>
#include <vector>

#include "common_test_utils/test_constants.hpp"
#include "single_layer_tests/assign.hpp"

using LayerTestsDefinitions::AssignLayerTest;

namespace {
const std::vector<InferenceEngine::Precision> netPrecisions = {
    InferenceEngine::Precision::FP32,
    // InferenceEngine::Precision::FP16,
    // InferenceEngine::Precision::I64
};

const std::vector<std::vector<size_t>> newShapes = {
    {1, 2, 3, 4}, {2, 3, 4, 5}  //
};

INSTANTIATE_TEST_CASE_P(AssignCheck, AssignLayerTest,
                        ::testing::Combine(::testing::ValuesIn(netPrecisions),                   //
                                           ::testing::ValuesIn(newShapes),                       //
                                           ::testing::Values(std::string("id")),                 //
                                           ::testing::Values(CommonTestUtils::DEVICE_PLAIDML)),  //
                        AssignLayerTest::getTestCaseName);
}  // namespace
