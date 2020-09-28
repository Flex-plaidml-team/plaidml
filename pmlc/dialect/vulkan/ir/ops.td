#ifndef __VULKAN_OPS__
#define __VULKAN_OPS__

include "mlir/IR/OpBase.td"

def Vk_Dialect : Dialect {
  let name = "vk";
  let summary = "Vulkan Dialect";
  let cppNamespace = "pmlc::dialect::vulkan";
}

def VkBuffer : DialectType<Vk_Dialect,
  CPred<"$_self.isa<BufferType>()">,
  "VkBuffer">;

def VkShaderModule : DialectType<Vk_Dialect,
  CPred<"$_self.isa<ShaderModuleType>()">,
  "VkShaderModule">;

class Vk_Op<string mnemonic, list<OpTrait> traits = []> :
    Op<Vk_Dialect, mnemonic, traits> {
}

def Vk_CreateShaderModuleOp : Vk_Op<"create_shader_module">,
                              Arguments<(ins Variadic<VkBuffer>:$operands)>{
  let summary = "new Module with local buffer ";
//  let results = (outs VkShaderModule:$module);
}

def Vk_Alloc : Vk_Op<"alloc"> {
  let results = (outs VkBuffer);
}

def Vk_ReadFromDevice : Vk_Op<"Vk_ReadFromDevice">
                       , Arguments<(ins VkBuffer:$deviceBuffer)>
                       , Results<(outs AnyMemRef:$hostBuffer)> {
  let summary = "Schedules data copy from host for use in execution environment.";
}

def Vk_WriteToDevice : Vk_Op<"Vk_WriteToDevice">
                      , Arguments<(ins AnyMemRef:$hostBuffer)>
                      , Results<(outs VkBuffer:$deviceBuffer)> {
  let summary = "Schedules data copy from execution environment for use on host.";
}

def Vk_Wait : Vk_Op<"wait"> {
  let summary = "Waits for events to finish.";

  let description = [{
    After this operation executes it is guaranteed that operations connected to
    events have finished, and it is save to use their results from host.
  }];
}

def Vk_InitVulkanCall : Vk_Op<"initvulkancall"> {
   let summary = "init vulkan device and command buffer";
}

def Vk_DeinitVulkan : Vk_Op<"DeinitVulkan"> {
   let summary = "deinit vulkan device and command buffer";
}

def Vk_SubmitCommandBuffers : Vk_Op<"SubmitCommandBuffers"> {
   let summary = "submit command buffer";
}

#endif // __VULKAN_OPS__
