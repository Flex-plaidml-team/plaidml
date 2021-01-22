// Copyright (C) 2019 Intel Corporation
// SPDX-License-Identifier: Apache-2.0
//

#include <vector>

#include "common_test_utils/test_constants.hpp"
#include "single_layer_tests/deformable_convolution.hpp"

using LayerTestsDefinitions::DeformableConvolutionLayerTest;

namespace {

const std::vector<InferenceEngine::Precision> netPrecisions = {
    InferenceEngine::Precision::FP32,
    // InferenceEngine::Precision::FP16  // TODO: Not yet working
};
/* ============= 1D Convolution ============*/
const auto DeformableConv1DParams_Explicitpadding =
    ::testing::Combine(::testing::Values(std::vector<size_t>({2})),     //
                       ::testing::Values(std::vector<size_t>({1})),     //
                       ::testing::Values(std::vector<ptrdiff_t>({0})),  //
                       ::testing::Values(std::vector<ptrdiff_t>({0})),  //
                       ::testing::Values(std::vector<size_t>({1})),     //
                       ::testing::Values(size_t(1)),                    //
                       ::testing::Values(size_t(1)),                    //
                       ::testing::Values(size_t(1)),                    //
                       ::testing::Values(ngraph::op::PadType::EXPLICIT));

const auto DeformableConv1DParams_AutoPadValid = ::testing::Combine(::testing::Values(std::vector<size_t>({2})),     //
                                                                    ::testing::Values(std::vector<size_t>({1})),     //
                                                                    ::testing::Values(std::vector<ptrdiff_t>({0})),  //
                                                                    ::testing::Values(std::vector<ptrdiff_t>({0})),  //
                                                                    ::testing::Values(std::vector<size_t>({1})),     //
                                                                    ::testing::Values(size_t(1)),                    //
                                                                    ::testing::Values(size_t(1)),                    //
                                                                    ::testing::Values(size_t(1)),                    //
                                                                    ::testing::Values(ngraph::op::PadType::EXPLICIT));

INSTANTIATE_TEST_CASE_P(DeformableConvolution1D_Explicitpadding, DeformableConvolutionLayerTest,
                        ::testing::Combine(DeformableConv1DParams_Explicitpadding,               //
                                           ::testing::ValuesIn(netPrecisions),                   //
                                           ::testing::Values(std::vector<size_t>({1, 1, 3})),    //
                                           ::testing::Values(std::vector<size_t>({1, 2, 2})),    //
                                           ::testing::Values(CommonTestUtils::DEVICE_PLAIDML)),  //
                        DeformableConvolutionLayerTest::getTestCaseName);

INSTANTIATE_TEST_CASE_P(DeformableConvolution1D_AutoPadValid, DeformableConvolutionLayerTest,
                        ::testing::Combine(DeformableConv1DParams_AutoPadValid,                  //
                                           ::testing::ValuesIn(netPrecisions),                   //
                                           ::testing::Values(std::vector<size_t>({1, 1, 3})),    //
                                           ::testing::Values(std::vector<size_t>({1, 2, 2})),    //
                                           ::testing::Values(CommonTestUtils::DEVICE_PLAIDML)),  //
                        DeformableConvolutionLayerTest::getTestCaseName);

/* ============= 2D Convolution ============= */
const std::vector<std::vector<size_t>> kernels = {
    {2, 2},
};
const std::vector<std::vector<size_t>> strides = {
    {1, 1},
};
const std::vector<std::vector<ptrdiff_t>> padBegins = {
    {1, 1},
};
const std::vector<std::vector<ptrdiff_t>> padEnds = {
    {0, 0},
};
const std::vector<std::vector<size_t>> dilations = {
    {1, 1},
};
const std::vector<size_t> numOutChannels = {
    2,
};
const std::vector<size_t> group = {
    1,
};  // Group not equal 1 isn't supported in Openvino for now
const std::vector<size_t> deformableGroup = {
    1,
};
const std::vector<ngraph::op::PadType> padTypes = {
    ngraph::op::PadType::EXPLICIT,  //
    ngraph::op::PadType::VALID      //
};

const auto conv2DParams_ExplicitPadding = ::testing::Combine(::testing::ValuesIn(kernels),                     //
                                                             ::testing::ValuesIn(strides),                     //
                                                             ::testing::ValuesIn(padBegins),                   //
                                                             ::testing::ValuesIn(padEnds),                     //
                                                             ::testing::ValuesIn(dilations),                   //
                                                             ::testing::ValuesIn(numOutChannels),              //
                                                             ::testing::ValuesIn(group),                       //
                                                             ::testing::ValuesIn(deformableGroup),             //
                                                             ::testing::Values(ngraph::op::PadType::EXPLICIT)  //
);
const auto conv2DParams_AutoPadValid = ::testing::Combine(::testing::ValuesIn(kernels),                       //
                                                          ::testing::ValuesIn(strides),                       //
                                                          ::testing::Values(std::vector<ptrdiff_t>({0, 0})),  //
                                                          ::testing::Values(std::vector<ptrdiff_t>({0, 0})),  //
                                                          ::testing::ValuesIn(dilations),                     //
                                                          ::testing::ValuesIn(numOutChannels),                //
                                                          ::testing::ValuesIn(group),                         //
                                                          ::testing::ValuesIn(deformableGroup),               //
                                                          ::testing::Values(ngraph::op::PadType::VALID)       //
);

INSTANTIATE_TEST_CASE_P(Convolution2D_ExplicitPadding, DeformableConvolutionLayerTest,
                        ::testing::Combine(conv2DParams_ExplicitPadding,                          //
                                           ::testing::ValuesIn(netPrecisions),                    //
                                           ::testing::Values(std::vector<size_t>({1, 2, 3, 3})),  //
                                           ::testing::Values(std::vector<size_t>({1, 8, 3, 3})),  //
                                           ::testing::Values(CommonTestUtils::DEVICE_PLAIDML)),   //
                        DeformableConvolutionLayerTest::getTestCaseName);

INSTANTIATE_TEST_CASE_P(Convolution2D_AutoPadValid, DeformableConvolutionLayerTest,
                        ::testing::Combine(conv2DParams_AutoPadValid,  //
                                           ::testing::ValuesIn(netPrecisions),
                                           ::testing::Values(std::vector<size_t>({1, 2, 3, 3})),  //
                                           ::testing::Values(std::vector<size_t>({1, 8, 2, 2})),  //
                                           ::testing::Values(CommonTestUtils::DEVICE_PLAIDML)),   //
                        DeformableConvolutionLayerTest::getTestCaseName);

/* ============= 3D Convolution ============= */

const std::vector<std::vector<size_t>> kernels3d = {
    {2, 2, 2},
};
const std::vector<std::vector<ptrdiff_t>> paddings3d = {
    {1, 1, 1},
};

const std::vector<std::vector<size_t>> strides3d = {
    {1, 1, 1},
};
const std::vector<std::vector<size_t>> dilations3d = {
    {1, 1, 1},
};

const auto conv3DParams_ExplicitPadding = ::testing::Combine(::testing::ValuesIn(kernels3d),                   //
                                                             ::testing::ValuesIn(strides3d),                   //
                                                             ::testing::ValuesIn(paddings3d),                  //
                                                             ::testing::ValuesIn(paddings3d),                  //
                                                             ::testing::ValuesIn(dilations3d),                 //
                                                             ::testing::Values(2),                             //
                                                             ::testing::ValuesIn(group),                       //
                                                             ::testing::ValuesIn(deformableGroup),             //
                                                             ::testing::Values(ngraph::op::PadType::EXPLICIT)  //
);
const auto conv3DParams_AutoPadValid = ::testing::Combine(::testing::ValuesIn(kernels3d),                        //
                                                          ::testing::ValuesIn(strides3d),                        //
                                                          ::testing::Values(std::vector<ptrdiff_t>({0, 0, 0})),  //
                                                          ::testing::Values(std::vector<ptrdiff_t>({0, 0, 0})),  //
                                                          ::testing::ValuesIn(dilations3d),                      //
                                                          ::testing::Values(2),                                  //
                                                          ::testing::ValuesIn(group),                            //
                                                          ::testing::ValuesIn(deformableGroup),                  //
                                                          ::testing::Values(ngraph::op::PadType::VALID)          //
);

INSTANTIATE_TEST_CASE_P(Convolution3D_ExplicitPadding, DeformableConvolutionLayerTest,
                        ::testing::Combine(conv3DParams_ExplicitPadding,                              //
                                           ::testing::ValuesIn(netPrecisions),                        //
                                           ::testing::Values(std::vector<size_t>({1, 2, 3, 3, 3})),   //
                                           ::testing::Values(std::vector<size_t>({1, 24, 4, 4, 4})),  //
                                           ::testing::Values(CommonTestUtils::DEVICE_PLAIDML)),       //
                        DeformableConvolutionLayerTest::getTestCaseName);

INSTANTIATE_TEST_CASE_P(Convolution3D_AutoPadValid, DeformableConvolutionLayerTest,
                        ::testing::Combine(conv3DParams_AutoPadValid,                                 //
                                           ::testing::ValuesIn(netPrecisions),                        //
                                           ::testing::Values(std::vector<size_t>({1, 2, 3, 3, 3})),   //
                                           ::testing::Values(std::vector<size_t>({1, 24, 2, 2, 2})),  //
                                           ::testing::Values(CommonTestUtils::DEVICE_PLAIDML)),       //
                        DeformableConvolutionLayerTest::getTestCaseName);

}  // namespace
