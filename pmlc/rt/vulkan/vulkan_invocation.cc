// Vulkan invocation implementation, originally from the LLVM project, and
// subsequently modified by Intel Corporation.
//
// Original copyright:
//
//===- VulkanRuntime.cpp - MLIR Vulkan runtime ------------------*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "pmlc/rt/vulkan/vulkan_invocation.h"

#include <chrono>

#include "llvm/Support/FormatVariadic.h"

#include "pmlc/rt/vulkan/vulkan_error.h"
#include "pmlc/util/logging.h"

#include <ctime>
#define SET_TIMER(timespec)	clock_gettime(CLOCK_MONOTONIC, &timespec)
#define TIME_ELAPSED(before, after, level, str) \
	{					\
		float interval;			\
		interval = ((((after).tv_sec - (before).tv_sec) * 1000.0) + (((after).tv_nsec - (before).tv_nsec) / 1000000.0)); \
		IVLOG(level, "Time elapsed in " << str << ": " << interval << " ms");	\
	}
#define TIME_ELAPSED_TILL_NOW(before, after, str)	\
	{						\
		SET_TIMER(after);			\
		TIME_ELAPSED(before, after, 1, str)	\
	}
#define TIME_ELAPSED_TILL_NOW_LOG_2(before, after, str) \
	{						\
		SET_TIMER(after);			\
		TIME_ELAPSED(before, after, 2, str)	\
	}

