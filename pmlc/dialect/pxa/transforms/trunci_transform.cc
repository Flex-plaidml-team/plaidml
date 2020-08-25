// Copyright 2020 Intel Corporation

#include "pmlc/dialect/pxa/transforms/trunci_transform.h"

#include "mlir/Dialect/StandardOps/IR/Ops.h"
#include "mlir/Pass/Pass.h"
#include "pmlc/dialect/pxa/ir/ops.h"
#include "pmlc/dialect/pxa/transforms/pass_detail.h"
#include "pmlc/util/logging.h"

#include "mlir/IR/Builders.h"
#include "mlir/IR/TypeUtilities.h"

using namespace mlir; // NOLINT[build/namespaces]

namespace pmlc::dialect::pxa {
namespace {

LogicalResult truncITypeTransformation(TruncateIOp op) {

  auto originDstType = getElementTypeOrSelf(op.getType());
  auto originTypeWidth = originDstType.cast<IntegerType>().getWidth();
  if (!originTypeWidth || originTypeWidth % 8 == 0) {
    return failure();
  }

  bool isFollowedBySelect = false;
  auto dstResult = op.getResult();
  for (auto userOp : dstResult.getUsers()) {
    if (dyn_cast<SelectOp>(userOp)) {
      isFollowedBySelect = true;
      break;
    }
  }

  OpBuilder builder(op.getOperation());
  auto loc = op.getLoc();
  auto srcOperand = op.getOperand();

  if (isFollowedBySelect) {
    auto srcType = srcOperand.getType();
    auto cstOp0 = builder.create<ConstantIntOp>(loc, 0, srcType);
    auto cmpiOp = builder.create<CmpIOp>(loc, CmpIPredicate::ne, srcOperand,
                                         cstOp0.getResult());
    dstResult.replaceAllUsesWith(cmpiOp.getResult());
  } else {
    auto dstType = builder.getIntegerType(8);
    auto newTruncIOp = builder.create<TruncateIOp>(loc, srcOperand, dstType);
    dstResult.replaceAllUsesWith(newTruncIOp.getResult());
  }
  op.erase();

  return success();
}

struct TruncateTypeTransformationPass
    : public TruncateTypeTransformationBase<TruncateTypeTransformationPass> {
  void runOnFunction() final {
    auto funcOp = getFunction();
    funcOp.walk(
        [&](TruncateIOp trunciOp) { truncITypeTransformation(trunciOp); });
  }
};
} // namespace

std::unique_ptr<mlir::Pass> createTruncateTypeTransformationPass() {
  return std::make_unique<TruncateTypeTransformationPass>();
}

} // namespace pmlc::dialect::pxa