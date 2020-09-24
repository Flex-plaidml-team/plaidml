// Copyright 2020. Intel Corporation

#pragma once

#include "mlir/IR/Location.h"
#include "mlir/IR/Types.h"

namespace pmlc::dialect::vulkan {

namespace TypeKinds {
enum Kind {
  BufferType,
  ShaderModuleType,
};
}

class BufferType
    : public mlir::Type::TypeBase<BufferType, mlir::Type, mlir::TypeStorage> {
public:
  using Base::Base;
  static BufferType get(mlir::MLIRContext *context);
  static bool kindof(unsigned kind) { return kind == TypeKinds::BufferType; }
};

class ShaderModuleType
    : public mlir::Type::TypeBase<ShaderModuleType, mlir::Type,
                                  mlir::TypeStorage> {
public:
  using Base::Base;
  static ShaderModuleType get(mlir::MLIRContext *context);
  static bool kindof(unsigned kind) {
    return kind == TypeKinds::ShaderModuleType;
  }
};
} //  namespace pmlc::dialect::vulkan
