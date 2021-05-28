// Copyright (C) 2021 Intel Corporation
// SPDX-License-Identifier: Apache-2.0
//

#include "single_layer_tests/deformable_psroi_pooling.hpp"
#include <vector>

using LayerTestsDefinitions::DeformablePSROIPoolingLayerTest;

namespace {
const std::vector < std::vector<size_t> dataShape = {{}};
const std::vector < std::vector<size_t> roiShape = {{}};
const std::vector < std::vector<size_t> offsetShape = {{}};
const std::vector<int64_t> outputDims = {};
const std::vector<int64_t> groupSizes = {};
const std::vector<float> spatialScales = {};
const std::vector<std::vector<int64_t>> spatialBinsXY = {{}};
const std::vector<float> transStd = {};
const std::vector<int64_t> partSize = {};
const std::vector<InferenceEngine::Precision> netPrecisions = {
    InferenceEngine::Precision::FP32,
};

/* =============== 2 inputs with offsets =============== */

/* =============== 3 inputs without offsets =============== */
const auto smoke3Attributes = ::testing::Combine(            //
    ::testing::Values(std::vector<size_t>{1, 392, 38, 63}),  //
    ::testing::Values(std::vector<size_t>{300, 5}),          //
    ::testing::Values(std::vector<size_t>{300, 2, 7, 7}),    //
    ::testing::Values(8),                                    //
    ::testing::Values(7),                                    //
    ::testing::Values(0.0625),                               //
    ::testing::Values(std::vector<int64_t>{4, 4});           //
    ::testing::Values(0.1),                                  //
    ::testing::Values(7));
const auto smoke3Params = ::testing::Combine(            //
    smoke3Attributes,                                    //
    ::testing::Value(InferenceEngine::Precision::FP32),  //
    ::testing::Value(CommonTestUtils::DEVICE_PLAIDML));

INSTANTIATE_TEST_CASE_P(smokeWithOffsets, DeformablePSROIPoolingLayerTest, smokeParams,
                        DeformablePSROIPoolingLayerTest::getTestCaseName);

}  // namespace