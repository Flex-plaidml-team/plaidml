// Vulkan runtime wrappers, originally from the LLVM project, and subsequently
// modified by Intel Corporation.
//
// Original copyright:
//
//===- vulkan-runtime-wrappers.cpp - MLIR Vulkan runner wrapper library ---===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// Implements C runtime wrappers around the VulkanRuntime.
//
//===----------------------------------------------------------------------===//

#include <ctime>
#include <mutex>
#include <numeric>

#include "half.hpp"
#include "llvm/Support/raw_ostream.h"

#include "mlir/ExecutionEngine/RunnerUtils.h"

#include "pmlc/rt/symbol_registry.h"
#include "pmlc/rt/vulkan/vulkan_invocation.h"
#include "pmlc/util/logging.h"

using pmlc::rt::Device;

namespace pmlc::rt::vulkan {
namespace {

template <typename T>
void bindBuffer(void *vkInvocation, DescriptorSetIndex setIndex,
                BindingIndex bindIndex, uint32_t bufferByteSize,
                BufferCopyMode bufferCopyMode,
                ::UnrankedMemRefType<T> *unrankedMemRef) {
  DynamicMemRefType<T> memRef(*unrankedMemRef);
  T *ptr = memRef.data + memRef.offset;
  VulkanHostMemoryBuffer memBuffer{ptr, bufferByteSize};
  static_cast<VulkanInvocation *>(vkInvocation)
      ->setResourceData(setIndex, bindIndex, bufferCopyMode, memBuffer);
}

} // namespace

extern "C" {

void *initVulkan() { return new VulkanInvocation(); }

void deinitVulkan(void *vkInvocation) {
  delete static_cast<VulkanInvocation *>(vkInvocation);
}

void createVulkanLaunchKernelAction(void *vkInvocation, uint8_t *shader,
                                    uint32_t size, const char *entryPoint,
                                    uint32_t x, uint32_t y, uint32_t z) {
  static_cast<VulkanInvocation *>(vkInvocation)
      ->createLaunchKernelAction(shader, size, entryPoint, {x, y, z});
}

void createVulkanMemoryTransferAction(void *vkInvocation, uint64_t src_index,
                                      uint64_t src_binding, uint64_t dst_index,
                                      uint64_t dst_binding) {
  static_cast<VulkanInvocation *>(vkInvocation)
      ->createMemoryTransferAction(src_index, src_binding, dst_index,
                                   dst_binding);
}

void setVulkanLaunchKernelAction(void *vkInvocation, uint32_t subgroupSize) {
  static_cast<VulkanInvocation *>(vkInvocation)
      ->setLaunchKernelAction(subgroupSize);
}

void addVulkanLaunchActionToSchedule(void *vkInvocation) {
  static_cast<VulkanInvocation *>(vkInvocation)->addLaunchActionToSchedule();
}

void run(void *vkInvocation) {
  static_cast<VulkanInvocation *>(vkInvocation)->run();
}

void *hostTimer() {
  struct timespec *timer = (struct timespec *)malloc(sizeof(struct timespec));
  clock_gettime(CLOCK_MONOTONIC, timer);
  return (void *)timer;
}

void getHostExecTime(void *timerBefore, void *timerAfter) {
  struct timespec *before = (struct timespec *)timerBefore;
  struct timespec *after = (struct timespec *)timerAfter;
  float interval;
  interval = ((after->tv_sec - before->tv_sec) * 1000.0) +
             ((after->tv_nsec - before->tv_nsec) / 1000000.0);
  IVLOG(1, "Elapsed Time is " << interval << " ms");
}

#define BIND_BUFFER_IMPL(_name_, _type_)                                       \
  void _mlir_ciface_bindBuffer##_name_(                                        \
      void *vkInvocation, DescriptorSetIndex setIndex, BindingIndex bindIndex, \
      uint32_t bufferByteSize, uint32_t bufferCopyMode,                        \
      ::UnrankedMemRefType<_type_> *unrankedMemRef) {                          \
    bindBuffer(vkInvocation, setIndex, bindIndex, bufferByteSize,              \
               bufferCopyMode, unrankedMemRef);                                \
  }

BIND_BUFFER_IMPL(Float16, half_float::half);
BIND_BUFFER_IMPL(Float32, float);
BIND_BUFFER_IMPL(Float64, double);
BIND_BUFFER_IMPL(Integer8, int8_t);
BIND_BUFFER_IMPL(Integer16, int16_t);
BIND_BUFFER_IMPL(Integer32, int32_t);
BIND_BUFFER_IMPL(Integer64, int64_t);

void _mlir_ciface_fillResourceFloat32(
    ::UnrankedMemRefType<float> *unrankedMemRef, int32_t size, float value) {
  DynamicMemRefType<float> memRef(*unrankedMemRef);
  float *ptr = memRef.data + memRef.offset;
  std::fill_n(ptr, size, value);
}

} // extern "C"

namespace {
struct Registration {
  Registration() {
    using pmlc::rt::registerSymbol;

    // Vulkan Runtime functions
    registerSymbol("initVulkan", reinterpret_cast<void *>(initVulkan));
    registerSymbol("deinitVulkan", reinterpret_cast<void *>(deinitVulkan));
    registerSymbol("createVulkanLaunchKernelAction",
                   reinterpret_cast<void *>(createVulkanLaunchKernelAction));
    registerSymbol("createVulkanMemoryTransferAction",
                   reinterpret_cast<void *>(createVulkanMemoryTransferAction));
    registerSymbol("setVulkanLaunchKernelAction",
                   reinterpret_cast<void *>(setVulkanLaunchKernelAction));
    registerSymbol("addVulkanLaunchActionToSchedule",
                   reinterpret_cast<void *>(addVulkanLaunchActionToSchedule));
    registerSymbol("run", reinterpret_cast<void *>(run));
    registerSymbol("hostTimer", reinterpret_cast<void *>(hostTimer));
    registerSymbol("getHostExecTime",
                   reinterpret_cast<void *>(getHostExecTime));
    registerSymbol("_mlir_ciface_bindBufferFloat16",
                   reinterpret_cast<void *>(_mlir_ciface_bindBufferFloat16));
    registerSymbol("_mlir_ciface_bindBufferFloat32",
                   reinterpret_cast<void *>(_mlir_ciface_bindBufferFloat32));
    registerSymbol("_mlir_ciface_bindBufferFloat64",
                   reinterpret_cast<void *>(_mlir_ciface_bindBufferFloat64));
    registerSymbol("_mlir_ciface_bindBufferInteger8",
                   reinterpret_cast<void *>(_mlir_ciface_bindBufferInteger8));
    registerSymbol("_mlir_ciface_bindBufferInteger16",
                   reinterpret_cast<void *>(_mlir_ciface_bindBufferInteger16));
    registerSymbol("_mlir_ciface_bindBufferInteger32",
                   reinterpret_cast<void *>(_mlir_ciface_bindBufferInteger32));
    registerSymbol("_mlir_ciface_bindBufferInteger64",
                   reinterpret_cast<void *>(_mlir_ciface_bindBufferInteger64));
    registerSymbol("_mlir_ciface_fillResourceFloat32",
                   reinterpret_cast<void *>(_mlir_ciface_fillResourceFloat32));
  }
};
static Registration reg;
} // namespace
} // namespace pmlc::rt::vulkan
