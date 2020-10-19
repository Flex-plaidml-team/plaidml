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

#include <cstdarg>
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

extern "C" {

void *initVulkan(void *device) {
  return new VulkanInvocation(static_cast<VulkanDevice *>(device));
}

void deinitVulkan(void *vkInvocation) {
  delete static_cast<VulkanInvocation *>(vkInvocation);
}

void createVulkanLaunchKernelAction(void *vkInvocation, uint8_t *shader,
                                    uint32_t size, const char *entryPoint,
                                    uint32_t x, uint32_t y, uint32_t z,
                                    uint32_t count, ...) {
  std::vector<void *> deviceBuffer;
  va_list args;
  va_start(args, count);
  for (unsigned i = 0; i < count; ++i)
    deviceBuffer.push_back(va_arg(args, void *));
  va_end(args);
  static_cast<VulkanInvocation *>(vkInvocation)
      ->createLaunchKernelAction(shader, size, entryPoint, {x, y, z},
                                 deviceBuffer);
}

// add this API to compute dialect.
void createVulkanMemoryTransferAction(void *vkInvocation, uint64_t src_index,
                                      uint64_t src_binding, uint64_t dst_index,
                                      uint64_t dst_binding) {}

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

void *VkAlloc(void *vkInvocation, uint32_t bytes, void *hostPtr) {
  vulkanBuffer *newBuffer = new vulkanBuffer();
  VulkanHostMemoryBuffer memBuffer{hostPtr, bytes};
  newBuffer->HostBuffer = memBuffer;
  newBuffer->spirvClass = mlir::spirv::StorageClass::StorageBuffer;
  // maybe set it in Alloc Pattern of comp_to_vulkanCall pass.
  DescriptorSetIndex setIndex = 0;
  return static_cast<VulkanInvocation *>(vkInvocation)
      ->createMemoryBuffer(setIndex, newBuffer);
}

void VkDealloc(void *invocation, void *memory) {
  static_cast<VulkanInvocation *>(invocation)->deallocDeviceBuffer(memory);
}

void *VkRead(void *dst, void *src, void *invocation, uint32_t count, ...) {
  static_cast<VulkanInvocation *>(invocation)->copyDeviceBufferToHost(dst, src);
  return nullptr;
}

void *VkWrite(void *src, void *dst, void *invocation, uint32_t count, ...) {
  static_cast<VulkanInvocation *>(invocation)->copyHostBufferToDevice(src, dst);
  return nullptr;
}

void *VkScheduleFunc() { return nullptr; }

// TODO open vulkan backend API;
void *VkBarrier(void *invocation, uint32_t count, ...) { return nullptr; }

void VkWait(uint32_t count, ...) {}

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
    registerSymbol("VkBarrier", reinterpret_cast<void *>(VkBarrier));
    registerSymbol("VkWait", reinterpret_cast<void *>(VkWait));
    registerSymbol("VkAlloc", reinterpret_cast<void *>(VkAlloc));
    registerSymbol("VkDealloc", reinterpret_cast<void *>(VkDealloc));
    registerSymbol("VkRead", reinterpret_cast<void *>(VkRead));
    registerSymbol("VkWrite", reinterpret_cast<void *>(VkWrite));
    registerSymbol("VkScheduleFunc", reinterpret_cast<void *>(VkScheduleFunc));
  }
};
static Registration reg;
} // namespace
} // namespace pmlc::rt::vulkan
