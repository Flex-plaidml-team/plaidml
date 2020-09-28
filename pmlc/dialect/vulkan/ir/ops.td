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

def Vk_CreateShaderModuleOp : Vk_Op<"create_shader_module"> {
  let arguments = (ins StrAttr:$binary);
  let results = (outs VkShaderModule:$module);
}

def Vk_Alloc : Vk_Op<"alloc"> {
  let results = (outs VkBuffer);
}

def Vk_Copy : Vk_Op<"copy"> {
  let arguments = (ins VkBuffer:$src);
  let results = (outs VkBuffer:$dst);
}

def Vk_hostWrite : Vk_Op<"Vk_hostWrite",>
                       , Arguments<(ins AnyMemRef:$hostMem)>
                       , Results<(outs AnyType:$outEvent)> {
  let summary = "Schedules data copy from host for use in execution environment.";
}

def Vk_hostRead : Vk_Op<"schedule_read",>
                      , Arguments<(ins AnyMemRef:$vkBuffer>
                      , Results<(outs AnyType:$outEvent)> {
  let summary = "Schedules data copy from execution environment for use on host.";
}

def Vk_Dispatch : Vk_Op<"dispatch"> {
  let arguments = (ins
    VkShaderModule:$module,
    StrAttr:$entry_point,
    Index:$workgroup_x,
    Index:$workgroup_y,
    Index:$workgroup_z
  );
  let assemblyFormat = [{
    type($module) $module `,` `entry_point` `=` $entry_point `,`
    `workgroup` `=` `[` $workgroup_x `,` $workgroup_y `,` $workgroup_z `]`
    attr-dict
  }];
}

def Vk_InitVulkanCall : Vk_Op<"initvulkancall"> {
   let summary = "init vulkan device and command buffer"
}

def Vk_DeinitVulkan : Vk_Op<"DeinitVulkan"> {
   let summary = "deinit vulkan device and command buffer"
}

def Vk_CreateVulkanLaunchKernelAction : Vk_Op<"createVulkanLaunchKernelAction"> {

}

def Vk_SetLaunchKernelAction : Vk_Op<"setLaunchKernelAction">,
                               Arguments<(ins Variadic<VkBuffer>:$operands),{
  let builders = [
    OpBuilder<"OpBuilder &builder, OperationState &result, GPUFuncOp kernelFunc, "
              "ValueRange kernelOperands">,
  ];
}

def Vk_AddVulkanLaunchActionToSchedule : Vk_Op<"AddVulkanLaunchActionToSchedule"> {

}

def Vk_SubmitCommandBuffers : Vk_Op<"SubmitCommandBuffers"> {

}


#endif // __VULKAN_OPS__
