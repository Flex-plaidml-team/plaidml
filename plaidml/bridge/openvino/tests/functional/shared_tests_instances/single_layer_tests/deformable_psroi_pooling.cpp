// Copyright (C) 2021 Intel Corporation
// SPDX-License-Identifier: Apache-2.0
//

#include <vector>

#include "common_test_utils/test_constants.hpp"
#include "single_layer_tests/deformable_psroi_pooling.hpp"

using LayerTestsDefinitions::DeformablePSROIPoolingLayerTest;

namespace {

const std::vector<InferenceEngine::Precision> netPrecisions = {
    InferenceEngine::Precision::FP32,
    // InferenceEngine::Precision::FP16  // TODO: Not yet working
};
const std::vector<std::vector<size_t>> input = {
    {1, 8, 5, 5},
};
const std::vector<std::vector<size_t>> coords = {
    {1, 5},
};
const std::vector<std::vector<size_t>> offsets = {
    {1, 4, 2, 2},
};
const std::vector<bool> no_trans = {
    false,
};
const std::vector<int64_t> output_dim = {
    2,
};
const std::vector<float> spatial_scale = {
    1.0,
};
const std::vector<std::int64_t> group_size = {
    4,
};
const std::vector<std::string> mode = {
    "bilinear_deformable",
};
const std::vector<std::int64_t> spatial_bins_x = {
    1,
};
const std::vector<std::int64_t> spatial_bins_y = {
    1,
};
const std::vector<float> trans_std = {
    1.0,
};
const std::vector<std::int64_t> part_size = {
    2,
};

const auto DeformablePSROIPoolingParams = ::testing::Combine(::testing::Values(std::vector<size_t>({1, 8, 5, 5})),   //
                                                             ::testing::ValuesIn(coords),                            //
                                                             ::testing::Values(std::vector<size_t>({1, 4, 2, 2})),   //
                                                             ::testing::ValuesIn(no_trans),                          //
                                                             ::testing::Values(2),                                   //
                                                             ::testing::ValuesIn(spatial_scale),                     //
                                                             ::testing::Values(4),                                   //
                                                             ::testing::Values(std::string("bilinear_deformable")),  //
                                                             ::testing::ValuesIn(spatial_bins_x),                    //
                                                             ::testing::ValuesIn(spatial_bins_y)                     //
);

INSTANTIATE_TEST_CASE_P(smoke_DeformablePSROIPooling, DeformablePSROIPoolingLayerTest,
                        ::testing::Combine(DeformablePSROIPoolingParams,                         //
                                           ::testing::ValuesIn(trans_std),                       //
                                           ::testing::ValuesIn(part_size),                       //
                                           ::testing::ValuesIn(netPrecisions),                   //
                                           ::testing::Values(CommonTestUtils::DEVICE_PLAIDML)),  //
                        DeformablePSROIPoolingLayerTest::getTestCaseName);
}  // namespace
