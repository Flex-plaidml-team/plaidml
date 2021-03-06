#include "llvm/Support/FormatVariadic.h"

#include "mlir/Pass/Pass.h"
#include "mlir/Pass/PassManager.h"

#include "pmlc/compiler/registry.h"
#include "pmlc/target/x86/pipeline.h"

using namespace mlir; // NOLINT[build/namespaces]

namespace pmlc::target::x86 {

static constexpr const char *kTargetName = "llvm_cpu";
static constexpr const char *kPassPipelineTargetName = "target-llvm_cpu";

static PassPipelineRegistration<> passPipelineReg(kPassPipelineTargetName,
                                                  "Target pipeline for CPU",
                                                  pipelineBuilder);

class Target : public compiler::Target {
public:
  void buildPipeline(mlir::OpPassManager &pm, llvm::StringRef targetOptions) {
    pipelineBuilder(pm);
  }

  util::BufferPtr
  save(compiler::Program &program,
       const std::unordered_map<std::string, std::string> &config) {
    throw std::runtime_error(
        llvm::formatv("Target '{0}' does not have 'save' support.", kTargetName)
            .str());
  }
};

void registerTarget() {
  pmlc::compiler::registerTarget(kTargetName, std::make_shared<Target>());
}

} // namespace pmlc::target::x86