namespace pmlc::rt::vulkan {

VulkanInvocation::VulkanInvocation() : device{Device::current<VulkanDevice>()} {
  VkCommandPoolCreateInfo commandPoolCreateInfo = {};
  commandPoolCreateInfo.sType = VK_STRUCTURE_TYPE_COMMAND_POOL_CREATE_INFO;
  commandPoolCreateInfo.pNext = nullptr;
  commandPoolCreateInfo.flags = 0;
  commandPoolCreateInfo.queueFamilyIndex = device->getQueueFamilyIndex();
  throwOnVulkanError(vkCreateCommandPool(device->getDevice(),
                                         &commandPoolCreateInfo, 0,
                                         &commandPool),
                     "vkCreateCommandPool");

  VkQueryPoolCreateInfo queryPoolCreateInfo = {};
  queryPoolCreateInfo.sType = VK_STRUCTURE_TYPE_QUERY_POOL_CREATE_INFO;
  queryPoolCreateInfo.pNext = nullptr;
  queryPoolCreateInfo.flags = 0;
  queryPoolCreateInfo.queryType = VK_QUERY_TYPE_TIMESTAMP;
  queryPoolCreateInfo.queryCount = timestampQueryPoolSize;
  queryPoolCreateInfo.pipelineStatistics = 0;
  throwOnVulkanError(
      vkCreateQueryPool(device->getDevice(), &queryPoolCreateInfo,
                        /*allocator=*/nullptr, &timestampQueryPool),
      "vkCreateQueryPool");
}

VulkanInvocation::~VulkanInvocation() {
  struct timespec before, after, total;

  // According to Vulkan spec:
  // "To ensure that no work is active on the device, vkDeviceWaitIdle can be
  // used to gate the destruction of the device. Prior to destroying a device,
  // an application is responsible for destroying/freeing any Vulkan objects
  // that were created using that device as the first parameter of the
  // corresponding vkCreate* or vkAllocate* command."
  SET_TIMER(before);
  vkDeviceWaitIdle(device->getDevice());
  TIME_ELAPSED_TILL_NOW(before, after, "~VulkanInvocation vkDeviceWaitIdle");

  // Free and destroy.
  SET_TIMER(before);
  vkFreeCommandBuffers(device->getDevice(), commandPool, commandBuffers.size(),
                       commandBuffers.data());
  vkDestroyCommandPool(device->getDevice(), commandPool, nullptr);
  vkDestroyQueryPool(device->getDevice(), timestampQueryPool,
                     /*allocator=*/nullptr);
  TIME_ELAPSED_TILL_NOW(before, after, "~VulkanInvocation freeing buffer and pool");

  SET_TIMER(total);
  for (const auto &action : schedule) {
    if (auto kernel = std::dynamic_pointer_cast<LaunchKernelAction>(action)) {
      SET_TIMER(before);
      vkFreeDescriptorSets(device->getDevice(), kernel->descriptorPool,
                           kernel->descriptorSets.size(),
                           kernel->descriptorSets.data());
      vkDestroyDescriptorPool(device->getDevice(), kernel->descriptorPool,
                              nullptr);
      vkDestroyPipeline(device->getDevice(), kernel->pipeline, nullptr);
      vkDestroyPipelineLayout(device->getDevice(), kernel->pipelineLayout,
                              nullptr);
      for (auto &descriptorSetLayout : kernel->descriptorSetLayouts) {
        vkDestroyDescriptorSetLayout(device->getDevice(), descriptorSetLayout,
                                     nullptr);
      }
      vkDestroyShaderModule(device->getDevice(), kernel->shaderModule, nullptr);

      // For each descriptor set.
      for (auto &deviceMemoryBufferMapPair : kernel->deviceMemoryBufferMap) {
        auto &deviceMemoryBuffers = deviceMemoryBufferMapPair.second;
        // For each descriptor binding.
        for (auto &memoryBuffer : deviceMemoryBuffers) {
          vkFreeMemory(device->getDevice(), memoryBuffer.deviceMemory, nullptr);
          vkDestroyBuffer(device->getDevice(), memoryBuffer.buffer, nullptr);
        }
      }
      TIME_ELAPSED_TILL_NOW_LOG_2(before, after, "~VulkanInvocation every LaunchKernelAction");
    }
  }
  TIME_ELAPSED_TILL_NOW(total, after, "~VulkanInvocation traversing all LaunchKernelAction");

  for (auto func : timeData){
    IVLOG(1, "Time elapsed in " <<func.first << ": " << func.second << " ms");
  }
}

void VulkanInvocation::createLaunchKernelAction(uint8_t *shader, uint32_t size,
                                                const char *entryPoint,
                                                NumWorkGroups numWorkGroups) {
  timer.punchPoint();
  curr = std::make_shared<LaunchKernelAction>();

  curr->binary = shader;
  curr->binarySize = size;
  curr->entryPoint = entryPoint;
  curr->workGroups = numWorkGroups;
  timeData["createLaunchKernelAction"] += timer.getDuration();
}

void VulkanInvocation::setLaunchKernelAction() {
  timer.punchPoint();
  // Create logical device, shader module and memory buffers.
  checkResourceData();
  createMemoryBuffers();
  createShaderModule();

  // Descriptor bindings divided into sets. Each descriptor binding
  // must have a layout binding attached into a descriptor set layout.
  // Each layout set must be binded into a pipeline layout.
  initDescriptorSetLayoutBindingMap();

  createDescriptorSetLayout();
  createPipelineLayout();

  // Each descriptor set must be allocated from a descriptor pool.
  createComputePipeline();
  createDescriptorPool();
  allocateDescriptorSets();
  setWriteDescriptors();
  timeData["tSetVulkanLaunchKernelAction"] += timer.getDuration();
}

void VulkanInvocation::addLaunchActionToSchedule() {
  timer.punchPoint();
  schedule.push_back(curr);
  curr = nullptr;
  timeData["addLaunchActionToSchedule"] += timer.getDuration();
}

void VulkanInvocation::createMemoryTransferAction(VkBuffer src, VkBuffer dst,
                                                  size_t size) {
  auto transferAction = std::make_shared<MemoryTransferAction>();
  transferAction->src = src;
  transferAction->dst = dst;
  const VkBufferCopy copy = {0, 0, size};
  transferAction->regions.push_back(copy);

  schedule.push_back(transferAction);
}

void VulkanInvocation::createMemoryTransferAction(uint64_t src_index,
                                                  uint64_t src_binding,
                                                  uint64_t dst_index,
                                                  uint64_t dst_binding) {
  std::shared_ptr<LaunchKernelAction> kernel_src;
  std::shared_ptr<LaunchKernelAction> kernel_dst;
  uint64_t kernel_index = 0;
  for (auto action : schedule) {
    if (auto kernel = std::dynamic_pointer_cast<LaunchKernelAction>(action)) {
      if (src_index == kernel_index) {
        kernel_src = kernel;
      }
      if (dst_index == kernel_index) {
        kernel_dst = kernel;
      }
      kernel_index++;
    }
  }

  if (kernel_index == dst_index) {
    kernel_dst = curr;
  }
  if (kernel_index == src_index) {
    kernel_src = curr;
  }

  if ((!kernel_src) || (!kernel_dst)) {
    throw std::runtime_error{
        "createMemoryTransferAction: invalid kernel index"};
  }

  auto descriptorSetIndex = 0;
  auto memoryBuffersSrc = kernel_src->deviceMemoryBufferMap[descriptorSetIndex];
  auto memoryBuffersDst = kernel_dst->deviceMemoryBufferMap[descriptorSetIndex];

  VkBuffer bufferSrc{VK_NULL_HANDLE};
  VkBuffer bufferDst{VK_NULL_HANDLE};
  size_t bufferSizeSrc = 0;
  size_t bufferSizeDst = 0;

  for (auto memoryBuffer : memoryBuffersSrc) {
    if (memoryBuffer.bindingIndex == src_binding) {
      bufferSrc = memoryBuffer.buffer;
      bufferSizeSrc = memoryBuffer.bufferSize;
    }
  }

  for (auto memoryBuffer : memoryBuffersDst) {
    if (memoryBuffer.bindingIndex == dst_binding) {
      bufferDst = memoryBuffer.buffer;
      bufferSizeDst = memoryBuffer.bufferSize;
    }
  }

  if (bufferSizeSrc != bufferSizeDst) {
    throw std::runtime_error{
        "createMemoryTransferAction: different buffer sizes!"};
  }

  createMemoryTransferAction(bufferSrc, bufferDst, bufferSizeDst);

  VkBufferMemoryBarrier bufferMemoryBarrier = {};
  bufferMemoryBarrier.sType = VK_STRUCTURE_TYPE_BUFFER_MEMORY_BARRIER;
  bufferMemoryBarrier.pNext = nullptr;
  bufferMemoryBarrier.srcAccessMask = VK_ACCESS_TRANSFER_WRITE_BIT;
  bufferMemoryBarrier.dstAccessMask = VK_ACCESS_TRANSFER_READ_BIT;
  bufferMemoryBarrier.srcQueueFamilyIndex = VK_QUEUE_FAMILY_IGNORED;
  bufferMemoryBarrier.dstQueueFamilyIndex = VK_QUEUE_FAMILY_IGNORED;
  bufferMemoryBarrier.buffer = bufferDst;
  bufferMemoryBarrier.offset = 0;
  bufferMemoryBarrier.size = VK_WHOLE_SIZE;

  kernel_dst->deps.push_back(bufferMemoryBarrier);
}

#include <ctime>
#define SET_TIMER(timespec)	clock_gettime(CLOCK_MONOTONIC, &timespec)
#define TIME_ELAPSED(before, after, str) \
	{				 \
		float interval;		 \
		interval = ((((after).tv_sec - (before).tv_sec) * 1000.0) + (((after).tv_nsec - (before).tv_nsec) / 1000000.0)); \
		IVLOG(1, "Time elapsed in " << str << ": " << interval << " ms");	\
	}

void VulkanInvocation::submitCommandBuffers() {
  using fp_milliseconds =
      std::chrono::duration<double, std::chrono::milliseconds::period>;
  using fp_nanoseconds =
      std::chrono::duration<double, std::chrono::nanoseconds::period>;

  createSchedule();

  struct timespec before, after;
  float interval;
  clock_gettime(CLOCK_MONOTONIC, &before);
  submitCommandBuffersToQueue();
  clock_gettime(CLOCK_MONOTONIC, &after);
  interval = ((after.tv_sec - before.tv_sec) * 1000.0) + ((after.tv_nsec - before.tv_nsec) / 1000000.0);
  IVLOG(1, "submitCommandBuffersToQueue time is " <<  interval << " ms");

  clock_gettime(CLOCK_MONOTONIC, &before);
  throwOnVulkanError(vkQueueWaitIdle(device->getQueue()), "vkQueueWaitIdle");
  clock_gettime(CLOCK_MONOTONIC, &after);
  interval = ((after.tv_sec - before.tv_sec) * 1000.0) + ((after.tv_nsec - before.tv_nsec) / 1000000.0);
  IVLOG(1, "vkQueueWaitIdle time is " <<  interval << " ms");

  if (device->getTimestampValidBits()) {
    uint64_t *results = reinterpret_cast<uint64_t *>(
        calloc(timestampQueryCount, sizeof(uint64_t)));
    vkGetQueryPoolResults(device->getDevice(), timestampQueryPool,
                          /*firstQuery=*/0,
                          /*queryCount=*/timestampQueryCount,
                          /*dataSize=*/timestampQueryCount * sizeof(uint64_t),
                          results,
                          /*stride=*/sizeof(uint64_t),
                          (VK_QUERY_RESULT_64_BIT | VK_QUERY_RESULT_WAIT_BIT));

    fp_nanoseconds overall_ns{(results[1] - results[0]) *
                              device->getTimestampPeriod()};
    IVLOG(1, "Overall Vulkan time: " << fp_milliseconds(overall_ns).count()
                                     << "ms");

    fp_nanoseconds total_kernel_ns{0};
    for (uint32_t i = 2; i < timestampQueryCount; i += 2) {
      fp_nanoseconds kernel_ns{(results[i + 1] - results[i]) *
                               device->getTimestampPeriod()};

      IVLOG(2, "  Vulkan kernel exec time: "
                   << fp_milliseconds(kernel_ns).count() << "ms");

      total_kernel_ns += kernel_ns;
    }

    if (timestampQueryCount == timestampQueryPoolSize) {
      IVLOG(
          1,
          "WARNING: Ran out of space in the timestamp query pool which has "
          "size = "
              << timestampQueryPoolSize
              << "; consider increasing the size of the timestamp query pool.");
    }

    IVLOG(1, "Total Vulkan kernels: " << (timestampQueryCount - 2) / 2);
    IVLOG(1, "Total Vulkan kernel exec time: "
                 << fp_milliseconds(total_kernel_ns).count() << "ms");
    IVLOG(1, "Percentage Vulkan kernel exec time: "
                 << total_kernel_ns.count() * 100 / overall_ns.count() << "%");

    fp_nanoseconds total_memxfer_ns = overall_ns - total_kernel_ns;
    IVLOG(1, "Total Vulkan memory transfers: " << memoryTransferCount);
    IVLOG(1, "Total (esimtated) Vulkan memory transfer time: "
                 << fp_milliseconds(total_memxfer_ns).count() << "ms");
    IVLOG(1, "Percentage (estimated) Vulkan memory transfer time: "
                 << total_memxfer_ns.count() * 100 / overall_ns.count() << "%");
  }

  clock_gettime(CLOCK_MONOTONIC, &before);
  updateHostMemoryBuffers();
  clock_gettime(CLOCK_MONOTONIC, &after);
  interval = ((after.tv_sec - before.tv_sec) * 1000.0) + ((after.tv_nsec - before.tv_nsec) / 1000000.0);
  IVLOG(1, "updateHostMemoryBuffers time is " <<  interval << " ms");

}

void VulkanInvocation::setResourceData(const ResourceData &resData) {
  if (!curr) {
    throw std::runtime_error{"setResourceData: curr is nullptr!"};
  }
  curr->resourceData = resData;
}

void VulkanInvocation::setResourceData(
    const DescriptorSetIndex desIndex, const BindingIndex bindIndex,
    const VulkanHostMemoryBuffer &hostMemBuffer) {
  if (!curr) {
    throw std::runtime_error{"setResourceData: curr is nullptr!"};
  }
  curr->resourceData[desIndex][bindIndex] = hostMemBuffer;
  curr->resourceStorageClassData[desIndex][bindIndex] =
      mlir::spirv::StorageClass::StorageBuffer;
}

void VulkanInvocation::setResourceStorageClassBindingMap(
    const ResourceStorageClassBindingMap &stClassData) {
  if (!curr) {
    throw std::runtime_error{
        "setResourceStorageClassBindingMap: curr is nullptr!"};
  }
  curr->resourceStorageClassData = stClassData;
}

void VulkanInvocation::mapStorageClassToDescriptorType(
    mlir::spirv::StorageClass storageClass, VkDescriptorType &descriptorType) {
  switch (storageClass) {
  case mlir::spirv::StorageClass::StorageBuffer:
    descriptorType = VK_DESCRIPTOR_TYPE_STORAGE_BUFFER;
    break;
  case mlir::spirv::StorageClass::Uniform:
    descriptorType = VK_DESCRIPTOR_TYPE_UNIFORM_BUFFER;
    break;
  default:
    throw std::runtime_error{"unsupported storage class"};
  }
}

void VulkanInvocation::mapStorageClassToBufferUsageFlag(
    mlir::spirv::StorageClass storageClass,
    VkBufferUsageFlagBits &bufferUsage) {
  switch (storageClass) {
  case mlir::spirv::StorageClass::StorageBuffer:
    bufferUsage = VK_BUFFER_USAGE_STORAGE_BUFFER_BIT;
    break;
  case mlir::spirv::StorageClass::Uniform:
    bufferUsage = VK_BUFFER_USAGE_UNIFORM_BUFFER_BIT;
    break;
  default:
    throw std::runtime_error{"unsupported storage class"};
  }
}

void VulkanInvocation::checkResourceData() {
  if (!curr) {
    throw std::runtime_error{"checkResourceData: curr is nullptr!"};
  }
  if (!curr->resourceData.size()) {
    throw std::runtime_error{"Vulkan device needs at least one resource"};
  }
  if (!curr->binarySize || !curr->binary) {
    throw std::runtime_error{"binary shader size must be greater than zero"};
  }
}

void VulkanInvocation::createMemoryBuffers() {
  timer.punchPoint();
  if (!curr) {
    throw std::runtime_error{"createMemoryBuffers: curr is nullptr!"};
  }

  // For each descriptor set.
  for (const auto &resourceDataMapPair : curr->resourceData) {
    llvm::SmallVector<VulkanDeviceMemoryBuffer, 1> deviceMemoryBuffers;
    const auto descriptorSetIndex = resourceDataMapPair.first;
    const auto &resourceDataMap = resourceDataMapPair.second;

    // For each descriptor binding.
    for (const auto &resourceDataBindingPair : resourceDataMap) {
      // Create device memory buffer.
      VulkanDeviceMemoryBuffer memoryBuffer;
      memoryBuffer.bindingIndex = resourceDataBindingPair.first;
      VkDescriptorType descriptorType = {};
      VkBufferUsageFlagBits bufferUsageSrc = VK_BUFFER_USAGE_TRANSFER_SRC_BIT;
      VkBufferUsageFlagBits bufferUsageDst = VK_BUFFER_USAGE_TRANSFER_DST_BIT;

      // Check that descriptor set has storage class map.
      const auto resourceStorageClassMapIt =
          curr->resourceStorageClassData.find(descriptorSetIndex);
      if (resourceStorageClassMapIt == curr->resourceStorageClassData.end()) {
        throw std::runtime_error{llvm::formatv(
            "cannot find storge class for resource in descriptor set: {0}",
            descriptorSetIndex)};
      }

      // Check that specific descriptor binding has storage class.
      const auto &resourceStorageClassMap = resourceStorageClassMapIt->second;
      const auto resourceStorageClassIt =
          resourceStorageClassMap.find(resourceDataBindingPair.first);
      if (resourceStorageClassIt == resourceStorageClassMap.end()) {
        throw std::runtime_error{
            llvm::formatv("cannot find storage class for resource with "
                          "descriptor index: {0}",
                          resourceDataBindingPair.first)};
      }

      const auto resourceStorageClassBinding = resourceStorageClassIt->second;
      mapStorageClassToDescriptorType(resourceStorageClassBinding,
                                      descriptorType);
      mapStorageClassToBufferUsageFlag(resourceStorageClassBinding,
                                       bufferUsageSrc);
      mapStorageClassToBufferUsageFlag(resourceStorageClassBinding,
                                       bufferUsageDst);

      // Set descriptor type for the specific device memory buffer.
      memoryBuffer.descriptorType = descriptorType;
      const auto bufferSize = resourceDataBindingPair.second.size;

      // Specify memory allocation info.
      VkMemoryAllocateInfo memoryAllocateInfo = {};
      memoryAllocateInfo.sType = VK_STRUCTURE_TYPE_MEMORY_ALLOCATE_INFO;
      memoryAllocateInfo.pNext = nullptr;
      memoryAllocateInfo.allocationSize = bufferSize;
      memoryAllocateInfo.memoryTypeIndex = device->getMemoryTypeIndex();

      // Allocate device memory.
      throwOnVulkanError(vkAllocateMemory(device->getDevice(),
                                          &memoryAllocateInfo, 0,
                                          &memoryBuffer.deviceMemory),
                         "vkAllocateMemory");
      void *payload;
      throwOnVulkanError(vkMapMemory(device->getDevice(),
                                     memoryBuffer.deviceMemory, 0, bufferSize,
                                     0, reinterpret_cast<void **>(&payload)),
                         "vkMapMemory");

      timer.punchPoint();
      // Copy host memory into the mapped area.
      std::memcpy(payload, resourceDataBindingPair.second.ptr, bufferSize);
      timeData["host memory into mapped area, memcpy"] += timer.getDuration();
      vkUnmapMemory(device->getDevice(), memoryBuffer.deviceMemory);
      timeData["host memory into mapped area, vkUnmapMemory"] += timer.getConstantDuration();

      VkBufferCreateInfo bufferCreateInfo = {};
      bufferCreateInfo.sType = VK_STRUCTURE_TYPE_BUFFER_CREATE_INFO;
      bufferCreateInfo.pNext = nullptr;
      bufferCreateInfo.flags = 0;
      bufferCreateInfo.size = bufferSize;
      bufferCreateInfo.usage = bufferUsageSrc | bufferUsageDst;
      bufferCreateInfo.sharingMode = VK_SHARING_MODE_EXCLUSIVE;
      bufferCreateInfo.queueFamilyIndexCount = 1;
      auto queueFamilyIndex = device->getQueueFamilyIndex();
      bufferCreateInfo.pQueueFamilyIndices = &queueFamilyIndex;
      throwOnVulkanError(vkCreateBuffer(device->getDevice(), &bufferCreateInfo,
                                        0, &memoryBuffer.buffer),
                         "vkCreateBuffer");

      // Bind buffer and device memory.
      throwOnVulkanError(vkBindBufferMemory(device->getDevice(),
                                            memoryBuffer.buffer,
                                            memoryBuffer.deviceMemory, 0),
                         "vkBindBufferMemory");

      memoryBuffer.bufferSize = bufferSize;

      // Update buffer info.
      memoryBuffer.bufferInfo.buffer = memoryBuffer.buffer;
      memoryBuffer.bufferInfo.offset = 0;
      memoryBuffer.bufferInfo.range = VK_WHOLE_SIZE;
      deviceMemoryBuffers.push_back(memoryBuffer);
    }

    // Associate device memory buffers with a descriptor set.
    curr->deviceMemoryBufferMap[descriptorSetIndex] = deviceMemoryBuffers;
  }
  timeData["createMemoryBuffers"] += timer.getDuration();
}

void VulkanInvocation::createShaderModule() {
  timer.punchPoint();
  if (!curr) {
    throw std::runtime_error{"createShaderModule : curr is nullptr!"};
  }

  VkShaderModuleCreateInfo shaderModuleCreateInfo = {};
  shaderModuleCreateInfo.sType = VK_STRUCTURE_TYPE_SHADER_MODULE_CREATE_INFO;
  shaderModuleCreateInfo.pNext = nullptr;
  shaderModuleCreateInfo.flags = 0;
  // Set size in bytes.
  shaderModuleCreateInfo.codeSize = curr->binarySize;
  // Set pointer to the binary shader.
  shaderModuleCreateInfo.pCode = reinterpret_cast<uint32_t *>(curr->binary);
  throwOnVulkanError(vkCreateShaderModule(device->getDevice(),
                                          &shaderModuleCreateInfo, 0,
                                          &curr->shaderModule),
                     "vkCreateShaderModule");
  timeData["createShaderModule"] += timer.getDuration();
}

void VulkanInvocation::initDescriptorSetLayoutBindingMap() {
  timer.punchPoint();
  if (!curr) {
    throw std::runtime_error{
        "initDescriptorSetLayoutBindingMap: curr is nullptr!"};
  }

  for (const auto &deviceMemoryBufferMapPair : curr->deviceMemoryBufferMap) {
    llvm::SmallVector<VkDescriptorSetLayoutBinding, 1>
        descriptorSetLayoutBindings;
    const auto &deviceMemoryBuffers = deviceMemoryBufferMapPair.second;
    const auto descriptorSetIndex = deviceMemoryBufferMapPair.first;

    // Create a layout binding for each descriptor.
    for (const auto &memBuffer : deviceMemoryBuffers) {
      VkDescriptorSetLayoutBinding descriptorSetLayoutBinding = {};
      descriptorSetLayoutBinding.binding = memBuffer.bindingIndex;
      descriptorSetLayoutBinding.descriptorType = memBuffer.descriptorType;
      descriptorSetLayoutBinding.descriptorCount = 1;
      descriptorSetLayoutBinding.stageFlags = VK_SHADER_STAGE_COMPUTE_BIT;
      descriptorSetLayoutBinding.pImmutableSamplers = 0;
      descriptorSetLayoutBindings.push_back(descriptorSetLayoutBinding);
    }
    curr->descriptorSetLayoutBindingMap[descriptorSetIndex] =
        descriptorSetLayoutBindings;
  }
  timeData["initDescriptorSetLayoutBindingMap"] += timer.getDuration();
}

void VulkanInvocation::createDescriptorSetLayout() {
  timer.punchPoint();
  if (!curr) {
    throw std::runtime_error{"createDescriptorSetLayout: curr is nullptr!"};
  }

  for (const auto &deviceMemoryBufferMapPair : curr->deviceMemoryBufferMap) {
    const auto descriptorSetIndex = deviceMemoryBufferMapPair.first;
    const auto &deviceMemoryBuffers = deviceMemoryBufferMapPair.second;
    // Each descriptor in a descriptor set must be the same type.
    VkDescriptorType descriptorType =
        deviceMemoryBuffers.front().descriptorType;
    const uint32_t descriptorSize = deviceMemoryBuffers.size();
    const auto descriptorSetLayoutBindingIt =
        curr->descriptorSetLayoutBindingMap.find(descriptorSetIndex);

    if (descriptorSetLayoutBindingIt ==
        curr->descriptorSetLayoutBindingMap.end()) {
      throw std::runtime_error{llvm::formatv(
          "cannot find layout bindings for the set with number: {0}",
          descriptorSetIndex)};
    }

    const auto &descriptorSetLayoutBindings =
        descriptorSetLayoutBindingIt->second;
    // Create descriptor set layout.
    VkDescriptorSetLayout descriptorSetLayout = {};
    VkDescriptorSetLayoutCreateInfo descriptorSetLayoutCreateInfo = {};

    descriptorSetLayoutCreateInfo.sType =
        VK_STRUCTURE_TYPE_DESCRIPTOR_SET_LAYOUT_CREATE_INFO;
    descriptorSetLayoutCreateInfo.pNext = nullptr;
    descriptorSetLayoutCreateInfo.flags = 0;
    // Amount of descriptor bindings in a layout set.
    descriptorSetLayoutCreateInfo.bindingCount =
        descriptorSetLayoutBindings.size();
    descriptorSetLayoutCreateInfo.pBindings =
        descriptorSetLayoutBindings.data();
    throwOnVulkanError(vkCreateDescriptorSetLayout(
                           device->getDevice(), &descriptorSetLayoutCreateInfo,
                           0, &descriptorSetLayout),
                       "vkCreateDescriptorSetLayout");

    curr->descriptorSetLayouts.push_back(descriptorSetLayout);
    curr->descriptorSetInfoPool.push_back(
        {descriptorSetIndex, descriptorSize, descriptorType});
  }
  timeData["createDescriptorSetLayout"] += timer.getDuration();
}

void VulkanInvocation::createPipelineLayout() {
  timer.punchPoint();
  if (!curr) {
    throw std::runtime_error{"createPipelineLayout: curr is nullptr!"};
  }

  // Associate descriptor sets with a pipeline layout.
  VkPipelineLayoutCreateInfo pipelineLayoutCreateInfo = {};
  pipelineLayoutCreateInfo.sType =
      VK_STRUCTURE_TYPE_PIPELINE_LAYOUT_CREATE_INFO;
  pipelineLayoutCreateInfo.pNext = nullptr;
  pipelineLayoutCreateInfo.flags = 0;
  pipelineLayoutCreateInfo.setLayoutCount = curr->descriptorSetLayouts.size();
  pipelineLayoutCreateInfo.pSetLayouts = curr->descriptorSetLayouts.data();
  pipelineLayoutCreateInfo.pushConstantRangeCount = 0;
  pipelineLayoutCreateInfo.pPushConstantRanges = 0;
  throwOnVulkanError(vkCreatePipelineLayout(device->getDevice(),
                                            &pipelineLayoutCreateInfo, 0,
                                            &curr->pipelineLayout),
                     "vkCreatePipelineLayout");
  timeData["createPipelineLayout"] = timer.getDuration();
}

void VulkanInvocation::createComputePipeline() {
  timer.punchPoint();
  if (!curr) {
    throw std::runtime_error{"createComputePipeline: curr is nullptr!"};
  }

  VkPipelineShaderStageCreateInfo stageInfo = {};
  stageInfo.sType = VK_STRUCTURE_TYPE_PIPELINE_SHADER_STAGE_CREATE_INFO;
  stageInfo.pNext = nullptr;
  stageInfo.flags = 0;
  stageInfo.stage = VK_SHADER_STAGE_COMPUTE_BIT;
  stageInfo.module = curr->shaderModule;
  // Set entry point.
  stageInfo.pName = curr->entryPoint;
  stageInfo.pSpecializationInfo = 0;

  VkComputePipelineCreateInfo computePipelineCreateInfo = {};
  computePipelineCreateInfo.sType =
      VK_STRUCTURE_TYPE_COMPUTE_PIPELINE_CREATE_INFO;
  computePipelineCreateInfo.pNext = nullptr;
  computePipelineCreateInfo.flags = 0;
  computePipelineCreateInfo.stage = stageInfo;
  computePipelineCreateInfo.layout = curr->pipelineLayout;
  computePipelineCreateInfo.basePipelineHandle = 0;
  computePipelineCreateInfo.basePipelineIndex = 0;
  throwOnVulkanError(vkCreateComputePipelines(device->getDevice(), 0, 1,
                                              &computePipelineCreateInfo, 0,
                                              &curr->pipeline),
                     "vkCreateComputePipelines");
  timeData["createComputePipeline"] += timer.getDuration();
}

void VulkanInvocation::createDescriptorPool() {
  timer.punchPoint();
  if (!curr) {
    throw std::runtime_error{"createDescriptorPool: curr is nullptr!"};
  }

  llvm::SmallVector<VkDescriptorPoolSize, 1> descriptorPoolSizes;
  for (const auto &descriptorSetInfo : curr->descriptorSetInfoPool) {
    // For each descriptor set populate descriptor pool size.
    VkDescriptorPoolSize descriptorPoolSize = {};
    descriptorPoolSize.type = descriptorSetInfo.descriptorType;
    descriptorPoolSize.descriptorCount = descriptorSetInfo.descriptorSize;
    descriptorPoolSizes.push_back(descriptorPoolSize);
  }

  VkDescriptorPoolCreateInfo descriptorPoolCreateInfo = {};
  descriptorPoolCreateInfo.sType =
      VK_STRUCTURE_TYPE_DESCRIPTOR_POOL_CREATE_INFO;
  descriptorPoolCreateInfo.pNext = nullptr;
  descriptorPoolCreateInfo.flags = 0;
  descriptorPoolCreateInfo.maxSets = descriptorPoolSizes.size();
  descriptorPoolCreateInfo.poolSizeCount = descriptorPoolSizes.size();
  descriptorPoolCreateInfo.pPoolSizes = descriptorPoolSizes.data();
  throwOnVulkanError(vkCreateDescriptorPool(device->getDevice(),
                                            &descriptorPoolCreateInfo, 0,
                                            &curr->descriptorPool),
                     "vkCreateDescriptorPool");
  timeData["createDescriptorPool"] += timer.getDuration();
}

void VulkanInvocation::allocateDescriptorSets() {
  timer.punchPoint();
  if (!curr) {
    throw std::runtime_error{"allocateDescriptorSets: curr is nullptr!"};
  }

  VkDescriptorSetAllocateInfo descriptorSetAllocateInfo = {};
  // Size of desciptor sets and descriptor layout sets is the same.
  curr->descriptorSets.resize(curr->descriptorSetLayouts.size());
  descriptorSetAllocateInfo.sType =
      VK_STRUCTURE_TYPE_DESCRIPTOR_SET_ALLOCATE_INFO;
  descriptorSetAllocateInfo.pNext = nullptr;
  descriptorSetAllocateInfo.descriptorPool = curr->descriptorPool;
  descriptorSetAllocateInfo.descriptorSetCount =
      curr->descriptorSetLayouts.size();
  descriptorSetAllocateInfo.pSetLayouts = curr->descriptorSetLayouts.data();
  throwOnVulkanError(vkAllocateDescriptorSets(device->getDevice(),
                                              &descriptorSetAllocateInfo,
                                              curr->descriptorSets.data()),
                     "vkAllocateDescriptorSets");
  timeData["allocateDescriptorSets"] += timer.getDuration();
}

void VulkanInvocation::setWriteDescriptors() {
  timer.punchPoint();
  if (!curr) {
    throw std::runtime_error{"setWriteDescriptors: curr is nullptr!"};
  }

  if (curr->descriptorSets.size() != curr->descriptorSetInfoPool.size()) {
    throw std::runtime_error{
        "Each descriptor set must have descriptor set information"};
  }
  // For each descriptor set.
  auto descriptorSetIt = curr->descriptorSets.begin();
  // Each descriptor set is associated with descriptor set info.
  for (const auto &descriptorSetInfo : curr->descriptorSetInfoPool) {
    // For each device memory buffer in the descriptor set.
    const auto &deviceMemoryBuffers =
        curr->deviceMemoryBufferMap[descriptorSetInfo.descriptorSet];
    for (const auto &memoryBuffer : deviceMemoryBuffers) {
      // Structure describing descriptor sets to write to.
      VkWriteDescriptorSet wSet = {};
      wSet.sType = VK_STRUCTURE_TYPE_WRITE_DESCRIPTOR_SET;
      wSet.pNext = nullptr;
      // Descriptor set.
      wSet.dstSet = *descriptorSetIt;
      wSet.dstBinding = memoryBuffer.bindingIndex;
      wSet.dstArrayElement = 0;
      wSet.descriptorCount = 1;
      wSet.descriptorType = memoryBuffer.descriptorType;
      wSet.pImageInfo = nullptr;
      wSet.pBufferInfo = &memoryBuffer.bufferInfo;
      wSet.pTexelBufferView = nullptr;
      vkUpdateDescriptorSets(device->getDevice(), 1, &wSet, 0, nullptr);
    }
    // Increment descriptor set iterator.
    ++descriptorSetIt;
  }
  timeData["setWriteDescriptors"] += timer.getDuration();
}

void VulkanInvocation::createSchedule() {
  VkCommandBufferAllocateInfo allocInfo = {};
  allocInfo.sType = VK_STRUCTURE_TYPE_COMMAND_BUFFER_ALLOCATE_INFO;
  allocInfo.pNext = nullptr;
  allocInfo.commandPool = commandPool;
  allocInfo.level = VK_COMMAND_BUFFER_LEVEL_PRIMARY;
  allocInfo.commandBufferCount = 1;

  VkCommandBuffer commandBuffer;
  throwOnVulkanError(
      vkAllocateCommandBuffers(device->getDevice(), &allocInfo, &commandBuffer),
      "vkAllocateCommandBuffers");

  VkCommandBufferBeginInfo beginInfo = {};
  beginInfo.sType = VK_STRUCTURE_TYPE_COMMAND_BUFFER_BEGIN_INFO;
  beginInfo.pNext = nullptr;
  beginInfo.flags = VK_COMMAND_BUFFER_USAGE_ONE_TIME_SUBMIT_BIT;
  beginInfo.pInheritanceInfo = nullptr;

  throwOnVulkanError(vkBeginCommandBuffer(commandBuffer, &beginInfo),
                     "vkBeginCommandBuffer");

  if (device->getTimestampValidBits()) {
    vkCmdWriteTimestamp(commandBuffer, VK_PIPELINE_STAGE_COMPUTE_SHADER_BIT,
                        timestampQueryPool, /*query=*/0);
  }

  for (const auto &action : schedule) {
    if (auto kernel = std::dynamic_pointer_cast<LaunchKernelAction>(action)) {
      if (device->getTimestampValidBits() &&
          timestampQueryCount < timestampQueryPoolSize) {
        vkCmdWriteTimestamp(commandBuffer, VK_PIPELINE_STAGE_COMPUTE_SHADER_BIT,
                            timestampQueryPool, timestampQueryCount++);
      }

      if (kernel->deps.size()) {
        vkCmdPipelineBarrier(
            commandBuffer,
            /*srcStageMask=*/VK_PIPELINE_STAGE_COMPUTE_SHADER_BIT,
            /*dstStageMask=*/VK_PIPELINE_STAGE_COMPUTE_SHADER_BIT,
            /*dependencyFlags=*/0, /*memoryBarrierCount=*/0,
            /*pMemoryBarriers=*/nullptr,
            /*bufferMemoryBarrierCount=*/kernel->deps.size(),
            /*pBufferMemoryBarriers=*/kernel->deps.data(),
            /*imageMemoryBarrierCount=*/0,
            /*pImageMemoryBarriers=*/nullptr);
      }

      vkCmdBindPipeline(commandBuffer,
                        /*pipelineBindPoint=*/VK_PIPELINE_BIND_POINT_COMPUTE,
                        kernel->pipeline);

      vkCmdBindDescriptorSets(
          commandBuffer,
          /*pipelineBindPoint=*/VK_PIPELINE_BIND_POINT_COMPUTE,
          /*layout=*/kernel->pipelineLayout,
          /*firstSet=*/0,
          /*descriptorSetCount=*/kernel->descriptorSets.size(),
          /*pDescriptorSets=*/kernel->descriptorSets.data(),
          /*dynamicOffsetCount=*/0,
          /*pDynamicOffsets=*/0);

      vkCmdDispatch(commandBuffer,
                    /*groupCountX=*/kernel->workGroups.x,
                    /*groupCountY=*/kernel->workGroups.y,
                    /*groupCountZ=*/kernel->workGroups.z);

      if (device->getTimestampValidBits() &&
          timestampQueryCount < timestampQueryPoolSize) {
        vkCmdWriteTimestamp(commandBuffer, VK_PIPELINE_STAGE_COMPUTE_SHADER_BIT,
                            timestampQueryPool, timestampQueryCount++);
      }
    }
    if (auto xfer = std::dynamic_pointer_cast<MemoryTransferAction>(action)) {
      memoryTransferCount++;
      vkCmdCopyBuffer(commandBuffer,
                      /*srcBuffer=*/xfer->src,
                      /*dstBuffer=*/xfer->dst,
                      /*regionCount=*/xfer->regions.size(),
                      /*pRegions=*/xfer->regions.data());
    }
  }

  if (device->getTimestampValidBits()) {
    vkCmdWriteTimestamp(commandBuffer, VK_PIPELINE_STAGE_COMPUTE_SHADER_BIT,
                        timestampQueryPool, /*query=*/1);
  }

  throwOnVulkanError(vkEndCommandBuffer(commandBuffer), "vkEndCommandBuffer");

  commandBuffers.push_back(commandBuffer);
}

void VulkanInvocation::submitCommandBuffersToQueue() {
  VkSubmitInfo submitInfo = {};
  submitInfo.sType = VK_STRUCTURE_TYPE_SUBMIT_INFO;
  submitInfo.pNext = nullptr;
  submitInfo.waitSemaphoreCount = 0;
  submitInfo.pWaitSemaphores = 0;
  submitInfo.pWaitDstStageMask = 0;
  submitInfo.commandBufferCount = commandBuffers.size();
  submitInfo.pCommandBuffers = commandBuffers.data();
  submitInfo.signalSemaphoreCount = 0;
  submitInfo.pSignalSemaphores = nullptr;
  throwOnVulkanError(vkQueueSubmit(device->getQueue(), 1, &submitInfo, 0),
                     "vkQueueSubmit");
}

void VulkanInvocation::updateHostMemoryBuffers() {
  const auto &action = schedule.back();
  auto kernel = std::dynamic_pointer_cast<LaunchKernelAction>(action);
  assert(kernel != NULL);
  // For each descriptor set.
  for (auto &resourceDataMapPair : kernel->resourceData) {
    auto &resourceDataMap = resourceDataMapPair.second;
    auto &deviceMemoryBuffers =
        kernel->deviceMemoryBufferMap[resourceDataMapPair.first];
    // For each device memory buffer in the set.
    for (auto &deviceMemoryBuffer : deviceMemoryBuffers) {
      if (resourceDataMap.count(deviceMemoryBuffer.bindingIndex)) {
        void *payload;
        auto &hostMemoryBuffer =
            resourceDataMap[deviceMemoryBuffer.bindingIndex];
        throwOnVulkanError(vkMapMemory(device->getDevice(),
                                       deviceMemoryBuffer.deviceMemory, 0,
                                       hostMemoryBuffer.size, 0,
                                       reinterpret_cast<void **>(&payload)),
                           "vkMapMemory");
        std::memcpy(hostMemoryBuffer.ptr, payload, hostMemoryBuffer.size);
        vkUnmapMemory(device->getDevice(), deviceMemoryBuffer.deviceMemory);
      }
    }
  }
}

} // namespace pmlc::rt::vulkan
