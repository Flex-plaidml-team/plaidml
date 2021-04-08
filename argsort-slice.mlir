INFO: Options provided by the client:
  Inherited 'common' options: --isatty=0 --terminal_columns=80
INFO: Reading rc options for 'run' from /home/zhibinli/Miscellaneous/plaidml/bzl/bazel.rc:
  Inherited 'common' options: --experimental_repo_remote_exec
INFO: Reading rc options for 'run' from /home/zhibinli/Miscellaneous/plaidml/bzl/bazel.rc:
  Inherited 'build' options: -c opt --spawn_strategy=standalone --genrule_strategy=standalone --announce_rc --nolegacy_external_runfiles --distinct_host_configuration=false --enable_platform_specific_config --action_env=LC_ALL --action_env=LANG --action_env=NO_PROXY --action_env=HTTP_PROXY --action_env=HTTPS_PROXY --action_env=no_proxy --action_env=http_proxy --action_env=https_proxy --define=version=0.0.0.dev0 --define=no_aws_support=true --nocheck_visibility
INFO: Reading rc options for 'run' from /home/zhibinli/Miscellaneous/plaidml/bzl/bazel.rc:
  'run' options: -c opt --spawn_strategy=standalone --genrule_strategy=standalone --test_env=HOME --test_env=PLAIDML_DEVICE --test_env=PLAIDML_TARGET --test_env=PLAIDML_SETTINGS --test_sharding_strategy=disabled
INFO: Found applicable config definition build:linux in file /home/zhibinli/Miscellaneous/plaidml/bzl/bazel.rc: --cpu=linux_x86_64 --crosstool_top=//toolchain:toolchain --cxxopt=-std=c++17 --define=compiler=gcc --host_crosstool_top=//toolchain:toolchain --build_tag_filters=-latex,-macos,-pytorch,-skip_linux,-windows
Loading: 
Loading: 0 packages loaded
Analyzing: target //plaidml/edsl/tests:cc_test (0 packages loaded, 0 targets configured)
WARNING: /home/zhibinli/.cache/bazel/_bazel_zhibinli/38e45cabaae39de916702e1ac85d4ac9/external/llvm-project/openmp/BUILD.bazel:41:18: in genrule rule @llvm-project//openmp:kmp_config_gen: Target '@llvm-project//openmp:kmp_config_gen' violates visibility of target '//vendor/llvm:expand_cmake_vars'. Continuing because --nocheck_visibility is active
WARNING: /home/zhibinli/.cache/bazel/_bazel_zhibinli/38e45cabaae39de916702e1ac85d4ac9/external/llvm-project/openmp/BUILD.bazel:34:18: in genrule rule @llvm-project//openmp:omp_gen: Target '@llvm-project//openmp:omp_gen' violates visibility of target '//vendor/llvm:expand_cmake_vars'. Continuing because --nocheck_visibility is active
WARNING: /home/zhibinli/.cache/bazel/_bazel_zhibinli/38e45cabaae39de916702e1ac85d4ac9/external/llvm-project/openmp/BUILD.bazel:48:18: in genrule rule @llvm-project//openmp:omp_tools_gen: Target '@llvm-project//openmp:omp_tools_gen' violates visibility of target '//vendor/llvm:expand_cmake_vars'. Continuing because --nocheck_visibility is active
WARNING: /home/zhibinli/.cache/bazel/_bazel_zhibinli/38e45cabaae39de916702e1ac85d4ac9/external/remote_java_tools_linux/BUILD:671:11: in hdrs attribute of cc_library rule @remote_java_tools_linux//:combiners: Artifact 'external/remote_java_tools_linux/java_tools/src/tools/singlejar/zip_headers.h' is duplicated (through '@remote_java_tools_linux//:transient_bytes' and '@remote_java_tools_linux//:zip_headers'). Since this rule was created by the macro 'cc_library', the error might have been caused by the macro implementation
INFO: Analyzed target //plaidml/edsl/tests:cc_test (0 packages loaded, 0 targets configured).
INFO: Found 1 target...
[0 / 2] [Prepa] BazelWorkspaceStatusAction stable-status.txt
[1 / 4] Compiling plaidml/edsl/tests/edsl_test.cc; 1s local
[2 / 4] [Prepa] Linking plaidml/edsl/tests/cc_test
[2 / 4] Linking plaidml/edsl/tests/cc_test; 2s local
Target //plaidml/edsl/tests:cc_test up-to-date:
  bazel-bin/plaidml/edsl/tests/cc_test
INFO: Elapsed time: 15.276s, Critical Path: 14.51s
INFO: 2 processes: 2 local.
INFO: Build completed successfully, 3 total actions
INFO: Running command line: external/bazel_tools/tools/test/test-setup.sh plaidml/edsl/tests/cc_test '--plaidml_device=llvm_cpu.0' '--plaidml_target=llvm_cpu' '--gtest_filter=CppEdsl.TMP'
INFO: Build completed successfully, 3 total actions
exec ${PAGER:-/usr/bin/less} "$0" || exit 1
Executing tests from //plaidml/edsl/tests:cc_test
-----------------------------------------------------------------------------
Note: Google Test filter = CppEdsl.TMP
[==========] Running 1 test from 1 test suite.
[----------] Global test environment set-up.
2021-04-07 05:11:48,467 VERBOSE-1 [default] plaidml_init
2021-04-07 05:11:48,467 VERBOSE-1 [default] PLAIDML_DEVICE = llvm_cpu.0
2021-04-07 05:11:48,467 VERBOSE-1 [default] PLAIDML_TARGET = llvm_cpu
2021-04-07 05:11:48,467 VERBOSE-1 [default] plaidml_exec_init
2021-04-07 05:11:48,510 VERBOSE-2 [default] Failed to register 'vulkan' runtime: volkInitialize failed with error code -3
[----------] 1 test from CppEdsl
[ RUN      ] CppEdsl.TMP
2021-04-07 05:11:48,510 VERBOSE-3 [default] plaidml_expr_input: 20xf32
2021-04-07 05:11:48,510 VERBOSE-3 [default] plaidml_expr_int> 0
2021-04-07 05:11:48,510 VERBOSE-3 [default] plaidml_expr_int> 0
2021-04-07 05:11:48,510 VERBOSE-3 [default] plaidml_expr_intrinsic: argsort
2021-04-07 05:11:48,511 VERBOSE-3 [default] plaidml_expr_free> 0:six
2021-04-07 05:11:48,511 VERBOSE-3 [default] plaidml_expr_free> 0:six
2021-04-07 05:11:48,511 VERBOSE-3 [default] plaidml_value_int> 0
2021-04-07 05:11:48,511 VERBOSE-3 [default] plaidml_value_int> 10
2021-04-07 05:11:48,511 VERBOSE-3 [default] plaidml_value_int> 1
2021-04-07 05:11:48,511 VERBOSE-3 [default] plaidml_value_tuple: 3
2021-04-07 05:11:48,511 VERBOSE-3 [default] plaidml_value_free: 0
2021-04-07 05:11:48,511 VERBOSE-3 [default] plaidml_value_free: 10
2021-04-07 05:11:48,511 VERBOSE-3 [default] plaidml_value_free: 1
2021-04-07 05:11:48,511 VERBOSE-3 [default] plaidml_value_expr
2021-04-07 05:11:48,511 VERBOSE-3 [default] plaidml_value_tuple: 1
2021-04-07 05:11:48,511 VERBOSE-3 [default] plaidml_value_tuple: 2
2021-04-07 05:11:48,511 VERBOSE-3 [default] plaidml_value_free: argsort()
2021-04-07 05:11:48,511 VERBOSE-3 [default] plaidml_value_free: ((0, 10, 1))
2021-04-07 05:11:48,511 VERBOSE-3 [default] plaidml_value_clone
2021-04-07 05:11:48,511 VERBOSE-1 [default] slice
2021-04-07 05:11:48,511 VERBOSE-3 [default] plaidml_value_tuple_get
2021-04-07 05:11:48,511 VERBOSE-3 [default] plaidml_value_none
2021-04-07 05:11:48,511 VERBOSE-3 [default] plaidml_value_none
2021-04-07 05:11:48,511 VERBOSE-3 [default] plaidml_value_clone
2021-04-07 05:11:48,511 VERBOSE-3 [default] plaidml_value_free: none
2021-04-07 05:11:48,511 VERBOSE-3 [default] plaidml_value_clone
2021-04-07 05:11:48,511 VERBOSE-3 [default] plaidml_value_free: none
2021-04-07 05:11:48,511 VERBOSE-3 [default] plaidml_tuple_free
2021-04-07 05:11:48,511 VERBOSE-3 [default] plaidml_value_get_kind
2021-04-07 05:11:48,511 VERBOSE-3 [default] plaidml_value_expr_get
2021-04-07 05:11:48,511 VERBOSE-3 [default] plaidml_value_tuple_get
2021-04-07 05:11:48,511 VERBOSE-3 [default] plaidml_value_none
2021-04-07 05:11:48,511 VERBOSE-3 [default] plaidml_value_clone
2021-04-07 05:11:48,511 VERBOSE-3 [default] plaidml_value_free: none
2021-04-07 05:11:48,511 VERBOSE-3 [default] plaidml_tuple_free
2021-04-07 05:11:48,511 VERBOSE-3 [default] plaidml_dim_expr_none
2021-04-07 05:11:48,511 VERBOSE-3 [default] plaidml_expr_bind_dims> argsort()
2021-04-07 05:11:48,511 VERBOSE-3 [default] plaidml_poly_expr_index
2021-04-07 05:11:48,511 VERBOSE-3 [default] plaidml_value_get_kind
2021-04-07 05:11:48,511 VERBOSE-3 [default] plaidml_value_get_kind
2021-04-07 05:11:48,511 VERBOSE-3 [default] plaidml_value_tuple_get
2021-04-07 05:11:48,511 VERBOSE-3 [default] plaidml_value_none
2021-04-07 05:11:48,511 VERBOSE-3 [default] plaidml_value_none
2021-04-07 05:11:48,511 VERBOSE-3 [default] plaidml_value_none
2021-04-07 05:11:48,511 VERBOSE-3 [default] plaidml_value_clone
2021-04-07 05:11:48,511 VERBOSE-3 [default] plaidml_value_free: none
2021-04-07 05:11:48,511 VERBOSE-3 [default] plaidml_value_clone
2021-04-07 05:11:48,511 VERBOSE-3 [default] plaidml_value_free: none
2021-04-07 05:11:48,511 VERBOSE-3 [default] plaidml_value_clone
2021-04-07 05:11:48,511 VERBOSE-3 [default] plaidml_value_free: none
2021-04-07 05:11:48,511 VERBOSE-3 [default] plaidml_tuple_free
2021-04-07 05:11:48,511 VERBOSE-3 [default] plaidml_dim_expr_none
2021-04-07 05:11:48,511 VERBOSE-3 [default] plaidml_dim_expr_none
2021-04-07 05:11:48,511 VERBOSE-3 [default] plaidml_value_get_kind
2021-04-07 05:11:48,511 VERBOSE-3 [default] plaidml_value_int_get
2021-04-07 05:11:48,511 VERBOSE-3 [default] plaidml_value_get_kind
2021-04-07 05:11:48,511 VERBOSE-3 [default] plaidml_value_int_get
2021-04-07 05:11:48,511 VERBOSE-3 [default] plaidml_dim_expr_int> 0
2021-04-07 05:11:48,511 VERBOSE-3 [default] plaidml_dim_expr_free> ?
2021-04-07 05:11:48,511 VERBOSE-3 [default] plaidml_value_get_kind
2021-04-07 05:11:48,511 VERBOSE-3 [default] plaidml_value_int_get
2021-04-07 05:11:48,511 VERBOSE-3 [default] plaidml_dim_expr_int> 10
2021-04-07 05:11:48,511 VERBOSE-3 [default] plaidml_dim_expr_free> ?
2021-04-07 05:11:48,511 VERBOSE-3 [default] plaidml_dim_expr_op> 2
2021-04-07 05:11:48,511 VERBOSE-3 [default] plaidml_dim_expr_int> 0
2021-04-07 05:11:48,511 VERBOSE-3 [default] plaidml_dim_expr_op> 1
2021-04-07 05:11:48,511 VERBOSE-3 [default] plaidml_dim_expr_free> 0
2021-04-07 05:11:48,511 VERBOSE-3 [default] plaidml_dim_expr_int> 1
2021-04-07 05:11:48,511 VERBOSE-3 [default] plaidml_dim_expr_op> 4
2021-04-07 05:11:48,511 VERBOSE-3 [default] plaidml_dim_expr_free> 1
2021-04-07 05:11:48,511 VERBOSE-3 [default] plaidml_dim_expr_free> add(sub(10, 0), 0)
2021-04-07 05:11:48,511 VERBOSE-3 [default] plaidml_dim_expr_free> sub(10, 0)
2021-04-07 05:11:48,511 VERBOSE-3 [default] plaidml_poly_expr_literal> 1
2021-04-07 05:11:48,511 VERBOSE-3 [default] plaidml_poly_expr_op> 3
2021-04-07 05:11:48,511 VERBOSE-3 [default] plaidml_poly_expr_free> 1
2021-04-07 05:11:48,511 VERBOSE-3 [default] plaidml_poly_expr_dim
2021-04-07 05:11:48,511 VERBOSE-3 [default] plaidml_poly_expr_op> 1
2021-04-07 05:11:48,511 VERBOSE-3 [default] plaidml_poly_expr_free> mul(1, %0x0000000003BEA5B0)
2021-04-07 05:11:48,511 VERBOSE-3 [default] plaidml_dim_expr_free> 10
2021-04-07 05:11:48,511 VERBOSE-3 [default] plaidml_dim_expr_free> 0
2021-04-07 05:11:48,511 VERBOSE-3 [default] plaidml_value_free: 0
2021-04-07 05:11:48,512 VERBOSE-3 [default] plaidml_value_free: 10
2021-04-07 05:11:48,512 VERBOSE-3 [default] plaidml_value_free: 1
2021-04-07 05:11:48,512 VERBOSE-3 [default] plaidml_expr_contraction
2021-04-07 05:11:48,512 VERBOSE-3 [default] plaidml_contraction_add_operand
2021-04-07 05:11:48,512 VERBOSE-3 [default] plaidml_contraction_build
2021-04-07 05:11:48,512 VERBOSE-3 [default] plaidml_value_expr
2021-04-07 05:11:48,512 VERBOSE-3 [default] plaidml_expr_free> assign()
2021-04-07 05:11:48,512 VERBOSE-3 [default] plaidml_poly_expr_free> add(0, mul(1, %0x0000000003BEA5B0))
2021-04-07 05:11:48,512 VERBOSE-3 [default] plaidml_dim_expr_free> div(add(sub(10, 0), 0), 1)
2021-04-07 05:11:48,512 VERBOSE-3 [default] plaidml_poly_expr_free> %0x0000000003BEA5B0
2021-04-07 05:11:48,512 VERBOSE-3 [default] plaidml_dim_expr_free> 20
2021-04-07 05:11:48,512 VERBOSE-3 [default] plaidml_value_free: (0, 10, 1)
2021-04-07 05:11:48,512 VERBOSE-3 [default] plaidml_expr_free> argsort()
2021-04-07 05:11:48,512 VERBOSE-3 [default] plaidml_value_free: argsort()
2021-04-07 05:11:48,512 VERBOSE-3 [default] plaidml_value_free: ((0, 10, 1))
2021-04-07 05:11:48,512 VERBOSE-3 [default] plaidml_value_free: (argsort(), ((0, 10, 1)))
2021-04-07 05:11:48,512 VERBOSE-3 [default] plaidml_value_free: assign()
2021-04-07 05:11:48,512 VERBOSE-3 [default] plaidml_value_clone
2021-04-07 05:11:48,512 VERBOSE-3 [default] plaidml_value_get_kind
2021-04-07 05:11:48,512 VERBOSE-3 [default] plaidml_value_expr_get
2021-04-07 05:11:48,512 VERBOSE-3 [default] plaidml_value_free: assign()
2021-04-07 05:11:48,512 VERBOSE-3 [default] plaidml_value_free: (argsort(), ((0, 10, 1)))
2021-04-07 05:11:48,512 VERBOSE-3 [default] plaidml_value_free: (0, 10, 1)
2021-04-07 05:11:48,512 VERBOSE-3 [default] plaidml_expr_free> argsort()
2021-04-07 05:11:48,512 VERBOSE-3 [default] 
#map = affine_map<(d0) -> (d0)>
module @argsort  {
  func @main(%arg0: tensor<20xf32>) -> tensor<10xsi32> {
    %c0 = tile.constant(0 : i64) : tensor<!tile.six>
    %c0_0 = tile.constant(0 : i64) : tensor<!tile.six>
    %0 = tile.argsort asc %arg0[0] : (tensor<20xf32>) -> tensor<20xsi32>
    %c0_1 = tile.constant(0 : i64) : tensor<si32>
    %1 = tile.contract assign, none, %c0_1, %0 {sink = #map, srcs = [#map]} : tensor<si32>, tensor<20xsi32> -> tensor<10xsi32>
    return %1 : tensor<10xsi32>
  }
}

2021-04-07 05:11:48,513 VERBOSE-3 [default] tile::TileDialect::materializeConstant> 0 : i64 : tensor<si32>
2021-04-07 05:11:48,513 VERBOSE-3 [default] tile::TileDialect::materializeConstant> 0 : i64 : tensor<si32>
2021-04-07 05:11:48,513 VERBOSE-2 [default] 
#map = affine_map<(d0) -> (d0)>
module @argsort  {
  func @main(%arg0: tensor<20xf32>) -> tensor<10xsi32> {
    %c0 = tile.constant(0 : i64) : tensor<si32>
    %0 = tile.argsort asc %arg0[0] : (tensor<20xf32>) -> tensor<20xsi32>
    %1 = tile.contract assign, none, %c0, %0 {sink = #map, srcs = [#map]} : tensor<si32>, tensor<20xsi32> -> tensor<10xsi32>
    return %1 : tensor<10xsi32>
  }
}

// *** IR Dump After InlineLayers *** ('func' operation: @main)
#map = affine_map<(d0) -> (d0)>
module @argsort  {
  func @main(%arg0: tensor<20xf32>) -> tensor<10xsi32> {
    %c0 = tile.constant(0 : i64) : tensor<si32>
    %0 = tile.argsort asc %arg0[0] : (tensor<20xf32>) -> tensor<20xsi32>
    %1 = tile.contract assign, none, %c0, %0 {sink = #map, srcs = [#map]} : tensor<si32>, tensor<20xsi32> -> tensor<10xsi32>
    return %1 : tensor<10xsi32>
  }
}


2021-04-07 05:11:48,518 VERBOSE-2 [default] Processing: %1 = tile.contract assign, none, %c0, %0 {sink = affine_map<(d0) -> (d0)>, srcs = [affine_map<(d0) -> (d0)>]} : tensor<si32>, tensor<20xsi32> -> tensor<10xsi32>
2021-04-07 05:11:48,518 VERBOSE-3 [default] Constraints:[0 <= x0 < 10, 0 <= x0 < 20, 0 <= 500000000 + x0 < 1000000000]
2021-04-07 05:11:48,518 VERBOSE-3 [default] Merged Parallel Constraints:[0 <= x0 < 10]
2021-04-07 05:11:48,518 VERBOSE-3 [default] No fractions to Defract
// *** IR Dump After ComputeBounds *** ('func' operation: @main)
#map0 = affine_map<() -> (0)>
#map1 = affine_map<(d0) -> (d0)>
#map2 = affine_map<() -> (9)>
module @argsort  {
  func @main(%arg0: tensor<20xf32>) -> tensor<10xsi32> {
    %c0 = tile.constant(0 : i64) : tensor<si32>
    %0 = tile.argsort asc %arg0[0] : (tensor<20xf32>) -> tensor<20xsi32>
    %1 = tile.contract assign, none, %c0, %0 {lowerBounds = #map0, sink = #map1, srcs = [#map1], upperBounds = #map2} : tensor<si32>, tensor<20xsi32> -> tensor<10xsi32>
    return %1 : tensor<10xsi32>
  }
}


// *** IR Dump After SplitMain *** ('module' operation: @argsort)
#map0 = affine_map<() -> (0)>
#map1 = affine_map<(d0) -> (d0)>
#map2 = affine_map<() -> (9)>
module @argsort  {
  func @init() -> !stdx.argpack {
    %0 = stdx.pack  : 
    return %0 : !stdx.argpack
  }
  func @main(%arg0: !stdx.argpack, %arg1: tensor<20xf32>) -> tensor<10xsi32> {
    stdx.unpack %arg0 : 
    %c0 = tile.constant(0 : i64) : tensor<si32>
    %0 = tile.argsort asc %arg1[0] : (tensor<20xf32>) -> tensor<20xsi32>
    %1 = tile.contract assign, none, %c0, %0 {lowerBounds = #map0, sink = #map1, srcs = [#map1], upperBounds = #map2} : tensor<si32>, tensor<20xsi32> -> tensor<10xsi32>
    return %1 : tensor<10xsi32>
  }
  func @fini(%arg0: !stdx.argpack) {
    stdx.unpack %arg0 : 
    return
  }
}


2021-04-07 05:11:48,520 VERBOSE-3 [default] Hoisting
2021-04-07 05:11:48,520 VERBOSE-3 [default] Doing it
2021-04-07 05:11:48,520 VERBOSE-3 [default] Trying op stdx.unpack %arg0 : 
2021-04-07 05:11:48,520 VERBOSE-3 [default] Trying op %c0 = tile.constant(0 : i64) : tensor<si32>
2021-04-07 05:11:48,520 VERBOSE-3 [default] Trying op %0 = tile.argsort asc %arg1[0] : (tensor<20xf32>) -> tensor<20xsi32>
2021-04-07 05:11:48,520 VERBOSE-3 [default] Checking operands %0 = tile.argsort asc %arg1[0] : (tensor<20xf32>) -> tensor<20xsi32>
2021-04-07 05:11:48,520 VERBOSE-3 [default] Trying op %1 = tile.contract assign, none, %c0, %0 {lowerBounds = affine_map<() -> (0)>, sink = affine_map<(d0) -> (d0)>, srcs = [affine_map<(d0) -> (d0)>], upperBounds = affine_map<() -> (9)>} : tensor<si32>, tensor<20xsi32> -> tensor<10xsi32>
2021-04-07 05:11:48,520 VERBOSE-3 [default] Checking operands %1 = tile.contract assign, none, %c0, %0 {lowerBounds = affine_map<() -> (0)>, sink = affine_map<(d0) -> (d0)>, srcs = [affine_map<(d0) -> (d0)>], upperBounds = affine_map<() -> (9)>} : tensor<si32>, tensor<20xsi32> -> tensor<10xsi32>
// *** IR Dump After HoistingPass *** ('module' operation: @argsort)
#map0 = affine_map<() -> (0)>
#map1 = affine_map<(d0) -> (d0)>
#map2 = affine_map<() -> (9)>
module @argsort  {
  func @init() -> !stdx.argpack {
    %0 = stdx.pack  : 
    return %0 : !stdx.argpack
  }
  func @main(%arg0: !stdx.argpack, %arg1: tensor<20xf32>) -> tensor<10xsi32> {
    stdx.unpack %arg0 : 
    %c0 = tile.constant(0 : i64) : tensor<si32>
    %0 = tile.argsort asc %arg1[0] : (tensor<20xf32>) -> tensor<20xsi32>
    %1 = tile.contract assign, none, %c0, %0 {lowerBounds = #map0, sink = #map1, srcs = [#map1], upperBounds = #map2} : tensor<si32>, tensor<20xsi32> -> tensor<10xsi32>
    return %1 : tensor<10xsi32>
  }
  func @fini(%arg0: !stdx.argpack) {
    stdx.unpack %arg0 : 
    return
  }
}


// *** IR Dump After PadConstraints *** ('func' operation: @init)
#map0 = affine_map<() -> (0)>
#map1 = affine_map<(d0) -> (d0)>
#map2 = affine_map<() -> (9)>
module @argsort  {
  func @init() -> !stdx.argpack {
    %0 = stdx.pack  : 
    return %0 : !stdx.argpack
  }
  func @main(%arg0: !stdx.argpack, %arg1: tensor<20xf32>) -> tensor<10xsi32> {
    stdx.unpack %arg0 : 
    %c0 = tile.constant(0 : i64) : tensor<si32>
    %0 = tile.argsort asc %arg1[0] : (tensor<20xf32>) -> tensor<20xsi32>
    %1 = tile.contract assign, none, %c0, %0 {lowerBounds = #map0, sink = #map1, srcs = [#map1], upperBounds = #map2} : tensor<si32>, tensor<20xsi32> -> tensor<10xsi32>
    return %1 : tensor<10xsi32>
  }
  func @fini(%arg0: !stdx.argpack) {
    stdx.unpack %arg0 : 
    return
  }
}


2021-04-07 05:11:48,521 VERBOSE-2 [default] remark: invalid agg/comb for use in padding
2021-04-07 05:11:48,521 VERBOSE-2 [default]   note: see current operation: %1 = tile.contract assign, none, %c0, %0 {lowerBounds = affine_map<() -> (0)>, sink = affine_map<(d0) -> (d0)>, srcs = [affine_map<(d0) -> (d0)>], upperBounds = affine_map<() -> (9)>} : tensor<si32>, tensor<20xsi32> -> tensor<10xsi32>
// *** IR Dump After PadConstraints *** ('func' operation: @main)
#map0 = affine_map<() -> (0)>
#map1 = affine_map<(d0) -> (d0)>
#map2 = affine_map<() -> (9)>
module @argsort  {
  func @init() -> !stdx.argpack {
    %0 = stdx.pack  : 
    return %0 : !stdx.argpack
  }
  func @main(%arg0: !stdx.argpack, %arg1: tensor<20xf32>) -> tensor<10xsi32> {
    stdx.unpack %arg0 : 
    %c0 = tile.constant(0 : i64) : tensor<si32>
    %0 = tile.argsort asc %arg1[0] : (tensor<20xf32>) -> tensor<20xsi32>
    %1 = tile.contract assign, none, %c0, %0 {lowerBounds = #map0, sink = #map1, srcs = [#map1], upperBounds = #map2} : tensor<si32>, tensor<20xsi32> -> tensor<10xsi32>
    return %1 : tensor<10xsi32>
  }
  func @fini(%arg0: !stdx.argpack) {
    stdx.unpack %arg0 : 
    return
  }
}


// *** IR Dump After PadConstraints *** ('func' operation: @fini)
#map0 = affine_map<() -> (0)>
#map1 = affine_map<(d0) -> (d0)>
#map2 = affine_map<() -> (9)>
module @argsort  {
  func @init() -> !stdx.argpack {
    %0 = stdx.pack  : 
    return %0 : !stdx.argpack
  }
  func @main(%arg0: !stdx.argpack, %arg1: tensor<20xf32>) -> tensor<10xsi32> {
    stdx.unpack %arg0 : 
    %c0 = tile.constant(0 : i64) : tensor<si32>
    %0 = tile.argsort asc %arg1[0] : (tensor<20xf32>) -> tensor<20xsi32>
    %1 = tile.contract assign, none, %c0, %0 {lowerBounds = #map0, sink = #map1, srcs = [#map1], upperBounds = #map2} : tensor<si32>, tensor<20xsi32> -> tensor<10xsi32>
    return %1 : tensor<10xsi32>
  }
  func @fini(%arg0: !stdx.argpack) {
    stdx.unpack %arg0 : 
    return
  }
}


2021-04-07 05:11:48,523 VERBOSE-3 [default] tile::TileDialect::materializeConstant> 0 : i64 : tensor<si32>
// *** IR Dump After Canonicalizer *** ('module' operation: @argsort)
#map0 = affine_map<() -> (0)>
#map1 = affine_map<(d0) -> (d0)>
#map2 = affine_map<() -> (9)>
module @argsort  {
  func @init() -> !stdx.argpack {
    %0 = stdx.pack  : 
    return %0 : !stdx.argpack
  }
  func @main(%arg0: !stdx.argpack, %arg1: tensor<20xf32>) -> tensor<10xsi32> {
    %c0 = tile.constant(0 : i64) : tensor<si32>
    stdx.unpack %arg0 : 
    %0 = tile.argsort asc %arg1[0] : (tensor<20xf32>) -> tensor<20xsi32>
    %1 = tile.contract assign, none, %c0, %0 {lowerBounds = #map0, sink = #map1, srcs = [#map1], upperBounds = #map2} : tensor<si32>, tensor<20xsi32> -> tensor<10xsi32>
    return %1 : tensor<10xsi32>
  }
  func @fini(%arg0: !stdx.argpack) {
    stdx.unpack %arg0 : 
    return
  }
}


// *** IR Dump After CSE *** ('module' operation: @argsort)
#map0 = affine_map<() -> (0)>
#map1 = affine_map<(d0) -> (d0)>
#map2 = affine_map<() -> (9)>
module @argsort  {
  func @init() -> !stdx.argpack {
    %0 = stdx.pack  : 
    return %0 : !stdx.argpack
  }
  func @main(%arg0: !stdx.argpack, %arg1: tensor<20xf32>) -> tensor<10xsi32> {
    %c0 = tile.constant(0 : i64) : tensor<si32>
    stdx.unpack %arg0 : 
    %0 = tile.argsort asc %arg1[0] : (tensor<20xf32>) -> tensor<20xsi32>
    %1 = tile.contract assign, none, %c0, %0 {lowerBounds = #map0, sink = #map1, srcs = [#map1], upperBounds = #map2} : tensor<si32>, tensor<20xsi32> -> tensor<10xsi32>
    return %1 : tensor<10xsi32>
  }
  func @fini(%arg0: !stdx.argpack) {
    stdx.unpack %arg0 : 
    return
  }
}


2021-04-07 05:11:48,524 VERBOSE-3 [default] ArgSortOpConversion::matchAndRewrite
// *** IR Dump After LowerTileToPXA *** ('module' operation: @argsort)
module @argsort  {
  func @init() -> !stdx.argpack {
    %0 = stdx.pack  : 
    return %0 : !stdx.argpack
  }
  func @main(%arg0: !stdx.argpack, %arg1: memref<20xf32>, %arg2: memref<10xi32>) -> memref<10xi32> {
    %c0_i32 = constant 0 : i32
    stdx.unpack %arg0 : 
    %0 = alloc() : memref<20xi32>
    %1 = layer.box "argsort" (%arg3, %arg4) = (%0, %arg1) : (memref<20xi32>, memref<20xf32>) -> memref<20xi32> {
      %c0 = constant 0 : index
      %c1 = constant 1 : index
      %c20 = constant 20 : index
      scf.for %arg5 = %c0 to %c20 step %c1 {
        %5 = index_cast %arg5 : index to i32
        store %5, %arg3[%arg5] : memref<20xi32>
      }
      %c19 = constant 19 : index
      scf.for %arg5 = %c0 to %c19 step %c1 {
        %5 = alloca() : memref<1xindex>
        store %arg5, %5[%c0] : memref<1xindex>
        %6 = load %arg3[%arg5] : memref<20xi32>
        %7 = index_cast %6 : i32 to index
        %8 = load %arg4[%7] : memref<20xf32>
        %9 = alloca() : memref<1xf32>
        store %8, %9[%c0] : memref<1xf32>
        %10 = addi %arg5, %c1 : index
        scf.for %arg6 = %10 to %c20 step %c1 {
          %14 = load %arg3[%arg6] : memref<20xi32>
          %15 = index_cast %14 : i32 to index
          %16 = load %arg4[%15] : memref<20xf32>
          %17 = load %9[%c0] : memref<1xf32>
          %18 = cmpf olt, %16, %17 : f32
          scf.if %18 {
            store %arg6, %5[%c0] : memref<1xindex>
            store %16, %9[%c0] : memref<1xf32>
          }
        }
        %11 = load %5[%c0] : memref<1xindex>
        %12 = load %arg3[%11] : memref<20xi32>
        %13 = load %arg3[%arg5] : memref<20xi32>
        store %12, %arg3[%arg5] : memref<20xi32>
        store %13, %arg3[%11] : memref<20xi32>
      }
      layer.return %arg3 : memref<20xi32>
    }
    %2 = alloc() : memref<10xi32>
    %3 = affine.parallel (%arg3) = (0) to (10) reduce ("assign") -> (memref<10xi32>) {
      %5 = pxa.reduce assign %c0_i32, %arg2[%arg3] : memref<10xi32>
      affine.yield %5 : memref<10xi32>
    }
    %4 = affine.parallel (%arg3) = (0) to (10) reduce ("assign") -> (memref<10xi32>) {
      %5 = pxa.load %1[%arg3] : memref<20xi32>
      %6 = pxa.reduce assign %5, %3[%arg3] : memref<10xi32>
      affine.yield %6 : memref<10xi32>
    }
    return %4 : memref<10xi32>
  }
  func @fini(%arg0: !stdx.argpack) {
    stdx.unpack %arg0 : 
    return
  }
}


// *** IR Dump After Canonicalizer *** ('module' operation: @argsort)
module @argsort  {
  func @init() -> !stdx.argpack {
    %0 = stdx.pack  : 
    return %0 : !stdx.argpack
  }
  func @main(%arg0: !stdx.argpack, %arg1: memref<20xf32>, %arg2: memref<10xi32>) -> memref<10xi32> {
    %c0_i32 = constant 0 : i32
    stdx.unpack %arg0 : 
    %0 = alloc() : memref<20xi32>
    %1 = layer.box "argsort" (%arg3, %arg4) = (%0, %arg1) : (memref<20xi32>, memref<20xf32>) -> memref<20xi32> {
      %c0 = constant 0 : index
      %c1 = constant 1 : index
      %c20 = constant 20 : index
      %c19 = constant 19 : index
      scf.for %arg5 = %c0 to %c20 step %c1 {
        %4 = index_cast %arg5 : index to i32
        store %4, %arg3[%arg5] : memref<20xi32>
      }
      scf.for %arg5 = %c0 to %c19 step %c1 {
        %4 = alloca() : memref<1xindex>
        store %arg5, %4[%c0] : memref<1xindex>
        %5 = load %arg3[%arg5] : memref<20xi32>
        %6 = index_cast %5 : i32 to index
        %7 = load %arg4[%6] : memref<20xf32>
        %8 = alloca() : memref<1xf32>
        store %7, %8[%c0] : memref<1xf32>
        %9 = addi %arg5, %c1 : index
        scf.for %arg6 = %9 to %c20 step %c1 {
          %13 = load %arg3[%arg6] : memref<20xi32>
          %14 = index_cast %13 : i32 to index
          %15 = load %arg4[%14] : memref<20xf32>
          %16 = load %8[%c0] : memref<1xf32>
          %17 = cmpf olt, %15, %16 : f32
          scf.if %17 {
            store %arg6, %4[%c0] : memref<1xindex>
            store %15, %8[%c0] : memref<1xf32>
          }
        }
        %10 = load %4[%c0] : memref<1xindex>
        %11 = load %arg3[%10] : memref<20xi32>
        %12 = load %arg3[%arg5] : memref<20xi32>
        store %11, %arg3[%arg5] : memref<20xi32>
        store %12, %arg3[%10] : memref<20xi32>
      }
      layer.return %arg3 : memref<20xi32>
    }
    %2 = affine.parallel (%arg3) = (0) to (10) reduce ("assign") -> (memref<10xi32>) {
      %4 = pxa.reduce assign %c0_i32, %arg2[%arg3] : memref<10xi32>
      affine.yield %4 : memref<10xi32>
    }
    %3 = affine.parallel (%arg3) = (0) to (10) reduce ("assign") -> (memref<10xi32>) {
      %4 = pxa.load %1[%arg3] : memref<20xi32>
      %5 = pxa.reduce assign %4, %2[%arg3] : memref<10xi32>
      affine.yield %5 : memref<10xi32>
    }
    return %3 : memref<10xi32>
  }
  func @fini(%arg0: !stdx.argpack) {
    stdx.unpack %arg0 : 
    return
  }
}


// *** IR Dump After CSE *** ('module' operation: @argsort)
module @argsort  {
  func @init() -> !stdx.argpack {
    %0 = stdx.pack  : 
    return %0 : !stdx.argpack
  }
  func @main(%arg0: !stdx.argpack, %arg1: memref<20xf32>, %arg2: memref<10xi32>) -> memref<10xi32> {
    %c0_i32 = constant 0 : i32
    stdx.unpack %arg0 : 
    %0 = alloc() : memref<20xi32>
    %1 = layer.box "argsort" (%arg3, %arg4) = (%0, %arg1) : (memref<20xi32>, memref<20xf32>) -> memref<20xi32> {
      %c0 = constant 0 : index
      %c1 = constant 1 : index
      %c20 = constant 20 : index
      %c19 = constant 19 : index
      scf.for %arg5 = %c0 to %c20 step %c1 {
        %4 = index_cast %arg5 : index to i32
        store %4, %arg3[%arg5] : memref<20xi32>
      }
      scf.for %arg5 = %c0 to %c19 step %c1 {
        %4 = alloca() : memref<1xindex>
        store %arg5, %4[%c0] : memref<1xindex>
        %5 = load %arg3[%arg5] : memref<20xi32>
        %6 = index_cast %5 : i32 to index
        %7 = load %arg4[%6] : memref<20xf32>
        %8 = alloca() : memref<1xf32>
        store %7, %8[%c0] : memref<1xf32>
        %9 = addi %arg5, %c1 : index
        scf.for %arg6 = %9 to %c20 step %c1 {
          %13 = load %arg3[%arg6] : memref<20xi32>
          %14 = index_cast %13 : i32 to index
          %15 = load %arg4[%14] : memref<20xf32>
          %16 = load %8[%c0] : memref<1xf32>
          %17 = cmpf olt, %15, %16 : f32
          scf.if %17 {
            store %arg6, %4[%c0] : memref<1xindex>
            store %15, %8[%c0] : memref<1xf32>
          }
        }
        %10 = load %4[%c0] : memref<1xindex>
        %11 = load %arg3[%10] : memref<20xi32>
        %12 = load %arg3[%arg5] : memref<20xi32>
        store %11, %arg3[%arg5] : memref<20xi32>
        store %12, %arg3[%10] : memref<20xi32>
      }
      layer.return %arg3 : memref<20xi32>
    }
    %2 = affine.parallel (%arg3) = (0) to (10) reduce ("assign") -> (memref<10xi32>) {
      %4 = pxa.reduce assign %c0_i32, %arg2[%arg3] : memref<10xi32>
      affine.yield %4 : memref<10xi32>
    }
    %3 = affine.parallel (%arg3) = (0) to (10) reduce ("assign") -> (memref<10xi32>) {
      %4 = pxa.load %1[%arg3] : memref<20xi32>
      %5 = pxa.reduce assign %4, %2[%arg3] : memref<10xi32>
      affine.yield %5 : memref<10xi32>
    }
    return %3 : memref<10xi32>
  }
  func @fini(%arg0: !stdx.argpack) {
    stdx.unpack %arg0 : 
    return
  }
}


// *** IR Dump After InlineLayers *** ('func' operation: @init)
module @argsort  {
  func @init() -> !stdx.argpack {
    %0 = stdx.pack  : 
    return %0 : !stdx.argpack
  }
  func @main(%arg0: !stdx.argpack, %arg1: memref<20xf32>, %arg2: memref<10xi32>) -> memref<10xi32> {
    %c0_i32 = constant 0 : i32
    stdx.unpack %arg0 : 
    %0 = alloc() : memref<20xi32>
    %1 = layer.box "argsort" (%arg3, %arg4) = (%0, %arg1) : (memref<20xi32>, memref<20xf32>) -> memref<20xi32> {
      %c0 = constant 0 : index
      %c1 = constant 1 : index
      %c20 = constant 20 : index
      %c19 = constant 19 : index
      scf.for %arg5 = %c0 to %c20 step %c1 {
        %4 = index_cast %arg5 : index to i32
        store %4, %arg3[%arg5] : memref<20xi32>
      }
      scf.for %arg5 = %c0 to %c19 step %c1 {
        %4 = alloca() : memref<1xindex>
        store %arg5, %4[%c0] : memref<1xindex>
        %5 = load %arg3[%arg5] : memref<20xi32>
        %6 = index_cast %5 : i32 to index
        %7 = load %arg4[%6] : memref<20xf32>
        %8 = alloca() : memref<1xf32>
        store %7, %8[%c0] : memref<1xf32>
        %9 = addi %arg5, %c1 : index
        scf.for %arg6 = %9 to %c20 step %c1 {
          %13 = load %arg3[%arg6] : memref<20xi32>
          %14 = index_cast %13 : i32 to index
          %15 = load %arg4[%14] : memref<20xf32>
          %16 = load %8[%c0] : memref<1xf32>
          %17 = cmpf olt, %15, %16 : f32
          scf.if %17 {
            store %arg6, %4[%c0] : memref<1xindex>
            store %15, %8[%c0] : memref<1xf32>
          }
        }
        %10 = load %4[%c0] : memref<1xindex>
        %11 = load %arg3[%10] : memref<20xi32>
        %12 = load %arg3[%arg5] : memref<20xi32>
        store %11, %arg3[%arg5] : memref<20xi32>
        store %12, %arg3[%10] : memref<20xi32>
      }
      layer.return %arg3 : memref<20xi32>
    }
    %2 = affine.parallel (%arg3) = (0) to (10) reduce ("assign") -> (memref<10xi32>) {
      %4 = pxa.reduce assign %c0_i32, %arg2[%arg3] : memref<10xi32>
      affine.yield %4 : memref<10xi32>
    }
    %3 = affine.parallel (%arg3) = (0) to (10) reduce ("assign") -> (memref<10xi32>) {
      %4 = pxa.load %1[%arg3] : memref<20xi32>
      %5 = pxa.reduce assign %4, %2[%arg3] : memref<10xi32>
      affine.yield %5 : memref<10xi32>
    }
    return %3 : memref<10xi32>
  }
  func @fini(%arg0: !stdx.argpack) {
    stdx.unpack %arg0 : 
    return
  }
}


2021-04-07 05:11:48,533 VERBOSE-3 [default] XSMMStencilPass> numThreads: 1
2021-04-07 05:11:48,533 VERBOSE-3 [default] XSMMStencilPass> isBatched: 1
// *** IR Dump After XSMMStencil *** ('func' operation: @init)
module @argsort  {
  func @init() -> !stdx.argpack {
    %0 = stdx.pack  : 
    return %0 : !stdx.argpack
  }
  func @main(%arg0: !stdx.argpack, %arg1: memref<20xf32>, %arg2: memref<10xi32>) -> memref<10xi32> {
    %c0_i32 = constant 0 : i32
    stdx.unpack %arg0 : 
    %0 = alloc() : memref<20xi32>
    %1 = layer.box "argsort" (%arg3, %arg4) = (%0, %arg1) : (memref<20xi32>, memref<20xf32>) -> memref<20xi32> {
      %c0 = constant 0 : index
      %c1 = constant 1 : index
      %c20 = constant 20 : index
      %c19 = constant 19 : index
      scf.for %arg5 = %c0 to %c20 step %c1 {
        %4 = index_cast %arg5 : index to i32
        store %4, %arg3[%arg5] : memref<20xi32>
      }
      scf.for %arg5 = %c0 to %c19 step %c1 {
        %4 = alloca() : memref<1xindex>
        store %arg5, %4[%c0] : memref<1xindex>
        %5 = load %arg3[%arg5] : memref<20xi32>
        %6 = index_cast %5 : i32 to index
        %7 = load %arg4[%6] : memref<20xf32>
        %8 = alloca() : memref<1xf32>
        store %7, %8[%c0] : memref<1xf32>
        %9 = addi %arg5, %c1 : index
        scf.for %arg6 = %9 to %c20 step %c1 {
          %13 = load %arg3[%arg6] : memref<20xi32>
          %14 = index_cast %13 : i32 to index
          %15 = load %arg4[%14] : memref<20xf32>
          %16 = load %8[%c0] : memref<1xf32>
          %17 = cmpf olt, %15, %16 : f32
          scf.if %17 {
            store %arg6, %4[%c0] : memref<1xindex>
            store %15, %8[%c0] : memref<1xf32>
          }
        }
        %10 = load %4[%c0] : memref<1xindex>
        %11 = load %arg3[%10] : memref<20xi32>
        %12 = load %arg3[%arg5] : memref<20xi32>
        store %11, %arg3[%arg5] : memref<20xi32>
        store %12, %arg3[%10] : memref<20xi32>
      }
      layer.return %arg3 : memref<20xi32>
    }
    %2 = affine.parallel (%arg3) = (0) to (10) reduce ("assign") -> (memref<10xi32>) {
      %4 = pxa.reduce assign %c0_i32, %arg2[%arg3] : memref<10xi32>
      affine.yield %4 : memref<10xi32>
    }
    %3 = affine.parallel (%arg3) = (0) to (10) reduce ("assign") -> (memref<10xi32>) {
      %4 = pxa.load %1[%arg3] : memref<20xi32>
      %5 = pxa.reduce assign %4, %2[%arg3] : memref<10xi32>
      affine.yield %5 : memref<10xi32>
    }
    return %3 : memref<10xi32>
  }
  func @fini(%arg0: !stdx.argpack) {
    stdx.unpack %arg0 : 
    return
  }
}


// *** IR Dump After AffineNormalize *** ('func' operation: @init)
module @argsort  {
  func @init() -> !stdx.argpack {
    %0 = stdx.pack  : 
    return %0 : !stdx.argpack
  }
  func @main(%arg0: !stdx.argpack, %arg1: memref<20xf32>, %arg2: memref<10xi32>) -> memref<10xi32> {
    %c0_i32 = constant 0 : i32
    stdx.unpack %arg0 : 
    %0 = alloc() : memref<20xi32>
    %1 = layer.box "argsort" (%arg3, %arg4) = (%0, %arg1) : (memref<20xi32>, memref<20xf32>) -> memref<20xi32> {
      %c0 = constant 0 : index
      %c1 = constant 1 : index
      %c20 = constant 20 : index
      %c19 = constant 19 : index
      scf.for %arg5 = %c0 to %c20 step %c1 {
        %4 = index_cast %arg5 : index to i32
        store %4, %arg3[%arg5] : memref<20xi32>
      }
      scf.for %arg5 = %c0 to %c19 step %c1 {
        %4 = alloca() : memref<1xindex>
        store %arg5, %4[%c0] : memref<1xindex>
        %5 = load %arg3[%arg5] : memref<20xi32>
        %6 = index_cast %5 : i32 to index
        %7 = load %arg4[%6] : memref<20xf32>
        %8 = alloca() : memref<1xf32>
        store %7, %8[%c0] : memref<1xf32>
        %9 = addi %arg5, %c1 : index
        scf.for %arg6 = %9 to %c20 step %c1 {
          %13 = load %arg3[%arg6] : memref<20xi32>
          %14 = index_cast %13 : i32 to index
          %15 = load %arg4[%14] : memref<20xf32>
          %16 = load %8[%c0] : memref<1xf32>
          %17 = cmpf olt, %15, %16 : f32
          scf.if %17 {
            store %arg6, %4[%c0] : memref<1xindex>
            store %15, %8[%c0] : memref<1xf32>
          }
        }
        %10 = load %4[%c0] : memref<1xindex>
        %11 = load %arg3[%10] : memref<20xi32>
        %12 = load %arg3[%arg5] : memref<20xi32>
        store %11, %arg3[%arg5] : memref<20xi32>
        store %12, %arg3[%10] : memref<20xi32>
      }
      layer.return %arg3 : memref<20xi32>
    }
    %2 = affine.parallel (%arg3) = (0) to (10) reduce ("assign") -> (memref<10xi32>) {
      %4 = pxa.reduce assign %c0_i32, %arg2[%arg3] : memref<10xi32>
      affine.yield %4 : memref<10xi32>
    }
    %3 = affine.parallel (%arg3) = (0) to (10) reduce ("assign") -> (memref<10xi32>) {
      %4 = pxa.load %1[%arg3] : memref<20xi32>
      %5 = pxa.reduce assign %4, %2[%arg3] : memref<10xi32>
      affine.yield %5 : memref<10xi32>
    }
    return %3 : memref<10xi32>
  }
  func @fini(%arg0: !stdx.argpack) {
    stdx.unpack %arg0 : 
    return
  }
}


2021-04-07 05:11:48,535 VERBOSE-1 [default] handleTerminator
// *** IR Dump After InlineLayers *** ('func' operation: @main)
module @argsort  {
  func @init() -> !stdx.argpack {
    %0 = stdx.pack  : 
    return %0 : !stdx.argpack
  }
  func @main(%arg0: !stdx.argpack, %arg1: memref<20xf32>, %arg2: memref<10xi32>) -> memref<10xi32> {
    %c0_i32 = constant 0 : i32
    stdx.unpack %arg0 : 
    %0 = alloc() : memref<20xi32>
    %c0 = constant 0 : index
    %c1 = constant 1 : index
    %c20 = constant 20 : index
    %c19 = constant 19 : index
    scf.for %arg3 = %c0 to %c20 step %c1 {
      %3 = index_cast %arg3 : index to i32
      store %3, %0[%arg3] : memref<20xi32>
    }
    scf.for %arg3 = %c0 to %c19 step %c1 {
      %3 = alloca() : memref<1xindex>
      store %arg3, %3[%c0] : memref<1xindex>
      %4 = load %0[%arg3] : memref<20xi32>
      %5 = index_cast %4 : i32 to index
      %6 = load %arg1[%5] : memref<20xf32>
      %7 = alloca() : memref<1xf32>
      store %6, %7[%c0] : memref<1xf32>
      %8 = addi %arg3, %c1 : index
      scf.for %arg4 = %8 to %c20 step %c1 {
        %12 = load %0[%arg4] : memref<20xi32>
        %13 = index_cast %12 : i32 to index
        %14 = load %arg1[%13] : memref<20xf32>
        %15 = load %7[%c0] : memref<1xf32>
        %16 = cmpf olt, %14, %15 : f32
        scf.if %16 {
          store %arg4, %3[%c0] : memref<1xindex>
          store %14, %7[%c0] : memref<1xf32>
        }
      }
      %9 = load %3[%c0] : memref<1xindex>
      %10 = load %0[%9] : memref<20xi32>
      %11 = load %0[%arg3] : memref<20xi32>
      store %10, %0[%arg3] : memref<20xi32>
      store %11, %0[%9] : memref<20xi32>
    }
    %1 = affine.parallel (%arg3) = (0) to (10) reduce ("assign") -> (memref<10xi32>) {
      %3 = pxa.reduce assign %c0_i32, %arg2[%arg3] : memref<10xi32>
      affine.yield %3 : memref<10xi32>
    }
    %2 = affine.parallel (%arg3) = (0) to (10) reduce ("assign") -> (memref<10xi32>) {
      %3 = pxa.load %0[%arg3] : memref<20xi32>
      %4 = pxa.reduce assign %3, %1[%arg3] : memref<10xi32>
      affine.yield %4 : memref<10xi32>
    }
    return %2 : memref<10xi32>
  }
  func @fini(%arg0: !stdx.argpack) {
    stdx.unpack %arg0 : 
    return
  }
}


2021-04-07 05:11:48,536 VERBOSE-3 [default] XSMMStencilPass> numThreads: 1
2021-04-07 05:11:48,536 VERBOSE-3 [default] XSMMStencilPass> isBatched: 1
// *** IR Dump After XSMMStencil *** ('func' operation: @main)
module @argsort  {
  func @init() -> !stdx.argpack {
    %0 = stdx.pack  : 
    return %0 : !stdx.argpack
  }
  func @main(%arg0: !stdx.argpack, %arg1: memref<20xf32>, %arg2: memref<10xi32>) -> memref<10xi32> {
    %c0_i32 = constant 0 : i32
    stdx.unpack %arg0 : 
    %0 = alloc() : memref<20xi32>
    %c0 = constant 0 : index
    %c1 = constant 1 : index
    %c20 = constant 20 : index
    %c19 = constant 19 : index
    scf.for %arg3 = %c0 to %c20 step %c1 {
      %3 = index_cast %arg3 : index to i32
      store %3, %0[%arg3] : memref<20xi32>
    }
    scf.for %arg3 = %c0 to %c19 step %c1 {
      %3 = alloca() : memref<1xindex>
      store %arg3, %3[%c0] : memref<1xindex>
      %4 = load %0[%arg3] : memref<20xi32>
      %5 = index_cast %4 : i32 to index
      %6 = load %arg1[%5] : memref<20xf32>
      %7 = alloca() : memref<1xf32>
      store %6, %7[%c0] : memref<1xf32>
      %8 = addi %arg3, %c1 : index
      scf.for %arg4 = %8 to %c20 step %c1 {
        %12 = load %0[%arg4] : memref<20xi32>
        %13 = index_cast %12 : i32 to index
        %14 = load %arg1[%13] : memref<20xf32>
        %15 = load %7[%c0] : memref<1xf32>
        %16 = cmpf olt, %14, %15 : f32
        scf.if %16 {
          store %arg4, %3[%c0] : memref<1xindex>
          store %14, %7[%c0] : memref<1xf32>
        }
      }
      %9 = load %3[%c0] : memref<1xindex>
      %10 = load %0[%9] : memref<20xi32>
      %11 = load %0[%arg3] : memref<20xi32>
      store %10, %0[%arg3] : memref<20xi32>
      store %11, %0[%9] : memref<20xi32>
    }
    %1 = affine.parallel (%arg3) = (0) to (10) reduce ("assign") -> (memref<10xi32>) {
      %3 = pxa.reduce assign %c0_i32, %arg2[%arg3] : memref<10xi32>
      affine.yield %3 : memref<10xi32>
    }
    %2 = affine.parallel (%arg3) = (0) to (10) reduce ("assign") -> (memref<10xi32>) {
      %3 = pxa.load %0[%arg3] : memref<20xi32>
      %4 = pxa.reduce assign %3, %1[%arg3] : memref<10xi32>
      affine.yield %4 : memref<10xi32>
    }
    return %2 : memref<10xi32>
  }
  func @fini(%arg0: !stdx.argpack) {
    stdx.unpack %arg0 : 
    return
  }
}


// *** IR Dump After AffineNormalize *** ('func' operation: @main)
module @argsort  {
  func @init() -> !stdx.argpack {
    %0 = stdx.pack  : 
    return %0 : !stdx.argpack
  }
  func @main(%arg0: !stdx.argpack, %arg1: memref<20xf32>, %arg2: memref<10xi32>) -> memref<10xi32> {
    %c0_i32 = constant 0 : i32
    stdx.unpack %arg0 : 
    %0 = alloc() : memref<20xi32>
    %c0 = constant 0 : index
    %c1 = constant 1 : index
    %c20 = constant 20 : index
    %c19 = constant 19 : index
    scf.for %arg3 = %c0 to %c20 step %c1 {
      %3 = index_cast %arg3 : index to i32
      store %3, %0[%arg3] : memref<20xi32>
    }
    scf.for %arg3 = %c0 to %c19 step %c1 {
      %3 = alloca() : memref<1xindex>
      store %arg3, %3[%c0] : memref<1xindex>
      %4 = load %0[%arg3] : memref<20xi32>
      %5 = index_cast %4 : i32 to index
      %6 = load %arg1[%5] : memref<20xf32>
      %7 = alloca() : memref<1xf32>
      store %6, %7[%c0] : memref<1xf32>
      %8 = addi %arg3, %c1 : index
      scf.for %arg4 = %8 to %c20 step %c1 {
        %12 = load %0[%arg4] : memref<20xi32>
        %13 = index_cast %12 : i32 to index
        %14 = load %arg1[%13] : memref<20xf32>
        %15 = load %7[%c0] : memref<1xf32>
        %16 = cmpf olt, %14, %15 : f32
        scf.if %16 {
          store %arg4, %3[%c0] : memref<1xindex>
          store %14, %7[%c0] : memref<1xf32>
        }
      }
      %9 = load %3[%c0] : memref<1xindex>
      %10 = load %0[%9] : memref<20xi32>
      %11 = load %0[%arg3] : memref<20xi32>
      store %10, %0[%arg3] : memref<20xi32>
      store %11, %0[%9] : memref<20xi32>
    }
    %1 = affine.parallel (%arg3) = (0) to (10) reduce ("assign") -> (memref<10xi32>) {
      %3 = pxa.reduce assign %c0_i32, %arg2[%arg3] : memref<10xi32>
      affine.yield %3 : memref<10xi32>
    }
    %2 = affine.parallel (%arg3) = (0) to (10) reduce ("assign") -> (memref<10xi32>) {
      %3 = pxa.load %0[%arg3] : memref<20xi32>
      %4 = pxa.reduce assign %3, %1[%arg3] : memref<10xi32>
      affine.yield %4 : memref<10xi32>
    }
    return %2 : memref<10xi32>
  }
  func @fini(%arg0: !stdx.argpack) {
    stdx.unpack %arg0 : 
    return
  }
}


// *** IR Dump After InlineLayers *** ('func' operation: @fini)
module @argsort  {
  func @init() -> !stdx.argpack {
    %0 = stdx.pack  : 
    return %0 : !stdx.argpack
  }
  func @main(%arg0: !stdx.argpack, %arg1: memref<20xf32>, %arg2: memref<10xi32>) -> memref<10xi32> {
    %c0_i32 = constant 0 : i32
    stdx.unpack %arg0 : 
    %0 = alloc() : memref<20xi32>
    %c0 = constant 0 : index
    %c1 = constant 1 : index
    %c20 = constant 20 : index
    %c19 = constant 19 : index
    scf.for %arg3 = %c0 to %c20 step %c1 {
      %3 = index_cast %arg3 : index to i32
      store %3, %0[%arg3] : memref<20xi32>
    }
    scf.for %arg3 = %c0 to %c19 step %c1 {
      %3 = alloca() : memref<1xindex>
      store %arg3, %3[%c0] : memref<1xindex>
      %4 = load %0[%arg3] : memref<20xi32>
      %5 = index_cast %4 : i32 to index
      %6 = load %arg1[%5] : memref<20xf32>
      %7 = alloca() : memref<1xf32>
      store %6, %7[%c0] : memref<1xf32>
      %8 = addi %arg3, %c1 : index
      scf.for %arg4 = %8 to %c20 step %c1 {
        %12 = load %0[%arg4] : memref<20xi32>
        %13 = index_cast %12 : i32 to index
        %14 = load %arg1[%13] : memref<20xf32>
        %15 = load %7[%c0] : memref<1xf32>
        %16 = cmpf olt, %14, %15 : f32
        scf.if %16 {
          store %arg4, %3[%c0] : memref<1xindex>
          store %14, %7[%c0] : memref<1xf32>
        }
      }
      %9 = load %3[%c0] : memref<1xindex>
      %10 = load %0[%9] : memref<20xi32>
      %11 = load %0[%arg3] : memref<20xi32>
      store %10, %0[%arg3] : memref<20xi32>
      store %11, %0[%9] : memref<20xi32>
    }
    %1 = affine.parallel (%arg3) = (0) to (10) reduce ("assign") -> (memref<10xi32>) {
      %3 = pxa.reduce assign %c0_i32, %arg2[%arg3] : memref<10xi32>
      affine.yield %3 : memref<10xi32>
    }
    %2 = affine.parallel (%arg3) = (0) to (10) reduce ("assign") -> (memref<10xi32>) {
      %3 = pxa.load %0[%arg3] : memref<20xi32>
      %4 = pxa.reduce assign %3, %1[%arg3] : memref<10xi32>
      affine.yield %4 : memref<10xi32>
    }
    return %2 : memref<10xi32>
  }
  func @fini(%arg0: !stdx.argpack) {
    stdx.unpack %arg0 : 
    return
  }
}


2021-04-07 05:11:48,540 VERBOSE-3 [default] XSMMStencilPass> numThreads: 1
2021-04-07 05:11:48,540 VERBOSE-3 [default] XSMMStencilPass> isBatched: 1
// *** IR Dump After XSMMStencil *** ('func' operation: @fini)
module @argsort  {
  func @init() -> !stdx.argpack {
    %0 = stdx.pack  : 
    return %0 : !stdx.argpack
  }
  func @main(%arg0: !stdx.argpack, %arg1: memref<20xf32>, %arg2: memref<10xi32>) -> memref<10xi32> {
    %c0_i32 = constant 0 : i32
    stdx.unpack %arg0 : 
    %0 = alloc() : memref<20xi32>
    %c0 = constant 0 : index
    %c1 = constant 1 : index
    %c20 = constant 20 : index
    %c19 = constant 19 : index
    scf.for %arg3 = %c0 to %c20 step %c1 {
      %3 = index_cast %arg3 : index to i32
      store %3, %0[%arg3] : memref<20xi32>
    }
    scf.for %arg3 = %c0 to %c19 step %c1 {
      %3 = alloca() : memref<1xindex>
      store %arg3, %3[%c0] : memref<1xindex>
      %4 = load %0[%arg3] : memref<20xi32>
      %5 = index_cast %4 : i32 to index
      %6 = load %arg1[%5] : memref<20xf32>
      %7 = alloca() : memref<1xf32>
      store %6, %7[%c0] : memref<1xf32>
      %8 = addi %arg3, %c1 : index
      scf.for %arg4 = %8 to %c20 step %c1 {
        %12 = load %0[%arg4] : memref<20xi32>
        %13 = index_cast %12 : i32 to index
        %14 = load %arg1[%13] : memref<20xf32>
        %15 = load %7[%c0] : memref<1xf32>
        %16 = cmpf olt, %14, %15 : f32
        scf.if %16 {
          store %arg4, %3[%c0] : memref<1xindex>
          store %14, %7[%c0] : memref<1xf32>
        }
      }
      %9 = load %3[%c0] : memref<1xindex>
      %10 = load %0[%9] : memref<20xi32>
      %11 = load %0[%arg3] : memref<20xi32>
      store %10, %0[%arg3] : memref<20xi32>
      store %11, %0[%9] : memref<20xi32>
    }
    %1 = affine.parallel (%arg3) = (0) to (10) reduce ("assign") -> (memref<10xi32>) {
      %3 = pxa.reduce assign %c0_i32, %arg2[%arg3] : memref<10xi32>
      affine.yield %3 : memref<10xi32>
    }
    %2 = affine.parallel (%arg3) = (0) to (10) reduce ("assign") -> (memref<10xi32>) {
      %3 = pxa.load %0[%arg3] : memref<20xi32>
      %4 = pxa.reduce assign %3, %1[%arg3] : memref<10xi32>
      affine.yield %4 : memref<10xi32>
    }
    return %2 : memref<10xi32>
  }
  func @fini(%arg0: !stdx.argpack) {
    stdx.unpack %arg0 : 
    return
  }
}


// *** IR Dump After AffineNormalize *** ('func' operation: @fini)
module @argsort  {
  func @init() -> !stdx.argpack {
    %0 = stdx.pack  : 
    return %0 : !stdx.argpack
  }
  func @main(%arg0: !stdx.argpack, %arg1: memref<20xf32>, %arg2: memref<10xi32>) -> memref<10xi32> {
    %c0_i32 = constant 0 : i32
    stdx.unpack %arg0 : 
    %0 = alloc() : memref<20xi32>
    %c0 = constant 0 : index
    %c1 = constant 1 : index
    %c20 = constant 20 : index
    %c19 = constant 19 : index
    scf.for %arg3 = %c0 to %c20 step %c1 {
      %3 = index_cast %arg3 : index to i32
      store %3, %0[%arg3] : memref<20xi32>
    }
    scf.for %arg3 = %c0 to %c19 step %c1 {
      %3 = alloca() : memref<1xindex>
      store %arg3, %3[%c0] : memref<1xindex>
      %4 = load %0[%arg3] : memref<20xi32>
      %5 = index_cast %4 : i32 to index
      %6 = load %arg1[%5] : memref<20xf32>
      %7 = alloca() : memref<1xf32>
      store %6, %7[%c0] : memref<1xf32>
      %8 = addi %arg3, %c1 : index
      scf.for %arg4 = %8 to %c20 step %c1 {
        %12 = load %0[%arg4] : memref<20xi32>
        %13 = index_cast %12 : i32 to index
        %14 = load %arg1[%13] : memref<20xf32>
        %15 = load %7[%c0] : memref<1xf32>
        %16 = cmpf olt, %14, %15 : f32
        scf.if %16 {
          store %arg4, %3[%c0] : memref<1xindex>
          store %14, %7[%c0] : memref<1xf32>
        }
      }
      %9 = load %3[%c0] : memref<1xindex>
      %10 = load %0[%9] : memref<20xi32>
      %11 = load %0[%arg3] : memref<20xi32>
      store %10, %0[%arg3] : memref<20xi32>
      store %11, %0[%9] : memref<20xi32>
    }
    %1 = affine.parallel (%arg3) = (0) to (10) reduce ("assign") -> (memref<10xi32>) {
      %3 = pxa.reduce assign %c0_i32, %arg2[%arg3] : memref<10xi32>
      affine.yield %3 : memref<10xi32>
    }
    %2 = affine.parallel (%arg3) = (0) to (10) reduce ("assign") -> (memref<10xi32>) {
      %3 = pxa.load %0[%arg3] : memref<20xi32>
      %4 = pxa.reduce assign %3, %1[%arg3] : memref<10xi32>
      affine.yield %4 : memref<10xi32>
    }
    return %2 : memref<10xi32>
  }
  func @fini(%arg0: !stdx.argpack) {
    stdx.unpack %arg0 : 
    return
  }
}


// *** IR Dump After Canonicalizer *** ('module' operation: @argsort)
module @argsort  {
  func @init() -> !stdx.argpack {
    %0 = stdx.pack  : 
    return %0 : !stdx.argpack
  }
  func @main(%arg0: !stdx.argpack, %arg1: memref<20xf32>, %arg2: memref<10xi32>) -> memref<10xi32> {
    %c0_i32 = constant 0 : i32
    %c0 = constant 0 : index
    %c1 = constant 1 : index
    %c20 = constant 20 : index
    %c19 = constant 19 : index
    stdx.unpack %arg0 : 
    %0 = alloc() : memref<20xi32>
    scf.for %arg3 = %c0 to %c20 step %c1 {
      %3 = index_cast %arg3 : index to i32
      store %3, %0[%arg3] : memref<20xi32>
    }
    scf.for %arg3 = %c0 to %c19 step %c1 {
      %3 = alloca() : memref<1xindex>
      store %arg3, %3[%c0] : memref<1xindex>
      %4 = load %0[%arg3] : memref<20xi32>
      %5 = index_cast %4 : i32 to index
      %6 = load %arg1[%5] : memref<20xf32>
      %7 = alloca() : memref<1xf32>
      store %6, %7[%c0] : memref<1xf32>
      %8 = addi %arg3, %c1 : index
      scf.for %arg4 = %8 to %c20 step %c1 {
        %12 = load %0[%arg4] : memref<20xi32>
        %13 = index_cast %12 : i32 to index
        %14 = load %arg1[%13] : memref<20xf32>
        %15 = load %7[%c0] : memref<1xf32>
        %16 = cmpf olt, %14, %15 : f32
        scf.if %16 {
          store %arg4, %3[%c0] : memref<1xindex>
          store %14, %7[%c0] : memref<1xf32>
        }
      }
      %9 = load %3[%c0] : memref<1xindex>
      %10 = load %0[%9] : memref<20xi32>
      %11 = load %0[%arg3] : memref<20xi32>
      store %10, %0[%arg3] : memref<20xi32>
      store %11, %0[%9] : memref<20xi32>
    }
    %1 = affine.parallel (%arg3) = (0) to (10) reduce ("assign") -> (memref<10xi32>) {
      %3 = pxa.reduce assign %c0_i32, %arg2[%arg3] : memref<10xi32>
      affine.yield %3 : memref<10xi32>
    }
    %2 = affine.parallel (%arg3) = (0) to (10) reduce ("assign") -> (memref<10xi32>) {
      %3 = pxa.load %0[%arg3] : memref<20xi32>
      %4 = pxa.reduce assign %3, %1[%arg3] : memref<10xi32>
      affine.yield %4 : memref<10xi32>
    }
    return %2 : memref<10xi32>
  }
  func @fini(%arg0: !stdx.argpack) {
    stdx.unpack %arg0 : 
    return
  }
}


// *** IR Dump After TileAccumulate *** ('func' operation: @init)
module @argsort  {
  func @init() -> !stdx.argpack {
    %0 = stdx.pack  : 
    return %0 : !stdx.argpack
  }
  func @main(%arg0: !stdx.argpack, %arg1: memref<20xf32>, %arg2: memref<10xi32>) -> memref<10xi32> {
    %c0_i32 = constant 0 : i32
    %c0 = constant 0 : index
    %c1 = constant 1 : index
    %c20 = constant 20 : index
    %c19 = constant 19 : index
    stdx.unpack %arg0 : 
    %0 = alloc() : memref<20xi32>
    scf.for %arg3 = %c0 to %c20 step %c1 {
      %3 = index_cast %arg3 : index to i32
      store %3, %0[%arg3] : memref<20xi32>
    }
    scf.for %arg3 = %c0 to %c19 step %c1 {
      %3 = alloca() : memref<1xindex>
      store %arg3, %3[%c0] : memref<1xindex>
      %4 = load %0[%arg3] : memref<20xi32>
      %5 = index_cast %4 : i32 to index
      %6 = load %arg1[%5] : memref<20xf32>
      %7 = alloca() : memref<1xf32>
      store %6, %7[%c0] : memref<1xf32>
      %8 = addi %arg3, %c1 : index
      scf.for %arg4 = %8 to %c20 step %c1 {
        %12 = load %0[%arg4] : memref<20xi32>
        %13 = index_cast %12 : i32 to index
        %14 = load %arg1[%13] : memref<20xf32>
        %15 = load %7[%c0] : memref<1xf32>
        %16 = cmpf olt, %14, %15 : f32
        scf.if %16 {
          store %arg4, %3[%c0] : memref<1xindex>
          store %14, %7[%c0] : memref<1xf32>
        }
      }
      %9 = load %3[%c0] : memref<1xindex>
      %10 = load %0[%9] : memref<20xi32>
      %11 = load %0[%arg3] : memref<20xi32>
      store %10, %0[%arg3] : memref<20xi32>
      store %11, %0[%9] : memref<20xi32>
    }
    %1 = affine.parallel (%arg3) = (0) to (10) reduce ("assign") -> (memref<10xi32>) {
      %3 = pxa.reduce assign %c0_i32, %arg2[%arg3] : memref<10xi32>
      affine.yield %3 : memref<10xi32>
    }
    %2 = affine.parallel (%arg3) = (0) to (10) reduce ("assign") -> (memref<10xi32>) {
      %3 = pxa.load %0[%arg3] : memref<20xi32>
      %4 = pxa.reduce assign %3, %1[%arg3] : memref<10xi32>
      affine.yield %4 : memref<10xi32>
    }
    return %2 : memref<10xi32>
  }
  func @fini(%arg0: !stdx.argpack) {
    stdx.unpack %arg0 : 
    return
  }
}


// *** IR Dump After AffineNormalize *** ('func' operation: @init)
module @argsort  {
  func @init() -> !stdx.argpack {
    %0 = stdx.pack  : 
    return %0 : !stdx.argpack
  }
  func @main(%arg0: !stdx.argpack, %arg1: memref<20xf32>, %arg2: memref<10xi32>) -> memref<10xi32> {
    %c0_i32 = constant 0 : i32
    %c0 = constant 0 : index
    %c1 = constant 1 : index
    %c20 = constant 20 : index
    %c19 = constant 19 : index
    stdx.unpack %arg0 : 
    %0 = alloc() : memref<20xi32>
    scf.for %arg3 = %c0 to %c20 step %c1 {
      %3 = index_cast %arg3 : index to i32
      store %3, %0[%arg3] : memref<20xi32>
    }
    scf.for %arg3 = %c0 to %c19 step %c1 {
      %3 = alloca() : memref<1xindex>
      store %arg3, %3[%c0] : memref<1xindex>
      %4 = load %0[%arg3] : memref<20xi32>
      %5 = index_cast %4 : i32 to index
      %6 = load %arg1[%5] : memref<20xf32>
      %7 = alloca() : memref<1xf32>
      store %6, %7[%c0] : memref<1xf32>
      %8 = addi %arg3, %c1 : index
      scf.for %arg4 = %8 to %c20 step %c1 {
        %12 = load %0[%arg4] : memref<20xi32>
        %13 = index_cast %12 : i32 to index
        %14 = load %arg1[%13] : memref<20xf32>
        %15 = load %7[%c0] : memref<1xf32>
        %16 = cmpf olt, %14, %15 : f32
        scf.if %16 {
          store %arg4, %3[%c0] : memref<1xindex>
          store %14, %7[%c0] : memref<1xf32>
        }
      }
      %9 = load %3[%c0] : memref<1xindex>
      %10 = load %0[%9] : memref<20xi32>
      %11 = load %0[%arg3] : memref<20xi32>
      store %10, %0[%arg3] : memref<20xi32>
      store %11, %0[%9] : memref<20xi32>
    }
    %1 = affine.parallel (%arg3) = (0) to (10) reduce ("assign") -> (memref<10xi32>) {
      %3 = pxa.reduce assign %c0_i32, %arg2[%arg3] : memref<10xi32>
      affine.yield %3 : memref<10xi32>
    }
    %2 = affine.parallel (%arg3) = (0) to (10) reduce ("assign") -> (memref<10xi32>) {
      %3 = pxa.load %0[%arg3] : memref<20xi32>
      %4 = pxa.reduce assign %3, %1[%arg3] : memref<10xi32>
      affine.yield %4 : memref<10xi32>
    }
    return %2 : memref<10xi32>
  }
  func @fini(%arg0: !stdx.argpack) {
    stdx.unpack %arg0 : 
    return
  }
}


// *** IR Dump After TileAccumulate *** ('func' operation: @main)
module @argsort  {
  func @init() -> !stdx.argpack {
    %0 = stdx.pack  : 
    return %0 : !stdx.argpack
  }
  func @main(%arg0: !stdx.argpack, %arg1: memref<20xf32>, %arg2: memref<10xi32>) -> memref<10xi32> {
    %c0_i32 = constant 0 : i32
    %c0 = constant 0 : index
    %c1 = constant 1 : index
    %c20 = constant 20 : index
    %c19 = constant 19 : index
    stdx.unpack %arg0 : 
    %0 = alloc() : memref<20xi32>
    scf.for %arg3 = %c0 to %c20 step %c1 {
      %3 = index_cast %arg3 : index to i32
      store %3, %0[%arg3] : memref<20xi32>
    }
    scf.for %arg3 = %c0 to %c19 step %c1 {
      %3 = alloca() : memref<1xindex>
      store %arg3, %3[%c0] : memref<1xindex>
      %4 = load %0[%arg3] : memref<20xi32>
      %5 = index_cast %4 : i32 to index
      %6 = load %arg1[%5] : memref<20xf32>
      %7 = alloca() : memref<1xf32>
      store %6, %7[%c0] : memref<1xf32>
      %8 = addi %arg3, %c1 : index
      scf.for %arg4 = %8 to %c20 step %c1 {
        %12 = load %0[%arg4] : memref<20xi32>
        %13 = index_cast %12 : i32 to index
        %14 = load %arg1[%13] : memref<20xf32>
        %15 = load %7[%c0] : memref<1xf32>
        %16 = cmpf olt, %14, %15 : f32
        scf.if %16 {
          store %arg4, %3[%c0] : memref<1xindex>
          store %14, %7[%c0] : memref<1xf32>
        }
      }
      %9 = load %3[%c0] : memref<1xindex>
      %10 = load %0[%9] : memref<20xi32>
      %11 = load %0[%arg3] : memref<20xi32>
      store %10, %0[%arg3] : memref<20xi32>
      store %11, %0[%9] : memref<20xi32>
    }
    %1 = affine.parallel (%arg3) = (0) to (10) reduce ("assign") -> (memref<10xi32>) {
      %3 = affine.parallel (%arg4) = (%arg3) to (%arg3 + 1) reduce ("assign") -> (memref<10xi32>) {
        %4 = pxa.reduce assign %c0_i32, %arg2[%arg4] : memref<10xi32>
        affine.yield %4 : memref<10xi32>
      }
      affine.yield %3 : memref<10xi32>
    }
    %2 = affine.parallel (%arg3) = (0) to (10) reduce ("assign") -> (memref<10xi32>) {
      %3 = affine.parallel (%arg4) = (%arg3) to (%arg3 + 1) reduce ("assign") -> (memref<10xi32>) {
        %4 = pxa.load %0[%arg4] : memref<20xi32>
        %5 = pxa.reduce assign %4, %1[%arg4] : memref<10xi32>
        affine.yield %5 : memref<10xi32>
      }
      affine.yield %3 : memref<10xi32>
    }
    return %2 : memref<10xi32>
  }
  func @fini(%arg0: !stdx.argpack) {
    stdx.unpack %arg0 : 
    return
  }
}


// *** IR Dump After AffineNormalize *** ('func' operation: @main)
#map0 = affine_map<() -> (0)>
#map1 = affine_map<(d0, d1) -> (d0 + d1)>
module @argsort  {
  func @init() -> !stdx.argpack {
    %0 = stdx.pack  : 
    return %0 : !stdx.argpack
  }
  func @main(%arg0: !stdx.argpack, %arg1: memref<20xf32>, %arg2: memref<10xi32>) -> memref<10xi32> {
    %c0_i32 = constant 0 : i32
    %c0 = constant 0 : index
    %c1 = constant 1 : index
    %c20 = constant 20 : index
    %c19 = constant 19 : index
    stdx.unpack %arg0 : 
    %0 = alloc() : memref<20xi32>
    scf.for %arg3 = %c0 to %c20 step %c1 {
      %3 = index_cast %arg3 : index to i32
      store %3, %0[%arg3] : memref<20xi32>
    }
    scf.for %arg3 = %c0 to %c19 step %c1 {
      %3 = alloca() : memref<1xindex>
      store %arg3, %3[%c0] : memref<1xindex>
      %4 = load %0[%arg3] : memref<20xi32>
      %5 = index_cast %4 : i32 to index
      %6 = load %arg1[%5] : memref<20xf32>
      %7 = alloca() : memref<1xf32>
      store %6, %7[%c0] : memref<1xf32>
      %8 = addi %arg3, %c1 : index
      scf.for %arg4 = %8 to %c20 step %c1 {
        %12 = load %0[%arg4] : memref<20xi32>
        %13 = index_cast %12 : i32 to index
        %14 = load %arg1[%13] : memref<20xf32>
        %15 = load %7[%c0] : memref<1xf32>
        %16 = cmpf olt, %14, %15 : f32
        scf.if %16 {
          store %arg4, %3[%c0] : memref<1xindex>
          store %14, %7[%c0] : memref<1xf32>
        }
      }
      %9 = load %3[%c0] : memref<1xindex>
      %10 = load %0[%9] : memref<20xi32>
      %11 = load %0[%arg3] : memref<20xi32>
      store %10, %0[%arg3] : memref<20xi32>
      store %11, %0[%9] : memref<20xi32>
    }
    %1 = affine.parallel (%arg3) = (0) to (10) reduce ("assign") -> (memref<10xi32>) {
      %3 = affine.parallel () = () to () reduce ("assign") -> (memref<10xi32>) {
        %4 = affine.apply #map0()
        %5 = affine.apply #map1(%arg3, %4)
        %6 = pxa.reduce assign %c0_i32, %arg2[%5] : memref<10xi32>
        affine.yield %6 : memref<10xi32>
      }
      affine.yield %3 : memref<10xi32>
    }
    %2 = affine.parallel (%arg3) = (0) to (10) reduce ("assign") -> (memref<10xi32>) {
      %3 = affine.parallel () = () to () reduce ("assign") -> (memref<10xi32>) {
        %4 = affine.apply #map0()
        %5 = affine.apply #map1(%arg3, %4)
        %6 = pxa.load %0[%5] : memref<20xi32>
        %7 = pxa.reduce assign %6, %1[%5] : memref<10xi32>
        affine.yield %7 : memref<10xi32>
      }
      affine.yield %3 : memref<10xi32>
    }
    return %2 : memref<10xi32>
  }
  func @fini(%arg0: !stdx.argpack) {
    stdx.unpack %arg0 : 
    return
  }
}


// *** IR Dump After TileAccumulate *** ('func' operation: @fini)
#map0 = affine_map<() -> (0)>
#map1 = affine_map<(d0, d1) -> (d0 + d1)>
module @argsort  {
  func @init() -> !stdx.argpack {
    %0 = stdx.pack  : 
    return %0 : !stdx.argpack
  }
  func @main(%arg0: !stdx.argpack, %arg1: memref<20xf32>, %arg2: memref<10xi32>) -> memref<10xi32> {
    %c0_i32 = constant 0 : i32
    %c0 = constant 0 : index
    %c1 = constant 1 : index
    %c20 = constant 20 : index
    %c19 = constant 19 : index
    stdx.unpack %arg0 : 
    %0 = alloc() : memref<20xi32>
    scf.for %arg3 = %c0 to %c20 step %c1 {
      %3 = index_cast %arg3 : index to i32
      store %3, %0[%arg3] : memref<20xi32>
    }
    scf.for %arg3 = %c0 to %c19 step %c1 {
      %3 = alloca() : memref<1xindex>
      store %arg3, %3[%c0] : memref<1xindex>
      %4 = load %0[%arg3] : memref<20xi32>
      %5 = index_cast %4 : i32 to index
      %6 = load %arg1[%5] : memref<20xf32>
      %7 = alloca() : memref<1xf32>
      store %6, %7[%c0] : memref<1xf32>
      %8 = addi %arg3, %c1 : index
      scf.for %arg4 = %8 to %c20 step %c1 {
        %12 = load %0[%arg4] : memref<20xi32>
        %13 = index_cast %12 : i32 to index
        %14 = load %arg1[%13] : memref<20xf32>
        %15 = load %7[%c0] : memref<1xf32>
        %16 = cmpf olt, %14, %15 : f32
        scf.if %16 {
          store %arg4, %3[%c0] : memref<1xindex>
          store %14, %7[%c0] : memref<1xf32>
        }
      }
      %9 = load %3[%c0] : memref<1xindex>
      %10 = load %0[%9] : memref<20xi32>
      %11 = load %0[%arg3] : memref<20xi32>
      store %10, %0[%arg3] : memref<20xi32>
      store %11, %0[%9] : memref<20xi32>
    }
    %1 = affine.parallel (%arg3) = (0) to (10) reduce ("assign") -> (memref<10xi32>) {
      %3 = affine.parallel () = () to () reduce ("assign") -> (memref<10xi32>) {
        %4 = affine.apply #map0()
        %5 = affine.apply #map1(%arg3, %4)
        %6 = pxa.reduce assign %c0_i32, %arg2[%5] : memref<10xi32>
        affine.yield %6 : memref<10xi32>
      }
      affine.yield %3 : memref<10xi32>
    }
    %2 = affine.parallel (%arg3) = (0) to (10) reduce ("assign") -> (memref<10xi32>) {
      %3 = affine.parallel () = () to () reduce ("assign") -> (memref<10xi32>) {
        %4 = affine.apply #map0()
        %5 = affine.apply #map1(%arg3, %4)
        %6 = pxa.load %0[%5] : memref<20xi32>
        %7 = pxa.reduce assign %6, %1[%5] : memref<10xi32>
        affine.yield %7 : memref<10xi32>
      }
      affine.yield %3 : memref<10xi32>
    }
    return %2 : memref<10xi32>
  }
  func @fini(%arg0: !stdx.argpack) {
    stdx.unpack %arg0 : 
    return
  }
}


// *** IR Dump After AffineNormalize *** ('func' operation: @fini)
#map0 = affine_map<() -> (0)>
#map1 = affine_map<(d0, d1) -> (d0 + d1)>
module @argsort  {
  func @init() -> !stdx.argpack {
    %0 = stdx.pack  : 
    return %0 : !stdx.argpack
  }
  func @main(%arg0: !stdx.argpack, %arg1: memref<20xf32>, %arg2: memref<10xi32>) -> memref<10xi32> {
    %c0_i32 = constant 0 : i32
    %c0 = constant 0 : index
    %c1 = constant 1 : index
    %c20 = constant 20 : index
    %c19 = constant 19 : index
    stdx.unpack %arg0 : 
    %0 = alloc() : memref<20xi32>
    scf.for %arg3 = %c0 to %c20 step %c1 {
      %3 = index_cast %arg3 : index to i32
      store %3, %0[%arg3] : memref<20xi32>
    }
    scf.for %arg3 = %c0 to %c19 step %c1 {
      %3 = alloca() : memref<1xindex>
      store %arg3, %3[%c0] : memref<1xindex>
      %4 = load %0[%arg3] : memref<20xi32>
      %5 = index_cast %4 : i32 to index
      %6 = load %arg1[%5] : memref<20xf32>
      %7 = alloca() : memref<1xf32>
      store %6, %7[%c0] : memref<1xf32>
      %8 = addi %arg3, %c1 : index
      scf.for %arg4 = %8 to %c20 step %c1 {
        %12 = load %0[%arg4] : memref<20xi32>
        %13 = index_cast %12 : i32 to index
        %14 = load %arg1[%13] : memref<20xf32>
        %15 = load %7[%c0] : memref<1xf32>
        %16 = cmpf olt, %14, %15 : f32
        scf.if %16 {
          store %arg4, %3[%c0] : memref<1xindex>
          store %14, %7[%c0] : memref<1xf32>
        }
      }
      %9 = load %3[%c0] : memref<1xindex>
      %10 = load %0[%9] : memref<20xi32>
      %11 = load %0[%arg3] : memref<20xi32>
      store %10, %0[%arg3] : memref<20xi32>
      store %11, %0[%9] : memref<20xi32>
    }
    %1 = affine.parallel (%arg3) = (0) to (10) reduce ("assign") -> (memref<10xi32>) {
      %3 = affine.parallel () = () to () reduce ("assign") -> (memref<10xi32>) {
        %4 = affine.apply #map0()
        %5 = affine.apply #map1(%arg3, %4)
        %6 = pxa.reduce assign %c0_i32, %arg2[%5] : memref<10xi32>
        affine.yield %6 : memref<10xi32>
      }
      affine.yield %3 : memref<10xi32>
    }
    %2 = affine.parallel (%arg3) = (0) to (10) reduce ("assign") -> (memref<10xi32>) {
      %3 = affine.parallel () = () to () reduce ("assign") -> (memref<10xi32>) {
        %4 = affine.apply #map0()
        %5 = affine.apply #map1(%arg3, %4)
        %6 = pxa.load %0[%5] : memref<20xi32>
        %7 = pxa.reduce assign %6, %1[%5] : memref<10xi32>
        affine.yield %7 : memref<10xi32>
      }
      affine.yield %3 : memref<10xi32>
    }
    return %2 : memref<10xi32>
  }
  func @fini(%arg0: !stdx.argpack) {
    stdx.unpack %arg0 : 
    return
  }
}


// *** IR Dump After Canonicalizer *** ('module' operation: @argsort)
module @argsort  {
  func @init() -> !stdx.argpack {
    %0 = stdx.pack  : 
    return %0 : !stdx.argpack
  }
  func @main(%arg0: !stdx.argpack, %arg1: memref<20xf32>, %arg2: memref<10xi32>) -> memref<10xi32> {
    %c0_i32 = constant 0 : i32
    %c0 = constant 0 : index
    %c1 = constant 1 : index
    %c20 = constant 20 : index
    %c19 = constant 19 : index
    stdx.unpack %arg0 : 
    %0 = alloc() : memref<20xi32>
    scf.for %arg3 = %c0 to %c20 step %c1 {
      %3 = index_cast %arg3 : index to i32
      store %3, %0[%arg3] : memref<20xi32>
    }
    scf.for %arg3 = %c0 to %c19 step %c1 {
      %3 = alloca() : memref<1xindex>
      store %arg3, %3[%c0] : memref<1xindex>
      %4 = load %0[%arg3] : memref<20xi32>
      %5 = index_cast %4 : i32 to index
      %6 = load %arg1[%5] : memref<20xf32>
      %7 = alloca() : memref<1xf32>
      store %6, %7[%c0] : memref<1xf32>
      %8 = addi %arg3, %c1 : index
      scf.for %arg4 = %8 to %c20 step %c1 {
        %12 = load %0[%arg4] : memref<20xi32>
        %13 = index_cast %12 : i32 to index
        %14 = load %arg1[%13] : memref<20xf32>
        %15 = load %7[%c0] : memref<1xf32>
        %16 = cmpf olt, %14, %15 : f32
        scf.if %16 {
          store %arg4, %3[%c0] : memref<1xindex>
          store %14, %7[%c0] : memref<1xf32>
        }
      }
      %9 = load %3[%c0] : memref<1xindex>
      %10 = load %0[%9] : memref<20xi32>
      %11 = load %0[%arg3] : memref<20xi32>
      store %10, %0[%arg3] : memref<20xi32>
      store %11, %0[%9] : memref<20xi32>
    }
    %1 = affine.parallel (%arg3) = (0) to (10) reduce ("assign") -> (memref<10xi32>) {
      %3 = affine.parallel () = () to () reduce ("assign") -> (memref<10xi32>) {
        %4 = pxa.reduce assign %c0_i32, %arg2[%arg3] : memref<10xi32>
        affine.yield %4 : memref<10xi32>
      }
      affine.yield %3 : memref<10xi32>
    }
    %2 = affine.parallel (%arg3) = (0) to (10) reduce ("assign") -> (memref<10xi32>) {
      %3 = affine.parallel () = () to () reduce ("assign") -> (memref<10xi32>) {
        %4 = pxa.load %0[%arg3] : memref<20xi32>
        %5 = pxa.reduce assign %4, %1[%arg3] : memref<10xi32>
        affine.yield %5 : memref<10xi32>
      }
      affine.yield %3 : memref<10xi32>
    }
    return %2 : memref<10xi32>
  }
  func @fini(%arg0: !stdx.argpack) {
    stdx.unpack %arg0 : 
    return
  }
}


// *** IR Dump After CPUThread *** ('func' operation: @init)
module @argsort  {
  func @init() -> !stdx.argpack {
    %0 = stdx.pack  : 
    return %0 : !stdx.argpack
  }
  func @main(%arg0: !stdx.argpack, %arg1: memref<20xf32>, %arg2: memref<10xi32>) -> memref<10xi32> {
    %c0_i32 = constant 0 : i32
    %c0 = constant 0 : index
    %c1 = constant 1 : index
    %c20 = constant 20 : index
    %c19 = constant 19 : index
    stdx.unpack %arg0 : 
    %0 = alloc() : memref<20xi32>
    scf.for %arg3 = %c0 to %c20 step %c1 {
      %3 = index_cast %arg3 : index to i32
      store %3, %0[%arg3] : memref<20xi32>
    }
    scf.for %arg3 = %c0 to %c19 step %c1 {
      %3 = alloca() : memref<1xindex>
      store %arg3, %3[%c0] : memref<1xindex>
      %4 = load %0[%arg3] : memref<20xi32>
      %5 = index_cast %4 : i32 to index
      %6 = load %arg1[%5] : memref<20xf32>
      %7 = alloca() : memref<1xf32>
      store %6, %7[%c0] : memref<1xf32>
      %8 = addi %arg3, %c1 : index
      scf.for %arg4 = %8 to %c20 step %c1 {
        %12 = load %0[%arg4] : memref<20xi32>
        %13 = index_cast %12 : i32 to index
        %14 = load %arg1[%13] : memref<20xf32>
        %15 = load %7[%c0] : memref<1xf32>
        %16 = cmpf olt, %14, %15 : f32
        scf.if %16 {
          store %arg4, %3[%c0] : memref<1xindex>
          store %14, %7[%c0] : memref<1xf32>
        }
      }
      %9 = load %3[%c0] : memref<1xindex>
      %10 = load %0[%9] : memref<20xi32>
      %11 = load %0[%arg3] : memref<20xi32>
      store %10, %0[%arg3] : memref<20xi32>
      store %11, %0[%9] : memref<20xi32>
    }
    %1 = affine.parallel (%arg3) = (0) to (10) reduce ("assign") -> (memref<10xi32>) {
      %3 = affine.parallel () = () to () reduce ("assign") -> (memref<10xi32>) {
        %4 = pxa.reduce assign %c0_i32, %arg2[%arg3] : memref<10xi32>
        affine.yield %4 : memref<10xi32>
      }
      affine.yield %3 : memref<10xi32>
    }
    %2 = affine.parallel (%arg3) = (0) to (10) reduce ("assign") -> (memref<10xi32>) {
      %3 = affine.parallel () = () to () reduce ("assign") -> (memref<10xi32>) {
        %4 = pxa.load %0[%arg3] : memref<20xi32>
        %5 = pxa.reduce assign %4, %1[%arg3] : memref<10xi32>
        affine.yield %5 : memref<10xi32>
      }
      affine.yield %3 : memref<10xi32>
    }
    return %2 : memref<10xi32>
  }
  func @fini(%arg0: !stdx.argpack) {
    stdx.unpack %arg0 : 
    return
  }
}


// *** IR Dump After AffineNormalize *** ('func' operation: @init)
module @argsort  {
  func @init() -> !stdx.argpack {
    %0 = stdx.pack  : 
    return %0 : !stdx.argpack
  }
  func @main(%arg0: !stdx.argpack, %arg1: memref<20xf32>, %arg2: memref<10xi32>) -> memref<10xi32> {
    %c0_i32 = constant 0 : i32
    %c0 = constant 0 : index
    %c1 = constant 1 : index
    %c20 = constant 20 : index
    %c19 = constant 19 : index
    stdx.unpack %arg0 : 
    %0 = alloc() : memref<20xi32>
    scf.for %arg3 = %c0 to %c20 step %c1 {
      %3 = index_cast %arg3 : index to i32
      store %3, %0[%arg3] : memref<20xi32>
    }
    scf.for %arg3 = %c0 to %c19 step %c1 {
      %3 = alloca() : memref<1xindex>
      store %arg3, %3[%c0] : memref<1xindex>
      %4 = load %0[%arg3] : memref<20xi32>
      %5 = index_cast %4 : i32 to index
      %6 = load %arg1[%5] : memref<20xf32>
      %7 = alloca() : memref<1xf32>
      store %6, %7[%c0] : memref<1xf32>
      %8 = addi %arg3, %c1 : index
      scf.for %arg4 = %8 to %c20 step %c1 {
        %12 = load %0[%arg4] : memref<20xi32>
        %13 = index_cast %12 : i32 to index
        %14 = load %arg1[%13] : memref<20xf32>
        %15 = load %7[%c0] : memref<1xf32>
        %16 = cmpf olt, %14, %15 : f32
        scf.if %16 {
          store %arg4, %3[%c0] : memref<1xindex>
          store %14, %7[%c0] : memref<1xf32>
        }
      }
      %9 = load %3[%c0] : memref<1xindex>
      %10 = load %0[%9] : memref<20xi32>
      %11 = load %0[%arg3] : memref<20xi32>
      store %10, %0[%arg3] : memref<20xi32>
      store %11, %0[%9] : memref<20xi32>
    }
    %1 = affine.parallel (%arg3) = (0) to (10) reduce ("assign") -> (memref<10xi32>) {
      %3 = affine.parallel () = () to () reduce ("assign") -> (memref<10xi32>) {
        %4 = pxa.reduce assign %c0_i32, %arg2[%arg3] : memref<10xi32>
        affine.yield %4 : memref<10xi32>
      }
      affine.yield %3 : memref<10xi32>
    }
    %2 = affine.parallel (%arg3) = (0) to (10) reduce ("assign") -> (memref<10xi32>) {
      %3 = affine.parallel () = () to () reduce ("assign") -> (memref<10xi32>) {
        %4 = pxa.load %0[%arg3] : memref<20xi32>
        %5 = pxa.reduce assign %4, %1[%arg3] : memref<10xi32>
        affine.yield %5 : memref<10xi32>
      }
      affine.yield %3 : memref<10xi32>
    }
    return %2 : memref<10xi32>
  }
  func @fini(%arg0: !stdx.argpack) {
    stdx.unpack %arg0 : 
    return
  }
}


// *** IR Dump After CPUThread *** ('func' operation: @main)
module @argsort  {
  func @init() -> !stdx.argpack {
    %0 = stdx.pack  : 
    return %0 : !stdx.argpack
  }
  func @main(%arg0: !stdx.argpack, %arg1: memref<20xf32>, %arg2: memref<10xi32>) -> memref<10xi32> {
    %c0_i32 = constant 0 : i32
    %c0 = constant 0 : index
    %c1 = constant 1 : index
    %c20 = constant 20 : index
    %c19 = constant 19 : index
    stdx.unpack %arg0 : 
    %0 = alloc() : memref<20xi32>
    scf.for %arg3 = %c0 to %c20 step %c1 {
      %3 = index_cast %arg3 : index to i32
      store %3, %0[%arg3] : memref<20xi32>
    }
    scf.for %arg3 = %c0 to %c19 step %c1 {
      %3 = alloca() : memref<1xindex>
      store %arg3, %3[%c0] : memref<1xindex>
      %4 = load %0[%arg3] : memref<20xi32>
      %5 = index_cast %4 : i32 to index
      %6 = load %arg1[%5] : memref<20xf32>
      %7 = alloca() : memref<1xf32>
      store %6, %7[%c0] : memref<1xf32>
      %8 = addi %arg3, %c1 : index
      scf.for %arg4 = %8 to %c20 step %c1 {
        %12 = load %0[%arg4] : memref<20xi32>
        %13 = index_cast %12 : i32 to index
        %14 = load %arg1[%13] : memref<20xf32>
        %15 = load %7[%c0] : memref<1xf32>
        %16 = cmpf olt, %14, %15 : f32
        scf.if %16 {
          store %arg4, %3[%c0] : memref<1xindex>
          store %14, %7[%c0] : memref<1xf32>
        }
      }
      %9 = load %3[%c0] : memref<1xindex>
      %10 = load %0[%9] : memref<20xi32>
      %11 = load %0[%arg3] : memref<20xi32>
      store %10, %0[%arg3] : memref<20xi32>
      store %11, %0[%9] : memref<20xi32>
    }
    %1 = affine.parallel (%arg3) = (0) to (10) reduce ("assign") -> (memref<10xi32>) {
      %3 = affine.parallel (%arg4) = (%arg3) to (%arg3 + 1) reduce ("assign") -> (memref<10xi32>) {
        %4 = affine.parallel () = () to () reduce ("assign") -> (memref<10xi32>) {
          %5 = pxa.reduce assign %c0_i32, %arg2[%arg4] : memref<10xi32>
          affine.yield %5 : memref<10xi32>
        }
        affine.yield %4 : memref<10xi32>
      }
      affine.yield %3 : memref<10xi32>
    } {tags = {cpuThread}}
    %2 = affine.parallel (%arg3) = (0) to (10) reduce ("assign") -> (memref<10xi32>) {
      %3 = affine.parallel (%arg4) = (%arg3) to (%arg3 + 1) reduce ("assign") -> (memref<10xi32>) {
        %4 = affine.parallel () = () to () reduce ("assign") -> (memref<10xi32>) {
          %5 = pxa.load %0[%arg4] : memref<20xi32>
          %6 = pxa.reduce assign %5, %1[%arg4] : memref<10xi32>
          affine.yield %6 : memref<10xi32>
        }
        affine.yield %4 : memref<10xi32>
      }
      affine.yield %3 : memref<10xi32>
    } {tags = {cpuThread}}
    return %2 : memref<10xi32>
  }
  func @fini(%arg0: !stdx.argpack) {
    stdx.unpack %arg0 : 
    return
  }
}


// *** IR Dump After AffineNormalize *** ('func' operation: @main)
#map0 = affine_map<() -> (0)>
#map1 = affine_map<(d0, d1) -> (d0 + d1)>
module @argsort  {
  func @init() -> !stdx.argpack {
    %0 = stdx.pack  : 
    return %0 : !stdx.argpack
  }
  func @main(%arg0: !stdx.argpack, %arg1: memref<20xf32>, %arg2: memref<10xi32>) -> memref<10xi32> {
    %c0_i32 = constant 0 : i32
    %c0 = constant 0 : index
    %c1 = constant 1 : index
    %c20 = constant 20 : index
    %c19 = constant 19 : index
    stdx.unpack %arg0 : 
    %0 = alloc() : memref<20xi32>
    scf.for %arg3 = %c0 to %c20 step %c1 {
      %3 = index_cast %arg3 : index to i32
      store %3, %0[%arg3] : memref<20xi32>
    }
    scf.for %arg3 = %c0 to %c19 step %c1 {
      %3 = alloca() : memref<1xindex>
      store %arg3, %3[%c0] : memref<1xindex>
      %4 = load %0[%arg3] : memref<20xi32>
      %5 = index_cast %4 : i32 to index
      %6 = load %arg1[%5] : memref<20xf32>
      %7 = alloca() : memref<1xf32>
      store %6, %7[%c0] : memref<1xf32>
      %8 = addi %arg3, %c1 : index
      scf.for %arg4 = %8 to %c20 step %c1 {
        %12 = load %0[%arg4] : memref<20xi32>
        %13 = index_cast %12 : i32 to index
        %14 = load %arg1[%13] : memref<20xf32>
        %15 = load %7[%c0] : memref<1xf32>
        %16 = cmpf olt, %14, %15 : f32
        scf.if %16 {
          store %arg4, %3[%c0] : memref<1xindex>
          store %14, %7[%c0] : memref<1xf32>
        }
      }
      %9 = load %3[%c0] : memref<1xindex>
      %10 = load %0[%9] : memref<20xi32>
      %11 = load %0[%arg3] : memref<20xi32>
      store %10, %0[%arg3] : memref<20xi32>
      store %11, %0[%9] : memref<20xi32>
    }
    %1 = affine.parallel (%arg3) = (0) to (10) reduce ("assign") -> (memref<10xi32>) {
      %3 = affine.apply #map0()
      %4 = affine.apply #map1(%arg3, %3)
      %5 = pxa.reduce assign %c0_i32, %arg2[%4] : memref<10xi32>
      affine.yield %5 : memref<10xi32>
    } {tags = {cpuThread}}
    %2 = affine.parallel (%arg3) = (0) to (10) reduce ("assign") -> (memref<10xi32>) {
      %3 = affine.apply #map0()
      %4 = affine.apply #map1(%arg3, %3)
      %5 = pxa.load %0[%4] : memref<20xi32>
      %6 = pxa.reduce assign %5, %1[%4] : memref<10xi32>
      affine.yield %6 : memref<10xi32>
    } {tags = {cpuThread}}
    return %2 : memref<10xi32>
  }
  func @fini(%arg0: !stdx.argpack) {
    stdx.unpack %arg0 : 
    return
  }
}


// *** IR Dump After CPUThread *** ('func' operation: @fini)
#map0 = affine_map<() -> (0)>
#map1 = affine_map<(d0, d1) -> (d0 + d1)>
module @argsort  {
  func @init() -> !stdx.argpack {
    %0 = stdx.pack  : 
    return %0 : !stdx.argpack
  }
  func @main(%arg0: !stdx.argpack, %arg1: memref<20xf32>, %arg2: memref<10xi32>) -> memref<10xi32> {
    %c0_i32 = constant 0 : i32
    %c0 = constant 0 : index
    %c1 = constant 1 : index
    %c20 = constant 20 : index
    %c19 = constant 19 : index
    stdx.unpack %arg0 : 
    %0 = alloc() : memref<20xi32>
    scf.for %arg3 = %c0 to %c20 step %c1 {
      %3 = index_cast %arg3 : index to i32
      store %3, %0[%arg3] : memref<20xi32>
    }
    scf.for %arg3 = %c0 to %c19 step %c1 {
      %3 = alloca() : memref<1xindex>
      store %arg3, %3[%c0] : memref<1xindex>
      %4 = load %0[%arg3] : memref<20xi32>
      %5 = index_cast %4 : i32 to index
      %6 = load %arg1[%5] : memref<20xf32>
      %7 = alloca() : memref<1xf32>
      store %6, %7[%c0] : memref<1xf32>
      %8 = addi %arg3, %c1 : index
      scf.for %arg4 = %8 to %c20 step %c1 {
        %12 = load %0[%arg4] : memref<20xi32>
        %13 = index_cast %12 : i32 to index
        %14 = load %arg1[%13] : memref<20xf32>
        %15 = load %7[%c0] : memref<1xf32>
        %16 = cmpf olt, %14, %15 : f32
        scf.if %16 {
          store %arg4, %3[%c0] : memref<1xindex>
          store %14, %7[%c0] : memref<1xf32>
        }
      }
      %9 = load %3[%c0] : memref<1xindex>
      %10 = load %0[%9] : memref<20xi32>
      %11 = load %0[%arg3] : memref<20xi32>
      store %10, %0[%arg3] : memref<20xi32>
      store %11, %0[%9] : memref<20xi32>
    }
    %1 = affine.parallel (%arg3) = (0) to (10) reduce ("assign") -> (memref<10xi32>) {
      %3 = affine.apply #map0()
      %4 = affine.apply #map1(%arg3, %3)
      %5 = pxa.reduce assign %c0_i32, %arg2[%4] : memref<10xi32>
      affine.yield %5 : memref<10xi32>
    } {tags = {cpuThread}}
    %2 = affine.parallel (%arg3) = (0) to (10) reduce ("assign") -> (memref<10xi32>) {
      %3 = affine.apply #map0()
      %4 = affine.apply #map1(%arg3, %3)
      %5 = pxa.load %0[%4] : memref<20xi32>
      %6 = pxa.reduce assign %5, %1[%4] : memref<10xi32>
      affine.yield %6 : memref<10xi32>
    } {tags = {cpuThread}}
    return %2 : memref<10xi32>
  }
  func @fini(%arg0: !stdx.argpack) {
    stdx.unpack %arg0 : 
    return
  }
}


// *** IR Dump After AffineNormalize *** ('func' operation: @fini)
#map0 = affine_map<() -> (0)>
#map1 = affine_map<(d0, d1) -> (d0 + d1)>
module @argsort  {
  func @init() -> !stdx.argpack {
    %0 = stdx.pack  : 
    return %0 : !stdx.argpack
  }
  func @main(%arg0: !stdx.argpack, %arg1: memref<20xf32>, %arg2: memref<10xi32>) -> memref<10xi32> {
    %c0_i32 = constant 0 : i32
    %c0 = constant 0 : index
    %c1 = constant 1 : index
    %c20 = constant 20 : index
    %c19 = constant 19 : index
    stdx.unpack %arg0 : 
    %0 = alloc() : memref<20xi32>
    scf.for %arg3 = %c0 to %c20 step %c1 {
      %3 = index_cast %arg3 : index to i32
      store %3, %0[%arg3] : memref<20xi32>
    }
    scf.for %arg3 = %c0 to %c19 step %c1 {
      %3 = alloca() : memref<1xindex>
      store %arg3, %3[%c0] : memref<1xindex>
      %4 = load %0[%arg3] : memref<20xi32>
      %5 = index_cast %4 : i32 to index
      %6 = load %arg1[%5] : memref<20xf32>
      %7 = alloca() : memref<1xf32>
      store %6, %7[%c0] : memref<1xf32>
      %8 = addi %arg3, %c1 : index
      scf.for %arg4 = %8 to %c20 step %c1 {
        %12 = load %0[%arg4] : memref<20xi32>
        %13 = index_cast %12 : i32 to index
        %14 = load %arg1[%13] : memref<20xf32>
        %15 = load %7[%c0] : memref<1xf32>
        %16 = cmpf olt, %14, %15 : f32
        scf.if %16 {
          store %arg4, %3[%c0] : memref<1xindex>
          store %14, %7[%c0] : memref<1xf32>
        }
      }
      %9 = load %3[%c0] : memref<1xindex>
      %10 = load %0[%9] : memref<20xi32>
      %11 = load %0[%arg3] : memref<20xi32>
      store %10, %0[%arg3] : memref<20xi32>
      store %11, %0[%9] : memref<20xi32>
    }
    %1 = affine.parallel (%arg3) = (0) to (10) reduce ("assign") -> (memref<10xi32>) {
      %3 = affine.apply #map0()
      %4 = affine.apply #map1(%arg3, %3)
      %5 = pxa.reduce assign %c0_i32, %arg2[%4] : memref<10xi32>
      affine.yield %5 : memref<10xi32>
    } {tags = {cpuThread}}
    %2 = affine.parallel (%arg3) = (0) to (10) reduce ("assign") -> (memref<10xi32>) {
      %3 = affine.apply #map0()
      %4 = affine.apply #map1(%arg3, %3)
      %5 = pxa.load %0[%4] : memref<20xi32>
      %6 = pxa.reduce assign %5, %1[%4] : memref<10xi32>
      affine.yield %6 : memref<10xi32>
    } {tags = {cpuThread}}
    return %2 : memref<10xi32>
  }
  func @fini(%arg0: !stdx.argpack) {
    stdx.unpack %arg0 : 
    return
  }
}


// *** IR Dump After Canonicalizer *** ('module' operation: @argsort)
module @argsort  {
  func @init() -> !stdx.argpack {
    %0 = stdx.pack  : 
    return %0 : !stdx.argpack
  }
  func @main(%arg0: !stdx.argpack, %arg1: memref<20xf32>, %arg2: memref<10xi32>) -> memref<10xi32> {
    %c0_i32 = constant 0 : i32
    %c0 = constant 0 : index
    %c1 = constant 1 : index
    %c20 = constant 20 : index
    %c19 = constant 19 : index
    stdx.unpack %arg0 : 
    %0 = alloc() : memref<20xi32>
    scf.for %arg3 = %c0 to %c20 step %c1 {
      %3 = index_cast %arg3 : index to i32
      store %3, %0[%arg3] : memref<20xi32>
    }
    scf.for %arg3 = %c0 to %c19 step %c1 {
      %3 = alloca() : memref<1xindex>
      store %arg3, %3[%c0] : memref<1xindex>
      %4 = load %0[%arg3] : memref<20xi32>
      %5 = index_cast %4 : i32 to index
      %6 = load %arg1[%5] : memref<20xf32>
      %7 = alloca() : memref<1xf32>
      store %6, %7[%c0] : memref<1xf32>
      %8 = addi %arg3, %c1 : index
      scf.for %arg4 = %8 to %c20 step %c1 {
        %12 = load %0[%arg4] : memref<20xi32>
        %13 = index_cast %12 : i32 to index
        %14 = load %arg1[%13] : memref<20xf32>
        %15 = load %7[%c0] : memref<1xf32>
        %16 = cmpf olt, %14, %15 : f32
        scf.if %16 {
          store %arg4, %3[%c0] : memref<1xindex>
          store %14, %7[%c0] : memref<1xf32>
        }
      }
      %9 = load %3[%c0] : memref<1xindex>
      %10 = load %0[%9] : memref<20xi32>
      %11 = load %0[%arg3] : memref<20xi32>
      store %10, %0[%arg3] : memref<20xi32>
      store %11, %0[%9] : memref<20xi32>
    }
    %1 = affine.parallel (%arg3) = (0) to (10) reduce ("assign") -> (memref<10xi32>) {
      %3 = pxa.reduce assign %c0_i32, %arg2[%arg3] : memref<10xi32>
      affine.yield %3 : memref<10xi32>
    } {tags = {cpuThread}}
    %2 = affine.parallel (%arg3) = (0) to (10) reduce ("assign") -> (memref<10xi32>) {
      %3 = pxa.load %0[%arg3] : memref<20xi32>
      %4 = pxa.reduce assign %3, %1[%arg3] : memref<10xi32>
      affine.yield %4 : memref<10xi32>
    } {tags = {cpuThread}}
    return %2 : memref<10xi32>
  }
  func @fini(%arg0: !stdx.argpack) {
    stdx.unpack %arg0 : 
    return
  }
}


// *** IR Dump After Fusion *** ('func' operation: @init)
module @argsort  {
  func @init() -> !stdx.argpack {
    %0 = stdx.pack  : 
    return %0 : !stdx.argpack
  }
  func @main(%arg0: !stdx.argpack, %arg1: memref<20xf32>, %arg2: memref<10xi32>) -> memref<10xi32> {
    %c0_i32 = constant 0 : i32
    %c0 = constant 0 : index
    %c1 = constant 1 : index
    %c20 = constant 20 : index
    %c19 = constant 19 : index
    stdx.unpack %arg0 : 
    %0 = alloc() : memref<20xi32>
    scf.for %arg3 = %c0 to %c20 step %c1 {
      %3 = index_cast %arg3 : index to i32
      store %3, %0[%arg3] : memref<20xi32>
    }
    scf.for %arg3 = %c0 to %c19 step %c1 {
      %3 = alloca() : memref<1xindex>
      store %arg3, %3[%c0] : memref<1xindex>
      %4 = load %0[%arg3] : memref<20xi32>
      %5 = index_cast %4 : i32 to index
      %6 = load %arg1[%5] : memref<20xf32>
      %7 = alloca() : memref<1xf32>
      store %6, %7[%c0] : memref<1xf32>
      %8 = addi %arg3, %c1 : index
      scf.for %arg4 = %8 to %c20 step %c1 {
        %12 = load %0[%arg4] : memref<20xi32>
        %13 = index_cast %12 : i32 to index
        %14 = load %arg1[%13] : memref<20xf32>
        %15 = load %7[%c0] : memref<1xf32>
        %16 = cmpf olt, %14, %15 : f32
        scf.if %16 {
          store %arg4, %3[%c0] : memref<1xindex>
          store %14, %7[%c0] : memref<1xf32>
        }
      }
      %9 = load %3[%c0] : memref<1xindex>
      %10 = load %0[%9] : memref<20xi32>
      %11 = load %0[%arg3] : memref<20xi32>
      store %10, %0[%arg3] : memref<20xi32>
      store %11, %0[%9] : memref<20xi32>
    }
    %1 = affine.parallel (%arg3) = (0) to (10) reduce ("assign") -> (memref<10xi32>) {
      %3 = pxa.reduce assign %c0_i32, %arg2[%arg3] : memref<10xi32>
      affine.yield %3 : memref<10xi32>
    } {tags = {cpuThread}}
    %2 = affine.parallel (%arg3) = (0) to (10) reduce ("assign") -> (memref<10xi32>) {
      %3 = pxa.load %0[%arg3] : memref<20xi32>
      %4 = pxa.reduce assign %3, %1[%arg3] : memref<10xi32>
      affine.yield %4 : memref<10xi32>
    } {tags = {cpuThread}}
    return %2 : memref<10xi32>
  }
  func @fini(%arg0: !stdx.argpack) {
    stdx.unpack %arg0 : 
    return
  }
}


// *** IR Dump After AffineNormalize *** ('func' operation: @init)
module @argsort  {
  func @init() -> !stdx.argpack {
    %0 = stdx.pack  : 
    return %0 : !stdx.argpack
  }
  func @main(%arg0: !stdx.argpack, %arg1: memref<20xf32>, %arg2: memref<10xi32>) -> memref<10xi32> {
    %c0_i32 = constant 0 : i32
    %c0 = constant 0 : index
    %c1 = constant 1 : index
    %c20 = constant 20 : index
    %c19 = constant 19 : index
    stdx.unpack %arg0 : 
    %0 = alloc() : memref<20xi32>
    scf.for %arg3 = %c0 to %c20 step %c1 {
      %3 = index_cast %arg3 : index to i32
      store %3, %0[%arg3] : memref<20xi32>
    }
    scf.for %arg3 = %c0 to %c19 step %c1 {
      %3 = alloca() : memref<1xindex>
      store %arg3, %3[%c0] : memref<1xindex>
      %4 = load %0[%arg3] : memref<20xi32>
      %5 = index_cast %4 : i32 to index
      %6 = load %arg1[%5] : memref<20xf32>
      %7 = alloca() : memref<1xf32>
      store %6, %7[%c0] : memref<1xf32>
      %8 = addi %arg3, %c1 : index
      scf.for %arg4 = %8 to %c20 step %c1 {
        %12 = load %0[%arg4] : memref<20xi32>
        %13 = index_cast %12 : i32 to index
        %14 = load %arg1[%13] : memref<20xf32>
        %15 = load %7[%c0] : memref<1xf32>
        %16 = cmpf olt, %14, %15 : f32
        scf.if %16 {
          store %arg4, %3[%c0] : memref<1xindex>
          store %14, %7[%c0] : memref<1xf32>
        }
      }
      %9 = load %3[%c0] : memref<1xindex>
      %10 = load %0[%9] : memref<20xi32>
      %11 = load %0[%arg3] : memref<20xi32>
      store %10, %0[%arg3] : memref<20xi32>
      store %11, %0[%9] : memref<20xi32>
    }
    %1 = affine.parallel (%arg3) = (0) to (10) reduce ("assign") -> (memref<10xi32>) {
      %3 = pxa.reduce assign %c0_i32, %arg2[%arg3] : memref<10xi32>
      affine.yield %3 : memref<10xi32>
    } {tags = {cpuThread}}
    %2 = affine.parallel (%arg3) = (0) to (10) reduce ("assign") -> (memref<10xi32>) {
      %3 = pxa.load %0[%arg3] : memref<20xi32>
      %4 = pxa.reduce assign %3, %1[%arg3] : memref<10xi32>
      affine.yield %4 : memref<10xi32>
    } {tags = {cpuThread}}
    return %2 : memref<10xi32>
  }
  func @fini(%arg0: !stdx.argpack) {
    stdx.unpack %arg0 : 
    return
  }
}


2021-04-07 05:11:48,557 VERBOSE-3 [default] Collecting read/write information
2021-04-07 05:11:48,557 VERBOSE-3 [default] considerPlan>
2021-04-07 05:11:48,557 VERBOSE-3 [default]   A: %3 = pxa.reduce assign %c0_i32, %arg2[%arg3] : memref<10xi32>
2021-04-07 05:11:48,557 VERBOSE-3 [default]   B: %4 = pxa.reduce assign %3, %1[%arg3] : memref<10xi32>
2021-04-07 05:11:48,557 VERBOSE-3 [default] sa: 0:[^bb0:%arg0=1]
2021-04-07 05:11:48,557 VERBOSE-3 [default] sb: 0:[^bb0:%arg0=1]
2021-04-07 05:11:48,557 VERBOSE-3 [default] Mapping arg 0 to 0
2021-04-07 05:11:48,557 VERBOSE-3 [default] Doing a batch solve!
2021-04-07 05:11:48,557 VERBOSE-3 [default] Constraints: [0 <= x1_a < 10, 0 <= x1_b < 10, 0 <= x1_a - x1_b < 1]
2021-04-07 05:11:48,557 VERBOSE-3 [default] toMin: [x1_a - x1_b]
2021-04-07 05:11:48,558 VERBOSE-3 [default] obj_val = 0
2021-04-07 05:11:48,558 VERBOSE-3 [default] isAliased: 1
2021-04-07 05:11:48,558 VERBOSE-3 [default]   WAW: %4 = pxa.reduce assign %3, %1[%arg3] : memref<10xi32>
2021-04-07 05:11:48,558 VERBOSE-3 [default] Doing a batch solve!
2021-04-07 05:11:48,558 VERBOSE-3 [default] Constraints: [0 <= x1_a < 10, 0 <= x1_b < 10, 0 <= x1_a - x1_b < 1]
2021-04-07 05:11:48,558 VERBOSE-3 [default] toMin: [x1_a - x1_b]
2021-04-07 05:11:48,558 VERBOSE-3 [default] obj_val = 0
2021-04-07 05:11:48,558 VERBOSE-3 [default]   isAliased: 1
2021-04-07 05:11:48,558 VERBOSE-3 [default] Found 0 read after writes
2021-04-07 05:11:48,558 VERBOSE-3 [default] Found 1 write after writes
// *** IR Dump After Fusion *** ('func' operation: @main)
module @argsort  {
  func @init() -> !stdx.argpack {
    %0 = stdx.pack  : 
    return %0 : !stdx.argpack
  }
  func @main(%arg0: !stdx.argpack, %arg1: memref<20xf32>, %arg2: memref<10xi32>) -> memref<10xi32> {
    %c0_i32 = constant 0 : i32
    %c0 = constant 0 : index
    %c1 = constant 1 : index
    %c20 = constant 20 : index
    %c19 = constant 19 : index
    stdx.unpack %arg0 : 
    %0 = alloc() : memref<20xi32>
    scf.for %arg3 = %c0 to %c20 step %c1 {
      %2 = index_cast %arg3 : index to i32
      store %2, %0[%arg3] : memref<20xi32>
    }
    scf.for %arg3 = %c0 to %c19 step %c1 {
      %2 = alloca() : memref<1xindex>
      store %arg3, %2[%c0] : memref<1xindex>
      %3 = load %0[%arg3] : memref<20xi32>
      %4 = index_cast %3 : i32 to index
      %5 = load %arg1[%4] : memref<20xf32>
      %6 = alloca() : memref<1xf32>
      store %5, %6[%c0] : memref<1xf32>
      %7 = addi %arg3, %c1 : index
      scf.for %arg4 = %7 to %c20 step %c1 {
        %11 = load %0[%arg4] : memref<20xi32>
        %12 = index_cast %11 : i32 to index
        %13 = load %arg1[%12] : memref<20xf32>
        %14 = load %6[%c0] : memref<1xf32>
        %15 = cmpf olt, %13, %14 : f32
        scf.if %15 {
          store %arg4, %2[%c0] : memref<1xindex>
          store %13, %6[%c0] : memref<1xf32>
        }
      }
      %8 = load %2[%c0] : memref<1xindex>
      %9 = load %0[%8] : memref<20xi32>
      %10 = load %0[%arg3] : memref<20xi32>
      store %9, %0[%arg3] : memref<20xi32>
      store %10, %0[%8] : memref<20xi32>
    }
    %1 = affine.parallel (%arg3) = (0) to (10) reduce ("assign") -> (memref<10xi32>) {
      %2 = affine.parallel () = () to () reduce ("assign") -> (memref<10xi32>) {
        %4 = pxa.reduce assign %c0_i32, %arg2[%arg3] : memref<10xi32>
        affine.yield %4 : memref<10xi32>
      }
      %3 = affine.parallel () = () to () reduce ("assign") -> (memref<10xi32>) {
        %4 = pxa.load %0[%arg3] : memref<20xi32>
        %5 = pxa.reduce assign %4, %2[%arg3] : memref<10xi32>
        affine.yield %5 : memref<10xi32>
      }
      affine.yield %3 : memref<10xi32>
    } {tags = {cpuThread}}
    return %1 : memref<10xi32>
  }
  func @fini(%arg0: !stdx.argpack) {
    stdx.unpack %arg0 : 
    return
  }
}


// *** IR Dump After AffineNormalize *** ('func' operation: @main)
module @argsort  {
  func @init() -> !stdx.argpack {
    %0 = stdx.pack  : 
    return %0 : !stdx.argpack
  }
  func @main(%arg0: !stdx.argpack, %arg1: memref<20xf32>, %arg2: memref<10xi32>) -> memref<10xi32> {
    %c0_i32 = constant 0 : i32
    %c0 = constant 0 : index
    %c1 = constant 1 : index
    %c20 = constant 20 : index
    %c19 = constant 19 : index
    stdx.unpack %arg0 : 
    %0 = alloc() : memref<20xi32>
    scf.for %arg3 = %c0 to %c20 step %c1 {
      %2 = index_cast %arg3 : index to i32
      store %2, %0[%arg3] : memref<20xi32>
    }
    scf.for %arg3 = %c0 to %c19 step %c1 {
      %2 = alloca() : memref<1xindex>
      store %arg3, %2[%c0] : memref<1xindex>
      %3 = load %0[%arg3] : memref<20xi32>
      %4 = index_cast %3 : i32 to index
      %5 = load %arg1[%4] : memref<20xf32>
      %6 = alloca() : memref<1xf32>
      store %5, %6[%c0] : memref<1xf32>
      %7 = addi %arg3, %c1 : index
      scf.for %arg4 = %7 to %c20 step %c1 {
        %11 = load %0[%arg4] : memref<20xi32>
        %12 = index_cast %11 : i32 to index
        %13 = load %arg1[%12] : memref<20xf32>
        %14 = load %6[%c0] : memref<1xf32>
        %15 = cmpf olt, %13, %14 : f32
        scf.if %15 {
          store %arg4, %2[%c0] : memref<1xindex>
          store %13, %6[%c0] : memref<1xf32>
        }
      }
      %8 = load %2[%c0] : memref<1xindex>
      %9 = load %0[%8] : memref<20xi32>
      %10 = load %0[%arg3] : memref<20xi32>
      store %9, %0[%arg3] : memref<20xi32>
      store %10, %0[%8] : memref<20xi32>
    }
    %1 = affine.parallel (%arg3) = (0) to (10) reduce ("assign") -> (memref<10xi32>) {
      %2 = pxa.reduce assign %c0_i32, %arg2[%arg3] : memref<10xi32>
      %3 = pxa.load %0[%arg3] : memref<20xi32>
      %4 = pxa.reduce assign %3, %2[%arg3] : memref<10xi32>
      affine.yield %4 : memref<10xi32>
    } {tags = {cpuThread}}
    return %1 : memref<10xi32>
  }
  func @fini(%arg0: !stdx.argpack) {
    stdx.unpack %arg0 : 
    return
  }
}


// *** IR Dump After Fusion *** ('func' operation: @fini)
module @argsort  {
  func @init() -> !stdx.argpack {
    %0 = stdx.pack  : 
    return %0 : !stdx.argpack
  }
  func @main(%arg0: !stdx.argpack, %arg1: memref<20xf32>, %arg2: memref<10xi32>) -> memref<10xi32> {
    %c0_i32 = constant 0 : i32
    %c0 = constant 0 : index
    %c1 = constant 1 : index
    %c20 = constant 20 : index
    %c19 = constant 19 : index
    stdx.unpack %arg0 : 
    %0 = alloc() : memref<20xi32>
    scf.for %arg3 = %c0 to %c20 step %c1 {
      %2 = index_cast %arg3 : index to i32
      store %2, %0[%arg3] : memref<20xi32>
    }
    scf.for %arg3 = %c0 to %c19 step %c1 {
      %2 = alloca() : memref<1xindex>
      store %arg3, %2[%c0] : memref<1xindex>
      %3 = load %0[%arg3] : memref<20xi32>
      %4 = index_cast %3 : i32 to index
      %5 = load %arg1[%4] : memref<20xf32>
      %6 = alloca() : memref<1xf32>
      store %5, %6[%c0] : memref<1xf32>
      %7 = addi %arg3, %c1 : index
      scf.for %arg4 = %7 to %c20 step %c1 {
        %11 = load %0[%arg4] : memref<20xi32>
        %12 = index_cast %11 : i32 to index
        %13 = load %arg1[%12] : memref<20xf32>
        %14 = load %6[%c0] : memref<1xf32>
        %15 = cmpf olt, %13, %14 : f32
        scf.if %15 {
          store %arg4, %2[%c0] : memref<1xindex>
          store %13, %6[%c0] : memref<1xf32>
        }
      }
      %8 = load %2[%c0] : memref<1xindex>
      %9 = load %0[%8] : memref<20xi32>
      %10 = load %0[%arg3] : memref<20xi32>
      store %9, %0[%arg3] : memref<20xi32>
      store %10, %0[%8] : memref<20xi32>
    }
    %1 = affine.parallel (%arg3) = (0) to (10) reduce ("assign") -> (memref<10xi32>) {
      %2 = pxa.reduce assign %c0_i32, %arg2[%arg3] : memref<10xi32>
      %3 = pxa.load %0[%arg3] : memref<20xi32>
      %4 = pxa.reduce assign %3, %2[%arg3] : memref<10xi32>
      affine.yield %4 : memref<10xi32>
    } {tags = {cpuThread}}
    return %1 : memref<10xi32>
  }
  func @fini(%arg0: !stdx.argpack) {
    stdx.unpack %arg0 : 
    return
  }
}


// *** IR Dump After AffineNormalize *** ('func' operation: @fini)
module @argsort  {
  func @init() -> !stdx.argpack {
    %0 = stdx.pack  : 
    return %0 : !stdx.argpack
  }
  func @main(%arg0: !stdx.argpack, %arg1: memref<20xf32>, %arg2: memref<10xi32>) -> memref<10xi32> {
    %c0_i32 = constant 0 : i32
    %c0 = constant 0 : index
    %c1 = constant 1 : index
    %c20 = constant 20 : index
    %c19 = constant 19 : index
    stdx.unpack %arg0 : 
    %0 = alloc() : memref<20xi32>
    scf.for %arg3 = %c0 to %c20 step %c1 {
      %2 = index_cast %arg3 : index to i32
      store %2, %0[%arg3] : memref<20xi32>
    }
    scf.for %arg3 = %c0 to %c19 step %c1 {
      %2 = alloca() : memref<1xindex>
      store %arg3, %2[%c0] : memref<1xindex>
      %3 = load %0[%arg3] : memref<20xi32>
      %4 = index_cast %3 : i32 to index
      %5 = load %arg1[%4] : memref<20xf32>
      %6 = alloca() : memref<1xf32>
      store %5, %6[%c0] : memref<1xf32>
      %7 = addi %arg3, %c1 : index
      scf.for %arg4 = %7 to %c20 step %c1 {
        %11 = load %0[%arg4] : memref<20xi32>
        %12 = index_cast %11 : i32 to index
        %13 = load %arg1[%12] : memref<20xf32>
        %14 = load %6[%c0] : memref<1xf32>
        %15 = cmpf olt, %13, %14 : f32
        scf.if %15 {
          store %arg4, %2[%c0] : memref<1xindex>
          store %13, %6[%c0] : memref<1xf32>
        }
      }
      %8 = load %2[%c0] : memref<1xindex>
      %9 = load %0[%8] : memref<20xi32>
      %10 = load %0[%arg3] : memref<20xi32>
      store %9, %0[%arg3] : memref<20xi32>
      store %10, %0[%8] : memref<20xi32>
    }
    %1 = affine.parallel (%arg3) = (0) to (10) reduce ("assign") -> (memref<10xi32>) {
      %2 = pxa.reduce assign %c0_i32, %arg2[%arg3] : memref<10xi32>
      %3 = pxa.load %0[%arg3] : memref<20xi32>
      %4 = pxa.reduce assign %3, %2[%arg3] : memref<10xi32>
      affine.yield %4 : memref<10xi32>
    } {tags = {cpuThread}}
    return %1 : memref<10xi32>
  }
  func @fini(%arg0: !stdx.argpack) {
    stdx.unpack %arg0 : 
    return
  }
}


// *** IR Dump After Canonicalizer *** ('module' operation: @argsort)
module @argsort  {
  func @init() -> !stdx.argpack {
    %0 = stdx.pack  : 
    return %0 : !stdx.argpack
  }
  func @main(%arg0: !stdx.argpack, %arg1: memref<20xf32>, %arg2: memref<10xi32>) -> memref<10xi32> {
    %c0_i32 = constant 0 : i32
    %c0 = constant 0 : index
    %c1 = constant 1 : index
    %c20 = constant 20 : index
    %c19 = constant 19 : index
    stdx.unpack %arg0 : 
    %0 = alloc() : memref<20xi32>
    scf.for %arg3 = %c0 to %c20 step %c1 {
      %2 = index_cast %arg3 : index to i32
      store %2, %0[%arg3] : memref<20xi32>
    }
    scf.for %arg3 = %c0 to %c19 step %c1 {
      %2 = alloca() : memref<1xindex>
      store %arg3, %2[%c0] : memref<1xindex>
      %3 = load %0[%arg3] : memref<20xi32>
      %4 = index_cast %3 : i32 to index
      %5 = load %arg1[%4] : memref<20xf32>
      %6 = alloca() : memref<1xf32>
      store %5, %6[%c0] : memref<1xf32>
      %7 = addi %arg3, %c1 : index
      scf.for %arg4 = %7 to %c20 step %c1 {
        %11 = load %0[%arg4] : memref<20xi32>
        %12 = index_cast %11 : i32 to index
        %13 = load %arg1[%12] : memref<20xf32>
        %14 = load %6[%c0] : memref<1xf32>
        %15 = cmpf olt, %13, %14 : f32
        scf.if %15 {
          store %arg4, %2[%c0] : memref<1xindex>
          store %13, %6[%c0] : memref<1xf32>
        }
      }
      %8 = load %2[%c0] : memref<1xindex>
      %9 = load %0[%8] : memref<20xi32>
      %10 = load %0[%arg3] : memref<20xi32>
      store %9, %0[%arg3] : memref<20xi32>
      store %10, %0[%8] : memref<20xi32>
    }
    %1 = affine.parallel (%arg3) = (0) to (10) reduce ("assign") -> (memref<10xi32>) {
      %2 = pxa.reduce assign %c0_i32, %arg2[%arg3] : memref<10xi32>
      %3 = pxa.load %0[%arg3] : memref<20xi32>
      %4 = pxa.reduce assign %3, %2[%arg3] : memref<10xi32>
      affine.yield %4 : memref<10xi32>
    } {tags = {cpuThread}}
    return %1 : memref<10xi32>
  }
  func @fini(%arg0: !stdx.argpack) {
    stdx.unpack %arg0 : 
    return
  }
}


// *** IR Dump After MemRefDataFlowOpt *** ('func' operation: @init)
module @argsort  {
  func @init() -> !stdx.argpack {
    %0 = stdx.pack  : 
    return %0 : !stdx.argpack
  }
  func @main(%arg0: !stdx.argpack, %arg1: memref<20xf32>, %arg2: memref<10xi32>) -> memref<10xi32> {
    %c0_i32 = constant 0 : i32
    %c0 = constant 0 : index
    %c1 = constant 1 : index
    %c20 = constant 20 : index
    %c19 = constant 19 : index
    stdx.unpack %arg0 : 
    %0 = alloc() : memref<20xi32>
    scf.for %arg3 = %c0 to %c20 step %c1 {
      %2 = index_cast %arg3 : index to i32
      store %2, %0[%arg3] : memref<20xi32>
    }
    scf.for %arg3 = %c0 to %c19 step %c1 {
      %2 = alloca() : memref<1xindex>
      store %arg3, %2[%c0] : memref<1xindex>
      %3 = load %0[%arg3] : memref<20xi32>
      %4 = index_cast %3 : i32 to index
      %5 = load %arg1[%4] : memref<20xf32>
      %6 = alloca() : memref<1xf32>
      store %5, %6[%c0] : memref<1xf32>
      %7 = addi %arg3, %c1 : index
      scf.for %arg4 = %7 to %c20 step %c1 {
        %11 = load %0[%arg4] : memref<20xi32>
        %12 = index_cast %11 : i32 to index
        %13 = load %arg1[%12] : memref<20xf32>
        %14 = load %6[%c0] : memref<1xf32>
        %15 = cmpf olt, %13, %14 : f32
        scf.if %15 {
          store %arg4, %2[%c0] : memref<1xindex>
          store %13, %6[%c0] : memref<1xf32>
        }
      }
      %8 = load %2[%c0] : memref<1xindex>
      %9 = load %0[%8] : memref<20xi32>
      %10 = load %0[%arg3] : memref<20xi32>
      store %9, %0[%arg3] : memref<20xi32>
      store %10, %0[%8] : memref<20xi32>
    }
    %1 = affine.parallel (%arg3) = (0) to (10) reduce ("assign") -> (memref<10xi32>) {
      %2 = pxa.reduce assign %c0_i32, %arg2[%arg3] : memref<10xi32>
      %3 = pxa.load %0[%arg3] : memref<20xi32>
      %4 = pxa.reduce assign %3, %2[%arg3] : memref<10xi32>
      affine.yield %4 : memref<10xi32>
    } {tags = {cpuThread}}
    return %1 : memref<10xi32>
  }
  func @fini(%arg0: !stdx.argpack) {
    stdx.unpack %arg0 : 
    return
  }
}


// *** IR Dump After MemRefDataFlowOpt *** ('func' operation: @main)
module @argsort  {
  func @init() -> !stdx.argpack {
    %0 = stdx.pack  : 
    return %0 : !stdx.argpack
  }
  func @main(%arg0: !stdx.argpack, %arg1: memref<20xf32>, %arg2: memref<10xi32>) -> memref<10xi32> {
    %c0_i32 = constant 0 : i32
    %c0 = constant 0 : index
    %c1 = constant 1 : index
    %c20 = constant 20 : index
    %c19 = constant 19 : index
    stdx.unpack %arg0 : 
    %0 = alloc() : memref<20xi32>
    scf.for %arg3 = %c0 to %c20 step %c1 {
      %2 = index_cast %arg3 : index to i32
      store %2, %0[%arg3] : memref<20xi32>
    }
    scf.for %arg3 = %c0 to %c19 step %c1 {
      %2 = alloca() : memref<1xindex>
      store %arg3, %2[%c0] : memref<1xindex>
      %3 = load %0[%arg3] : memref<20xi32>
      %4 = index_cast %3 : i32 to index
      %5 = load %arg1[%4] : memref<20xf32>
      %6 = alloca() : memref<1xf32>
      store %5, %6[%c0] : memref<1xf32>
      %7 = addi %arg3, %c1 : index
      scf.for %arg4 = %7 to %c20 step %c1 {
        %11 = load %0[%arg4] : memref<20xi32>
        %12 = index_cast %11 : i32 to index
        %13 = load %arg1[%12] : memref<20xf32>
        %14 = load %6[%c0] : memref<1xf32>
        %15 = cmpf olt, %13, %14 : f32
        scf.if %15 {
          store %arg4, %2[%c0] : memref<1xindex>
          store %13, %6[%c0] : memref<1xf32>
        }
      }
      %8 = load %2[%c0] : memref<1xindex>
      %9 = load %0[%8] : memref<20xi32>
      %10 = load %0[%arg3] : memref<20xi32>
      store %9, %0[%arg3] : memref<20xi32>
      store %10, %0[%8] : memref<20xi32>
    }
    %1 = affine.parallel (%arg3) = (0) to (10) reduce ("assign") -> (memref<10xi32>) {
      %2 = pxa.reduce assign %c0_i32, %arg2[%arg3] : memref<10xi32>
      %3 = pxa.load %0[%arg3] : memref<20xi32>
      %4 = pxa.reduce assign %3, %2[%arg3] : memref<10xi32>
      affine.yield %4 : memref<10xi32>
    } {tags = {cpuThread}}
    return %1 : memref<10xi32>
  }
  func @fini(%arg0: !stdx.argpack) {
    stdx.unpack %arg0 : 
    return
  }
}


// *** IR Dump After MemRefDataFlowOpt *** ('func' operation: @fini)
module @argsort  {
  func @init() -> !stdx.argpack {
    %0 = stdx.pack  : 
    return %0 : !stdx.argpack
  }
  func @main(%arg0: !stdx.argpack, %arg1: memref<20xf32>, %arg2: memref<10xi32>) -> memref<10xi32> {
    %c0_i32 = constant 0 : i32
    %c0 = constant 0 : index
    %c1 = constant 1 : index
    %c20 = constant 20 : index
    %c19 = constant 19 : index
    stdx.unpack %arg0 : 
    %0 = alloc() : memref<20xi32>
    scf.for %arg3 = %c0 to %c20 step %c1 {
      %2 = index_cast %arg3 : index to i32
      store %2, %0[%arg3] : memref<20xi32>
    }
    scf.for %arg3 = %c0 to %c19 step %c1 {
      %2 = alloca() : memref<1xindex>
      store %arg3, %2[%c0] : memref<1xindex>
      %3 = load %0[%arg3] : memref<20xi32>
      %4 = index_cast %3 : i32 to index
      %5 = load %arg1[%4] : memref<20xf32>
      %6 = alloca() : memref<1xf32>
      store %5, %6[%c0] : memref<1xf32>
      %7 = addi %arg3, %c1 : index
      scf.for %arg4 = %7 to %c20 step %c1 {
        %11 = load %0[%arg4] : memref<20xi32>
        %12 = index_cast %11 : i32 to index
        %13 = load %arg1[%12] : memref<20xf32>
        %14 = load %6[%c0] : memref<1xf32>
        %15 = cmpf olt, %13, %14 : f32
        scf.if %15 {
          store %arg4, %2[%c0] : memref<1xindex>
          store %13, %6[%c0] : memref<1xf32>
        }
      }
      %8 = load %2[%c0] : memref<1xindex>
      %9 = load %0[%8] : memref<20xi32>
      %10 = load %0[%arg3] : memref<20xi32>
      store %9, %0[%arg3] : memref<20xi32>
      store %10, %0[%8] : memref<20xi32>
    }
    %1 = affine.parallel (%arg3) = (0) to (10) reduce ("assign") -> (memref<10xi32>) {
      %2 = pxa.reduce assign %c0_i32, %arg2[%arg3] : memref<10xi32>
      %3 = pxa.load %0[%arg3] : memref<20xi32>
      %4 = pxa.reduce assign %3, %2[%arg3] : memref<10xi32>
      affine.yield %4 : memref<10xi32>
    } {tags = {cpuThread}}
    return %1 : memref<10xi32>
  }
  func @fini(%arg0: !stdx.argpack) {
    stdx.unpack %arg0 : 
    return
  }
}


// *** IR Dump After Canonicalizer *** ('module' operation: @argsort)
module @argsort  {
  func @init() -> !stdx.argpack {
    %0 = stdx.pack  : 
    return %0 : !stdx.argpack
  }
  func @main(%arg0: !stdx.argpack, %arg1: memref<20xf32>, %arg2: memref<10xi32>) -> memref<10xi32> {
    %c0_i32 = constant 0 : i32
    %c0 = constant 0 : index
    %c1 = constant 1 : index
    %c20 = constant 20 : index
    %c19 = constant 19 : index
    stdx.unpack %arg0 : 
    %0 = alloc() : memref<20xi32>
    scf.for %arg3 = %c0 to %c20 step %c1 {
      %2 = index_cast %arg3 : index to i32
      store %2, %0[%arg3] : memref<20xi32>
    }
    scf.for %arg3 = %c0 to %c19 step %c1 {
      %2 = alloca() : memref<1xindex>
      store %arg3, %2[%c0] : memref<1xindex>
      %3 = load %0[%arg3] : memref<20xi32>
      %4 = index_cast %3 : i32 to index
      %5 = load %arg1[%4] : memref<20xf32>
      %6 = alloca() : memref<1xf32>
      store %5, %6[%c0] : memref<1xf32>
      %7 = addi %arg3, %c1 : index
      scf.for %arg4 = %7 to %c20 step %c1 {
        %11 = load %0[%arg4] : memref<20xi32>
        %12 = index_cast %11 : i32 to index
        %13 = load %arg1[%12] : memref<20xf32>
        %14 = load %6[%c0] : memref<1xf32>
        %15 = cmpf olt, %13, %14 : f32
        scf.if %15 {
          store %arg4, %2[%c0] : memref<1xindex>
          store %13, %6[%c0] : memref<1xf32>
        }
      }
      %8 = load %2[%c0] : memref<1xindex>
      %9 = load %0[%8] : memref<20xi32>
      %10 = load %0[%arg3] : memref<20xi32>
      store %9, %0[%arg3] : memref<20xi32>
      store %10, %0[%8] : memref<20xi32>
    }
    %1 = affine.parallel (%arg3) = (0) to (10) reduce ("assign") -> (memref<10xi32>) {
      %2 = pxa.reduce assign %c0_i32, %arg2[%arg3] : memref<10xi32>
      %3 = pxa.load %0[%arg3] : memref<20xi32>
      %4 = pxa.reduce assign %3, %2[%arg3] : memref<10xi32>
      affine.yield %4 : memref<10xi32>
    } {tags = {cpuThread}}
    return %1 : memref<10xi32>
  }
  func @fini(%arg0: !stdx.argpack) {
    stdx.unpack %arg0 : 
    return
  }
}


// *** IR Dump After Localize *** ('func' operation: @init)
module @argsort  {
  func @init() -> !stdx.argpack {
    %0 = stdx.pack  : 
    return %0 : !stdx.argpack
  }
  func @main(%arg0: !stdx.argpack, %arg1: memref<20xf32>, %arg2: memref<10xi32>) -> memref<10xi32> {
    %c0_i32 = constant 0 : i32
    %c0 = constant 0 : index
    %c1 = constant 1 : index
    %c20 = constant 20 : index
    %c19 = constant 19 : index
    stdx.unpack %arg0 : 
    %0 = alloc() : memref<20xi32>
    scf.for %arg3 = %c0 to %c20 step %c1 {
      %2 = index_cast %arg3 : index to i32
      store %2, %0[%arg3] : memref<20xi32>
    }
    scf.for %arg3 = %c0 to %c19 step %c1 {
      %2 = alloca() : memref<1xindex>
      store %arg3, %2[%c0] : memref<1xindex>
      %3 = load %0[%arg3] : memref<20xi32>
      %4 = index_cast %3 : i32 to index
      %5 = load %arg1[%4] : memref<20xf32>
      %6 = alloca() : memref<1xf32>
      store %5, %6[%c0] : memref<1xf32>
      %7 = addi %arg3, %c1 : index
      scf.for %arg4 = %7 to %c20 step %c1 {
        %11 = load %0[%arg4] : memref<20xi32>
        %12 = index_cast %11 : i32 to index
        %13 = load %arg1[%12] : memref<20xf32>
        %14 = load %6[%c0] : memref<1xf32>
        %15 = cmpf olt, %13, %14 : f32
        scf.if %15 {
          store %arg4, %2[%c0] : memref<1xindex>
          store %13, %6[%c0] : memref<1xf32>
        }
      }
      %8 = load %2[%c0] : memref<1xindex>
      %9 = load %0[%8] : memref<20xi32>
      %10 = load %0[%arg3] : memref<20xi32>
      store %9, %0[%arg3] : memref<20xi32>
      store %10, %0[%8] : memref<20xi32>
    }
    %1 = affine.parallel (%arg3) = (0) to (10) reduce ("assign") -> (memref<10xi32>) {
      %2 = pxa.reduce assign %c0_i32, %arg2[%arg3] : memref<10xi32>
      %3 = pxa.load %0[%arg3] : memref<20xi32>
      %4 = pxa.reduce assign %3, %2[%arg3] : memref<10xi32>
      affine.yield %4 : memref<10xi32>
    } {tags = {cpuThread}}
    return %1 : memref<10xi32>
  }
  func @fini(%arg0: !stdx.argpack) {
    stdx.unpack %arg0 : 
    return
  }
}


// *** IR Dump After ResizeTmps *** ('func' operation: @init)
module @argsort  {
  func @init() -> !stdx.argpack {
    %0 = stdx.pack  : 
    return %0 : !stdx.argpack
  }
  func @main(%arg0: !stdx.argpack, %arg1: memref<20xf32>, %arg2: memref<10xi32>) -> memref<10xi32> {
    %c0_i32 = constant 0 : i32
    %c0 = constant 0 : index
    %c1 = constant 1 : index
    %c20 = constant 20 : index
    %c19 = constant 19 : index
    stdx.unpack %arg0 : 
    %0 = alloc() : memref<20xi32>
    scf.for %arg3 = %c0 to %c20 step %c1 {
      %2 = index_cast %arg3 : index to i32
      store %2, %0[%arg3] : memref<20xi32>
    }
    scf.for %arg3 = %c0 to %c19 step %c1 {
      %2 = alloca() : memref<1xindex>
      store %arg3, %2[%c0] : memref<1xindex>
      %3 = load %0[%arg3] : memref<20xi32>
      %4 = index_cast %3 : i32 to index
      %5 = load %arg1[%4] : memref<20xf32>
      %6 = alloca() : memref<1xf32>
      store %5, %6[%c0] : memref<1xf32>
      %7 = addi %arg3, %c1 : index
      scf.for %arg4 = %7 to %c20 step %c1 {
        %11 = load %0[%arg4] : memref<20xi32>
        %12 = index_cast %11 : i32 to index
        %13 = load %arg1[%12] : memref<20xf32>
        %14 = load %6[%c0] : memref<1xf32>
        %15 = cmpf olt, %13, %14 : f32
        scf.if %15 {
          store %arg4, %2[%c0] : memref<1xindex>
          store %13, %6[%c0] : memref<1xf32>
        }
      }
      %8 = load %2[%c0] : memref<1xindex>
      %9 = load %0[%8] : memref<20xi32>
      %10 = load %0[%arg3] : memref<20xi32>
      store %9, %0[%arg3] : memref<20xi32>
      store %10, %0[%8] : memref<20xi32>
    }
    %1 = affine.parallel (%arg3) = (0) to (10) reduce ("assign") -> (memref<10xi32>) {
      %2 = pxa.reduce assign %c0_i32, %arg2[%arg3] : memref<10xi32>
      %3 = pxa.load %0[%arg3] : memref<20xi32>
      %4 = pxa.reduce assign %3, %2[%arg3] : memref<10xi32>
      affine.yield %4 : memref<10xi32>
    } {tags = {cpuThread}}
    return %1 : memref<10xi32>
  }
  func @fini(%arg0: !stdx.argpack) {
    stdx.unpack %arg0 : 
    return
  }
}


// *** IR Dump After Localize *** ('func' operation: @main)
module @argsort  {
  func @init() -> !stdx.argpack {
    %0 = stdx.pack  : 
    return %0 : !stdx.argpack
  }
  func @main(%arg0: !stdx.argpack, %arg1: memref<20xf32>, %arg2: memref<10xi32>) -> memref<10xi32> {
    %c0_i32 = constant 0 : i32
    %c0 = constant 0 : index
    %c1 = constant 1 : index
    %c20 = constant 20 : index
    %c19 = constant 19 : index
    stdx.unpack %arg0 : 
    %0 = alloc() : memref<20xi32>
    scf.for %arg3 = %c0 to %c20 step %c1 {
      %2 = index_cast %arg3 : index to i32
      store %2, %0[%arg3] : memref<20xi32>
    }
    scf.for %arg3 = %c0 to %c19 step %c1 {
      %2 = alloca() : memref<1xindex>
      store %arg3, %2[%c0] : memref<1xindex>
      %3 = load %0[%arg3] : memref<20xi32>
      %4 = index_cast %3 : i32 to index
      %5 = load %arg1[%4] : memref<20xf32>
      %6 = alloca() : memref<1xf32>
      store %5, %6[%c0] : memref<1xf32>
      %7 = addi %arg3, %c1 : index
      scf.for %arg4 = %7 to %c20 step %c1 {
        %11 = load %0[%arg4] : memref<20xi32>
        %12 = index_cast %11 : i32 to index
        %13 = load %arg1[%12] : memref<20xf32>
        %14 = load %6[%c0] : memref<1xf32>
        %15 = cmpf olt, %13, %14 : f32
        scf.if %15 {
          store %arg4, %2[%c0] : memref<1xindex>
          store %13, %6[%c0] : memref<1xf32>
        }
      }
      %8 = load %2[%c0] : memref<1xindex>
      %9 = load %0[%8] : memref<20xi32>
      %10 = load %0[%arg3] : memref<20xi32>
      store %9, %0[%arg3] : memref<20xi32>
      store %10, %0[%8] : memref<20xi32>
    }
    %1 = affine.parallel (%arg3) = (0) to (10) reduce ("assign") -> (memref<10xi32>) {
      %2 = pxa.reduce assign %c0_i32, %arg2[%arg3] : memref<10xi32>
      %3 = pxa.load %0[%arg3] : memref<20xi32>
      %4 = pxa.reduce assign %3, %2[%arg3] : memref<10xi32>
      affine.yield %4 : memref<10xi32>
    } {tags = {cpuThread}}
    return %1 : memref<10xi32>
  }
  func @fini(%arg0: !stdx.argpack) {
    stdx.unpack %arg0 : 
    return
  }
}


2021-04-07 05:11:48,565 VERBOSE-2 [default] Considering: %0 = alloc() : memref<20xi32>
2021-04-07 05:11:48,565 VERBOSE-2 [default] Found use: %3 = pxa.load %0[%arg3] : memref<20xi32>
2021-04-07 05:11:48,566 VERBOSE-2 [default] Original size:20
2021-04-07 05:11:48,566 VERBOSE-2 [default] Computed size:10
// *** IR Dump After ResizeTmps *** ('func' operation: @main)
module @argsort  {
  func @init() -> !stdx.argpack {
    %0 = stdx.pack  : 
    return %0 : !stdx.argpack
  }
  func @main(%arg0: !stdx.argpack, %arg1: memref<20xf32>, %arg2: memref<10xi32>) -> memref<10xi32> {
    %c0_i32 = constant 0 : i32
    %c0 = constant 0 : index
    %c1 = constant 1 : index
    %c20 = constant 20 : index
    %c19 = constant 19 : index
    stdx.unpack %arg0 : 
    %0 = alloc() : memref<10xi32>
    scf.for %arg3 = %c0 to %c20 step %c1 {
      %2 = index_cast %arg3 : index to i32
      store %2, %0[%arg3] : memref<10xi32>
    }
    scf.for %arg3 = %c0 to %c19 step %c1 {
      %2 = alloca() : memref<1xindex>
      store %arg3, %2[%c0] : memref<1xindex>
      %3 = load %0[%arg3] : memref<10xi32>
      %4 = index_cast %3 : i32 to index
      %5 = load %arg1[%4] : memref<20xf32>
      %6 = alloca() : memref<1xf32>
      store %5, %6[%c0] : memref<1xf32>
      %7 = addi %arg3, %c1 : index
      scf.for %arg4 = %7 to %c20 step %c1 {
        %11 = load %0[%arg4] : memref<10xi32>
        %12 = index_cast %11 : i32 to index
        %13 = load %arg1[%12] : memref<20xf32>
        %14 = load %6[%c0] : memref<1xf32>
        %15 = cmpf olt, %13, %14 : f32
        scf.if %15 {
          store %arg4, %2[%c0] : memref<1xindex>
          store %13, %6[%c0] : memref<1xf32>
        }
      }
      %8 = load %2[%c0] : memref<1xindex>
      %9 = load %0[%8] : memref<10xi32>
      %10 = load %0[%arg3] : memref<10xi32>
      store %9, %0[%arg3] : memref<10xi32>
      store %10, %0[%8] : memref<10xi32>
    }
    %1 = affine.parallel (%arg3) = (0) to (10) reduce ("assign") -> (memref<10xi32>) {
      %2 = pxa.reduce assign %c0_i32, %arg2[%arg3] : memref<10xi32>
      %3 = pxa.load %0[%arg3] : memref<10xi32>
      %4 = pxa.load %0[%arg3] : memref<10xi32>
      %5 = pxa.reduce assign %3, %2[%arg3] : memref<10xi32>
      affine.yield %5 : memref<10xi32>
    } {tags = {cpuThread}}
    return %1 : memref<10xi32>
  }
  func @fini(%arg0: !stdx.argpack) {
    stdx.unpack %arg0 : 
    return
  }
}


// *** IR Dump After Localize *** ('func' operation: @fini)
module @argsort  {
  func @init() -> !stdx.argpack {
    %0 = stdx.pack  : 
    return %0 : !stdx.argpack
  }
  func @main(%arg0: !stdx.argpack, %arg1: memref<20xf32>, %arg2: memref<10xi32>) -> memref<10xi32> {
    %c0_i32 = constant 0 : i32
    %c0 = constant 0 : index
    %c1 = constant 1 : index
    %c20 = constant 20 : index
    %c19 = constant 19 : index
    stdx.unpack %arg0 : 
    %0 = alloc() : memref<10xi32>
    scf.for %arg3 = %c0 to %c20 step %c1 {
      %2 = index_cast %arg3 : index to i32
      store %2, %0[%arg3] : memref<10xi32>
    }
    scf.for %arg3 = %c0 to %c19 step %c1 {
      %2 = alloca() : memref<1xindex>
      store %arg3, %2[%c0] : memref<1xindex>
      %3 = load %0[%arg3] : memref<10xi32>
      %4 = index_cast %3 : i32 to index
      %5 = load %arg1[%4] : memref<20xf32>
      %6 = alloca() : memref<1xf32>
      store %5, %6[%c0] : memref<1xf32>
      %7 = addi %arg3, %c1 : index
      scf.for %arg4 = %7 to %c20 step %c1 {
        %11 = load %0[%arg4] : memref<10xi32>
        %12 = index_cast %11 : i32 to index
        %13 = load %arg1[%12] : memref<20xf32>
        %14 = load %6[%c0] : memref<1xf32>
        %15 = cmpf olt, %13, %14 : f32
        scf.if %15 {
          store %arg4, %2[%c0] : memref<1xindex>
          store %13, %6[%c0] : memref<1xf32>
        }
      }
      %8 = load %2[%c0] : memref<1xindex>
      %9 = load %0[%8] : memref<10xi32>
      %10 = load %0[%arg3] : memref<10xi32>
      store %9, %0[%arg3] : memref<10xi32>
      store %10, %0[%8] : memref<10xi32>
    }
    %1 = affine.parallel (%arg3) = (0) to (10) reduce ("assign") -> (memref<10xi32>) {
      %2 = pxa.reduce assign %c0_i32, %arg2[%arg3] : memref<10xi32>
      %3 = pxa.load %0[%arg3] : memref<10xi32>
      %4 = pxa.load %0[%arg3] : memref<10xi32>
      %5 = pxa.reduce assign %3, %2[%arg3] : memref<10xi32>
      affine.yield %5 : memref<10xi32>
    } {tags = {cpuThread}}
    return %1 : memref<10xi32>
  }
  func @fini(%arg0: !stdx.argpack) {
    stdx.unpack %arg0 : 
    return
  }
}


// *** IR Dump After ResizeTmps *** ('func' operation: @fini)
module @argsort  {
  func @init() -> !stdx.argpack {
    %0 = stdx.pack  : 
    return %0 : !stdx.argpack
  }
  func @main(%arg0: !stdx.argpack, %arg1: memref<20xf32>, %arg2: memref<10xi32>) -> memref<10xi32> {
    %c0_i32 = constant 0 : i32
    %c0 = constant 0 : index
    %c1 = constant 1 : index
    %c20 = constant 20 : index
    %c19 = constant 19 : index
    stdx.unpack %arg0 : 
    %0 = alloc() : memref<10xi32>
    scf.for %arg3 = %c0 to %c20 step %c1 {
      %2 = index_cast %arg3 : index to i32
      store %2, %0[%arg3] : memref<10xi32>
    }
    scf.for %arg3 = %c0 to %c19 step %c1 {
      %2 = alloca() : memref<1xindex>
      store %arg3, %2[%c0] : memref<1xindex>
      %3 = load %0[%arg3] : memref<10xi32>
      %4 = index_cast %3 : i32 to index
      %5 = load %arg1[%4] : memref<20xf32>
      %6 = alloca() : memref<1xf32>
      store %5, %6[%c0] : memref<1xf32>
      %7 = addi %arg3, %c1 : index
      scf.for %arg4 = %7 to %c20 step %c1 {
        %11 = load %0[%arg4] : memref<10xi32>
        %12 = index_cast %11 : i32 to index
        %13 = load %arg1[%12] : memref<20xf32>
        %14 = load %6[%c0] : memref<1xf32>
        %15 = cmpf olt, %13, %14 : f32
        scf.if %15 {
          store %arg4, %2[%c0] : memref<1xindex>
          store %13, %6[%c0] : memref<1xf32>
        }
      }
      %8 = load %2[%c0] : memref<1xindex>
      %9 = load %0[%8] : memref<10xi32>
      %10 = load %0[%arg3] : memref<10xi32>
      store %9, %0[%arg3] : memref<10xi32>
      store %10, %0[%8] : memref<10xi32>
    }
    %1 = affine.parallel (%arg3) = (0) to (10) reduce ("assign") -> (memref<10xi32>) {
      %2 = pxa.reduce assign %c0_i32, %arg2[%arg3] : memref<10xi32>
      %3 = pxa.load %0[%arg3] : memref<10xi32>
      %4 = pxa.load %0[%arg3] : memref<10xi32>
      %5 = pxa.reduce assign %3, %2[%arg3] : memref<10xi32>
      affine.yield %5 : memref<10xi32>
    } {tags = {cpuThread}}
    return %1 : memref<10xi32>
  }
  func @fini(%arg0: !stdx.argpack) {
    stdx.unpack %arg0 : 
    return
  }
}


2021-04-07 05:11:48,567 VERBOSE-3 [default] alloc: %0 = alloc() : memref<10xi32>
2021-04-07 05:11:48,567 VERBOSE-3 [default]   use: %3 = pxa.load %0[%arg3] : memref<10xi32>
2021-04-07 05:11:48,567 VERBOSE-3 [default]   ancestor: %3 = pxa.load %0[%arg3] : memref<10xi32>
2021-04-07 05:11:48,567 VERBOSE-3 [default]   use: %4 = pxa.load %0[%arg3] : memref<10xi32>
2021-04-07 05:11:48,567 VERBOSE-3 [default]   ancestor: %4 = pxa.load %0[%arg3] : memref<10xi32>
2021-04-07 05:11:48,567 VERBOSE-3 [default]   use: store %10, %0[%8] : memref<10xi32>
2021-04-07 05:11:48,567 VERBOSE-3 [default]   ancestor: store %10, %0[%8] : memref<10xi32>
2021-04-07 05:11:48,567 VERBOSE-3 [default]   use: store %9, %0[%arg3] : memref<10xi32>
2021-04-07 05:11:48,567 VERBOSE-3 [default]   ancestor: store %9, %0[%arg3] : memref<10xi32>
2021-04-07 05:11:48,567 VERBOSE-3 [default]   use: %10 = load %0[%arg3] : memref<10xi32>
2021-04-07 05:11:48,567 VERBOSE-3 [default]   ancestor: %10 = load %0[%arg3] : memref<10xi32>
2021-04-07 05:11:48,567 VERBOSE-3 [default]   use: %9 = load %0[%8] : memref<10xi32>
2021-04-07 05:11:48,567 VERBOSE-3 [default]   ancestor: %9 = load %0[%8] : memref<10xi32>
2021-04-07 05:11:48,567 VERBOSE-3 [default]   use: %11 = load %0[%arg4] : memref<10xi32>
2021-04-07 05:11:48,567 VERBOSE-3 [default]   ancestor: %11 = load %0[%arg4] : memref<10xi32>
2021-04-07 05:11:48,567 VERBOSE-3 [default]   use: %3 = load %0[%arg3] : memref<10xi32>
2021-04-07 05:11:48,567 VERBOSE-3 [default]   ancestor: %3 = load %0[%arg3] : memref<10xi32>
2021-04-07 05:11:48,567 VERBOSE-3 [default]   use: store %2, %0[%arg3] : memref<10xi32>
2021-04-07 05:11:48,567 VERBOSE-3 [default]   ancestor: store %2, %0[%arg3] : memref<10xi32>
2021-04-07 05:11:48,567 VERBOSE-3 [default]   last ancestor: %1 = affine.parallel (%arg3) = (0) to (10) reduce ("assign") -> (memref<10xi32>) {
  %2 = pxa.reduce assign %c0_i32, %arg2[%arg3] : memref<10xi32>
  %3 = pxa.load %0[%arg3] : memref<10xi32>
  %4 = pxa.load %0[%arg3] : memref<10xi32>
  %5 = pxa.reduce assign %3, %2[%arg3] : memref<10xi32>
  affine.yield %5 : memref<10xi32>
} {tags = {cpuThread}}
2021-04-07 05:11:48,567 VERBOSE-3 [default]   next operation: return %1 : memref<10xi32>
// *** IR Dump After DeallocPlacement *** ('module' operation: @argsort)
module @argsort  {
  func @init() -> !stdx.argpack {
    %0 = stdx.pack  : 
    return %0 : !stdx.argpack
  }
  func @main(%arg0: !stdx.argpack, %arg1: memref<20xf32>, %arg2: memref<10xi32>) -> memref<10xi32> {
    %c0_i32 = constant 0 : i32
    %c0 = constant 0 : index
    %c1 = constant 1 : index
    %c20 = constant 20 : index
    %c19 = constant 19 : index
    stdx.unpack %arg0 : 
    %0 = alloc() : memref<10xi32>
    scf.for %arg3 = %c0 to %c20 step %c1 {
      %2 = index_cast %arg3 : index to i32
      store %2, %0[%arg3] : memref<10xi32>
    }
    scf.for %arg3 = %c0 to %c19 step %c1 {
      %2 = alloca() : memref<1xindex>
      store %arg3, %2[%c0] : memref<1xindex>
      %3 = load %0[%arg3] : memref<10xi32>
      %4 = index_cast %3 : i32 to index
      %5 = load %arg1[%4] : memref<20xf32>
      %6 = alloca() : memref<1xf32>
      store %5, %6[%c0] : memref<1xf32>
      %7 = addi %arg3, %c1 : index
      scf.for %arg4 = %7 to %c20 step %c1 {
        %11 = load %0[%arg4] : memref<10xi32>
        %12 = index_cast %11 : i32 to index
        %13 = load %arg1[%12] : memref<20xf32>
        %14 = load %6[%c0] : memref<1xf32>
        %15 = cmpf olt, %13, %14 : f32
        scf.if %15 {
          store %arg4, %2[%c0] : memref<1xindex>
          store %13, %6[%c0] : memref<1xf32>
        }
      }
      %8 = load %2[%c0] : memref<1xindex>
      %9 = load %0[%8] : memref<10xi32>
      %10 = load %0[%arg3] : memref<10xi32>
      store %9, %0[%arg3] : memref<10xi32>
      store %10, %0[%8] : memref<10xi32>
    }
    %1 = affine.parallel (%arg3) = (0) to (10) reduce ("assign") -> (memref<10xi32>) {
      %2 = pxa.reduce assign %c0_i32, %arg2[%arg3] : memref<10xi32>
      %3 = pxa.load %0[%arg3] : memref<10xi32>
      %4 = pxa.load %0[%arg3] : memref<10xi32>
      %5 = pxa.reduce assign %3, %2[%arg3] : memref<10xi32>
      affine.yield %5 : memref<10xi32>
    } {tags = {cpuThread}}
    dealloc %0 : memref<10xi32>
    return %1 : memref<10xi32>
  }
  func @fini(%arg0: !stdx.argpack) {
    stdx.unpack %arg0 : 
    return
  }
}


// *** IR Dump After AffineNormalize *** ('func' operation: @init)
module @argsort  {
  func @init() -> !stdx.argpack {
    %0 = stdx.pack  : 
    return %0 : !stdx.argpack
  }
  func @main(%arg0: !stdx.argpack, %arg1: memref<20xf32>, %arg2: memref<10xi32>) -> memref<10xi32> {
    %c0_i32 = constant 0 : i32
    %c0 = constant 0 : index
    %c1 = constant 1 : index
    %c20 = constant 20 : index
    %c19 = constant 19 : index
    stdx.unpack %arg0 : 
    %0 = alloc() : memref<10xi32>
    scf.for %arg3 = %c0 to %c20 step %c1 {
      %2 = index_cast %arg3 : index to i32
      store %2, %0[%arg3] : memref<10xi32>
    }
    scf.for %arg3 = %c0 to %c19 step %c1 {
      %2 = alloca() : memref<1xindex>
      store %arg3, %2[%c0] : memref<1xindex>
      %3 = load %0[%arg3] : memref<10xi32>
      %4 = index_cast %3 : i32 to index
      %5 = load %arg1[%4] : memref<20xf32>
      %6 = alloca() : memref<1xf32>
      store %5, %6[%c0] : memref<1xf32>
      %7 = addi %arg3, %c1 : index
      scf.for %arg4 = %7 to %c20 step %c1 {
        %11 = load %0[%arg4] : memref<10xi32>
        %12 = index_cast %11 : i32 to index
        %13 = load %arg1[%12] : memref<20xf32>
        %14 = load %6[%c0] : memref<1xf32>
        %15 = cmpf olt, %13, %14 : f32
        scf.if %15 {
          store %arg4, %2[%c0] : memref<1xindex>
          store %13, %6[%c0] : memref<1xf32>
        }
      }
      %8 = load %2[%c0] : memref<1xindex>
      %9 = load %0[%8] : memref<10xi32>
      %10 = load %0[%arg3] : memref<10xi32>
      store %9, %0[%arg3] : memref<10xi32>
      store %10, %0[%8] : memref<10xi32>
    }
    %1 = affine.parallel (%arg3) = (0) to (10) reduce ("assign") -> (memref<10xi32>) {
      %2 = pxa.reduce assign %c0_i32, %arg2[%arg3] : memref<10xi32>
      %3 = pxa.load %0[%arg3] : memref<10xi32>
      %4 = pxa.load %0[%arg3] : memref<10xi32>
      %5 = pxa.reduce assign %3, %2[%arg3] : memref<10xi32>
      affine.yield %5 : memref<10xi32>
    } {tags = {cpuThread}}
    dealloc %0 : memref<10xi32>
    return %1 : memref<10xi32>
  }
  func @fini(%arg0: !stdx.argpack) {
    stdx.unpack %arg0 : 
    return
  }
}


// *** IR Dump After AffineNormalize *** ('func' operation: @main)
module @argsort  {
  func @init() -> !stdx.argpack {
    %0 = stdx.pack  : 
    return %0 : !stdx.argpack
  }
  func @main(%arg0: !stdx.argpack, %arg1: memref<20xf32>, %arg2: memref<10xi32>) -> memref<10xi32> {
    %c0_i32 = constant 0 : i32
    %c0 = constant 0 : index
    %c1 = constant 1 : index
    %c20 = constant 20 : index
    %c19 = constant 19 : index
    stdx.unpack %arg0 : 
    %0 = alloc() : memref<10xi32>
    scf.for %arg3 = %c0 to %c20 step %c1 {
      %2 = index_cast %arg3 : index to i32
      store %2, %0[%arg3] : memref<10xi32>
    }
    scf.for %arg3 = %c0 to %c19 step %c1 {
      %2 = alloca() : memref<1xindex>
      store %arg3, %2[%c0] : memref<1xindex>
      %3 = load %0[%arg3] : memref<10xi32>
      %4 = index_cast %3 : i32 to index
      %5 = load %arg1[%4] : memref<20xf32>
      %6 = alloca() : memref<1xf32>
      store %5, %6[%c0] : memref<1xf32>
      %7 = addi %arg3, %c1 : index
      scf.for %arg4 = %7 to %c20 step %c1 {
        %11 = load %0[%arg4] : memref<10xi32>
        %12 = index_cast %11 : i32 to index
        %13 = load %arg1[%12] : memref<20xf32>
        %14 = load %6[%c0] : memref<1xf32>
        %15 = cmpf olt, %13, %14 : f32
        scf.if %15 {
          store %arg4, %2[%c0] : memref<1xindex>
          store %13, %6[%c0] : memref<1xf32>
        }
      }
      %8 = load %2[%c0] : memref<1xindex>
      %9 = load %0[%8] : memref<10xi32>
      %10 = load %0[%arg3] : memref<10xi32>
      store %9, %0[%arg3] : memref<10xi32>
      store %10, %0[%8] : memref<10xi32>
    }
    %1 = affine.parallel (%arg3) = (0) to (10) reduce ("assign") -> (memref<10xi32>) {
      %2 = pxa.reduce assign %c0_i32, %arg2[%arg3] : memref<10xi32>
      %3 = pxa.load %0[%arg3] : memref<10xi32>
      %4 = pxa.load %0[%arg3] : memref<10xi32>
      %5 = pxa.reduce assign %3, %2[%arg3] : memref<10xi32>
      affine.yield %5 : memref<10xi32>
    } {tags = {cpuThread}}
    dealloc %0 : memref<10xi32>
    return %1 : memref<10xi32>
  }
  func @fini(%arg0: !stdx.argpack) {
    stdx.unpack %arg0 : 
    return
  }
}


// *** IR Dump After AffineNormalize *** ('func' operation: @fini)
module @argsort  {
  func @init() -> !stdx.argpack {
    %0 = stdx.pack  : 
    return %0 : !stdx.argpack
  }
  func @main(%arg0: !stdx.argpack, %arg1: memref<20xf32>, %arg2: memref<10xi32>) -> memref<10xi32> {
    %c0_i32 = constant 0 : i32
    %c0 = constant 0 : index
    %c1 = constant 1 : index
    %c20 = constant 20 : index
    %c19 = constant 19 : index
    stdx.unpack %arg0 : 
    %0 = alloc() : memref<10xi32>
    scf.for %arg3 = %c0 to %c20 step %c1 {
      %2 = index_cast %arg3 : index to i32
      store %2, %0[%arg3] : memref<10xi32>
    }
    scf.for %arg3 = %c0 to %c19 step %c1 {
      %2 = alloca() : memref<1xindex>
      store %arg3, %2[%c0] : memref<1xindex>
      %3 = load %0[%arg3] : memref<10xi32>
      %4 = index_cast %3 : i32 to index
      %5 = load %arg1[%4] : memref<20xf32>
      %6 = alloca() : memref<1xf32>
      store %5, %6[%c0] : memref<1xf32>
      %7 = addi %arg3, %c1 : index
      scf.for %arg4 = %7 to %c20 step %c1 {
        %11 = load %0[%arg4] : memref<10xi32>
        %12 = index_cast %11 : i32 to index
        %13 = load %arg1[%12] : memref<20xf32>
        %14 = load %6[%c0] : memref<1xf32>
        %15 = cmpf olt, %13, %14 : f32
        scf.if %15 {
          store %arg4, %2[%c0] : memref<1xindex>
          store %13, %6[%c0] : memref<1xf32>
        }
      }
      %8 = load %2[%c0] : memref<1xindex>
      %9 = load %0[%8] : memref<10xi32>
      %10 = load %0[%arg3] : memref<10xi32>
      store %9, %0[%arg3] : memref<10xi32>
      store %10, %0[%8] : memref<10xi32>
    }
    %1 = affine.parallel (%arg3) = (0) to (10) reduce ("assign") -> (memref<10xi32>) {
      %2 = pxa.reduce assign %c0_i32, %arg2[%arg3] : memref<10xi32>
      %3 = pxa.load %0[%arg3] : memref<10xi32>
      %4 = pxa.load %0[%arg3] : memref<10xi32>
      %5 = pxa.reduce assign %3, %2[%arg3] : memref<10xi32>
      affine.yield %5 : memref<10xi32>
    } {tags = {cpuThread}}
    dealloc %0 : memref<10xi32>
    return %1 : memref<10xi32>
  }
  func @fini(%arg0: !stdx.argpack) {
    stdx.unpack %arg0 : 
    return
  }
}


// *** IR Dump After Canonicalizer *** ('module' operation: @argsort)
module @argsort  {
  func @init() -> !stdx.argpack {
    %0 = stdx.pack  : 
    return %0 : !stdx.argpack
  }
  func @main(%arg0: !stdx.argpack, %arg1: memref<20xf32>, %arg2: memref<10xi32>) -> memref<10xi32> {
    %c0_i32 = constant 0 : i32
    %c0 = constant 0 : index
    %c1 = constant 1 : index
    %c20 = constant 20 : index
    %c19 = constant 19 : index
    stdx.unpack %arg0 : 
    %0 = alloc() : memref<10xi32>
    scf.for %arg3 = %c0 to %c20 step %c1 {
      %2 = index_cast %arg3 : index to i32
      store %2, %0[%arg3] : memref<10xi32>
    }
    scf.for %arg3 = %c0 to %c19 step %c1 {
      %2 = alloca() : memref<1xindex>
      store %arg3, %2[%c0] : memref<1xindex>
      %3 = load %0[%arg3] : memref<10xi32>
      %4 = index_cast %3 : i32 to index
      %5 = load %arg1[%4] : memref<20xf32>
      %6 = alloca() : memref<1xf32>
      store %5, %6[%c0] : memref<1xf32>
      %7 = addi %arg3, %c1 : index
      scf.for %arg4 = %7 to %c20 step %c1 {
        %11 = load %0[%arg4] : memref<10xi32>
        %12 = index_cast %11 : i32 to index
        %13 = load %arg1[%12] : memref<20xf32>
        %14 = load %6[%c0] : memref<1xf32>
        %15 = cmpf olt, %13, %14 : f32
        scf.if %15 {
          store %arg4, %2[%c0] : memref<1xindex>
          store %13, %6[%c0] : memref<1xf32>
        }
      }
      %8 = load %2[%c0] : memref<1xindex>
      %9 = load %0[%8] : memref<10xi32>
      %10 = load %0[%arg3] : memref<10xi32>
      store %9, %0[%arg3] : memref<10xi32>
      store %10, %0[%8] : memref<10xi32>
    }
    %1 = affine.parallel (%arg3) = (0) to (10) reduce ("assign") -> (memref<10xi32>) {
      %2 = pxa.reduce assign %c0_i32, %arg2[%arg3] : memref<10xi32>
      %3 = pxa.load %0[%arg3] : memref<10xi32>
      %4 = pxa.reduce assign %3, %2[%arg3] : memref<10xi32>
      affine.yield %4 : memref<10xi32>
    } {tags = {cpuThread}}
    dealloc %0 : memref<10xi32>
    return %1 : memref<10xi32>
  }
  func @fini(%arg0: !stdx.argpack) {
    stdx.unpack %arg0 : 
    return
  }
}


// *** IR Dump After CSE *** ('module' operation: @argsort)
module @argsort  {
  func @init() -> !stdx.argpack {
    %0 = stdx.pack  : 
    return %0 : !stdx.argpack
  }
  func @main(%arg0: !stdx.argpack, %arg1: memref<20xf32>, %arg2: memref<10xi32>) -> memref<10xi32> {
    %c0_i32 = constant 0 : i32
    %c0 = constant 0 : index
    %c1 = constant 1 : index
    %c20 = constant 20 : index
    %c19 = constant 19 : index
    stdx.unpack %arg0 : 
    %0 = alloc() : memref<10xi32>
    scf.for %arg3 = %c0 to %c20 step %c1 {
      %2 = index_cast %arg3 : index to i32
      store %2, %0[%arg3] : memref<10xi32>
    }
    scf.for %arg3 = %c0 to %c19 step %c1 {
      %2 = alloca() : memref<1xindex>
      store %arg3, %2[%c0] : memref<1xindex>
      %3 = load %0[%arg3] : memref<10xi32>
      %4 = index_cast %3 : i32 to index
      %5 = load %arg1[%4] : memref<20xf32>
      %6 = alloca() : memref<1xf32>
      store %5, %6[%c0] : memref<1xf32>
      %7 = addi %arg3, %c1 : index
      scf.for %arg4 = %7 to %c20 step %c1 {
        %11 = load %0[%arg4] : memref<10xi32>
        %12 = index_cast %11 : i32 to index
        %13 = load %arg1[%12] : memref<20xf32>
        %14 = load %6[%c0] : memref<1xf32>
        %15 = cmpf olt, %13, %14 : f32
        scf.if %15 {
          store %arg4, %2[%c0] : memref<1xindex>
          store %13, %6[%c0] : memref<1xf32>
        }
      }
      %8 = load %2[%c0] : memref<1xindex>
      %9 = load %0[%8] : memref<10xi32>
      %10 = load %0[%arg3] : memref<10xi32>
      store %9, %0[%arg3] : memref<10xi32>
      store %10, %0[%8] : memref<10xi32>
    }
    %1 = affine.parallel (%arg3) = (0) to (10) reduce ("assign") -> (memref<10xi32>) {
      %2 = pxa.reduce assign %c0_i32, %arg2[%arg3] : memref<10xi32>
      %3 = pxa.load %0[%arg3] : memref<10xi32>
      %4 = pxa.reduce assign %3, %2[%arg3] : memref<10xi32>
      affine.yield %4 : memref<10xi32>
    } {tags = {cpuThread}}
    dealloc %0 : memref<10xi32>
    return %1 : memref<10xi32>
  }
  func @fini(%arg0: !stdx.argpack) {
    stdx.unpack %arg0 : 
    return
  }
}


2021-04-07 05:11:48,571 VERBOSE-2 [default] FuncOpConversion::rewrite> () -> !stdx.argpack
2021-04-07 05:11:48,571 VERBOSE-2 [default] ReturnOpConversion::matchAndRewrite>
2021-04-07 05:11:48,571 VERBOSE-2 [default] FuncOpConversion::rewrite> (!stdx.argpack, memref<20xf32>, memref<10xi32>) -> memref<10xi32>
2021-04-07 05:11:48,571 VERBOSE-2 [default] ReturnOpConversion::matchAndRewrite>
// *** IR Dump After ConvertPXAToAffine *** ('module' operation: @argsort)
module @argsort  {
  func @init() -> !stdx.argpack {
    %0 = stdx.pack  : 
    return %0 : !stdx.argpack
  }
  func @main(%arg0: !stdx.argpack, %arg1: memref<20xf32>, %arg2: memref<10xi32>) {
    %c0_i32 = constant 0 : i32
    %c0 = constant 0 : index
    %c1 = constant 1 : index
    %c20 = constant 20 : index
    %c19 = constant 19 : index
    stdx.unpack %arg0 : 
    %0 = alloc() : memref<10xi32>
    scf.for %arg3 = %c0 to %c20 step %c1 {
      %1 = index_cast %arg3 : index to i32
      store %1, %0[%arg3] : memref<10xi32>
    }
    scf.for %arg3 = %c0 to %c19 step %c1 {
      %1 = alloca() : memref<1xindex>
      store %arg3, %1[%c0] : memref<1xindex>
      %2 = load %0[%arg3] : memref<10xi32>
      %3 = index_cast %2 : i32 to index
      %4 = load %arg1[%3] : memref<20xf32>
      %5 = alloca() : memref<1xf32>
      store %4, %5[%c0] : memref<1xf32>
      %6 = addi %arg3, %c1 : index
      scf.for %arg4 = %6 to %c20 step %c1 {
        %10 = load %0[%arg4] : memref<10xi32>
        %11 = index_cast %10 : i32 to index
        %12 = load %arg1[%11] : memref<20xf32>
        %13 = load %5[%c0] : memref<1xf32>
        %14 = cmpf olt, %12, %13 : f32
        scf.if %14 {
          store %arg4, %1[%c0] : memref<1xindex>
          store %12, %5[%c0] : memref<1xf32>
        }
      }
      %7 = load %1[%c0] : memref<1xindex>
      %8 = load %0[%7] : memref<10xi32>
      %9 = load %0[%arg3] : memref<10xi32>
      store %8, %0[%arg3] : memref<10xi32>
      store %9, %0[%7] : memref<10xi32>
    }
    affine.parallel (%arg3) = (0) to (10) {
      %1 = affine.load %arg2[%arg3] : memref<10xi32>
      affine.store %c0_i32, %arg2[%arg3] : memref<10xi32>
      %2 = affine.load %0[%arg3] : memref<10xi32>
      %3 = affine.load %arg2[%arg3] : memref<10xi32>
      affine.store %2, %arg2[%arg3] : memref<10xi32>
    } {tags = {cpuThread}}
    dealloc %0 : memref<10xi32>
    return
  }
  func @fini(%arg0: !stdx.argpack) {
    stdx.unpack %arg0 : 
    return
  }
}


// *** IR Dump After LoopInvariantCodeMotion *** ('module' operation: @argsort)
module @argsort  {
  func @init() -> !stdx.argpack {
    %0 = stdx.pack  : 
    return %0 : !stdx.argpack
  }
  func @main(%arg0: !stdx.argpack, %arg1: memref<20xf32>, %arg2: memref<10xi32>) {
    %c0_i32 = constant 0 : i32
    %c0 = constant 0 : index
    %c1 = constant 1 : index
    %c20 = constant 20 : index
    %c19 = constant 19 : index
    stdx.unpack %arg0 : 
    %0 = alloc() : memref<10xi32>
    scf.for %arg3 = %c0 to %c20 step %c1 {
      %1 = index_cast %arg3 : index to i32
      store %1, %0[%arg3] : memref<10xi32>
    }
    scf.for %arg3 = %c0 to %c19 step %c1 {
      %1 = alloca() : memref<1xindex>
      store %arg3, %1[%c0] : memref<1xindex>
      %2 = load %0[%arg3] : memref<10xi32>
      %3 = index_cast %2 : i32 to index
      %4 = load %arg1[%3] : memref<20xf32>
      %5 = alloca() : memref<1xf32>
      store %4, %5[%c0] : memref<1xf32>
      %6 = addi %arg3, %c1 : index
      scf.for %arg4 = %6 to %c20 step %c1 {
        %10 = load %0[%arg4] : memref<10xi32>
        %11 = index_cast %10 : i32 to index
        %12 = load %arg1[%11] : memref<20xf32>
        %13 = load %5[%c0] : memref<1xf32>
        %14 = cmpf olt, %12, %13 : f32
        scf.if %14 {
          store %arg4, %1[%c0] : memref<1xindex>
          store %12, %5[%c0] : memref<1xf32>
        }
      }
      %7 = load %1[%c0] : memref<1xindex>
      %8 = load %0[%7] : memref<10xi32>
      %9 = load %0[%arg3] : memref<10xi32>
      store %8, %0[%arg3] : memref<10xi32>
      store %9, %0[%7] : memref<10xi32>
    }
    affine.parallel (%arg3) = (0) to (10) {
      %1 = affine.load %arg2[%arg3] : memref<10xi32>
      affine.store %c0_i32, %arg2[%arg3] : memref<10xi32>
      %2 = affine.load %0[%arg3] : memref<10xi32>
      %3 = affine.load %arg2[%arg3] : memref<10xi32>
      affine.store %2, %arg2[%arg3] : memref<10xi32>
    } {tags = {cpuThread}}
    dealloc %0 : memref<10xi32>
    return
  }
  func @fini(%arg0: !stdx.argpack) {
    stdx.unpack %arg0 : 
    return
  }
}


// *** IR Dump After Canonicalizer *** ('module' operation: @argsort)
module @argsort  {
  func @init() -> !stdx.argpack {
    %0 = stdx.pack  : 
    return %0 : !stdx.argpack
  }
  func @main(%arg0: !stdx.argpack, %arg1: memref<20xf32>, %arg2: memref<10xi32>) {
    %c0_i32 = constant 0 : i32
    %c0 = constant 0 : index
    %c1 = constant 1 : index
    %c20 = constant 20 : index
    %c19 = constant 19 : index
    stdx.unpack %arg0 : 
    %0 = alloc() : memref<10xi32>
    scf.for %arg3 = %c0 to %c20 step %c1 {
      %1 = index_cast %arg3 : index to i32
      store %1, %0[%arg3] : memref<10xi32>
    }
    scf.for %arg3 = %c0 to %c19 step %c1 {
      %1 = alloca() : memref<1xindex>
      store %arg3, %1[%c0] : memref<1xindex>
      %2 = load %0[%arg3] : memref<10xi32>
      %3 = index_cast %2 : i32 to index
      %4 = load %arg1[%3] : memref<20xf32>
      %5 = alloca() : memref<1xf32>
      store %4, %5[%c0] : memref<1xf32>
      %6 = addi %arg3, %c1 : index
      scf.for %arg4 = %6 to %c20 step %c1 {
        %10 = load %0[%arg4] : memref<10xi32>
        %11 = index_cast %10 : i32 to index
        %12 = load %arg1[%11] : memref<20xf32>
        %13 = load %5[%c0] : memref<1xf32>
        %14 = cmpf olt, %12, %13 : f32
        scf.if %14 {
          store %arg4, %1[%c0] : memref<1xindex>
          store %12, %5[%c0] : memref<1xf32>
        }
      }
      %7 = load %1[%c0] : memref<1xindex>
      %8 = load %0[%7] : memref<10xi32>
      %9 = load %0[%arg3] : memref<10xi32>
      store %8, %0[%arg3] : memref<10xi32>
      store %9, %0[%7] : memref<10xi32>
    }
    affine.parallel (%arg3) = (0) to (10) {
      affine.store %c0_i32, %arg2[%arg3] : memref<10xi32>
      %1 = affine.load %0[%arg3] : memref<10xi32>
      affine.store %1, %arg2[%arg3] : memref<10xi32>
    } {tags = {cpuThread}}
    dealloc %0 : memref<10xi32>
    return
  }
  func @fini(%arg0: !stdx.argpack) {
    stdx.unpack %arg0 : 
    return
  }
}


// *** IR Dump After CSE *** ('module' operation: @argsort)
module @argsort  {
  func @init() -> !stdx.argpack {
    %0 = stdx.pack  : 
    return %0 : !stdx.argpack
  }
  func @main(%arg0: !stdx.argpack, %arg1: memref<20xf32>, %arg2: memref<10xi32>) {
    %c0_i32 = constant 0 : i32
    %c0 = constant 0 : index
    %c1 = constant 1 : index
    %c20 = constant 20 : index
    %c19 = constant 19 : index
    stdx.unpack %arg0 : 
    %0 = alloc() : memref<10xi32>
    scf.for %arg3 = %c0 to %c20 step %c1 {
      %1 = index_cast %arg3 : index to i32
      store %1, %0[%arg3] : memref<10xi32>
    }
    scf.for %arg3 = %c0 to %c19 step %c1 {
      %1 = alloca() : memref<1xindex>
      store %arg3, %1[%c0] : memref<1xindex>
      %2 = load %0[%arg3] : memref<10xi32>
      %3 = index_cast %2 : i32 to index
      %4 = load %arg1[%3] : memref<20xf32>
      %5 = alloca() : memref<1xf32>
      store %4, %5[%c0] : memref<1xf32>
      %6 = addi %arg3, %c1 : index
      scf.for %arg4 = %6 to %c20 step %c1 {
        %10 = load %0[%arg4] : memref<10xi32>
        %11 = index_cast %10 : i32 to index
        %12 = load %arg1[%11] : memref<20xf32>
        %13 = load %5[%c0] : memref<1xf32>
        %14 = cmpf olt, %12, %13 : f32
        scf.if %14 {
          store %arg4, %1[%c0] : memref<1xindex>
          store %12, %5[%c0] : memref<1xf32>
        }
      }
      %7 = load %1[%c0] : memref<1xindex>
      %8 = load %0[%7] : memref<10xi32>
      %9 = load %0[%arg3] : memref<10xi32>
      store %8, %0[%arg3] : memref<10xi32>
      store %9, %0[%7] : memref<10xi32>
    }
    affine.parallel (%arg3) = (0) to (10) {
      affine.store %c0_i32, %arg2[%arg3] : memref<10xi32>
      %1 = affine.load %0[%arg3] : memref<10xi32>
      affine.store %1, %arg2[%arg3] : memref<10xi32>
    } {tags = {cpuThread}}
    dealloc %0 : memref<10xi32>
    return
  }
  func @fini(%arg0: !stdx.argpack) {
    stdx.unpack %arg0 : 
    return
  }
}


// *** IR Dump After ConvertAffineToStandard *** ('module' operation: @argsort)
module @argsort  {
  func @init() -> !stdx.argpack {
    %0 = stdx.pack  : 
    return %0 : !stdx.argpack
  }
  func @main(%arg0: !stdx.argpack, %arg1: memref<20xf32>, %arg2: memref<10xi32>) {
    %c0_i32 = constant 0 : i32
    %c0 = constant 0 : index
    %c1 = constant 1 : index
    %c20 = constant 20 : index
    %c19 = constant 19 : index
    stdx.unpack %arg0 : 
    %0 = alloc() : memref<10xi32>
    scf.for %arg3 = %c0 to %c20 step %c1 {
      %1 = index_cast %arg3 : index to i32
      store %1, %0[%arg3] : memref<10xi32>
    }
    scf.for %arg3 = %c0 to %c19 step %c1 {
      %1 = alloca() : memref<1xindex>
      store %arg3, %1[%c0] : memref<1xindex>
      %2 = load %0[%arg3] : memref<10xi32>
      %3 = index_cast %2 : i32 to index
      %4 = load %arg1[%3] : memref<20xf32>
      %5 = alloca() : memref<1xf32>
      store %4, %5[%c0] : memref<1xf32>
      %6 = addi %arg3, %c1 : index
      scf.for %arg4 = %6 to %c20 step %c1 {
        %10 = load %0[%arg4] : memref<10xi32>
        %11 = index_cast %10 : i32 to index
        %12 = load %arg1[%11] : memref<20xf32>
        %13 = load %5[%c0] : memref<1xf32>
        %14 = cmpf olt, %12, %13 : f32
        scf.if %14 {
          store %arg4, %1[%c0] : memref<1xindex>
          store %12, %5[%c0] : memref<1xf32>
        }
      }
      %7 = load %1[%c0] : memref<1xindex>
      %8 = load %0[%7] : memref<10xi32>
      %9 = load %0[%arg3] : memref<10xi32>
      store %8, %0[%arg3] : memref<10xi32>
      store %9, %0[%7] : memref<10xi32>
    }
    %c0_0 = constant 0 : index
    %c10 = constant 10 : index
    %c1_1 = constant 1 : index
    scf.parallel (%arg3) = (%c0_0) to (%c10) step (%c1_1) {
      store %c0_i32, %arg2[%arg3] : memref<10xi32>
      %1 = load %0[%arg3] : memref<10xi32>
      store %1, %arg2[%arg3] : memref<10xi32>
      scf.yield
    }
    dealloc %0 : memref<10xi32>
    return
  }
  func @fini(%arg0: !stdx.argpack) {
    stdx.unpack %arg0 : 
    return
  }
}


// *** IR Dump After Canonicalizer *** ('module' operation: @argsort)
module @argsort  {
  func @init() -> !stdx.argpack {
    %0 = stdx.pack  : 
    return %0 : !stdx.argpack
  }
  func @main(%arg0: !stdx.argpack, %arg1: memref<20xf32>, %arg2: memref<10xi32>) {
    %c0_i32 = constant 0 : i32
    %c20 = constant 20 : index
    %c19 = constant 19 : index
    %c0 = constant 0 : index
    %c10 = constant 10 : index
    %c1 = constant 1 : index
    stdx.unpack %arg0 : 
    %0 = alloc() : memref<10xi32>
    scf.for %arg3 = %c0 to %c20 step %c1 {
      %1 = index_cast %arg3 : index to i32
      store %1, %0[%arg3] : memref<10xi32>
    }
    scf.for %arg3 = %c0 to %c19 step %c1 {
      %1 = alloca() : memref<1xindex>
      store %arg3, %1[%c0] : memref<1xindex>
      %2 = load %0[%arg3] : memref<10xi32>
      %3 = index_cast %2 : i32 to index
      %4 = load %arg1[%3] : memref<20xf32>
      %5 = alloca() : memref<1xf32>
      store %4, %5[%c0] : memref<1xf32>
      %6 = addi %arg3, %c1 : index
      scf.for %arg4 = %6 to %c20 step %c1 {
        %10 = load %0[%arg4] : memref<10xi32>
        %11 = index_cast %10 : i32 to index
        %12 = load %arg1[%11] : memref<20xf32>
        %13 = load %5[%c0] : memref<1xf32>
        %14 = cmpf olt, %12, %13 : f32
        scf.if %14 {
          store %arg4, %1[%c0] : memref<1xindex>
          store %12, %5[%c0] : memref<1xf32>
        }
      }
      %7 = load %1[%c0] : memref<1xindex>
      %8 = load %0[%7] : memref<10xi32>
      %9 = load %0[%arg3] : memref<10xi32>
      store %8, %0[%arg3] : memref<10xi32>
      store %9, %0[%7] : memref<10xi32>
    }
    scf.parallel (%arg3) = (%c0) to (%c10) step (%c1) {
      store %c0_i32, %arg2[%arg3] : memref<10xi32>
      %1 = load %0[%arg3] : memref<10xi32>
      store %1, %arg2[%arg3] : memref<10xi32>
      scf.yield
    }
    dealloc %0 : memref<10xi32>
    return
  }
  func @fini(%arg0: !stdx.argpack) {
    stdx.unpack %arg0 : 
    return
  }
}


// *** IR Dump After CSE *** ('module' operation: @argsort)
module @argsort  {
  func @init() -> !stdx.argpack {
    %0 = stdx.pack  : 
    return %0 : !stdx.argpack
  }
  func @main(%arg0: !stdx.argpack, %arg1: memref<20xf32>, %arg2: memref<10xi32>) {
    %c0_i32 = constant 0 : i32
    %c20 = constant 20 : index
    %c19 = constant 19 : index
    %c0 = constant 0 : index
    %c10 = constant 10 : index
    %c1 = constant 1 : index
    stdx.unpack %arg0 : 
    %0 = alloc() : memref<10xi32>
    scf.for %arg3 = %c0 to %c20 step %c1 {
      %1 = index_cast %arg3 : index to i32
      store %1, %0[%arg3] : memref<10xi32>
    }
    scf.for %arg3 = %c0 to %c19 step %c1 {
      %1 = alloca() : memref<1xindex>
      store %arg3, %1[%c0] : memref<1xindex>
      %2 = load %0[%arg3] : memref<10xi32>
      %3 = index_cast %2 : i32 to index
      %4 = load %arg1[%3] : memref<20xf32>
      %5 = alloca() : memref<1xf32>
      store %4, %5[%c0] : memref<1xf32>
      %6 = addi %arg3, %c1 : index
      scf.for %arg4 = %6 to %c20 step %c1 {
        %10 = load %0[%arg4] : memref<10xi32>
        %11 = index_cast %10 : i32 to index
        %12 = load %arg1[%11] : memref<20xf32>
        %13 = load %5[%c0] : memref<1xf32>
        %14 = cmpf olt, %12, %13 : f32
        scf.if %14 {
          store %arg4, %1[%c0] : memref<1xindex>
          store %12, %5[%c0] : memref<1xf32>
        }
      }
      %7 = load %1[%c0] : memref<1xindex>
      %8 = load %0[%7] : memref<10xi32>
      %9 = load %0[%arg3] : memref<10xi32>
      store %8, %0[%arg3] : memref<10xi32>
      store %9, %0[%7] : memref<10xi32>
    }
    scf.parallel (%arg3) = (%c0) to (%c10) step (%c1) {
      store %c0_i32, %arg2[%arg3] : memref<10xi32>
      %1 = load %0[%arg3] : memref<10xi32>
      store %1, %arg2[%arg3] : memref<10xi32>
      scf.yield
    }
    dealloc %0 : memref<10xi32>
    return
  }
  func @fini(%arg0: !stdx.argpack) {
    stdx.unpack %arg0 : 
    return
  }
}


2021-04-07 05:11:48,575 VERBOSE-2 [default] convertSCPParallel
// *** IR Dump After LowerSCFToOpenMP *** ('module' operation: @argsort)
module @argsort  {
  func @init() -> !stdx.argpack {
    %0 = stdx.pack  : 
    return %0 : !stdx.argpack
  }
  func @main(%arg0: !stdx.argpack, %arg1: memref<20xf32>, %arg2: memref<10xi32>) {
    %c0_i32 = constant 0 : i32
    %c20 = constant 20 : index
    %c19 = constant 19 : index
    %c0 = constant 0 : index
    %c10 = constant 10 : index
    %c1 = constant 1 : index
    stdx.unpack %arg0 : 
    %0 = alloc() : memref<10xi32>
    scf.for %arg3 = %c0 to %c20 step %c1 {
      %1 = index_cast %arg3 : index to i32
      store %1, %0[%arg3] : memref<10xi32>
    }
    scf.for %arg3 = %c0 to %c19 step %c1 {
      %1 = alloca() : memref<1xindex>
      store %arg3, %1[%c0] : memref<1xindex>
      %2 = load %0[%arg3] : memref<10xi32>
      %3 = index_cast %2 : i32 to index
      %4 = load %arg1[%3] : memref<20xf32>
      %5 = alloca() : memref<1xf32>
      store %4, %5[%c0] : memref<1xf32>
      %6 = addi %arg3, %c1 : index
      scf.for %arg4 = %6 to %c20 step %c1 {
        %10 = load %0[%arg4] : memref<10xi32>
        %11 = index_cast %10 : i32 to index
        %12 = load %arg1[%11] : memref<20xf32>
        %13 = load %5[%c0] : memref<1xf32>
        %14 = cmpf olt, %12, %13 : f32
        scf.if %14 {
          store %arg4, %1[%c0] : memref<1xindex>
          store %12, %5[%c0] : memref<1xf32>
        }
      }
      %7 = load %1[%c0] : memref<1xindex>
      %8 = load %0[%7] : memref<10xi32>
      %9 = load %0[%arg3] : memref<10xi32>
      store %8, %0[%arg3] : memref<10xi32>
      store %9, %0[%7] : memref<10xi32>
    }
    %c10_0 = constant 10 : index
    omp.parallel num_threads(%c10_0 : index) default(shared) {
      %1 = call @plaidml_rt_thread_num() : () -> index
      %c10_1 = constant 10 : index
      store %c0_i32, %arg2[%1] : memref<10xi32>
      %2 = load %0[%1] : memref<10xi32>
      store %2, %arg2[%1] : memref<10xi32>
      omp.terminator
    }
    dealloc %0 : memref<10xi32>
    return
  }
  func @fini(%arg0: !stdx.argpack) {
    stdx.unpack %arg0 : 
    return
  }
  func private @plaidml_rt_thread_num() -> index
}


// *** IR Dump After Canonicalizer *** ('module' operation: @argsort)
module @argsort  {
  func @init() -> !stdx.argpack {
    %0 = stdx.pack  : 
    return %0 : !stdx.argpack
  }
  func @main(%arg0: !stdx.argpack, %arg1: memref<20xf32>, %arg2: memref<10xi32>) {
    %c0_i32 = constant 0 : i32
    %c20 = constant 20 : index
    %c19 = constant 19 : index
    %c0 = constant 0 : index
    %c1 = constant 1 : index
    %c10 = constant 10 : index
    stdx.unpack %arg0 : 
    %0 = alloc() : memref<10xi32>
    scf.for %arg3 = %c0 to %c20 step %c1 {
      %1 = index_cast %arg3 : index to i32
      store %1, %0[%arg3] : memref<10xi32>
    }
    scf.for %arg3 = %c0 to %c19 step %c1 {
      %1 = alloca() : memref<1xindex>
      store %arg3, %1[%c0] : memref<1xindex>
      %2 = load %0[%arg3] : memref<10xi32>
      %3 = index_cast %2 : i32 to index
      %4 = load %arg1[%3] : memref<20xf32>
      %5 = alloca() : memref<1xf32>
      store %4, %5[%c0] : memref<1xf32>
      %6 = addi %arg3, %c1 : index
      scf.for %arg4 = %6 to %c20 step %c1 {
        %10 = load %0[%arg4] : memref<10xi32>
        %11 = index_cast %10 : i32 to index
        %12 = load %arg1[%11] : memref<20xf32>
        %13 = load %5[%c0] : memref<1xf32>
        %14 = cmpf olt, %12, %13 : f32
        scf.if %14 {
          store %arg4, %1[%c0] : memref<1xindex>
          store %12, %5[%c0] : memref<1xf32>
        }
      }
      %7 = load %1[%c0] : memref<1xindex>
      %8 = load %0[%7] : memref<10xi32>
      %9 = load %0[%arg3] : memref<10xi32>
      store %8, %0[%arg3] : memref<10xi32>
      store %9, %0[%7] : memref<10xi32>
    }
    omp.parallel num_threads(%c10 : index) default(shared) {
      %1 = call @plaidml_rt_thread_num() : () -> index
      store %c0_i32, %arg2[%1] : memref<10xi32>
      %2 = load %0[%1] : memref<10xi32>
      store %2, %arg2[%1] : memref<10xi32>
      omp.terminator
    }
    dealloc %0 : memref<10xi32>
    return
  }
  func @fini(%arg0: !stdx.argpack) {
    stdx.unpack %arg0 : 
    return
  }
  func private @plaidml_rt_thread_num() -> index
}


// *** IR Dump After CSE *** ('module' operation: @argsort)
module @argsort  {
  func @init() -> !stdx.argpack {
    %0 = stdx.pack  : 
    return %0 : !stdx.argpack
  }
  func @main(%arg0: !stdx.argpack, %arg1: memref<20xf32>, %arg2: memref<10xi32>) {
    %c0_i32 = constant 0 : i32
    %c20 = constant 20 : index
    %c19 = constant 19 : index
    %c0 = constant 0 : index
    %c1 = constant 1 : index
    %c10 = constant 10 : index
    stdx.unpack %arg0 : 
    %0 = alloc() : memref<10xi32>
    scf.for %arg3 = %c0 to %c20 step %c1 {
      %1 = index_cast %arg3 : index to i32
      store %1, %0[%arg3] : memref<10xi32>
    }
    scf.for %arg3 = %c0 to %c19 step %c1 {
      %1 = alloca() : memref<1xindex>
      store %arg3, %1[%c0] : memref<1xindex>
      %2 = load %0[%arg3] : memref<10xi32>
      %3 = index_cast %2 : i32 to index
      %4 = load %arg1[%3] : memref<20xf32>
      %5 = alloca() : memref<1xf32>
      store %4, %5[%c0] : memref<1xf32>
      %6 = addi %arg3, %c1 : index
      scf.for %arg4 = %6 to %c20 step %c1 {
        %10 = load %0[%arg4] : memref<10xi32>
        %11 = index_cast %10 : i32 to index
        %12 = load %arg1[%11] : memref<20xf32>
        %13 = load %5[%c0] : memref<1xf32>
        %14 = cmpf olt, %12, %13 : f32
        scf.if %14 {
          store %arg4, %1[%c0] : memref<1xindex>
          store %12, %5[%c0] : memref<1xf32>
        }
      }
      %7 = load %1[%c0] : memref<1xindex>
      %8 = load %0[%7] : memref<10xi32>
      %9 = load %0[%arg3] : memref<10xi32>
      store %8, %0[%arg3] : memref<10xi32>
      store %9, %0[%7] : memref<10xi32>
    }
    omp.parallel num_threads(%c10 : index) default(shared) {
      %1 = call @plaidml_rt_thread_num() : () -> index
      store %c0_i32, %arg2[%1] : memref<10xi32>
      %2 = load %0[%1] : memref<10xi32>
      store %2, %arg2[%1] : memref<10xi32>
      omp.terminator
    }
    dealloc %0 : memref<10xi32>
    return
  }
  func @fini(%arg0: !stdx.argpack) {
    stdx.unpack %arg0 : 
    return
  }
  func private @plaidml_rt_thread_num() -> index
}


// *** IR Dump After SCFToStandard *** ('module' operation: @argsort)
module @argsort  {
  func @init() -> !stdx.argpack {
    %0 = stdx.pack  : 
    return %0 : !stdx.argpack
  }
  func @main(%arg0: !stdx.argpack, %arg1: memref<20xf32>, %arg2: memref<10xi32>) {
    %c0_i32 = constant 0 : i32
    %c20 = constant 20 : index
    %c19 = constant 19 : index
    %c0 = constant 0 : index
    %c1 = constant 1 : index
    %c10 = constant 10 : index
    stdx.unpack %arg0 : 
    %0 = alloc() : memref<10xi32>
    br ^bb1(%c0 : index)
  ^bb1(%1: index):  // 2 preds: ^bb0, ^bb2
    %2 = cmpi slt, %1, %c20 : index
    cond_br %2, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %3 = index_cast %1 : index to i32
    store %3, %0[%1] : memref<10xi32>
    %4 = addi %1, %c1 : index
    br ^bb1(%4 : index)
  ^bb3:  // pred: ^bb1
    br ^bb4(%c0 : index)
  ^bb4(%5: index):  // 2 preds: ^bb3, ^bb10
    %6 = cmpi slt, %5, %c19 : index
    cond_br %6, ^bb5, ^bb11
  ^bb5:  // pred: ^bb4
    %7 = alloca() : memref<1xindex>
    store %5, %7[%c0] : memref<1xindex>
    %8 = load %0[%5] : memref<10xi32>
    %9 = index_cast %8 : i32 to index
    %10 = load %arg1[%9] : memref<20xf32>
    %11 = alloca() : memref<1xf32>
    store %10, %11[%c0] : memref<1xf32>
    %12 = addi %5, %c1 : index
    br ^bb6(%12 : index)
  ^bb6(%13: index):  // 2 preds: ^bb5, ^bb9
    %14 = cmpi slt, %13, %c20 : index
    cond_br %14, ^bb7, ^bb10
  ^bb7:  // pred: ^bb6
    %15 = load %0[%13] : memref<10xi32>
    %16 = index_cast %15 : i32 to index
    %17 = load %arg1[%16] : memref<20xf32>
    %18 = load %11[%c0] : memref<1xf32>
    %19 = cmpf olt, %17, %18 : f32
    cond_br %19, ^bb8, ^bb9
  ^bb8:  // pred: ^bb7
    store %13, %7[%c0] : memref<1xindex>
    store %17, %11[%c0] : memref<1xf32>
    br ^bb9
  ^bb9:  // 2 preds: ^bb7, ^bb8
    %20 = addi %13, %c1 : index
    br ^bb6(%20 : index)
  ^bb10:  // pred: ^bb6
    %21 = load %7[%c0] : memref<1xindex>
    %22 = load %0[%21] : memref<10xi32>
    %23 = load %0[%5] : memref<10xi32>
    store %22, %0[%5] : memref<10xi32>
    store %23, %0[%21] : memref<10xi32>
    %24 = addi %5, %c1 : index
    br ^bb4(%24 : index)
  ^bb11:  // pred: ^bb4
    omp.parallel num_threads(%c10 : index) default(shared) {
      %25 = call @plaidml_rt_thread_num() : () -> index
      store %c0_i32, %arg2[%25] : memref<10xi32>
      %26 = load %0[%25] : memref<10xi32>
      store %26, %arg2[%25] : memref<10xi32>
      omp.terminator
    }
    dealloc %0 : memref<10xi32>
    return
  }
  func @fini(%arg0: !stdx.argpack) {
    stdx.unpack %arg0 : 
    return
  }
  func private @plaidml_rt_thread_num() -> index
}


// *** IR Dump After ConvertStandardToLLVM *** ('module' operation: @argsort)
module @argsort  {
  llvm.func @free(!llvm.ptr<i8>)
  llvm.func @malloc(i64) -> !llvm.ptr<i8>
  llvm.func @init() -> !llvm.ptr<i8> {
    %0 = llvm.mlir.null : !llvm.ptr<i8>
    llvm.return %0 : !llvm.ptr<i8>
  }
  llvm.func @_mlir_ciface_init() -> !llvm.ptr<i8> {
    %0 = llvm.call @init() : () -> !llvm.ptr<i8>
    llvm.return %0 : !llvm.ptr<i8>
  }
  llvm.func @main(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<f32>, %arg2: !llvm.ptr<f32>, %arg3: i64, %arg4: i64, %arg5: i64, %arg6: !llvm.ptr<i32>, %arg7: !llvm.ptr<i32>, %arg8: i64, %arg9: i64, %arg10: i64) {
    %0 = llvm.mlir.undef : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %1 = llvm.insertvalue %arg1, %0[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %2 = llvm.insertvalue %arg2, %1[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %3 = llvm.insertvalue %arg3, %2[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %4 = llvm.insertvalue %arg4, %3[3, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %5 = llvm.insertvalue %arg5, %4[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %6 = llvm.mlir.undef : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %7 = llvm.insertvalue %arg6, %6[0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %8 = llvm.insertvalue %arg7, %7[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %9 = llvm.insertvalue %arg8, %8[2] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %10 = llvm.insertvalue %arg9, %9[3, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %11 = llvm.insertvalue %arg10, %10[4, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %12 = llvm.mlir.constant(0 : i32) : i32
    %13 = llvm.mlir.constant(20 : index) : i64
    %14 = llvm.mlir.constant(19 : index) : i64
    %15 = llvm.mlir.constant(0 : index) : i64
    %16 = llvm.mlir.constant(1 : index) : i64
    %17 = llvm.mlir.constant(10 : index) : i64
    %18 = llvm.mlir.constant(10 : index) : i64
    %19 = llvm.mlir.constant(1 : index) : i64
    %20 = llvm.mlir.null : !llvm.ptr<i32>
    %21 = llvm.getelementptr %20[%18] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    %22 = llvm.ptrtoint %21 : !llvm.ptr<i32> to i64
    %23 = llvm.call @malloc(%22) : (i64) -> !llvm.ptr<i8>
    %24 = llvm.bitcast %23 : !llvm.ptr<i8> to !llvm.ptr<i32>
    %25 = llvm.mlir.undef : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %26 = llvm.insertvalue %24, %25[0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %27 = llvm.insertvalue %24, %26[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %28 = llvm.mlir.constant(0 : index) : i64
    %29 = llvm.insertvalue %28, %27[2] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %30 = llvm.insertvalue %18, %29[3, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %31 = llvm.insertvalue %19, %30[4, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    llvm.br ^bb1(%15 : i64)
  ^bb1(%32: i64):  // 2 preds: ^bb0, ^bb2
    %33 = llvm.icmp "slt" %32, %13 : i64
    llvm.cond_br %33, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %34 = llvm.trunc %32 : i64 to i32
    %35 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %36 = llvm.getelementptr %35[%32] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %34, %36 : !llvm.ptr<i32>
    %37 = llvm.add %32, %16  : i64
    llvm.br ^bb1(%37 : i64)
  ^bb3:  // pred: ^bb1
    llvm.br ^bb4(%15 : i64)
  ^bb4(%38: i64):  // 2 preds: ^bb3, ^bb10
    %39 = llvm.icmp "slt" %38, %14 : i64
    llvm.cond_br %39, ^bb5, ^bb11
  ^bb5:  // pred: ^bb4
    %40 = llvm.mlir.constant(1 : index) : i64
    %41 = llvm.mlir.constant(1 : index) : i64
    %42 = llvm.mlir.null : !llvm.ptr<i64>
    %43 = llvm.getelementptr %42[%40] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    %44 = llvm.ptrtoint %43 : !llvm.ptr<i64> to i64
    %45 = llvm.alloca %44 x i64 : (i64) -> !llvm.ptr<i64>
    %46 = llvm.mlir.undef : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %47 = llvm.insertvalue %45, %46[0] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %48 = llvm.insertvalue %45, %47[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %49 = llvm.mlir.constant(0 : index) : i64
    %50 = llvm.insertvalue %49, %48[2] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %51 = llvm.insertvalue %40, %50[3, 0] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %52 = llvm.insertvalue %41, %51[4, 0] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %53 = llvm.extractvalue %52[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %54 = llvm.getelementptr %53[%15] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    llvm.store %38, %54 : !llvm.ptr<i64>
    %55 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %56 = llvm.getelementptr %55[%38] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    %57 = llvm.load %56 : !llvm.ptr<i32>
    %58 = llvm.sext %57 : i32 to i64
    %59 = llvm.extractvalue %5[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %60 = llvm.getelementptr %59[%58] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %61 = llvm.load %60 : !llvm.ptr<f32>
    %62 = llvm.mlir.constant(1 : index) : i64
    %63 = llvm.mlir.constant(1 : index) : i64
    %64 = llvm.mlir.null : !llvm.ptr<f32>
    %65 = llvm.getelementptr %64[%62] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %66 = llvm.ptrtoint %65 : !llvm.ptr<f32> to i64
    %67 = llvm.alloca %66 x f32 : (i64) -> !llvm.ptr<f32>
    %68 = llvm.mlir.undef : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %69 = llvm.insertvalue %67, %68[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %70 = llvm.insertvalue %67, %69[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %71 = llvm.mlir.constant(0 : index) : i64
    %72 = llvm.insertvalue %71, %70[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %73 = llvm.insertvalue %62, %72[3, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %74 = llvm.insertvalue %63, %73[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %75 = llvm.extractvalue %74[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %76 = llvm.getelementptr %75[%15] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    llvm.store %61, %76 : !llvm.ptr<f32>
    %77 = llvm.add %38, %16  : i64
    llvm.br ^bb6(%77 : i64)
  ^bb6(%78: i64):  // 2 preds: ^bb5, ^bb9
    %79 = llvm.icmp "slt" %78, %13 : i64
    llvm.cond_br %79, ^bb7, ^bb10
  ^bb7:  // pred: ^bb6
    %80 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %81 = llvm.getelementptr %80[%78] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    %82 = llvm.load %81 : !llvm.ptr<i32>
    %83 = llvm.sext %82 : i32 to i64
    %84 = llvm.extractvalue %5[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %85 = llvm.getelementptr %84[%83] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %86 = llvm.load %85 : !llvm.ptr<f32>
    %87 = llvm.extractvalue %74[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %88 = llvm.getelementptr %87[%15] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %89 = llvm.load %88 : !llvm.ptr<f32>
    %90 = llvm.fcmp "olt" %86, %89 : f32
    llvm.cond_br %90, ^bb8, ^bb9
  ^bb8:  // pred: ^bb7
    %91 = llvm.extractvalue %52[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %92 = llvm.getelementptr %91[%15] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    llvm.store %78, %92 : !llvm.ptr<i64>
    %93 = llvm.extractvalue %74[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %94 = llvm.getelementptr %93[%15] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    llvm.store %86, %94 : !llvm.ptr<f32>
    llvm.br ^bb9
  ^bb9:  // 2 preds: ^bb7, ^bb8
    %95 = llvm.add %78, %16  : i64
    llvm.br ^bb6(%95 : i64)
  ^bb10:  // pred: ^bb6
    %96 = llvm.extractvalue %52[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %97 = llvm.getelementptr %96[%15] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    %98 = llvm.load %97 : !llvm.ptr<i64>
    %99 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %100 = llvm.getelementptr %99[%98] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    %101 = llvm.load %100 : !llvm.ptr<i32>
    %102 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %103 = llvm.getelementptr %102[%38] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    %104 = llvm.load %103 : !llvm.ptr<i32>
    %105 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %106 = llvm.getelementptr %105[%38] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %101, %106 : !llvm.ptr<i32>
    %107 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %108 = llvm.getelementptr %107[%98] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %104, %108 : !llvm.ptr<i32>
    %109 = llvm.add %38, %16  : i64
    llvm.br ^bb4(%109 : i64)
  ^bb11:  // pred: ^bb4
    omp.parallel num_threads(%17 : i64) default(shared) {
      %112 = llvm.call @plaidml_rt_thread_num() : () -> i64
      %113 = llvm.extractvalue %11[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
      %114 = llvm.getelementptr %113[%112] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
      llvm.store %12, %114 : !llvm.ptr<i32>
      %115 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
      %116 = llvm.getelementptr %115[%112] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
      %117 = llvm.load %116 : !llvm.ptr<i32>
      %118 = llvm.extractvalue %11[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
      %119 = llvm.getelementptr %118[%112] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
      llvm.store %117, %119 : !llvm.ptr<i32>
      omp.terminator
    }
    %110 = llvm.extractvalue %31[0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %111 = llvm.bitcast %110 : !llvm.ptr<i32> to !llvm.ptr<i8>
    llvm.call @free(%111) : (!llvm.ptr<i8>) -> ()
    llvm.return
  }
  llvm.func @_mlir_ciface_main(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>>, %arg2: !llvm.ptr<struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>>) {
    %0 = llvm.load %arg1 : !llvm.ptr<struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>>
    %1 = llvm.extractvalue %0[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %3 = llvm.extractvalue %0[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %4 = llvm.extractvalue %0[3, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %5 = llvm.extractvalue %0[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %6 = llvm.load %arg2 : !llvm.ptr<struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>>
    %7 = llvm.extractvalue %6[0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %8 = llvm.extractvalue %6[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %9 = llvm.extractvalue %6[2] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %10 = llvm.extractvalue %6[3, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %11 = llvm.extractvalue %6[4, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    llvm.call @main(%arg0, %1, %2, %3, %4, %5, %7, %8, %9, %10, %11) : (!llvm.ptr<i8>, !llvm.ptr<f32>, !llvm.ptr<f32>, i64, i64, i64, !llvm.ptr<i32>, !llvm.ptr<i32>, i64, i64, i64) -> ()
    llvm.return
  }
  llvm.func @fini(%arg0: !llvm.ptr<i8>) {
    llvm.return
  }
  llvm.func @_mlir_ciface_fini(%arg0: !llvm.ptr<i8>) {
    llvm.call @fini(%arg0) : (!llvm.ptr<i8>) -> ()
    llvm.return
  }
  llvm.func @plaidml_rt_thread_num() -> i64 attributes {sym_visibility = "private"} {
    %0 = llvm.call @_mlir_ciface_plaidml_rt_thread_num() : () -> i64
    llvm.return %0 : i64
  }
  llvm.func @_mlir_ciface_plaidml_rt_thread_num() -> i64 attributes {sym_visibility = "private"}
}


// *** IR Dump After TraceLinking *** ('module' operation: @argsort)
module @argsort  {
  llvm.func @free(!llvm.ptr<i8>)
  llvm.func @malloc(i64) -> !llvm.ptr<i8>
  llvm.func @init() -> !llvm.ptr<i8> {
    %0 = llvm.mlir.null : !llvm.ptr<i8>
    llvm.return %0 : !llvm.ptr<i8>
  }
  llvm.func @_mlir_ciface_init() -> !llvm.ptr<i8> {
    %0 = llvm.call @init() : () -> !llvm.ptr<i8>
    llvm.return %0 : !llvm.ptr<i8>
  }
  llvm.func @main(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<f32>, %arg2: !llvm.ptr<f32>, %arg3: i64, %arg4: i64, %arg5: i64, %arg6: !llvm.ptr<i32>, %arg7: !llvm.ptr<i32>, %arg8: i64, %arg9: i64, %arg10: i64) {
    %0 = llvm.mlir.undef : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %1 = llvm.insertvalue %arg1, %0[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %2 = llvm.insertvalue %arg2, %1[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %3 = llvm.insertvalue %arg3, %2[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %4 = llvm.insertvalue %arg4, %3[3, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %5 = llvm.insertvalue %arg5, %4[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %6 = llvm.mlir.undef : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %7 = llvm.insertvalue %arg6, %6[0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %8 = llvm.insertvalue %arg7, %7[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %9 = llvm.insertvalue %arg8, %8[2] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %10 = llvm.insertvalue %arg9, %9[3, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %11 = llvm.insertvalue %arg10, %10[4, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %12 = llvm.mlir.constant(0 : i32) : i32
    %13 = llvm.mlir.constant(20 : index) : i64
    %14 = llvm.mlir.constant(19 : index) : i64
    %15 = llvm.mlir.constant(0 : index) : i64
    %16 = llvm.mlir.constant(1 : index) : i64
    %17 = llvm.mlir.constant(10 : index) : i64
    %18 = llvm.mlir.constant(10 : index) : i64
    %19 = llvm.mlir.constant(1 : index) : i64
    %20 = llvm.mlir.null : !llvm.ptr<i32>
    %21 = llvm.getelementptr %20[%18] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    %22 = llvm.ptrtoint %21 : !llvm.ptr<i32> to i64
    %23 = llvm.call @malloc(%22) : (i64) -> !llvm.ptr<i8>
    %24 = llvm.bitcast %23 : !llvm.ptr<i8> to !llvm.ptr<i32>
    %25 = llvm.mlir.undef : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %26 = llvm.insertvalue %24, %25[0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %27 = llvm.insertvalue %24, %26[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %28 = llvm.mlir.constant(0 : index) : i64
    %29 = llvm.insertvalue %28, %27[2] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %30 = llvm.insertvalue %18, %29[3, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %31 = llvm.insertvalue %19, %30[4, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    llvm.br ^bb1(%15 : i64)
  ^bb1(%32: i64):  // 2 preds: ^bb0, ^bb2
    %33 = llvm.icmp "slt" %32, %13 : i64
    llvm.cond_br %33, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %34 = llvm.trunc %32 : i64 to i32
    %35 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %36 = llvm.getelementptr %35[%32] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %34, %36 : !llvm.ptr<i32>
    %37 = llvm.add %32, %16  : i64
    llvm.br ^bb1(%37 : i64)
  ^bb3:  // pred: ^bb1
    llvm.br ^bb4(%15 : i64)
  ^bb4(%38: i64):  // 2 preds: ^bb3, ^bb10
    %39 = llvm.icmp "slt" %38, %14 : i64
    llvm.cond_br %39, ^bb5, ^bb11
  ^bb5:  // pred: ^bb4
    %40 = llvm.mlir.constant(1 : index) : i64
    %41 = llvm.mlir.constant(1 : index) : i64
    %42 = llvm.mlir.null : !llvm.ptr<i64>
    %43 = llvm.getelementptr %42[%40] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    %44 = llvm.ptrtoint %43 : !llvm.ptr<i64> to i64
    %45 = llvm.alloca %44 x i64 : (i64) -> !llvm.ptr<i64>
    %46 = llvm.mlir.undef : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %47 = llvm.insertvalue %45, %46[0] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %48 = llvm.insertvalue %45, %47[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %49 = llvm.mlir.constant(0 : index) : i64
    %50 = llvm.insertvalue %49, %48[2] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %51 = llvm.insertvalue %40, %50[3, 0] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %52 = llvm.insertvalue %41, %51[4, 0] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %53 = llvm.extractvalue %52[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %54 = llvm.getelementptr %53[%15] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    llvm.store %38, %54 : !llvm.ptr<i64>
    %55 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %56 = llvm.getelementptr %55[%38] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    %57 = llvm.load %56 : !llvm.ptr<i32>
    %58 = llvm.sext %57 : i32 to i64
    %59 = llvm.extractvalue %5[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %60 = llvm.getelementptr %59[%58] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %61 = llvm.load %60 : !llvm.ptr<f32>
    %62 = llvm.mlir.constant(1 : index) : i64
    %63 = llvm.mlir.constant(1 : index) : i64
    %64 = llvm.mlir.null : !llvm.ptr<f32>
    %65 = llvm.getelementptr %64[%62] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %66 = llvm.ptrtoint %65 : !llvm.ptr<f32> to i64
    %67 = llvm.alloca %66 x f32 : (i64) -> !llvm.ptr<f32>
    %68 = llvm.mlir.undef : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %69 = llvm.insertvalue %67, %68[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %70 = llvm.insertvalue %67, %69[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %71 = llvm.mlir.constant(0 : index) : i64
    %72 = llvm.insertvalue %71, %70[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %73 = llvm.insertvalue %62, %72[3, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %74 = llvm.insertvalue %63, %73[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %75 = llvm.extractvalue %74[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %76 = llvm.getelementptr %75[%15] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    llvm.store %61, %76 : !llvm.ptr<f32>
    %77 = llvm.add %38, %16  : i64
    llvm.br ^bb6(%77 : i64)
  ^bb6(%78: i64):  // 2 preds: ^bb5, ^bb9
    %79 = llvm.icmp "slt" %78, %13 : i64
    llvm.cond_br %79, ^bb7, ^bb10
  ^bb7:  // pred: ^bb6
    %80 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %81 = llvm.getelementptr %80[%78] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    %82 = llvm.load %81 : !llvm.ptr<i32>
    %83 = llvm.sext %82 : i32 to i64
    %84 = llvm.extractvalue %5[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %85 = llvm.getelementptr %84[%83] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %86 = llvm.load %85 : !llvm.ptr<f32>
    %87 = llvm.extractvalue %74[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %88 = llvm.getelementptr %87[%15] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %89 = llvm.load %88 : !llvm.ptr<f32>
    %90 = llvm.fcmp "olt" %86, %89 : f32
    llvm.cond_br %90, ^bb8, ^bb9
  ^bb8:  // pred: ^bb7
    %91 = llvm.extractvalue %52[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %92 = llvm.getelementptr %91[%15] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    llvm.store %78, %92 : !llvm.ptr<i64>
    %93 = llvm.extractvalue %74[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %94 = llvm.getelementptr %93[%15] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    llvm.store %86, %94 : !llvm.ptr<f32>
    llvm.br ^bb9
  ^bb9:  // 2 preds: ^bb7, ^bb8
    %95 = llvm.add %78, %16  : i64
    llvm.br ^bb6(%95 : i64)
  ^bb10:  // pred: ^bb6
    %96 = llvm.extractvalue %52[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %97 = llvm.getelementptr %96[%15] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    %98 = llvm.load %97 : !llvm.ptr<i64>
    %99 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %100 = llvm.getelementptr %99[%98] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    %101 = llvm.load %100 : !llvm.ptr<i32>
    %102 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %103 = llvm.getelementptr %102[%38] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    %104 = llvm.load %103 : !llvm.ptr<i32>
    %105 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %106 = llvm.getelementptr %105[%38] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %101, %106 : !llvm.ptr<i32>
    %107 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %108 = llvm.getelementptr %107[%98] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %104, %108 : !llvm.ptr<i32>
    %109 = llvm.add %38, %16  : i64
    llvm.br ^bb4(%109 : i64)
  ^bb11:  // pred: ^bb4
    omp.parallel num_threads(%17 : i64) default(shared) {
      %112 = llvm.call @plaidml_rt_thread_num() : () -> i64
      %113 = llvm.extractvalue %11[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
      %114 = llvm.getelementptr %113[%112] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
      llvm.store %12, %114 : !llvm.ptr<i32>
      %115 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
      %116 = llvm.getelementptr %115[%112] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
      %117 = llvm.load %116 : !llvm.ptr<i32>
      %118 = llvm.extractvalue %11[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
      %119 = llvm.getelementptr %118[%112] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
      llvm.store %117, %119 : !llvm.ptr<i32>
      omp.terminator
    }
    %110 = llvm.extractvalue %31[0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %111 = llvm.bitcast %110 : !llvm.ptr<i32> to !llvm.ptr<i8>
    llvm.call @free(%111) : (!llvm.ptr<i8>) -> ()
    llvm.return
  }
  llvm.func @_mlir_ciface_main(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>>, %arg2: !llvm.ptr<struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>>) {
    %0 = llvm.load %arg1 : !llvm.ptr<struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>>
    %1 = llvm.extractvalue %0[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %3 = llvm.extractvalue %0[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %4 = llvm.extractvalue %0[3, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %5 = llvm.extractvalue %0[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %6 = llvm.load %arg2 : !llvm.ptr<struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>>
    %7 = llvm.extractvalue %6[0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %8 = llvm.extractvalue %6[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %9 = llvm.extractvalue %6[2] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %10 = llvm.extractvalue %6[3, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %11 = llvm.extractvalue %6[4, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    llvm.call @main(%arg0, %1, %2, %3, %4, %5, %7, %8, %9, %10, %11) : (!llvm.ptr<i8>, !llvm.ptr<f32>, !llvm.ptr<f32>, i64, i64, i64, !llvm.ptr<i32>, !llvm.ptr<i32>, i64, i64, i64) -> ()
    llvm.return
  }
  llvm.func @fini(%arg0: !llvm.ptr<i8>) {
    llvm.return
  }
  llvm.func @_mlir_ciface_fini(%arg0: !llvm.ptr<i8>) {
    llvm.call @fini(%arg0) : (!llvm.ptr<i8>) -> ()
    llvm.return
  }
  llvm.func @plaidml_rt_thread_num() -> i64 attributes {sym_visibility = "private"} {
    %0 = llvm.call @_mlir_ciface_plaidml_rt_thread_num() : () -> i64
    llvm.return %0 : i64
  }
  llvm.func @_mlir_ciface_plaidml_rt_thread_num() -> i64 attributes {sym_visibility = "private"}
}


// *** IR Dump After OpenMPWorkaround *** ('llvm.func' operation: @free)
module @argsort  {
  llvm.func @free(!llvm.ptr<i8>)
  llvm.func @malloc(i64) -> !llvm.ptr<i8>
  llvm.func @init() -> !llvm.ptr<i8> {
    %0 = llvm.mlir.null : !llvm.ptr<i8>
    llvm.return %0 : !llvm.ptr<i8>
  }
  llvm.func @_mlir_ciface_init() -> !llvm.ptr<i8> {
    %0 = llvm.call @init() : () -> !llvm.ptr<i8>
    llvm.return %0 : !llvm.ptr<i8>
  }
  llvm.func @main(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<f32>, %arg2: !llvm.ptr<f32>, %arg3: i64, %arg4: i64, %arg5: i64, %arg6: !llvm.ptr<i32>, %arg7: !llvm.ptr<i32>, %arg8: i64, %arg9: i64, %arg10: i64) {
    %0 = llvm.mlir.undef : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %1 = llvm.insertvalue %arg1, %0[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %2 = llvm.insertvalue %arg2, %1[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %3 = llvm.insertvalue %arg3, %2[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %4 = llvm.insertvalue %arg4, %3[3, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %5 = llvm.insertvalue %arg5, %4[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %6 = llvm.mlir.undef : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %7 = llvm.insertvalue %arg6, %6[0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %8 = llvm.insertvalue %arg7, %7[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %9 = llvm.insertvalue %arg8, %8[2] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %10 = llvm.insertvalue %arg9, %9[3, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %11 = llvm.insertvalue %arg10, %10[4, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %12 = llvm.mlir.constant(0 : i32) : i32
    %13 = llvm.mlir.constant(20 : index) : i64
    %14 = llvm.mlir.constant(19 : index) : i64
    %15 = llvm.mlir.constant(0 : index) : i64
    %16 = llvm.mlir.constant(1 : index) : i64
    %17 = llvm.mlir.constant(10 : index) : i64
    %18 = llvm.mlir.constant(10 : index) : i64
    %19 = llvm.mlir.constant(1 : index) : i64
    %20 = llvm.mlir.null : !llvm.ptr<i32>
    %21 = llvm.getelementptr %20[%18] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    %22 = llvm.ptrtoint %21 : !llvm.ptr<i32> to i64
    %23 = llvm.call @malloc(%22) : (i64) -> !llvm.ptr<i8>
    %24 = llvm.bitcast %23 : !llvm.ptr<i8> to !llvm.ptr<i32>
    %25 = llvm.mlir.undef : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %26 = llvm.insertvalue %24, %25[0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %27 = llvm.insertvalue %24, %26[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %28 = llvm.mlir.constant(0 : index) : i64
    %29 = llvm.insertvalue %28, %27[2] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %30 = llvm.insertvalue %18, %29[3, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %31 = llvm.insertvalue %19, %30[4, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    llvm.br ^bb1(%15 : i64)
  ^bb1(%32: i64):  // 2 preds: ^bb0, ^bb2
    %33 = llvm.icmp "slt" %32, %13 : i64
    llvm.cond_br %33, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %34 = llvm.trunc %32 : i64 to i32
    %35 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %36 = llvm.getelementptr %35[%32] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %34, %36 : !llvm.ptr<i32>
    %37 = llvm.add %32, %16  : i64
    llvm.br ^bb1(%37 : i64)
  ^bb3:  // pred: ^bb1
    llvm.br ^bb4(%15 : i64)
  ^bb4(%38: i64):  // 2 preds: ^bb3, ^bb10
    %39 = llvm.icmp "slt" %38, %14 : i64
    llvm.cond_br %39, ^bb5, ^bb11
  ^bb5:  // pred: ^bb4
    %40 = llvm.mlir.constant(1 : index) : i64
    %41 = llvm.mlir.constant(1 : index) : i64
    %42 = llvm.mlir.null : !llvm.ptr<i64>
    %43 = llvm.getelementptr %42[%40] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    %44 = llvm.ptrtoint %43 : !llvm.ptr<i64> to i64
    %45 = llvm.alloca %44 x i64 : (i64) -> !llvm.ptr<i64>
    %46 = llvm.mlir.undef : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %47 = llvm.insertvalue %45, %46[0] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %48 = llvm.insertvalue %45, %47[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %49 = llvm.mlir.constant(0 : index) : i64
    %50 = llvm.insertvalue %49, %48[2] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %51 = llvm.insertvalue %40, %50[3, 0] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %52 = llvm.insertvalue %41, %51[4, 0] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %53 = llvm.extractvalue %52[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %54 = llvm.getelementptr %53[%15] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    llvm.store %38, %54 : !llvm.ptr<i64>
    %55 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %56 = llvm.getelementptr %55[%38] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    %57 = llvm.load %56 : !llvm.ptr<i32>
    %58 = llvm.sext %57 : i32 to i64
    %59 = llvm.extractvalue %5[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %60 = llvm.getelementptr %59[%58] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %61 = llvm.load %60 : !llvm.ptr<f32>
    %62 = llvm.mlir.constant(1 : index) : i64
    %63 = llvm.mlir.constant(1 : index) : i64
    %64 = llvm.mlir.null : !llvm.ptr<f32>
    %65 = llvm.getelementptr %64[%62] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %66 = llvm.ptrtoint %65 : !llvm.ptr<f32> to i64
    %67 = llvm.alloca %66 x f32 : (i64) -> !llvm.ptr<f32>
    %68 = llvm.mlir.undef : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %69 = llvm.insertvalue %67, %68[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %70 = llvm.insertvalue %67, %69[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %71 = llvm.mlir.constant(0 : index) : i64
    %72 = llvm.insertvalue %71, %70[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %73 = llvm.insertvalue %62, %72[3, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %74 = llvm.insertvalue %63, %73[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %75 = llvm.extractvalue %74[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %76 = llvm.getelementptr %75[%15] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    llvm.store %61, %76 : !llvm.ptr<f32>
    %77 = llvm.add %38, %16  : i64
    llvm.br ^bb6(%77 : i64)
  ^bb6(%78: i64):  // 2 preds: ^bb5, ^bb9
    %79 = llvm.icmp "slt" %78, %13 : i64
    llvm.cond_br %79, ^bb7, ^bb10
  ^bb7:  // pred: ^bb6
    %80 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %81 = llvm.getelementptr %80[%78] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    %82 = llvm.load %81 : !llvm.ptr<i32>
    %83 = llvm.sext %82 : i32 to i64
    %84 = llvm.extractvalue %5[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %85 = llvm.getelementptr %84[%83] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %86 = llvm.load %85 : !llvm.ptr<f32>
    %87 = llvm.extractvalue %74[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %88 = llvm.getelementptr %87[%15] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %89 = llvm.load %88 : !llvm.ptr<f32>
    %90 = llvm.fcmp "olt" %86, %89 : f32
    llvm.cond_br %90, ^bb8, ^bb9
  ^bb8:  // pred: ^bb7
    %91 = llvm.extractvalue %52[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %92 = llvm.getelementptr %91[%15] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    llvm.store %78, %92 : !llvm.ptr<i64>
    %93 = llvm.extractvalue %74[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %94 = llvm.getelementptr %93[%15] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    llvm.store %86, %94 : !llvm.ptr<f32>
    llvm.br ^bb9
  ^bb9:  // 2 preds: ^bb7, ^bb8
    %95 = llvm.add %78, %16  : i64
    llvm.br ^bb6(%95 : i64)
  ^bb10:  // pred: ^bb6
    %96 = llvm.extractvalue %52[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %97 = llvm.getelementptr %96[%15] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    %98 = llvm.load %97 : !llvm.ptr<i64>
    %99 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %100 = llvm.getelementptr %99[%98] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    %101 = llvm.load %100 : !llvm.ptr<i32>
    %102 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %103 = llvm.getelementptr %102[%38] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    %104 = llvm.load %103 : !llvm.ptr<i32>
    %105 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %106 = llvm.getelementptr %105[%38] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %101, %106 : !llvm.ptr<i32>
    %107 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %108 = llvm.getelementptr %107[%98] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %104, %108 : !llvm.ptr<i32>
    %109 = llvm.add %38, %16  : i64
    llvm.br ^bb4(%109 : i64)
  ^bb11:  // pred: ^bb4
    omp.parallel num_threads(%17 : i64) default(shared) {
      %112 = llvm.call @plaidml_rt_thread_num() : () -> i64
      %113 = llvm.extractvalue %11[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
      %114 = llvm.getelementptr %113[%112] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
      llvm.store %12, %114 : !llvm.ptr<i32>
      %115 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
      %116 = llvm.getelementptr %115[%112] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
      %117 = llvm.load %116 : !llvm.ptr<i32>
      %118 = llvm.extractvalue %11[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
      %119 = llvm.getelementptr %118[%112] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
      llvm.store %117, %119 : !llvm.ptr<i32>
      omp.terminator
    }
    %110 = llvm.extractvalue %31[0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %111 = llvm.bitcast %110 : !llvm.ptr<i32> to !llvm.ptr<i8>
    llvm.call @free(%111) : (!llvm.ptr<i8>) -> ()
    llvm.return
  }
  llvm.func @_mlir_ciface_main(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>>, %arg2: !llvm.ptr<struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>>) {
    %0 = llvm.load %arg1 : !llvm.ptr<struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>>
    %1 = llvm.extractvalue %0[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %3 = llvm.extractvalue %0[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %4 = llvm.extractvalue %0[3, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %5 = llvm.extractvalue %0[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %6 = llvm.load %arg2 : !llvm.ptr<struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>>
    %7 = llvm.extractvalue %6[0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %8 = llvm.extractvalue %6[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %9 = llvm.extractvalue %6[2] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %10 = llvm.extractvalue %6[3, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %11 = llvm.extractvalue %6[4, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    llvm.call @main(%arg0, %1, %2, %3, %4, %5, %7, %8, %9, %10, %11) : (!llvm.ptr<i8>, !llvm.ptr<f32>, !llvm.ptr<f32>, i64, i64, i64, !llvm.ptr<i32>, !llvm.ptr<i32>, i64, i64, i64) -> ()
    llvm.return
  }
  llvm.func @fini(%arg0: !llvm.ptr<i8>) {
    llvm.return
  }
  llvm.func @_mlir_ciface_fini(%arg0: !llvm.ptr<i8>) {
    llvm.call @fini(%arg0) : (!llvm.ptr<i8>) -> ()
    llvm.return
  }
  llvm.func @plaidml_rt_thread_num() -> i64 attributes {sym_visibility = "private"} {
    %0 = llvm.call @_mlir_ciface_plaidml_rt_thread_num() : () -> i64
    llvm.return %0 : i64
  }
  llvm.func @_mlir_ciface_plaidml_rt_thread_num() -> i64 attributes {sym_visibility = "private"}
}


// *** IR Dump After OpenMPWorkaround *** ('llvm.func' operation: @malloc)
module @argsort  {
  llvm.func @free(!llvm.ptr<i8>)
  llvm.func @malloc(i64) -> !llvm.ptr<i8>
  llvm.func @init() -> !llvm.ptr<i8> {
    %0 = llvm.mlir.null : !llvm.ptr<i8>
    llvm.return %0 : !llvm.ptr<i8>
  }
  llvm.func @_mlir_ciface_init() -> !llvm.ptr<i8> {
    %0 = llvm.call @init() : () -> !llvm.ptr<i8>
    llvm.return %0 : !llvm.ptr<i8>
  }
  llvm.func @main(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<f32>, %arg2: !llvm.ptr<f32>, %arg3: i64, %arg4: i64, %arg5: i64, %arg6: !llvm.ptr<i32>, %arg7: !llvm.ptr<i32>, %arg8: i64, %arg9: i64, %arg10: i64) {
    %0 = llvm.mlir.undef : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %1 = llvm.insertvalue %arg1, %0[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %2 = llvm.insertvalue %arg2, %1[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %3 = llvm.insertvalue %arg3, %2[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %4 = llvm.insertvalue %arg4, %3[3, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %5 = llvm.insertvalue %arg5, %4[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %6 = llvm.mlir.undef : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %7 = llvm.insertvalue %arg6, %6[0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %8 = llvm.insertvalue %arg7, %7[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %9 = llvm.insertvalue %arg8, %8[2] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %10 = llvm.insertvalue %arg9, %9[3, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %11 = llvm.insertvalue %arg10, %10[4, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %12 = llvm.mlir.constant(0 : i32) : i32
    %13 = llvm.mlir.constant(20 : index) : i64
    %14 = llvm.mlir.constant(19 : index) : i64
    %15 = llvm.mlir.constant(0 : index) : i64
    %16 = llvm.mlir.constant(1 : index) : i64
    %17 = llvm.mlir.constant(10 : index) : i64
    %18 = llvm.mlir.constant(10 : index) : i64
    %19 = llvm.mlir.constant(1 : index) : i64
    %20 = llvm.mlir.null : !llvm.ptr<i32>
    %21 = llvm.getelementptr %20[%18] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    %22 = llvm.ptrtoint %21 : !llvm.ptr<i32> to i64
    %23 = llvm.call @malloc(%22) : (i64) -> !llvm.ptr<i8>
    %24 = llvm.bitcast %23 : !llvm.ptr<i8> to !llvm.ptr<i32>
    %25 = llvm.mlir.undef : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %26 = llvm.insertvalue %24, %25[0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %27 = llvm.insertvalue %24, %26[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %28 = llvm.mlir.constant(0 : index) : i64
    %29 = llvm.insertvalue %28, %27[2] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %30 = llvm.insertvalue %18, %29[3, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %31 = llvm.insertvalue %19, %30[4, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    llvm.br ^bb1(%15 : i64)
  ^bb1(%32: i64):  // 2 preds: ^bb0, ^bb2
    %33 = llvm.icmp "slt" %32, %13 : i64
    llvm.cond_br %33, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %34 = llvm.trunc %32 : i64 to i32
    %35 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %36 = llvm.getelementptr %35[%32] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %34, %36 : !llvm.ptr<i32>
    %37 = llvm.add %32, %16  : i64
    llvm.br ^bb1(%37 : i64)
  ^bb3:  // pred: ^bb1
    llvm.br ^bb4(%15 : i64)
  ^bb4(%38: i64):  // 2 preds: ^bb3, ^bb10
    %39 = llvm.icmp "slt" %38, %14 : i64
    llvm.cond_br %39, ^bb5, ^bb11
  ^bb5:  // pred: ^bb4
    %40 = llvm.mlir.constant(1 : index) : i64
    %41 = llvm.mlir.constant(1 : index) : i64
    %42 = llvm.mlir.null : !llvm.ptr<i64>
    %43 = llvm.getelementptr %42[%40] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    %44 = llvm.ptrtoint %43 : !llvm.ptr<i64> to i64
    %45 = llvm.alloca %44 x i64 : (i64) -> !llvm.ptr<i64>
    %46 = llvm.mlir.undef : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %47 = llvm.insertvalue %45, %46[0] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %48 = llvm.insertvalue %45, %47[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %49 = llvm.mlir.constant(0 : index) : i64
    %50 = llvm.insertvalue %49, %48[2] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %51 = llvm.insertvalue %40, %50[3, 0] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %52 = llvm.insertvalue %41, %51[4, 0] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %53 = llvm.extractvalue %52[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %54 = llvm.getelementptr %53[%15] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    llvm.store %38, %54 : !llvm.ptr<i64>
    %55 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %56 = llvm.getelementptr %55[%38] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    %57 = llvm.load %56 : !llvm.ptr<i32>
    %58 = llvm.sext %57 : i32 to i64
    %59 = llvm.extractvalue %5[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %60 = llvm.getelementptr %59[%58] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %61 = llvm.load %60 : !llvm.ptr<f32>
    %62 = llvm.mlir.constant(1 : index) : i64
    %63 = llvm.mlir.constant(1 : index) : i64
    %64 = llvm.mlir.null : !llvm.ptr<f32>
    %65 = llvm.getelementptr %64[%62] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %66 = llvm.ptrtoint %65 : !llvm.ptr<f32> to i64
    %67 = llvm.alloca %66 x f32 : (i64) -> !llvm.ptr<f32>
    %68 = llvm.mlir.undef : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %69 = llvm.insertvalue %67, %68[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %70 = llvm.insertvalue %67, %69[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %71 = llvm.mlir.constant(0 : index) : i64
    %72 = llvm.insertvalue %71, %70[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %73 = llvm.insertvalue %62, %72[3, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %74 = llvm.insertvalue %63, %73[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %75 = llvm.extractvalue %74[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %76 = llvm.getelementptr %75[%15] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    llvm.store %61, %76 : !llvm.ptr<f32>
    %77 = llvm.add %38, %16  : i64
    llvm.br ^bb6(%77 : i64)
  ^bb6(%78: i64):  // 2 preds: ^bb5, ^bb9
    %79 = llvm.icmp "slt" %78, %13 : i64
    llvm.cond_br %79, ^bb7, ^bb10
  ^bb7:  // pred: ^bb6
    %80 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %81 = llvm.getelementptr %80[%78] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    %82 = llvm.load %81 : !llvm.ptr<i32>
    %83 = llvm.sext %82 : i32 to i64
    %84 = llvm.extractvalue %5[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %85 = llvm.getelementptr %84[%83] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %86 = llvm.load %85 : !llvm.ptr<f32>
    %87 = llvm.extractvalue %74[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %88 = llvm.getelementptr %87[%15] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %89 = llvm.load %88 : !llvm.ptr<f32>
    %90 = llvm.fcmp "olt" %86, %89 : f32
    llvm.cond_br %90, ^bb8, ^bb9
  ^bb8:  // pred: ^bb7
    %91 = llvm.extractvalue %52[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %92 = llvm.getelementptr %91[%15] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    llvm.store %78, %92 : !llvm.ptr<i64>
    %93 = llvm.extractvalue %74[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %94 = llvm.getelementptr %93[%15] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    llvm.store %86, %94 : !llvm.ptr<f32>
    llvm.br ^bb9
  ^bb9:  // 2 preds: ^bb7, ^bb8
    %95 = llvm.add %78, %16  : i64
    llvm.br ^bb6(%95 : i64)
  ^bb10:  // pred: ^bb6
    %96 = llvm.extractvalue %52[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %97 = llvm.getelementptr %96[%15] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    %98 = llvm.load %97 : !llvm.ptr<i64>
    %99 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %100 = llvm.getelementptr %99[%98] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    %101 = llvm.load %100 : !llvm.ptr<i32>
    %102 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %103 = llvm.getelementptr %102[%38] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    %104 = llvm.load %103 : !llvm.ptr<i32>
    %105 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %106 = llvm.getelementptr %105[%38] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %101, %106 : !llvm.ptr<i32>
    %107 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %108 = llvm.getelementptr %107[%98] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %104, %108 : !llvm.ptr<i32>
    %109 = llvm.add %38, %16  : i64
    llvm.br ^bb4(%109 : i64)
  ^bb11:  // pred: ^bb4
    omp.parallel num_threads(%17 : i64) default(shared) {
      %112 = llvm.call @plaidml_rt_thread_num() : () -> i64
      %113 = llvm.extractvalue %11[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
      %114 = llvm.getelementptr %113[%112] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
      llvm.store %12, %114 : !llvm.ptr<i32>
      %115 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
      %116 = llvm.getelementptr %115[%112] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
      %117 = llvm.load %116 : !llvm.ptr<i32>
      %118 = llvm.extractvalue %11[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
      %119 = llvm.getelementptr %118[%112] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
      llvm.store %117, %119 : !llvm.ptr<i32>
      omp.terminator
    }
    %110 = llvm.extractvalue %31[0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %111 = llvm.bitcast %110 : !llvm.ptr<i32> to !llvm.ptr<i8>
    llvm.call @free(%111) : (!llvm.ptr<i8>) -> ()
    llvm.return
  }
  llvm.func @_mlir_ciface_main(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>>, %arg2: !llvm.ptr<struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>>) {
    %0 = llvm.load %arg1 : !llvm.ptr<struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>>
    %1 = llvm.extractvalue %0[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %3 = llvm.extractvalue %0[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %4 = llvm.extractvalue %0[3, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %5 = llvm.extractvalue %0[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %6 = llvm.load %arg2 : !llvm.ptr<struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>>
    %7 = llvm.extractvalue %6[0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %8 = llvm.extractvalue %6[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %9 = llvm.extractvalue %6[2] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %10 = llvm.extractvalue %6[3, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %11 = llvm.extractvalue %6[4, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    llvm.call @main(%arg0, %1, %2, %3, %4, %5, %7, %8, %9, %10, %11) : (!llvm.ptr<i8>, !llvm.ptr<f32>, !llvm.ptr<f32>, i64, i64, i64, !llvm.ptr<i32>, !llvm.ptr<i32>, i64, i64, i64) -> ()
    llvm.return
  }
  llvm.func @fini(%arg0: !llvm.ptr<i8>) {
    llvm.return
  }
  llvm.func @_mlir_ciface_fini(%arg0: !llvm.ptr<i8>) {
    llvm.call @fini(%arg0) : (!llvm.ptr<i8>) -> ()
    llvm.return
  }
  llvm.func @plaidml_rt_thread_num() -> i64 attributes {sym_visibility = "private"} {
    %0 = llvm.call @_mlir_ciface_plaidml_rt_thread_num() : () -> i64
    llvm.return %0 : i64
  }
  llvm.func @_mlir_ciface_plaidml_rt_thread_num() -> i64 attributes {sym_visibility = "private"}
}


// *** IR Dump After OpenMPWorkaround *** ('llvm.func' operation: @init)
module @argsort  {
  llvm.func @free(!llvm.ptr<i8>)
  llvm.func @malloc(i64) -> !llvm.ptr<i8>
  llvm.func @init() -> !llvm.ptr<i8> {
    %0 = llvm.mlir.null : !llvm.ptr<i8>
    llvm.return %0 : !llvm.ptr<i8>
  }
  llvm.func @_mlir_ciface_init() -> !llvm.ptr<i8> {
    %0 = llvm.call @init() : () -> !llvm.ptr<i8>
    llvm.return %0 : !llvm.ptr<i8>
  }
  llvm.func @main(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<f32>, %arg2: !llvm.ptr<f32>, %arg3: i64, %arg4: i64, %arg5: i64, %arg6: !llvm.ptr<i32>, %arg7: !llvm.ptr<i32>, %arg8: i64, %arg9: i64, %arg10: i64) {
    %0 = llvm.mlir.undef : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %1 = llvm.insertvalue %arg1, %0[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %2 = llvm.insertvalue %arg2, %1[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %3 = llvm.insertvalue %arg3, %2[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %4 = llvm.insertvalue %arg4, %3[3, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %5 = llvm.insertvalue %arg5, %4[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %6 = llvm.mlir.undef : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %7 = llvm.insertvalue %arg6, %6[0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %8 = llvm.insertvalue %arg7, %7[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %9 = llvm.insertvalue %arg8, %8[2] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %10 = llvm.insertvalue %arg9, %9[3, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %11 = llvm.insertvalue %arg10, %10[4, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %12 = llvm.mlir.constant(0 : i32) : i32
    %13 = llvm.mlir.constant(20 : index) : i64
    %14 = llvm.mlir.constant(19 : index) : i64
    %15 = llvm.mlir.constant(0 : index) : i64
    %16 = llvm.mlir.constant(1 : index) : i64
    %17 = llvm.mlir.constant(10 : index) : i64
    %18 = llvm.mlir.constant(10 : index) : i64
    %19 = llvm.mlir.constant(1 : index) : i64
    %20 = llvm.mlir.null : !llvm.ptr<i32>
    %21 = llvm.getelementptr %20[%18] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    %22 = llvm.ptrtoint %21 : !llvm.ptr<i32> to i64
    %23 = llvm.call @malloc(%22) : (i64) -> !llvm.ptr<i8>
    %24 = llvm.bitcast %23 : !llvm.ptr<i8> to !llvm.ptr<i32>
    %25 = llvm.mlir.undef : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %26 = llvm.insertvalue %24, %25[0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %27 = llvm.insertvalue %24, %26[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %28 = llvm.mlir.constant(0 : index) : i64
    %29 = llvm.insertvalue %28, %27[2] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %30 = llvm.insertvalue %18, %29[3, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %31 = llvm.insertvalue %19, %30[4, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    llvm.br ^bb1(%15 : i64)
  ^bb1(%32: i64):  // 2 preds: ^bb0, ^bb2
    %33 = llvm.icmp "slt" %32, %13 : i64
    llvm.cond_br %33, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %34 = llvm.trunc %32 : i64 to i32
    %35 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %36 = llvm.getelementptr %35[%32] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %34, %36 : !llvm.ptr<i32>
    %37 = llvm.add %32, %16  : i64
    llvm.br ^bb1(%37 : i64)
  ^bb3:  // pred: ^bb1
    llvm.br ^bb4(%15 : i64)
  ^bb4(%38: i64):  // 2 preds: ^bb3, ^bb10
    %39 = llvm.icmp "slt" %38, %14 : i64
    llvm.cond_br %39, ^bb5, ^bb11
  ^bb5:  // pred: ^bb4
    %40 = llvm.mlir.constant(1 : index) : i64
    %41 = llvm.mlir.constant(1 : index) : i64
    %42 = llvm.mlir.null : !llvm.ptr<i64>
    %43 = llvm.getelementptr %42[%40] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    %44 = llvm.ptrtoint %43 : !llvm.ptr<i64> to i64
    %45 = llvm.alloca %44 x i64 : (i64) -> !llvm.ptr<i64>
    %46 = llvm.mlir.undef : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %47 = llvm.insertvalue %45, %46[0] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %48 = llvm.insertvalue %45, %47[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %49 = llvm.mlir.constant(0 : index) : i64
    %50 = llvm.insertvalue %49, %48[2] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %51 = llvm.insertvalue %40, %50[3, 0] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %52 = llvm.insertvalue %41, %51[4, 0] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %53 = llvm.extractvalue %52[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %54 = llvm.getelementptr %53[%15] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    llvm.store %38, %54 : !llvm.ptr<i64>
    %55 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %56 = llvm.getelementptr %55[%38] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    %57 = llvm.load %56 : !llvm.ptr<i32>
    %58 = llvm.sext %57 : i32 to i64
    %59 = llvm.extractvalue %5[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %60 = llvm.getelementptr %59[%58] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %61 = llvm.load %60 : !llvm.ptr<f32>
    %62 = llvm.mlir.constant(1 : index) : i64
    %63 = llvm.mlir.constant(1 : index) : i64
    %64 = llvm.mlir.null : !llvm.ptr<f32>
    %65 = llvm.getelementptr %64[%62] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %66 = llvm.ptrtoint %65 : !llvm.ptr<f32> to i64
    %67 = llvm.alloca %66 x f32 : (i64) -> !llvm.ptr<f32>
    %68 = llvm.mlir.undef : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %69 = llvm.insertvalue %67, %68[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %70 = llvm.insertvalue %67, %69[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %71 = llvm.mlir.constant(0 : index) : i64
    %72 = llvm.insertvalue %71, %70[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %73 = llvm.insertvalue %62, %72[3, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %74 = llvm.insertvalue %63, %73[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %75 = llvm.extractvalue %74[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %76 = llvm.getelementptr %75[%15] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    llvm.store %61, %76 : !llvm.ptr<f32>
    %77 = llvm.add %38, %16  : i64
    llvm.br ^bb6(%77 : i64)
  ^bb6(%78: i64):  // 2 preds: ^bb5, ^bb9
    %79 = llvm.icmp "slt" %78, %13 : i64
    llvm.cond_br %79, ^bb7, ^bb10
  ^bb7:  // pred: ^bb6
    %80 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %81 = llvm.getelementptr %80[%78] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    %82 = llvm.load %81 : !llvm.ptr<i32>
    %83 = llvm.sext %82 : i32 to i64
    %84 = llvm.extractvalue %5[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %85 = llvm.getelementptr %84[%83] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %86 = llvm.load %85 : !llvm.ptr<f32>
    %87 = llvm.extractvalue %74[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %88 = llvm.getelementptr %87[%15] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %89 = llvm.load %88 : !llvm.ptr<f32>
    %90 = llvm.fcmp "olt" %86, %89 : f32
    llvm.cond_br %90, ^bb8, ^bb9
  ^bb8:  // pred: ^bb7
    %91 = llvm.extractvalue %52[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %92 = llvm.getelementptr %91[%15] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    llvm.store %78, %92 : !llvm.ptr<i64>
    %93 = llvm.extractvalue %74[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %94 = llvm.getelementptr %93[%15] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    llvm.store %86, %94 : !llvm.ptr<f32>
    llvm.br ^bb9
  ^bb9:  // 2 preds: ^bb7, ^bb8
    %95 = llvm.add %78, %16  : i64
    llvm.br ^bb6(%95 : i64)
  ^bb10:  // pred: ^bb6
    %96 = llvm.extractvalue %52[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %97 = llvm.getelementptr %96[%15] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    %98 = llvm.load %97 : !llvm.ptr<i64>
    %99 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %100 = llvm.getelementptr %99[%98] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    %101 = llvm.load %100 : !llvm.ptr<i32>
    %102 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %103 = llvm.getelementptr %102[%38] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    %104 = llvm.load %103 : !llvm.ptr<i32>
    %105 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %106 = llvm.getelementptr %105[%38] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %101, %106 : !llvm.ptr<i32>
    %107 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %108 = llvm.getelementptr %107[%98] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %104, %108 : !llvm.ptr<i32>
    %109 = llvm.add %38, %16  : i64
    llvm.br ^bb4(%109 : i64)
  ^bb11:  // pred: ^bb4
    omp.parallel num_threads(%17 : i64) default(shared) {
      %112 = llvm.call @plaidml_rt_thread_num() : () -> i64
      %113 = llvm.extractvalue %11[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
      %114 = llvm.getelementptr %113[%112] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
      llvm.store %12, %114 : !llvm.ptr<i32>
      %115 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
      %116 = llvm.getelementptr %115[%112] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
      %117 = llvm.load %116 : !llvm.ptr<i32>
      %118 = llvm.extractvalue %11[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
      %119 = llvm.getelementptr %118[%112] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
      llvm.store %117, %119 : !llvm.ptr<i32>
      omp.terminator
    }
    %110 = llvm.extractvalue %31[0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %111 = llvm.bitcast %110 : !llvm.ptr<i32> to !llvm.ptr<i8>
    llvm.call @free(%111) : (!llvm.ptr<i8>) -> ()
    llvm.return
  }
  llvm.func @_mlir_ciface_main(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>>, %arg2: !llvm.ptr<struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>>) {
    %0 = llvm.load %arg1 : !llvm.ptr<struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>>
    %1 = llvm.extractvalue %0[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %3 = llvm.extractvalue %0[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %4 = llvm.extractvalue %0[3, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %5 = llvm.extractvalue %0[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %6 = llvm.load %arg2 : !llvm.ptr<struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>>
    %7 = llvm.extractvalue %6[0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %8 = llvm.extractvalue %6[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %9 = llvm.extractvalue %6[2] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %10 = llvm.extractvalue %6[3, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %11 = llvm.extractvalue %6[4, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    llvm.call @main(%arg0, %1, %2, %3, %4, %5, %7, %8, %9, %10, %11) : (!llvm.ptr<i8>, !llvm.ptr<f32>, !llvm.ptr<f32>, i64, i64, i64, !llvm.ptr<i32>, !llvm.ptr<i32>, i64, i64, i64) -> ()
    llvm.return
  }
  llvm.func @fini(%arg0: !llvm.ptr<i8>) {
    llvm.return
  }
  llvm.func @_mlir_ciface_fini(%arg0: !llvm.ptr<i8>) {
    llvm.call @fini(%arg0) : (!llvm.ptr<i8>) -> ()
    llvm.return
  }
  llvm.func @plaidml_rt_thread_num() -> i64 attributes {sym_visibility = "private"} {
    %0 = llvm.call @_mlir_ciface_plaidml_rt_thread_num() : () -> i64
    llvm.return %0 : i64
  }
  llvm.func @_mlir_ciface_plaidml_rt_thread_num() -> i64 attributes {sym_visibility = "private"}
}


// *** IR Dump After OpenMPWorkaround *** ('llvm.func' operation: @_mlir_ciface_init)
module @argsort  {
  llvm.func @free(!llvm.ptr<i8>)
  llvm.func @malloc(i64) -> !llvm.ptr<i8>
  llvm.func @init() -> !llvm.ptr<i8> {
    %0 = llvm.mlir.null : !llvm.ptr<i8>
    llvm.return %0 : !llvm.ptr<i8>
  }
  llvm.func @_mlir_ciface_init() -> !llvm.ptr<i8> {
    %0 = llvm.call @init() : () -> !llvm.ptr<i8>
    llvm.return %0 : !llvm.ptr<i8>
  }
  llvm.func @main(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<f32>, %arg2: !llvm.ptr<f32>, %arg3: i64, %arg4: i64, %arg5: i64, %arg6: !llvm.ptr<i32>, %arg7: !llvm.ptr<i32>, %arg8: i64, %arg9: i64, %arg10: i64) {
    %0 = llvm.mlir.undef : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %1 = llvm.insertvalue %arg1, %0[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %2 = llvm.insertvalue %arg2, %1[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %3 = llvm.insertvalue %arg3, %2[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %4 = llvm.insertvalue %arg4, %3[3, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %5 = llvm.insertvalue %arg5, %4[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %6 = llvm.mlir.undef : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %7 = llvm.insertvalue %arg6, %6[0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %8 = llvm.insertvalue %arg7, %7[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %9 = llvm.insertvalue %arg8, %8[2] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %10 = llvm.insertvalue %arg9, %9[3, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %11 = llvm.insertvalue %arg10, %10[4, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %12 = llvm.mlir.constant(0 : i32) : i32
    %13 = llvm.mlir.constant(20 : index) : i64
    %14 = llvm.mlir.constant(19 : index) : i64
    %15 = llvm.mlir.constant(0 : index) : i64
    %16 = llvm.mlir.constant(1 : index) : i64
    %17 = llvm.mlir.constant(10 : index) : i64
    %18 = llvm.mlir.constant(10 : index) : i64
    %19 = llvm.mlir.constant(1 : index) : i64
    %20 = llvm.mlir.null : !llvm.ptr<i32>
    %21 = llvm.getelementptr %20[%18] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    %22 = llvm.ptrtoint %21 : !llvm.ptr<i32> to i64
    %23 = llvm.call @malloc(%22) : (i64) -> !llvm.ptr<i8>
    %24 = llvm.bitcast %23 : !llvm.ptr<i8> to !llvm.ptr<i32>
    %25 = llvm.mlir.undef : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %26 = llvm.insertvalue %24, %25[0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %27 = llvm.insertvalue %24, %26[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %28 = llvm.mlir.constant(0 : index) : i64
    %29 = llvm.insertvalue %28, %27[2] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %30 = llvm.insertvalue %18, %29[3, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %31 = llvm.insertvalue %19, %30[4, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    llvm.br ^bb1(%15 : i64)
  ^bb1(%32: i64):  // 2 preds: ^bb0, ^bb2
    %33 = llvm.icmp "slt" %32, %13 : i64
    llvm.cond_br %33, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %34 = llvm.trunc %32 : i64 to i32
    %35 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %36 = llvm.getelementptr %35[%32] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %34, %36 : !llvm.ptr<i32>
    %37 = llvm.add %32, %16  : i64
    llvm.br ^bb1(%37 : i64)
  ^bb3:  // pred: ^bb1
    llvm.br ^bb4(%15 : i64)
  ^bb4(%38: i64):  // 2 preds: ^bb3, ^bb10
    %39 = llvm.icmp "slt" %38, %14 : i64
    llvm.cond_br %39, ^bb5, ^bb11
  ^bb5:  // pred: ^bb4
    %40 = llvm.mlir.constant(1 : index) : i64
    %41 = llvm.mlir.constant(1 : index) : i64
    %42 = llvm.mlir.null : !llvm.ptr<i64>
    %43 = llvm.getelementptr %42[%40] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    %44 = llvm.ptrtoint %43 : !llvm.ptr<i64> to i64
    %45 = llvm.alloca %44 x i64 : (i64) -> !llvm.ptr<i64>
    %46 = llvm.mlir.undef : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %47 = llvm.insertvalue %45, %46[0] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %48 = llvm.insertvalue %45, %47[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %49 = llvm.mlir.constant(0 : index) : i64
    %50 = llvm.insertvalue %49, %48[2] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %51 = llvm.insertvalue %40, %50[3, 0] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %52 = llvm.insertvalue %41, %51[4, 0] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %53 = llvm.extractvalue %52[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %54 = llvm.getelementptr %53[%15] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    llvm.store %38, %54 : !llvm.ptr<i64>
    %55 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %56 = llvm.getelementptr %55[%38] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    %57 = llvm.load %56 : !llvm.ptr<i32>
    %58 = llvm.sext %57 : i32 to i64
    %59 = llvm.extractvalue %5[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %60 = llvm.getelementptr %59[%58] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %61 = llvm.load %60 : !llvm.ptr<f32>
    %62 = llvm.mlir.constant(1 : index) : i64
    %63 = llvm.mlir.constant(1 : index) : i64
    %64 = llvm.mlir.null : !llvm.ptr<f32>
    %65 = llvm.getelementptr %64[%62] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %66 = llvm.ptrtoint %65 : !llvm.ptr<f32> to i64
    %67 = llvm.alloca %66 x f32 : (i64) -> !llvm.ptr<f32>
    %68 = llvm.mlir.undef : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %69 = llvm.insertvalue %67, %68[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %70 = llvm.insertvalue %67, %69[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %71 = llvm.mlir.constant(0 : index) : i64
    %72 = llvm.insertvalue %71, %70[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %73 = llvm.insertvalue %62, %72[3, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %74 = llvm.insertvalue %63, %73[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %75 = llvm.extractvalue %74[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %76 = llvm.getelementptr %75[%15] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    llvm.store %61, %76 : !llvm.ptr<f32>
    %77 = llvm.add %38, %16  : i64
    llvm.br ^bb6(%77 : i64)
  ^bb6(%78: i64):  // 2 preds: ^bb5, ^bb9
    %79 = llvm.icmp "slt" %78, %13 : i64
    llvm.cond_br %79, ^bb7, ^bb10
  ^bb7:  // pred: ^bb6
    %80 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %81 = llvm.getelementptr %80[%78] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    %82 = llvm.load %81 : !llvm.ptr<i32>
    %83 = llvm.sext %82 : i32 to i64
    %84 = llvm.extractvalue %5[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %85 = llvm.getelementptr %84[%83] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %86 = llvm.load %85 : !llvm.ptr<f32>
    %87 = llvm.extractvalue %74[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %88 = llvm.getelementptr %87[%15] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %89 = llvm.load %88 : !llvm.ptr<f32>
    %90 = llvm.fcmp "olt" %86, %89 : f32
    llvm.cond_br %90, ^bb8, ^bb9
  ^bb8:  // pred: ^bb7
    %91 = llvm.extractvalue %52[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %92 = llvm.getelementptr %91[%15] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    llvm.store %78, %92 : !llvm.ptr<i64>
    %93 = llvm.extractvalue %74[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %94 = llvm.getelementptr %93[%15] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    llvm.store %86, %94 : !llvm.ptr<f32>
    llvm.br ^bb9
  ^bb9:  // 2 preds: ^bb7, ^bb8
    %95 = llvm.add %78, %16  : i64
    llvm.br ^bb6(%95 : i64)
  ^bb10:  // pred: ^bb6
    %96 = llvm.extractvalue %52[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %97 = llvm.getelementptr %96[%15] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    %98 = llvm.load %97 : !llvm.ptr<i64>
    %99 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %100 = llvm.getelementptr %99[%98] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    %101 = llvm.load %100 : !llvm.ptr<i32>
    %102 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %103 = llvm.getelementptr %102[%38] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    %104 = llvm.load %103 : !llvm.ptr<i32>
    %105 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %106 = llvm.getelementptr %105[%38] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %101, %106 : !llvm.ptr<i32>
    %107 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %108 = llvm.getelementptr %107[%98] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %104, %108 : !llvm.ptr<i32>
    %109 = llvm.add %38, %16  : i64
    llvm.br ^bb4(%109 : i64)
  ^bb11:  // pred: ^bb4
    omp.parallel num_threads(%17 : i64) default(shared) {
      %112 = llvm.call @plaidml_rt_thread_num() : () -> i64
      %113 = llvm.extractvalue %11[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
      %114 = llvm.getelementptr %113[%112] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
      llvm.store %12, %114 : !llvm.ptr<i32>
      %115 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
      %116 = llvm.getelementptr %115[%112] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
      %117 = llvm.load %116 : !llvm.ptr<i32>
      %118 = llvm.extractvalue %11[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
      %119 = llvm.getelementptr %118[%112] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
      llvm.store %117, %119 : !llvm.ptr<i32>
      omp.terminator
    }
    %110 = llvm.extractvalue %31[0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %111 = llvm.bitcast %110 : !llvm.ptr<i32> to !llvm.ptr<i8>
    llvm.call @free(%111) : (!llvm.ptr<i8>) -> ()
    llvm.return
  }
  llvm.func @_mlir_ciface_main(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>>, %arg2: !llvm.ptr<struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>>) {
    %0 = llvm.load %arg1 : !llvm.ptr<struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>>
    %1 = llvm.extractvalue %0[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %3 = llvm.extractvalue %0[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %4 = llvm.extractvalue %0[3, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %5 = llvm.extractvalue %0[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %6 = llvm.load %arg2 : !llvm.ptr<struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>>
    %7 = llvm.extractvalue %6[0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %8 = llvm.extractvalue %6[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %9 = llvm.extractvalue %6[2] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %10 = llvm.extractvalue %6[3, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %11 = llvm.extractvalue %6[4, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    llvm.call @main(%arg0, %1, %2, %3, %4, %5, %7, %8, %9, %10, %11) : (!llvm.ptr<i8>, !llvm.ptr<f32>, !llvm.ptr<f32>, i64, i64, i64, !llvm.ptr<i32>, !llvm.ptr<i32>, i64, i64, i64) -> ()
    llvm.return
  }
  llvm.func @fini(%arg0: !llvm.ptr<i8>) {
    llvm.return
  }
  llvm.func @_mlir_ciface_fini(%arg0: !llvm.ptr<i8>) {
    llvm.call @fini(%arg0) : (!llvm.ptr<i8>) -> ()
    llvm.return
  }
  llvm.func @plaidml_rt_thread_num() -> i64 attributes {sym_visibility = "private"} {
    %0 = llvm.call @_mlir_ciface_plaidml_rt_thread_num() : () -> i64
    llvm.return %0 : i64
  }
  llvm.func @_mlir_ciface_plaidml_rt_thread_num() -> i64 attributes {sym_visibility = "private"}
}


// *** IR Dump After OpenMPWorkaround *** ('llvm.func' operation: @main)
module @argsort  {
  llvm.func @free(!llvm.ptr<i8>)
  llvm.func @malloc(i64) -> !llvm.ptr<i8>
  llvm.func @init() -> !llvm.ptr<i8> {
    %0 = llvm.mlir.null : !llvm.ptr<i8>
    llvm.return %0 : !llvm.ptr<i8>
  }
  llvm.func @_mlir_ciface_init() -> !llvm.ptr<i8> {
    %0 = llvm.call @init() : () -> !llvm.ptr<i8>
    llvm.return %0 : !llvm.ptr<i8>
  }
  llvm.func @main(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<f32>, %arg2: !llvm.ptr<f32>, %arg3: i64, %arg4: i64, %arg5: i64, %arg6: !llvm.ptr<i32>, %arg7: !llvm.ptr<i32>, %arg8: i64, %arg9: i64, %arg10: i64) {
    %0 = llvm.mlir.undef : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %1 = llvm.insertvalue %arg1, %0[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %2 = llvm.insertvalue %arg2, %1[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %3 = llvm.insertvalue %arg3, %2[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %4 = llvm.insertvalue %arg4, %3[3, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %5 = llvm.insertvalue %arg5, %4[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %6 = llvm.mlir.undef : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %7 = llvm.insertvalue %arg6, %6[0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %8 = llvm.insertvalue %arg7, %7[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %9 = llvm.insertvalue %arg8, %8[2] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %10 = llvm.insertvalue %arg9, %9[3, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %11 = llvm.insertvalue %arg10, %10[4, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %12 = llvm.mlir.constant(0 : i32) : i32
    %13 = llvm.mlir.constant(20 : index) : i64
    %14 = llvm.mlir.constant(19 : index) : i64
    %15 = llvm.mlir.constant(0 : index) : i64
    %16 = llvm.mlir.constant(1 : index) : i64
    %17 = llvm.mlir.constant(10 : index) : i64
    %18 = llvm.mlir.constant(10 : index) : i64
    %19 = llvm.mlir.constant(1 : index) : i64
    %20 = llvm.mlir.null : !llvm.ptr<i32>
    %21 = llvm.getelementptr %20[%18] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    %22 = llvm.ptrtoint %21 : !llvm.ptr<i32> to i64
    %23 = llvm.call @malloc(%22) : (i64) -> !llvm.ptr<i8>
    %24 = llvm.bitcast %23 : !llvm.ptr<i8> to !llvm.ptr<i32>
    %25 = llvm.mlir.undef : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %26 = llvm.insertvalue %24, %25[0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %27 = llvm.insertvalue %24, %26[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %28 = llvm.mlir.constant(0 : index) : i64
    %29 = llvm.insertvalue %28, %27[2] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %30 = llvm.insertvalue %18, %29[3, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %31 = llvm.insertvalue %19, %30[4, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    llvm.br ^bb1(%15 : i64)
  ^bb1(%32: i64):  // 2 preds: ^bb0, ^bb2
    %33 = llvm.icmp "slt" %32, %13 : i64
    llvm.cond_br %33, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %34 = llvm.trunc %32 : i64 to i32
    %35 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %36 = llvm.getelementptr %35[%32] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %34, %36 : !llvm.ptr<i32>
    %37 = llvm.add %32, %16  : i64
    llvm.br ^bb1(%37 : i64)
  ^bb3:  // pred: ^bb1
    llvm.br ^bb4(%15 : i64)
  ^bb4(%38: i64):  // 2 preds: ^bb3, ^bb10
    %39 = llvm.icmp "slt" %38, %14 : i64
    llvm.cond_br %39, ^bb5, ^bb11
  ^bb5:  // pred: ^bb4
    %40 = llvm.mlir.constant(1 : index) : i64
    %41 = llvm.mlir.constant(1 : index) : i64
    %42 = llvm.mlir.null : !llvm.ptr<i64>
    %43 = llvm.getelementptr %42[%40] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    %44 = llvm.ptrtoint %43 : !llvm.ptr<i64> to i64
    %45 = llvm.alloca %44 x i64 : (i64) -> !llvm.ptr<i64>
    %46 = llvm.mlir.undef : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %47 = llvm.insertvalue %45, %46[0] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %48 = llvm.insertvalue %45, %47[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %49 = llvm.mlir.constant(0 : index) : i64
    %50 = llvm.insertvalue %49, %48[2] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %51 = llvm.insertvalue %40, %50[3, 0] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %52 = llvm.insertvalue %41, %51[4, 0] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %53 = llvm.extractvalue %52[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %54 = llvm.getelementptr %53[%15] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    llvm.store %38, %54 : !llvm.ptr<i64>
    %55 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %56 = llvm.getelementptr %55[%38] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    %57 = llvm.load %56 : !llvm.ptr<i32>
    %58 = llvm.sext %57 : i32 to i64
    %59 = llvm.extractvalue %5[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %60 = llvm.getelementptr %59[%58] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %61 = llvm.load %60 : !llvm.ptr<f32>
    %62 = llvm.mlir.constant(1 : index) : i64
    %63 = llvm.mlir.constant(1 : index) : i64
    %64 = llvm.mlir.null : !llvm.ptr<f32>
    %65 = llvm.getelementptr %64[%62] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %66 = llvm.ptrtoint %65 : !llvm.ptr<f32> to i64
    %67 = llvm.alloca %66 x f32 : (i64) -> !llvm.ptr<f32>
    %68 = llvm.mlir.undef : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %69 = llvm.insertvalue %67, %68[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %70 = llvm.insertvalue %67, %69[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %71 = llvm.mlir.constant(0 : index) : i64
    %72 = llvm.insertvalue %71, %70[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %73 = llvm.insertvalue %62, %72[3, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %74 = llvm.insertvalue %63, %73[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %75 = llvm.extractvalue %74[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %76 = llvm.getelementptr %75[%15] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    llvm.store %61, %76 : !llvm.ptr<f32>
    %77 = llvm.add %38, %16  : i64
    llvm.br ^bb6(%77 : i64)
  ^bb6(%78: i64):  // 2 preds: ^bb5, ^bb9
    %79 = llvm.icmp "slt" %78, %13 : i64
    llvm.cond_br %79, ^bb7, ^bb10
  ^bb7:  // pred: ^bb6
    %80 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %81 = llvm.getelementptr %80[%78] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    %82 = llvm.load %81 : !llvm.ptr<i32>
    %83 = llvm.sext %82 : i32 to i64
    %84 = llvm.extractvalue %5[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %85 = llvm.getelementptr %84[%83] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %86 = llvm.load %85 : !llvm.ptr<f32>
    %87 = llvm.extractvalue %74[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %88 = llvm.getelementptr %87[%15] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %89 = llvm.load %88 : !llvm.ptr<f32>
    %90 = llvm.fcmp "olt" %86, %89 : f32
    llvm.cond_br %90, ^bb8, ^bb9
  ^bb8:  // pred: ^bb7
    %91 = llvm.extractvalue %52[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %92 = llvm.getelementptr %91[%15] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    llvm.store %78, %92 : !llvm.ptr<i64>
    %93 = llvm.extractvalue %74[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %94 = llvm.getelementptr %93[%15] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    llvm.store %86, %94 : !llvm.ptr<f32>
    llvm.br ^bb9
  ^bb9:  // 2 preds: ^bb7, ^bb8
    %95 = llvm.add %78, %16  : i64
    llvm.br ^bb6(%95 : i64)
  ^bb10:  // pred: ^bb6
    %96 = llvm.extractvalue %52[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %97 = llvm.getelementptr %96[%15] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    %98 = llvm.load %97 : !llvm.ptr<i64>
    %99 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %100 = llvm.getelementptr %99[%98] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    %101 = llvm.load %100 : !llvm.ptr<i32>
    %102 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %103 = llvm.getelementptr %102[%38] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    %104 = llvm.load %103 : !llvm.ptr<i32>
    %105 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %106 = llvm.getelementptr %105[%38] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %101, %106 : !llvm.ptr<i32>
    %107 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %108 = llvm.getelementptr %107[%98] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %104, %108 : !llvm.ptr<i32>
    %109 = llvm.add %38, %16  : i64
    llvm.br ^bb4(%109 : i64)
  ^bb11:  // pred: ^bb4
    %110 = llvm.mlir.constant(1 : index) : i64
    %111 = llvm.alloca %110 x !llvm.struct<(struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>, i32, struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>)> : (i64) -> !llvm.ptr<struct<(struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>, i32, struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>)>>
    %112 = llvm.mlir.undef : !llvm.struct<(struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>, i32, struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>)>
    %113 = llvm.insertvalue %11, %112[0] : !llvm.struct<(struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>, i32, struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>)>
    %114 = llvm.insertvalue %12, %113[1] : !llvm.struct<(struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>, i32, struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>)>
    %115 = llvm.insertvalue %31, %114[2] : !llvm.struct<(struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>, i32, struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>)>
    llvm.store %115, %111 : !llvm.ptr<struct<(struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>, i32, struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>)>>
    omp.parallel num_threads(%17 : i64) default(shared) {
      %118 = llvm.load %111 : !llvm.ptr<struct<(struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>, i32, struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>)>>
      %119 = llvm.extractvalue %118[0] : !llvm.struct<(struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>, i32, struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>)>
      %120 = llvm.extractvalue %118[1] : !llvm.struct<(struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>, i32, struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>)>
      %121 = llvm.extractvalue %118[2] : !llvm.struct<(struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>, i32, struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>)>
      %122 = llvm.call @plaidml_rt_thread_num() : () -> i64
      %123 = llvm.extractvalue %119[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
      %124 = llvm.getelementptr %123[%122] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
      llvm.store %120, %124 : !llvm.ptr<i32>
      %125 = llvm.extractvalue %121[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
      %126 = llvm.getelementptr %125[%122] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
      %127 = llvm.load %126 : !llvm.ptr<i32>
      %128 = llvm.extractvalue %119[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
      %129 = llvm.getelementptr %128[%122] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
      llvm.store %127, %129 : !llvm.ptr<i32>
      omp.terminator
    }
    %116 = llvm.extractvalue %31[0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %117 = llvm.bitcast %116 : !llvm.ptr<i32> to !llvm.ptr<i8>
    llvm.call @free(%117) : (!llvm.ptr<i8>) -> ()
    llvm.return
  }
  llvm.func @_mlir_ciface_main(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>>, %arg2: !llvm.ptr<struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>>) {
    %0 = llvm.load %arg1 : !llvm.ptr<struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>>
    %1 = llvm.extractvalue %0[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %3 = llvm.extractvalue %0[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %4 = llvm.extractvalue %0[3, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %5 = llvm.extractvalue %0[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %6 = llvm.load %arg2 : !llvm.ptr<struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>>
    %7 = llvm.extractvalue %6[0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %8 = llvm.extractvalue %6[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %9 = llvm.extractvalue %6[2] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %10 = llvm.extractvalue %6[3, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %11 = llvm.extractvalue %6[4, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    llvm.call @main(%arg0, %1, %2, %3, %4, %5, %7, %8, %9, %10, %11) : (!llvm.ptr<i8>, !llvm.ptr<f32>, !llvm.ptr<f32>, i64, i64, i64, !llvm.ptr<i32>, !llvm.ptr<i32>, i64, i64, i64) -> ()
    llvm.return
  }
  llvm.func @fini(%arg0: !llvm.ptr<i8>) {
    llvm.return
  }
  llvm.func @_mlir_ciface_fini(%arg0: !llvm.ptr<i8>) {
    llvm.call @fini(%arg0) : (!llvm.ptr<i8>) -> ()
    llvm.return
  }
  llvm.func @plaidml_rt_thread_num() -> i64 attributes {sym_visibility = "private"} {
    %0 = llvm.call @_mlir_ciface_plaidml_rt_thread_num() : () -> i64
    llvm.return %0 : i64
  }
  llvm.func @_mlir_ciface_plaidml_rt_thread_num() -> i64 attributes {sym_visibility = "private"}
}


// *** IR Dump After OpenMPWorkaround *** ('llvm.func' operation: @_mlir_ciface_main)
module @argsort  {
  llvm.func @free(!llvm.ptr<i8>)
  llvm.func @malloc(i64) -> !llvm.ptr<i8>
  llvm.func @init() -> !llvm.ptr<i8> {
    %0 = llvm.mlir.null : !llvm.ptr<i8>
    llvm.return %0 : !llvm.ptr<i8>
  }
  llvm.func @_mlir_ciface_init() -> !llvm.ptr<i8> {
    %0 = llvm.call @init() : () -> !llvm.ptr<i8>
    llvm.return %0 : !llvm.ptr<i8>
  }
  llvm.func @main(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<f32>, %arg2: !llvm.ptr<f32>, %arg3: i64, %arg4: i64, %arg5: i64, %arg6: !llvm.ptr<i32>, %arg7: !llvm.ptr<i32>, %arg8: i64, %arg9: i64, %arg10: i64) {
    %0 = llvm.mlir.undef : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %1 = llvm.insertvalue %arg1, %0[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %2 = llvm.insertvalue %arg2, %1[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %3 = llvm.insertvalue %arg3, %2[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %4 = llvm.insertvalue %arg4, %3[3, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %5 = llvm.insertvalue %arg5, %4[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %6 = llvm.mlir.undef : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %7 = llvm.insertvalue %arg6, %6[0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %8 = llvm.insertvalue %arg7, %7[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %9 = llvm.insertvalue %arg8, %8[2] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %10 = llvm.insertvalue %arg9, %9[3, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %11 = llvm.insertvalue %arg10, %10[4, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %12 = llvm.mlir.constant(0 : i32) : i32
    %13 = llvm.mlir.constant(20 : index) : i64
    %14 = llvm.mlir.constant(19 : index) : i64
    %15 = llvm.mlir.constant(0 : index) : i64
    %16 = llvm.mlir.constant(1 : index) : i64
    %17 = llvm.mlir.constant(10 : index) : i64
    %18 = llvm.mlir.constant(10 : index) : i64
    %19 = llvm.mlir.constant(1 : index) : i64
    %20 = llvm.mlir.null : !llvm.ptr<i32>
    %21 = llvm.getelementptr %20[%18] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    %22 = llvm.ptrtoint %21 : !llvm.ptr<i32> to i64
    %23 = llvm.call @malloc(%22) : (i64) -> !llvm.ptr<i8>
    %24 = llvm.bitcast %23 : !llvm.ptr<i8> to !llvm.ptr<i32>
    %25 = llvm.mlir.undef : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %26 = llvm.insertvalue %24, %25[0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %27 = llvm.insertvalue %24, %26[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %28 = llvm.mlir.constant(0 : index) : i64
    %29 = llvm.insertvalue %28, %27[2] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %30 = llvm.insertvalue %18, %29[3, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %31 = llvm.insertvalue %19, %30[4, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    llvm.br ^bb1(%15 : i64)
  ^bb1(%32: i64):  // 2 preds: ^bb0, ^bb2
    %33 = llvm.icmp "slt" %32, %13 : i64
    llvm.cond_br %33, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %34 = llvm.trunc %32 : i64 to i32
    %35 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %36 = llvm.getelementptr %35[%32] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %34, %36 : !llvm.ptr<i32>
    %37 = llvm.add %32, %16  : i64
    llvm.br ^bb1(%37 : i64)
  ^bb3:  // pred: ^bb1
    llvm.br ^bb4(%15 : i64)
  ^bb4(%38: i64):  // 2 preds: ^bb3, ^bb10
    %39 = llvm.icmp "slt" %38, %14 : i64
    llvm.cond_br %39, ^bb5, ^bb11
  ^bb5:  // pred: ^bb4
    %40 = llvm.mlir.constant(1 : index) : i64
    %41 = llvm.mlir.constant(1 : index) : i64
    %42 = llvm.mlir.null : !llvm.ptr<i64>
    %43 = llvm.getelementptr %42[%40] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    %44 = llvm.ptrtoint %43 : !llvm.ptr<i64> to i64
    %45 = llvm.alloca %44 x i64 : (i64) -> !llvm.ptr<i64>
    %46 = llvm.mlir.undef : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %47 = llvm.insertvalue %45, %46[0] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %48 = llvm.insertvalue %45, %47[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %49 = llvm.mlir.constant(0 : index) : i64
    %50 = llvm.insertvalue %49, %48[2] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %51 = llvm.insertvalue %40, %50[3, 0] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %52 = llvm.insertvalue %41, %51[4, 0] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %53 = llvm.extractvalue %52[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %54 = llvm.getelementptr %53[%15] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    llvm.store %38, %54 : !llvm.ptr<i64>
    %55 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %56 = llvm.getelementptr %55[%38] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    %57 = llvm.load %56 : !llvm.ptr<i32>
    %58 = llvm.sext %57 : i32 to i64
    %59 = llvm.extractvalue %5[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %60 = llvm.getelementptr %59[%58] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %61 = llvm.load %60 : !llvm.ptr<f32>
    %62 = llvm.mlir.constant(1 : index) : i64
    %63 = llvm.mlir.constant(1 : index) : i64
    %64 = llvm.mlir.null : !llvm.ptr<f32>
    %65 = llvm.getelementptr %64[%62] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %66 = llvm.ptrtoint %65 : !llvm.ptr<f32> to i64
    %67 = llvm.alloca %66 x f32 : (i64) -> !llvm.ptr<f32>
    %68 = llvm.mlir.undef : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %69 = llvm.insertvalue %67, %68[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %70 = llvm.insertvalue %67, %69[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %71 = llvm.mlir.constant(0 : index) : i64
    %72 = llvm.insertvalue %71, %70[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %73 = llvm.insertvalue %62, %72[3, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %74 = llvm.insertvalue %63, %73[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %75 = llvm.extractvalue %74[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %76 = llvm.getelementptr %75[%15] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    llvm.store %61, %76 : !llvm.ptr<f32>
    %77 = llvm.add %38, %16  : i64
    llvm.br ^bb6(%77 : i64)
  ^bb6(%78: i64):  // 2 preds: ^bb5, ^bb9
    %79 = llvm.icmp "slt" %78, %13 : i64
    llvm.cond_br %79, ^bb7, ^bb10
  ^bb7:  // pred: ^bb6
    %80 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %81 = llvm.getelementptr %80[%78] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    %82 = llvm.load %81 : !llvm.ptr<i32>
    %83 = llvm.sext %82 : i32 to i64
    %84 = llvm.extractvalue %5[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %85 = llvm.getelementptr %84[%83] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %86 = llvm.load %85 : !llvm.ptr<f32>
    %87 = llvm.extractvalue %74[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %88 = llvm.getelementptr %87[%15] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %89 = llvm.load %88 : !llvm.ptr<f32>
    %90 = llvm.fcmp "olt" %86, %89 : f32
    llvm.cond_br %90, ^bb8, ^bb9
  ^bb8:  // pred: ^bb7
    %91 = llvm.extractvalue %52[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %92 = llvm.getelementptr %91[%15] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    llvm.store %78, %92 : !llvm.ptr<i64>
    %93 = llvm.extractvalue %74[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %94 = llvm.getelementptr %93[%15] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    llvm.store %86, %94 : !llvm.ptr<f32>
    llvm.br ^bb9
  ^bb9:  // 2 preds: ^bb7, ^bb8
    %95 = llvm.add %78, %16  : i64
    llvm.br ^bb6(%95 : i64)
  ^bb10:  // pred: ^bb6
    %96 = llvm.extractvalue %52[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %97 = llvm.getelementptr %96[%15] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    %98 = llvm.load %97 : !llvm.ptr<i64>
    %99 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %100 = llvm.getelementptr %99[%98] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    %101 = llvm.load %100 : !llvm.ptr<i32>
    %102 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %103 = llvm.getelementptr %102[%38] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    %104 = llvm.load %103 : !llvm.ptr<i32>
    %105 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %106 = llvm.getelementptr %105[%38] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %101, %106 : !llvm.ptr<i32>
    %107 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %108 = llvm.getelementptr %107[%98] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %104, %108 : !llvm.ptr<i32>
    %109 = llvm.add %38, %16  : i64
    llvm.br ^bb4(%109 : i64)
  ^bb11:  // pred: ^bb4
    %110 = llvm.mlir.constant(1 : index) : i64
    %111 = llvm.alloca %110 x !llvm.struct<(struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>, i32, struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>)> : (i64) -> !llvm.ptr<struct<(struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>, i32, struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>)>>
    %112 = llvm.mlir.undef : !llvm.struct<(struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>, i32, struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>)>
    %113 = llvm.insertvalue %11, %112[0] : !llvm.struct<(struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>, i32, struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>)>
    %114 = llvm.insertvalue %12, %113[1] : !llvm.struct<(struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>, i32, struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>)>
    %115 = llvm.insertvalue %31, %114[2] : !llvm.struct<(struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>, i32, struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>)>
    llvm.store %115, %111 : !llvm.ptr<struct<(struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>, i32, struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>)>>
    omp.parallel num_threads(%17 : i64) default(shared) {
      %118 = llvm.load %111 : !llvm.ptr<struct<(struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>, i32, struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>)>>
      %119 = llvm.extractvalue %118[0] : !llvm.struct<(struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>, i32, struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>)>
      %120 = llvm.extractvalue %118[1] : !llvm.struct<(struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>, i32, struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>)>
      %121 = llvm.extractvalue %118[2] : !llvm.struct<(struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>, i32, struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>)>
      %122 = llvm.call @plaidml_rt_thread_num() : () -> i64
      %123 = llvm.extractvalue %119[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
      %124 = llvm.getelementptr %123[%122] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
      llvm.store %120, %124 : !llvm.ptr<i32>
      %125 = llvm.extractvalue %121[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
      %126 = llvm.getelementptr %125[%122] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
      %127 = llvm.load %126 : !llvm.ptr<i32>
      %128 = llvm.extractvalue %119[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
      %129 = llvm.getelementptr %128[%122] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
      llvm.store %127, %129 : !llvm.ptr<i32>
      omp.terminator
    }
    %116 = llvm.extractvalue %31[0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %117 = llvm.bitcast %116 : !llvm.ptr<i32> to !llvm.ptr<i8>
    llvm.call @free(%117) : (!llvm.ptr<i8>) -> ()
    llvm.return
  }
  llvm.func @_mlir_ciface_main(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>>, %arg2: !llvm.ptr<struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>>) {
    %0 = llvm.load %arg1 : !llvm.ptr<struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>>
    %1 = llvm.extractvalue %0[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %3 = llvm.extractvalue %0[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %4 = llvm.extractvalue %0[3, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %5 = llvm.extractvalue %0[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %6 = llvm.load %arg2 : !llvm.ptr<struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>>
    %7 = llvm.extractvalue %6[0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %8 = llvm.extractvalue %6[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %9 = llvm.extractvalue %6[2] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %10 = llvm.extractvalue %6[3, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %11 = llvm.extractvalue %6[4, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    llvm.call @main(%arg0, %1, %2, %3, %4, %5, %7, %8, %9, %10, %11) : (!llvm.ptr<i8>, !llvm.ptr<f32>, !llvm.ptr<f32>, i64, i64, i64, !llvm.ptr<i32>, !llvm.ptr<i32>, i64, i64, i64) -> ()
    llvm.return
  }
  llvm.func @fini(%arg0: !llvm.ptr<i8>) {
    llvm.return
  }
  llvm.func @_mlir_ciface_fini(%arg0: !llvm.ptr<i8>) {
    llvm.call @fini(%arg0) : (!llvm.ptr<i8>) -> ()
    llvm.return
  }
  llvm.func @plaidml_rt_thread_num() -> i64 attributes {sym_visibility = "private"} {
    %0 = llvm.call @_mlir_ciface_plaidml_rt_thread_num() : () -> i64
    llvm.return %0 : i64
  }
  llvm.func @_mlir_ciface_plaidml_rt_thread_num() -> i64 attributes {sym_visibility = "private"}
}


// *** IR Dump After OpenMPWorkaround *** ('llvm.func' operation: @fini)
module @argsort  {
  llvm.func @free(!llvm.ptr<i8>)
  llvm.func @malloc(i64) -> !llvm.ptr<i8>
  llvm.func @init() -> !llvm.ptr<i8> {
    %0 = llvm.mlir.null : !llvm.ptr<i8>
    llvm.return %0 : !llvm.ptr<i8>
  }
  llvm.func @_mlir_ciface_init() -> !llvm.ptr<i8> {
    %0 = llvm.call @init() : () -> !llvm.ptr<i8>
    llvm.return %0 : !llvm.ptr<i8>
  }
  llvm.func @main(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<f32>, %arg2: !llvm.ptr<f32>, %arg3: i64, %arg4: i64, %arg5: i64, %arg6: !llvm.ptr<i32>, %arg7: !llvm.ptr<i32>, %arg8: i64, %arg9: i64, %arg10: i64) {
    %0 = llvm.mlir.undef : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %1 = llvm.insertvalue %arg1, %0[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %2 = llvm.insertvalue %arg2, %1[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %3 = llvm.insertvalue %arg3, %2[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %4 = llvm.insertvalue %arg4, %3[3, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %5 = llvm.insertvalue %arg5, %4[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %6 = llvm.mlir.undef : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %7 = llvm.insertvalue %arg6, %6[0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %8 = llvm.insertvalue %arg7, %7[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %9 = llvm.insertvalue %arg8, %8[2] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %10 = llvm.insertvalue %arg9, %9[3, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %11 = llvm.insertvalue %arg10, %10[4, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %12 = llvm.mlir.constant(0 : i32) : i32
    %13 = llvm.mlir.constant(20 : index) : i64
    %14 = llvm.mlir.constant(19 : index) : i64
    %15 = llvm.mlir.constant(0 : index) : i64
    %16 = llvm.mlir.constant(1 : index) : i64
    %17 = llvm.mlir.constant(10 : index) : i64
    %18 = llvm.mlir.constant(10 : index) : i64
    %19 = llvm.mlir.constant(1 : index) : i64
    %20 = llvm.mlir.null : !llvm.ptr<i32>
    %21 = llvm.getelementptr %20[%18] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    %22 = llvm.ptrtoint %21 : !llvm.ptr<i32> to i64
    %23 = llvm.call @malloc(%22) : (i64) -> !llvm.ptr<i8>
    %24 = llvm.bitcast %23 : !llvm.ptr<i8> to !llvm.ptr<i32>
    %25 = llvm.mlir.undef : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %26 = llvm.insertvalue %24, %25[0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %27 = llvm.insertvalue %24, %26[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %28 = llvm.mlir.constant(0 : index) : i64
    %29 = llvm.insertvalue %28, %27[2] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %30 = llvm.insertvalue %18, %29[3, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %31 = llvm.insertvalue %19, %30[4, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    llvm.br ^bb1(%15 : i64)
  ^bb1(%32: i64):  // 2 preds: ^bb0, ^bb2
    %33 = llvm.icmp "slt" %32, %13 : i64
    llvm.cond_br %33, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %34 = llvm.trunc %32 : i64 to i32
    %35 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %36 = llvm.getelementptr %35[%32] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %34, %36 : !llvm.ptr<i32>
    %37 = llvm.add %32, %16  : i64
    llvm.br ^bb1(%37 : i64)
  ^bb3:  // pred: ^bb1
    llvm.br ^bb4(%15 : i64)
  ^bb4(%38: i64):  // 2 preds: ^bb3, ^bb10
    %39 = llvm.icmp "slt" %38, %14 : i64
    llvm.cond_br %39, ^bb5, ^bb11
  ^bb5:  // pred: ^bb4
    %40 = llvm.mlir.constant(1 : index) : i64
    %41 = llvm.mlir.constant(1 : index) : i64
    %42 = llvm.mlir.null : !llvm.ptr<i64>
    %43 = llvm.getelementptr %42[%40] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    %44 = llvm.ptrtoint %43 : !llvm.ptr<i64> to i64
    %45 = llvm.alloca %44 x i64 : (i64) -> !llvm.ptr<i64>
    %46 = llvm.mlir.undef : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %47 = llvm.insertvalue %45, %46[0] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %48 = llvm.insertvalue %45, %47[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %49 = llvm.mlir.constant(0 : index) : i64
    %50 = llvm.insertvalue %49, %48[2] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %51 = llvm.insertvalue %40, %50[3, 0] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %52 = llvm.insertvalue %41, %51[4, 0] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %53 = llvm.extractvalue %52[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %54 = llvm.getelementptr %53[%15] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    llvm.store %38, %54 : !llvm.ptr<i64>
    %55 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %56 = llvm.getelementptr %55[%38] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    %57 = llvm.load %56 : !llvm.ptr<i32>
    %58 = llvm.sext %57 : i32 to i64
    %59 = llvm.extractvalue %5[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %60 = llvm.getelementptr %59[%58] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %61 = llvm.load %60 : !llvm.ptr<f32>
    %62 = llvm.mlir.constant(1 : index) : i64
    %63 = llvm.mlir.constant(1 : index) : i64
    %64 = llvm.mlir.null : !llvm.ptr<f32>
    %65 = llvm.getelementptr %64[%62] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %66 = llvm.ptrtoint %65 : !llvm.ptr<f32> to i64
    %67 = llvm.alloca %66 x f32 : (i64) -> !llvm.ptr<f32>
    %68 = llvm.mlir.undef : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %69 = llvm.insertvalue %67, %68[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %70 = llvm.insertvalue %67, %69[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %71 = llvm.mlir.constant(0 : index) : i64
    %72 = llvm.insertvalue %71, %70[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %73 = llvm.insertvalue %62, %72[3, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %74 = llvm.insertvalue %63, %73[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %75 = llvm.extractvalue %74[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %76 = llvm.getelementptr %75[%15] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    llvm.store %61, %76 : !llvm.ptr<f32>
    %77 = llvm.add %38, %16  : i64
    llvm.br ^bb6(%77 : i64)
  ^bb6(%78: i64):  // 2 preds: ^bb5, ^bb9
    %79 = llvm.icmp "slt" %78, %13 : i64
    llvm.cond_br %79, ^bb7, ^bb10
  ^bb7:  // pred: ^bb6
    %80 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %81 = llvm.getelementptr %80[%78] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    %82 = llvm.load %81 : !llvm.ptr<i32>
    %83 = llvm.sext %82 : i32 to i64
    %84 = llvm.extractvalue %5[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %85 = llvm.getelementptr %84[%83] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %86 = llvm.load %85 : !llvm.ptr<f32>
    %87 = llvm.extractvalue %74[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %88 = llvm.getelementptr %87[%15] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %89 = llvm.load %88 : !llvm.ptr<f32>
    %90 = llvm.fcmp "olt" %86, %89 : f32
    llvm.cond_br %90, ^bb8, ^bb9
  ^bb8:  // pred: ^bb7
    %91 = llvm.extractvalue %52[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %92 = llvm.getelementptr %91[%15] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    llvm.store %78, %92 : !llvm.ptr<i64>
    %93 = llvm.extractvalue %74[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %94 = llvm.getelementptr %93[%15] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    llvm.store %86, %94 : !llvm.ptr<f32>
    llvm.br ^bb9
  ^bb9:  // 2 preds: ^bb7, ^bb8
    %95 = llvm.add %78, %16  : i64
    llvm.br ^bb6(%95 : i64)
  ^bb10:  // pred: ^bb6
    %96 = llvm.extractvalue %52[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %97 = llvm.getelementptr %96[%15] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    %98 = llvm.load %97 : !llvm.ptr<i64>
    %99 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %100 = llvm.getelementptr %99[%98] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    %101 = llvm.load %100 : !llvm.ptr<i32>
    %102 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %103 = llvm.getelementptr %102[%38] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    %104 = llvm.load %103 : !llvm.ptr<i32>
    %105 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %106 = llvm.getelementptr %105[%38] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %101, %106 : !llvm.ptr<i32>
    %107 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %108 = llvm.getelementptr %107[%98] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %104, %108 : !llvm.ptr<i32>
    %109 = llvm.add %38, %16  : i64
    llvm.br ^bb4(%109 : i64)
  ^bb11:  // pred: ^bb4
    %110 = llvm.mlir.constant(1 : index) : i64
    %111 = llvm.alloca %110 x !llvm.struct<(struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>, i32, struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>)> : (i64) -> !llvm.ptr<struct<(struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>, i32, struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>)>>
    %112 = llvm.mlir.undef : !llvm.struct<(struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>, i32, struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>)>
    %113 = llvm.insertvalue %11, %112[0] : !llvm.struct<(struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>, i32, struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>)>
    %114 = llvm.insertvalue %12, %113[1] : !llvm.struct<(struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>, i32, struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>)>
    %115 = llvm.insertvalue %31, %114[2] : !llvm.struct<(struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>, i32, struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>)>
    llvm.store %115, %111 : !llvm.ptr<struct<(struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>, i32, struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>)>>
    omp.parallel num_threads(%17 : i64) default(shared) {
      %118 = llvm.load %111 : !llvm.ptr<struct<(struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>, i32, struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>)>>
      %119 = llvm.extractvalue %118[0] : !llvm.struct<(struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>, i32, struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>)>
      %120 = llvm.extractvalue %118[1] : !llvm.struct<(struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>, i32, struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>)>
      %121 = llvm.extractvalue %118[2] : !llvm.struct<(struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>, i32, struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>)>
      %122 = llvm.call @plaidml_rt_thread_num() : () -> i64
      %123 = llvm.extractvalue %119[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
      %124 = llvm.getelementptr %123[%122] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
      llvm.store %120, %124 : !llvm.ptr<i32>
      %125 = llvm.extractvalue %121[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
      %126 = llvm.getelementptr %125[%122] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
      %127 = llvm.load %126 : !llvm.ptr<i32>
      %128 = llvm.extractvalue %119[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
      %129 = llvm.getelementptr %128[%122] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
      llvm.store %127, %129 : !llvm.ptr<i32>
      omp.terminator
    }
    %116 = llvm.extractvalue %31[0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %117 = llvm.bitcast %116 : !llvm.ptr<i32> to !llvm.ptr<i8>
    llvm.call @free(%117) : (!llvm.ptr<i8>) -> ()
    llvm.return
  }
  llvm.func @_mlir_ciface_main(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>>, %arg2: !llvm.ptr<struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>>) {
    %0 = llvm.load %arg1 : !llvm.ptr<struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>>
    %1 = llvm.extractvalue %0[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %3 = llvm.extractvalue %0[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %4 = llvm.extractvalue %0[3, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %5 = llvm.extractvalue %0[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %6 = llvm.load %arg2 : !llvm.ptr<struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>>
    %7 = llvm.extractvalue %6[0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %8 = llvm.extractvalue %6[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %9 = llvm.extractvalue %6[2] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %10 = llvm.extractvalue %6[3, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %11 = llvm.extractvalue %6[4, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    llvm.call @main(%arg0, %1, %2, %3, %4, %5, %7, %8, %9, %10, %11) : (!llvm.ptr<i8>, !llvm.ptr<f32>, !llvm.ptr<f32>, i64, i64, i64, !llvm.ptr<i32>, !llvm.ptr<i32>, i64, i64, i64) -> ()
    llvm.return
  }
  llvm.func @fini(%arg0: !llvm.ptr<i8>) {
    llvm.return
  }
  llvm.func @_mlir_ciface_fini(%arg0: !llvm.ptr<i8>) {
    llvm.call @fini(%arg0) : (!llvm.ptr<i8>) -> ()
    llvm.return
  }
  llvm.func @plaidml_rt_thread_num() -> i64 attributes {sym_visibility = "private"} {
    %0 = llvm.call @_mlir_ciface_plaidml_rt_thread_num() : () -> i64
    llvm.return %0 : i64
  }
  llvm.func @_mlir_ciface_plaidml_rt_thread_num() -> i64 attributes {sym_visibility = "private"}
}


// *** IR Dump After OpenMPWorkaround *** ('llvm.func' operation: @_mlir_ciface_fini)
module @argsort  {
  llvm.func @free(!llvm.ptr<i8>)
  llvm.func @malloc(i64) -> !llvm.ptr<i8>
  llvm.func @init() -> !llvm.ptr<i8> {
    %0 = llvm.mlir.null : !llvm.ptr<i8>
    llvm.return %0 : !llvm.ptr<i8>
  }
  llvm.func @_mlir_ciface_init() -> !llvm.ptr<i8> {
    %0 = llvm.call @init() : () -> !llvm.ptr<i8>
    llvm.return %0 : !llvm.ptr<i8>
  }
  llvm.func @main(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<f32>, %arg2: !llvm.ptr<f32>, %arg3: i64, %arg4: i64, %arg5: i64, %arg6: !llvm.ptr<i32>, %arg7: !llvm.ptr<i32>, %arg8: i64, %arg9: i64, %arg10: i64) {
    %0 = llvm.mlir.undef : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %1 = llvm.insertvalue %arg1, %0[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %2 = llvm.insertvalue %arg2, %1[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %3 = llvm.insertvalue %arg3, %2[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %4 = llvm.insertvalue %arg4, %3[3, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %5 = llvm.insertvalue %arg5, %4[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %6 = llvm.mlir.undef : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %7 = llvm.insertvalue %arg6, %6[0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %8 = llvm.insertvalue %arg7, %7[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %9 = llvm.insertvalue %arg8, %8[2] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %10 = llvm.insertvalue %arg9, %9[3, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %11 = llvm.insertvalue %arg10, %10[4, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %12 = llvm.mlir.constant(0 : i32) : i32
    %13 = llvm.mlir.constant(20 : index) : i64
    %14 = llvm.mlir.constant(19 : index) : i64
    %15 = llvm.mlir.constant(0 : index) : i64
    %16 = llvm.mlir.constant(1 : index) : i64
    %17 = llvm.mlir.constant(10 : index) : i64
    %18 = llvm.mlir.constant(10 : index) : i64
    %19 = llvm.mlir.constant(1 : index) : i64
    %20 = llvm.mlir.null : !llvm.ptr<i32>
    %21 = llvm.getelementptr %20[%18] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    %22 = llvm.ptrtoint %21 : !llvm.ptr<i32> to i64
    %23 = llvm.call @malloc(%22) : (i64) -> !llvm.ptr<i8>
    %24 = llvm.bitcast %23 : !llvm.ptr<i8> to !llvm.ptr<i32>
    %25 = llvm.mlir.undef : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %26 = llvm.insertvalue %24, %25[0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %27 = llvm.insertvalue %24, %26[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %28 = llvm.mlir.constant(0 : index) : i64
    %29 = llvm.insertvalue %28, %27[2] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %30 = llvm.insertvalue %18, %29[3, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %31 = llvm.insertvalue %19, %30[4, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    llvm.br ^bb1(%15 : i64)
  ^bb1(%32: i64):  // 2 preds: ^bb0, ^bb2
    %33 = llvm.icmp "slt" %32, %13 : i64
    llvm.cond_br %33, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %34 = llvm.trunc %32 : i64 to i32
    %35 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %36 = llvm.getelementptr %35[%32] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %34, %36 : !llvm.ptr<i32>
    %37 = llvm.add %32, %16  : i64
    llvm.br ^bb1(%37 : i64)
  ^bb3:  // pred: ^bb1
    llvm.br ^bb4(%15 : i64)
  ^bb4(%38: i64):  // 2 preds: ^bb3, ^bb10
    %39 = llvm.icmp "slt" %38, %14 : i64
    llvm.cond_br %39, ^bb5, ^bb11
  ^bb5:  // pred: ^bb4
    %40 = llvm.mlir.constant(1 : index) : i64
    %41 = llvm.mlir.constant(1 : index) : i64
    %42 = llvm.mlir.null : !llvm.ptr<i64>
    %43 = llvm.getelementptr %42[%40] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    %44 = llvm.ptrtoint %43 : !llvm.ptr<i64> to i64
    %45 = llvm.alloca %44 x i64 : (i64) -> !llvm.ptr<i64>
    %46 = llvm.mlir.undef : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %47 = llvm.insertvalue %45, %46[0] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %48 = llvm.insertvalue %45, %47[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %49 = llvm.mlir.constant(0 : index) : i64
    %50 = llvm.insertvalue %49, %48[2] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %51 = llvm.insertvalue %40, %50[3, 0] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %52 = llvm.insertvalue %41, %51[4, 0] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %53 = llvm.extractvalue %52[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %54 = llvm.getelementptr %53[%15] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    llvm.store %38, %54 : !llvm.ptr<i64>
    %55 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %56 = llvm.getelementptr %55[%38] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    %57 = llvm.load %56 : !llvm.ptr<i32>
    %58 = llvm.sext %57 : i32 to i64
    %59 = llvm.extractvalue %5[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %60 = llvm.getelementptr %59[%58] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %61 = llvm.load %60 : !llvm.ptr<f32>
    %62 = llvm.mlir.constant(1 : index) : i64
    %63 = llvm.mlir.constant(1 : index) : i64
    %64 = llvm.mlir.null : !llvm.ptr<f32>
    %65 = llvm.getelementptr %64[%62] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %66 = llvm.ptrtoint %65 : !llvm.ptr<f32> to i64
    %67 = llvm.alloca %66 x f32 : (i64) -> !llvm.ptr<f32>
    %68 = llvm.mlir.undef : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %69 = llvm.insertvalue %67, %68[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %70 = llvm.insertvalue %67, %69[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %71 = llvm.mlir.constant(0 : index) : i64
    %72 = llvm.insertvalue %71, %70[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %73 = llvm.insertvalue %62, %72[3, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %74 = llvm.insertvalue %63, %73[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %75 = llvm.extractvalue %74[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %76 = llvm.getelementptr %75[%15] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    llvm.store %61, %76 : !llvm.ptr<f32>
    %77 = llvm.add %38, %16  : i64
    llvm.br ^bb6(%77 : i64)
  ^bb6(%78: i64):  // 2 preds: ^bb5, ^bb9
    %79 = llvm.icmp "slt" %78, %13 : i64
    llvm.cond_br %79, ^bb7, ^bb10
  ^bb7:  // pred: ^bb6
    %80 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %81 = llvm.getelementptr %80[%78] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    %82 = llvm.load %81 : !llvm.ptr<i32>
    %83 = llvm.sext %82 : i32 to i64
    %84 = llvm.extractvalue %5[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %85 = llvm.getelementptr %84[%83] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %86 = llvm.load %85 : !llvm.ptr<f32>
    %87 = llvm.extractvalue %74[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %88 = llvm.getelementptr %87[%15] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %89 = llvm.load %88 : !llvm.ptr<f32>
    %90 = llvm.fcmp "olt" %86, %89 : f32
    llvm.cond_br %90, ^bb8, ^bb9
  ^bb8:  // pred: ^bb7
    %91 = llvm.extractvalue %52[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %92 = llvm.getelementptr %91[%15] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    llvm.store %78, %92 : !llvm.ptr<i64>
    %93 = llvm.extractvalue %74[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %94 = llvm.getelementptr %93[%15] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    llvm.store %86, %94 : !llvm.ptr<f32>
    llvm.br ^bb9
  ^bb9:  // 2 preds: ^bb7, ^bb8
    %95 = llvm.add %78, %16  : i64
    llvm.br ^bb6(%95 : i64)
  ^bb10:  // pred: ^bb6
    %96 = llvm.extractvalue %52[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %97 = llvm.getelementptr %96[%15] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    %98 = llvm.load %97 : !llvm.ptr<i64>
    %99 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %100 = llvm.getelementptr %99[%98] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    %101 = llvm.load %100 : !llvm.ptr<i32>
    %102 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %103 = llvm.getelementptr %102[%38] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    %104 = llvm.load %103 : !llvm.ptr<i32>
    %105 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %106 = llvm.getelementptr %105[%38] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %101, %106 : !llvm.ptr<i32>
    %107 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %108 = llvm.getelementptr %107[%98] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %104, %108 : !llvm.ptr<i32>
    %109 = llvm.add %38, %16  : i64
    llvm.br ^bb4(%109 : i64)
  ^bb11:  // pred: ^bb4
    %110 = llvm.mlir.constant(1 : index) : i64
    %111 = llvm.alloca %110 x !llvm.struct<(struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>, i32, struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>)> : (i64) -> !llvm.ptr<struct<(struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>, i32, struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>)>>
    %112 = llvm.mlir.undef : !llvm.struct<(struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>, i32, struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>)>
    %113 = llvm.insertvalue %11, %112[0] : !llvm.struct<(struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>, i32, struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>)>
    %114 = llvm.insertvalue %12, %113[1] : !llvm.struct<(struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>, i32, struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>)>
    %115 = llvm.insertvalue %31, %114[2] : !llvm.struct<(struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>, i32, struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>)>
    llvm.store %115, %111 : !llvm.ptr<struct<(struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>, i32, struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>)>>
    omp.parallel num_threads(%17 : i64) default(shared) {
      %118 = llvm.load %111 : !llvm.ptr<struct<(struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>, i32, struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>)>>
      %119 = llvm.extractvalue %118[0] : !llvm.struct<(struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>, i32, struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>)>
      %120 = llvm.extractvalue %118[1] : !llvm.struct<(struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>, i32, struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>)>
      %121 = llvm.extractvalue %118[2] : !llvm.struct<(struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>, i32, struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>)>
      %122 = llvm.call @plaidml_rt_thread_num() : () -> i64
      %123 = llvm.extractvalue %119[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
      %124 = llvm.getelementptr %123[%122] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
      llvm.store %120, %124 : !llvm.ptr<i32>
      %125 = llvm.extractvalue %121[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
      %126 = llvm.getelementptr %125[%122] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
      %127 = llvm.load %126 : !llvm.ptr<i32>
      %128 = llvm.extractvalue %119[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
      %129 = llvm.getelementptr %128[%122] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
      llvm.store %127, %129 : !llvm.ptr<i32>
      omp.terminator
    }
    %116 = llvm.extractvalue %31[0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %117 = llvm.bitcast %116 : !llvm.ptr<i32> to !llvm.ptr<i8>
    llvm.call @free(%117) : (!llvm.ptr<i8>) -> ()
    llvm.return
  }
  llvm.func @_mlir_ciface_main(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>>, %arg2: !llvm.ptr<struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>>) {
    %0 = llvm.load %arg1 : !llvm.ptr<struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>>
    %1 = llvm.extractvalue %0[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %3 = llvm.extractvalue %0[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %4 = llvm.extractvalue %0[3, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %5 = llvm.extractvalue %0[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %6 = llvm.load %arg2 : !llvm.ptr<struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>>
    %7 = llvm.extractvalue %6[0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %8 = llvm.extractvalue %6[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %9 = llvm.extractvalue %6[2] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %10 = llvm.extractvalue %6[3, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %11 = llvm.extractvalue %6[4, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    llvm.call @main(%arg0, %1, %2, %3, %4, %5, %7, %8, %9, %10, %11) : (!llvm.ptr<i8>, !llvm.ptr<f32>, !llvm.ptr<f32>, i64, i64, i64, !llvm.ptr<i32>, !llvm.ptr<i32>, i64, i64, i64) -> ()
    llvm.return
  }
  llvm.func @fini(%arg0: !llvm.ptr<i8>) {
    llvm.return
  }
  llvm.func @_mlir_ciface_fini(%arg0: !llvm.ptr<i8>) {
    llvm.call @fini(%arg0) : (!llvm.ptr<i8>) -> ()
    llvm.return
  }
  llvm.func @plaidml_rt_thread_num() -> i64 attributes {sym_visibility = "private"} {
    %0 = llvm.call @_mlir_ciface_plaidml_rt_thread_num() : () -> i64
    llvm.return %0 : i64
  }
  llvm.func @_mlir_ciface_plaidml_rt_thread_num() -> i64 attributes {sym_visibility = "private"}
}


// *** IR Dump After OpenMPWorkaround *** ('llvm.func' operation: @plaidml_rt_thread_num)
module @argsort  {
  llvm.func @free(!llvm.ptr<i8>)
  llvm.func @malloc(i64) -> !llvm.ptr<i8>
  llvm.func @init() -> !llvm.ptr<i8> {
    %0 = llvm.mlir.null : !llvm.ptr<i8>
    llvm.return %0 : !llvm.ptr<i8>
  }
  llvm.func @_mlir_ciface_init() -> !llvm.ptr<i8> {
    %0 = llvm.call @init() : () -> !llvm.ptr<i8>
    llvm.return %0 : !llvm.ptr<i8>
  }
  llvm.func @main(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<f32>, %arg2: !llvm.ptr<f32>, %arg3: i64, %arg4: i64, %arg5: i64, %arg6: !llvm.ptr<i32>, %arg7: !llvm.ptr<i32>, %arg8: i64, %arg9: i64, %arg10: i64) {
    %0 = llvm.mlir.undef : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %1 = llvm.insertvalue %arg1, %0[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %2 = llvm.insertvalue %arg2, %1[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %3 = llvm.insertvalue %arg3, %2[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %4 = llvm.insertvalue %arg4, %3[3, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %5 = llvm.insertvalue %arg5, %4[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %6 = llvm.mlir.undef : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %7 = llvm.insertvalue %arg6, %6[0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %8 = llvm.insertvalue %arg7, %7[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %9 = llvm.insertvalue %arg8, %8[2] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %10 = llvm.insertvalue %arg9, %9[3, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %11 = llvm.insertvalue %arg10, %10[4, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %12 = llvm.mlir.constant(0 : i32) : i32
    %13 = llvm.mlir.constant(20 : index) : i64
    %14 = llvm.mlir.constant(19 : index) : i64
    %15 = llvm.mlir.constant(0 : index) : i64
    %16 = llvm.mlir.constant(1 : index) : i64
    %17 = llvm.mlir.constant(10 : index) : i64
    %18 = llvm.mlir.constant(10 : index) : i64
    %19 = llvm.mlir.constant(1 : index) : i64
    %20 = llvm.mlir.null : !llvm.ptr<i32>
    %21 = llvm.getelementptr %20[%18] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    %22 = llvm.ptrtoint %21 : !llvm.ptr<i32> to i64
    %23 = llvm.call @malloc(%22) : (i64) -> !llvm.ptr<i8>
    %24 = llvm.bitcast %23 : !llvm.ptr<i8> to !llvm.ptr<i32>
    %25 = llvm.mlir.undef : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %26 = llvm.insertvalue %24, %25[0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %27 = llvm.insertvalue %24, %26[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %28 = llvm.mlir.constant(0 : index) : i64
    %29 = llvm.insertvalue %28, %27[2] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %30 = llvm.insertvalue %18, %29[3, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %31 = llvm.insertvalue %19, %30[4, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    llvm.br ^bb1(%15 : i64)
  ^bb1(%32: i64):  // 2 preds: ^bb0, ^bb2
    %33 = llvm.icmp "slt" %32, %13 : i64
    llvm.cond_br %33, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %34 = llvm.trunc %32 : i64 to i32
    %35 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %36 = llvm.getelementptr %35[%32] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %34, %36 : !llvm.ptr<i32>
    %37 = llvm.add %32, %16  : i64
    llvm.br ^bb1(%37 : i64)
  ^bb3:  // pred: ^bb1
    llvm.br ^bb4(%15 : i64)
  ^bb4(%38: i64):  // 2 preds: ^bb3, ^bb10
    %39 = llvm.icmp "slt" %38, %14 : i64
    llvm.cond_br %39, ^bb5, ^bb11
  ^bb5:  // pred: ^bb4
    %40 = llvm.mlir.constant(1 : index) : i64
    %41 = llvm.mlir.constant(1 : index) : i64
    %42 = llvm.mlir.null : !llvm.ptr<i64>
    %43 = llvm.getelementptr %42[%40] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    %44 = llvm.ptrtoint %43 : !llvm.ptr<i64> to i64
    %45 = llvm.alloca %44 x i64 : (i64) -> !llvm.ptr<i64>
    %46 = llvm.mlir.undef : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %47 = llvm.insertvalue %45, %46[0] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %48 = llvm.insertvalue %45, %47[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %49 = llvm.mlir.constant(0 : index) : i64
    %50 = llvm.insertvalue %49, %48[2] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %51 = llvm.insertvalue %40, %50[3, 0] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %52 = llvm.insertvalue %41, %51[4, 0] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %53 = llvm.extractvalue %52[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %54 = llvm.getelementptr %53[%15] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    llvm.store %38, %54 : !llvm.ptr<i64>
    %55 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %56 = llvm.getelementptr %55[%38] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    %57 = llvm.load %56 : !llvm.ptr<i32>
    %58 = llvm.sext %57 : i32 to i64
    %59 = llvm.extractvalue %5[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %60 = llvm.getelementptr %59[%58] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %61 = llvm.load %60 : !llvm.ptr<f32>
    %62 = llvm.mlir.constant(1 : index) : i64
    %63 = llvm.mlir.constant(1 : index) : i64
    %64 = llvm.mlir.null : !llvm.ptr<f32>
    %65 = llvm.getelementptr %64[%62] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %66 = llvm.ptrtoint %65 : !llvm.ptr<f32> to i64
    %67 = llvm.alloca %66 x f32 : (i64) -> !llvm.ptr<f32>
    %68 = llvm.mlir.undef : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %69 = llvm.insertvalue %67, %68[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %70 = llvm.insertvalue %67, %69[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %71 = llvm.mlir.constant(0 : index) : i64
    %72 = llvm.insertvalue %71, %70[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %73 = llvm.insertvalue %62, %72[3, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %74 = llvm.insertvalue %63, %73[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %75 = llvm.extractvalue %74[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %76 = llvm.getelementptr %75[%15] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    llvm.store %61, %76 : !llvm.ptr<f32>
    %77 = llvm.add %38, %16  : i64
    llvm.br ^bb6(%77 : i64)
  ^bb6(%78: i64):  // 2 preds: ^bb5, ^bb9
    %79 = llvm.icmp "slt" %78, %13 : i64
    llvm.cond_br %79, ^bb7, ^bb10
  ^bb7:  // pred: ^bb6
    %80 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %81 = llvm.getelementptr %80[%78] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    %82 = llvm.load %81 : !llvm.ptr<i32>
    %83 = llvm.sext %82 : i32 to i64
    %84 = llvm.extractvalue %5[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %85 = llvm.getelementptr %84[%83] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %86 = llvm.load %85 : !llvm.ptr<f32>
    %87 = llvm.extractvalue %74[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %88 = llvm.getelementptr %87[%15] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %89 = llvm.load %88 : !llvm.ptr<f32>
    %90 = llvm.fcmp "olt" %86, %89 : f32
    llvm.cond_br %90, ^bb8, ^bb9
  ^bb8:  // pred: ^bb7
    %91 = llvm.extractvalue %52[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %92 = llvm.getelementptr %91[%15] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    llvm.store %78, %92 : !llvm.ptr<i64>
    %93 = llvm.extractvalue %74[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %94 = llvm.getelementptr %93[%15] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    llvm.store %86, %94 : !llvm.ptr<f32>
    llvm.br ^bb9
  ^bb9:  // 2 preds: ^bb7, ^bb8
    %95 = llvm.add %78, %16  : i64
    llvm.br ^bb6(%95 : i64)
  ^bb10:  // pred: ^bb6
    %96 = llvm.extractvalue %52[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %97 = llvm.getelementptr %96[%15] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    %98 = llvm.load %97 : !llvm.ptr<i64>
    %99 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %100 = llvm.getelementptr %99[%98] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    %101 = llvm.load %100 : !llvm.ptr<i32>
    %102 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %103 = llvm.getelementptr %102[%38] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    %104 = llvm.load %103 : !llvm.ptr<i32>
    %105 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %106 = llvm.getelementptr %105[%38] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %101, %106 : !llvm.ptr<i32>
    %107 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %108 = llvm.getelementptr %107[%98] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %104, %108 : !llvm.ptr<i32>
    %109 = llvm.add %38, %16  : i64
    llvm.br ^bb4(%109 : i64)
  ^bb11:  // pred: ^bb4
    %110 = llvm.mlir.constant(1 : index) : i64
    %111 = llvm.alloca %110 x !llvm.struct<(struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>, i32, struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>)> : (i64) -> !llvm.ptr<struct<(struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>, i32, struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>)>>
    %112 = llvm.mlir.undef : !llvm.struct<(struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>, i32, struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>)>
    %113 = llvm.insertvalue %11, %112[0] : !llvm.struct<(struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>, i32, struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>)>
    %114 = llvm.insertvalue %12, %113[1] : !llvm.struct<(struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>, i32, struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>)>
    %115 = llvm.insertvalue %31, %114[2] : !llvm.struct<(struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>, i32, struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>)>
    llvm.store %115, %111 : !llvm.ptr<struct<(struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>, i32, struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>)>>
    omp.parallel num_threads(%17 : i64) default(shared) {
      %118 = llvm.load %111 : !llvm.ptr<struct<(struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>, i32, struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>)>>
      %119 = llvm.extractvalue %118[0] : !llvm.struct<(struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>, i32, struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>)>
      %120 = llvm.extractvalue %118[1] : !llvm.struct<(struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>, i32, struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>)>
      %121 = llvm.extractvalue %118[2] : !llvm.struct<(struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>, i32, struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>)>
      %122 = llvm.call @plaidml_rt_thread_num() : () -> i64
      %123 = llvm.extractvalue %119[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
      %124 = llvm.getelementptr %123[%122] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
      llvm.store %120, %124 : !llvm.ptr<i32>
      %125 = llvm.extractvalue %121[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
      %126 = llvm.getelementptr %125[%122] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
      %127 = llvm.load %126 : !llvm.ptr<i32>
      %128 = llvm.extractvalue %119[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
      %129 = llvm.getelementptr %128[%122] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
      llvm.store %127, %129 : !llvm.ptr<i32>
      omp.terminator
    }
    %116 = llvm.extractvalue %31[0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %117 = llvm.bitcast %116 : !llvm.ptr<i32> to !llvm.ptr<i8>
    llvm.call @free(%117) : (!llvm.ptr<i8>) -> ()
    llvm.return
  }
  llvm.func @_mlir_ciface_main(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>>, %arg2: !llvm.ptr<struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>>) {
    %0 = llvm.load %arg1 : !llvm.ptr<struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>>
    %1 = llvm.extractvalue %0[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %3 = llvm.extractvalue %0[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %4 = llvm.extractvalue %0[3, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %5 = llvm.extractvalue %0[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %6 = llvm.load %arg2 : !llvm.ptr<struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>>
    %7 = llvm.extractvalue %6[0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %8 = llvm.extractvalue %6[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %9 = llvm.extractvalue %6[2] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %10 = llvm.extractvalue %6[3, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %11 = llvm.extractvalue %6[4, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    llvm.call @main(%arg0, %1, %2, %3, %4, %5, %7, %8, %9, %10, %11) : (!llvm.ptr<i8>, !llvm.ptr<f32>, !llvm.ptr<f32>, i64, i64, i64, !llvm.ptr<i32>, !llvm.ptr<i32>, i64, i64, i64) -> ()
    llvm.return
  }
  llvm.func @fini(%arg0: !llvm.ptr<i8>) {
    llvm.return
  }
  llvm.func @_mlir_ciface_fini(%arg0: !llvm.ptr<i8>) {
    llvm.call @fini(%arg0) : (!llvm.ptr<i8>) -> ()
    llvm.return
  }
  llvm.func @plaidml_rt_thread_num() -> i64 attributes {sym_visibility = "private"} {
    %0 = llvm.call @_mlir_ciface_plaidml_rt_thread_num() : () -> i64
    llvm.return %0 : i64
  }
  llvm.func @_mlir_ciface_plaidml_rt_thread_num() -> i64 attributes {sym_visibility = "private"}
}


// *** IR Dump After OpenMPWorkaround *** ('llvm.func' operation: @_mlir_ciface_plaidml_rt_thread_num)
module @argsort  {
  llvm.func @free(!llvm.ptr<i8>)
  llvm.func @malloc(i64) -> !llvm.ptr<i8>
  llvm.func @init() -> !llvm.ptr<i8> {
    %0 = llvm.mlir.null : !llvm.ptr<i8>
    llvm.return %0 : !llvm.ptr<i8>
  }
  llvm.func @_mlir_ciface_init() -> !llvm.ptr<i8> {
    %0 = llvm.call @init() : () -> !llvm.ptr<i8>
    llvm.return %0 : !llvm.ptr<i8>
  }
  llvm.func @main(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<f32>, %arg2: !llvm.ptr<f32>, %arg3: i64, %arg4: i64, %arg5: i64, %arg6: !llvm.ptr<i32>, %arg7: !llvm.ptr<i32>, %arg8: i64, %arg9: i64, %arg10: i64) {
    %0 = llvm.mlir.undef : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %1 = llvm.insertvalue %arg1, %0[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %2 = llvm.insertvalue %arg2, %1[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %3 = llvm.insertvalue %arg3, %2[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %4 = llvm.insertvalue %arg4, %3[3, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %5 = llvm.insertvalue %arg5, %4[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %6 = llvm.mlir.undef : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %7 = llvm.insertvalue %arg6, %6[0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %8 = llvm.insertvalue %arg7, %7[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %9 = llvm.insertvalue %arg8, %8[2] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %10 = llvm.insertvalue %arg9, %9[3, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %11 = llvm.insertvalue %arg10, %10[4, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %12 = llvm.mlir.constant(0 : i32) : i32
    %13 = llvm.mlir.constant(20 : index) : i64
    %14 = llvm.mlir.constant(19 : index) : i64
    %15 = llvm.mlir.constant(0 : index) : i64
    %16 = llvm.mlir.constant(1 : index) : i64
    %17 = llvm.mlir.constant(10 : index) : i64
    %18 = llvm.mlir.constant(10 : index) : i64
    %19 = llvm.mlir.constant(1 : index) : i64
    %20 = llvm.mlir.null : !llvm.ptr<i32>
    %21 = llvm.getelementptr %20[%18] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    %22 = llvm.ptrtoint %21 : !llvm.ptr<i32> to i64
    %23 = llvm.call @malloc(%22) : (i64) -> !llvm.ptr<i8>
    %24 = llvm.bitcast %23 : !llvm.ptr<i8> to !llvm.ptr<i32>
    %25 = llvm.mlir.undef : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %26 = llvm.insertvalue %24, %25[0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %27 = llvm.insertvalue %24, %26[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %28 = llvm.mlir.constant(0 : index) : i64
    %29 = llvm.insertvalue %28, %27[2] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %30 = llvm.insertvalue %18, %29[3, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %31 = llvm.insertvalue %19, %30[4, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    llvm.br ^bb1(%15 : i64)
  ^bb1(%32: i64):  // 2 preds: ^bb0, ^bb2
    %33 = llvm.icmp "slt" %32, %13 : i64
    llvm.cond_br %33, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %34 = llvm.trunc %32 : i64 to i32
    %35 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %36 = llvm.getelementptr %35[%32] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %34, %36 : !llvm.ptr<i32>
    %37 = llvm.add %32, %16  : i64
    llvm.br ^bb1(%37 : i64)
  ^bb3:  // pred: ^bb1
    llvm.br ^bb4(%15 : i64)
  ^bb4(%38: i64):  // 2 preds: ^bb3, ^bb10
    %39 = llvm.icmp "slt" %38, %14 : i64
    llvm.cond_br %39, ^bb5, ^bb11
  ^bb5:  // pred: ^bb4
    %40 = llvm.mlir.constant(1 : index) : i64
    %41 = llvm.mlir.constant(1 : index) : i64
    %42 = llvm.mlir.null : !llvm.ptr<i64>
    %43 = llvm.getelementptr %42[%40] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    %44 = llvm.ptrtoint %43 : !llvm.ptr<i64> to i64
    %45 = llvm.alloca %44 x i64 : (i64) -> !llvm.ptr<i64>
    %46 = llvm.mlir.undef : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %47 = llvm.insertvalue %45, %46[0] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %48 = llvm.insertvalue %45, %47[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %49 = llvm.mlir.constant(0 : index) : i64
    %50 = llvm.insertvalue %49, %48[2] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %51 = llvm.insertvalue %40, %50[3, 0] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %52 = llvm.insertvalue %41, %51[4, 0] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %53 = llvm.extractvalue %52[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %54 = llvm.getelementptr %53[%15] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    llvm.store %38, %54 : !llvm.ptr<i64>
    %55 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %56 = llvm.getelementptr %55[%38] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    %57 = llvm.load %56 : !llvm.ptr<i32>
    %58 = llvm.sext %57 : i32 to i64
    %59 = llvm.extractvalue %5[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %60 = llvm.getelementptr %59[%58] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %61 = llvm.load %60 : !llvm.ptr<f32>
    %62 = llvm.mlir.constant(1 : index) : i64
    %63 = llvm.mlir.constant(1 : index) : i64
    %64 = llvm.mlir.null : !llvm.ptr<f32>
    %65 = llvm.getelementptr %64[%62] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %66 = llvm.ptrtoint %65 : !llvm.ptr<f32> to i64
    %67 = llvm.alloca %66 x f32 : (i64) -> !llvm.ptr<f32>
    %68 = llvm.mlir.undef : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %69 = llvm.insertvalue %67, %68[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %70 = llvm.insertvalue %67, %69[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %71 = llvm.mlir.constant(0 : index) : i64
    %72 = llvm.insertvalue %71, %70[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %73 = llvm.insertvalue %62, %72[3, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %74 = llvm.insertvalue %63, %73[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %75 = llvm.extractvalue %74[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %76 = llvm.getelementptr %75[%15] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    llvm.store %61, %76 : !llvm.ptr<f32>
    %77 = llvm.add %38, %16  : i64
    llvm.br ^bb6(%77 : i64)
  ^bb6(%78: i64):  // 2 preds: ^bb5, ^bb9
    %79 = llvm.icmp "slt" %78, %13 : i64
    llvm.cond_br %79, ^bb7, ^bb10
  ^bb7:  // pred: ^bb6
    %80 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %81 = llvm.getelementptr %80[%78] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    %82 = llvm.load %81 : !llvm.ptr<i32>
    %83 = llvm.sext %82 : i32 to i64
    %84 = llvm.extractvalue %5[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %85 = llvm.getelementptr %84[%83] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %86 = llvm.load %85 : !llvm.ptr<f32>
    %87 = llvm.extractvalue %74[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %88 = llvm.getelementptr %87[%15] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %89 = llvm.load %88 : !llvm.ptr<f32>
    %90 = llvm.fcmp "olt" %86, %89 : f32
    llvm.cond_br %90, ^bb8, ^bb9
  ^bb8:  // pred: ^bb7
    %91 = llvm.extractvalue %52[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %92 = llvm.getelementptr %91[%15] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    llvm.store %78, %92 : !llvm.ptr<i64>
    %93 = llvm.extractvalue %74[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %94 = llvm.getelementptr %93[%15] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    llvm.store %86, %94 : !llvm.ptr<f32>
    llvm.br ^bb9
  ^bb9:  // 2 preds: ^bb7, ^bb8
    %95 = llvm.add %78, %16  : i64
    llvm.br ^bb6(%95 : i64)
  ^bb10:  // pred: ^bb6
    %96 = llvm.extractvalue %52[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %97 = llvm.getelementptr %96[%15] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    %98 = llvm.load %97 : !llvm.ptr<i64>
    %99 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %100 = llvm.getelementptr %99[%98] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    %101 = llvm.load %100 : !llvm.ptr<i32>
    %102 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %103 = llvm.getelementptr %102[%38] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    %104 = llvm.load %103 : !llvm.ptr<i32>
    %105 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %106 = llvm.getelementptr %105[%38] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %101, %106 : !llvm.ptr<i32>
    %107 = llvm.extractvalue %31[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %108 = llvm.getelementptr %107[%98] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %104, %108 : !llvm.ptr<i32>
    %109 = llvm.add %38, %16  : i64
    llvm.br ^bb4(%109 : i64)
  ^bb11:  // pred: ^bb4
    %110 = llvm.mlir.constant(1 : index) : i64
    %111 = llvm.alloca %110 x !llvm.struct<(struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>, i32, struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>)> : (i64) -> !llvm.ptr<struct<(struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>, i32, struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>)>>
    %112 = llvm.mlir.undef : !llvm.struct<(struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>, i32, struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>)>
    %113 = llvm.insertvalue %11, %112[0] : !llvm.struct<(struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>, i32, struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>)>
    %114 = llvm.insertvalue %12, %113[1] : !llvm.struct<(struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>, i32, struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>)>
    %115 = llvm.insertvalue %31, %114[2] : !llvm.struct<(struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>, i32, struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>)>
    llvm.store %115, %111 : !llvm.ptr<struct<(struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>, i32, struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>)>>
    omp.parallel num_threads(%17 : i64) default(shared) {
      %118 = llvm.load %111 : !llvm.ptr<struct<(struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>, i32, struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>)>>
      %119 = llvm.extractvalue %118[0] : !llvm.struct<(struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>, i32, struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>)>
      %120 = llvm.extractvalue %118[1] : !llvm.struct<(struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>, i32, struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>)>
      %121 = llvm.extractvalue %118[2] : !llvm.struct<(struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>, i32, struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>)>
      %122 = llvm.call @plaidml_rt_thread_num() : () -> i64
      %123 = llvm.extractvalue %119[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
      %124 = llvm.getelementptr %123[%122] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
      llvm.store %120, %124 : !llvm.ptr<i32>
      %125 = llvm.extractvalue %121[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
      %126 = llvm.getelementptr %125[%122] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
      %127 = llvm.load %126 : !llvm.ptr<i32>
      %128 = llvm.extractvalue %119[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
      %129 = llvm.getelementptr %128[%122] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
      llvm.store %127, %129 : !llvm.ptr<i32>
      omp.terminator
    }
    %116 = llvm.extractvalue %31[0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %117 = llvm.bitcast %116 : !llvm.ptr<i32> to !llvm.ptr<i8>
    llvm.call @free(%117) : (!llvm.ptr<i8>) -> ()
    llvm.return
  }
  llvm.func @_mlir_ciface_main(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>>, %arg2: !llvm.ptr<struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>>) {
    %0 = llvm.load %arg1 : !llvm.ptr<struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>>
    %1 = llvm.extractvalue %0[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %3 = llvm.extractvalue %0[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %4 = llvm.extractvalue %0[3, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %5 = llvm.extractvalue %0[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %6 = llvm.load %arg2 : !llvm.ptr<struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>>
    %7 = llvm.extractvalue %6[0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %8 = llvm.extractvalue %6[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %9 = llvm.extractvalue %6[2] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %10 = llvm.extractvalue %6[3, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %11 = llvm.extractvalue %6[4, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    llvm.call @main(%arg0, %1, %2, %3, %4, %5, %7, %8, %9, %10, %11) : (!llvm.ptr<i8>, !llvm.ptr<f32>, !llvm.ptr<f32>, i64, i64, i64, !llvm.ptr<i32>, !llvm.ptr<i32>, i64, i64, i64) -> ()
    llvm.return
  }
  llvm.func @fini(%arg0: !llvm.ptr<i8>) {
    llvm.return
  }
  llvm.func @_mlir_ciface_fini(%arg0: !llvm.ptr<i8>) {
    llvm.call @fini(%arg0) : (!llvm.ptr<i8>) -> ()
    llvm.return
  }
  llvm.func @plaidml_rt_thread_num() -> i64 attributes {sym_visibility = "private"} {
    %0 = llvm.call @_mlir_ciface_plaidml_rt_thread_num() : () -> i64
    llvm.return %0 : i64
  }
  llvm.func @_mlir_ciface_plaidml_rt_thread_num() -> i64 attributes {sym_visibility = "private"}
}


===-------------------------------------------------------------------------===
                         ... Pass statistics report ...
===-------------------------------------------------------------------------===
'func' Pipeline
  InlineLayers
  ComputeBounds
SplitMain
HoistingPass
'func' Pipeline
  PadConstraints
Canonicalizer
CSE
  (S) 0 num-cse'd - Number of operations CSE'd
  (S) 0 num-dce'd - Number of operations DCE'd
LowerTileToPXA
Canonicalizer
CSE
  (S) 0 num-cse'd - Number of operations CSE'd
  (S) 0 num-dce'd - Number of operations DCE'd
'func' Pipeline
  InlineLayers
  XSMMStencil
  AffineNormalize
Canonicalizer
'func' Pipeline
  TileAccumulate
  AffineNormalize
Canonicalizer
'func' Pipeline
  CPUThread
  AffineNormalize
Canonicalizer
'func' Pipeline
  Fusion
  AffineNormalize
Canonicalizer
'func' Pipeline
  MemRefDataFlowOpt
Canonicalizer
'func' Pipeline
  Localize
  ResizeTmps
DeallocPlacement
'func' Pipeline
  AffineNormalize
Canonicalizer
CSE
  (S) 0 num-cse'd - Number of operations CSE'd
  (S) 0 num-dce'd - Number of operations DCE'd
ConvertPXAToAffine
LoopInvariantCodeMotion
Canonicalizer
CSE
  (S) 0 num-cse'd - Number of operations CSE'd
  (S) 0 num-dce'd - Number of operations DCE'd
ConvertAffineToStandard
Canonicalizer
CSE
  (S) 0 num-cse'd - Number of operations CSE'd
  (S) 0 num-dce'd - Number of operations DCE'd
LowerSCFToOpenMP
Canonicalizer
CSE
  (S) 0 num-cse'd - Number of operations CSE'd
  (S) 0 num-dce'd - Number of operations DCE'd
SCFToStandard
ConvertStandardToLLVM
TraceLinking
'llvm.func' Pipeline
  OpenMPWorkaround

===-------------------------------------------------------------------------===
                      ... Pass execution timing report ...
===-------------------------------------------------------------------------===
  Total Execution Time: 0.0868 seconds

   ---Wall Time---  --- Name ---
   0.0020 (  2.3%)  'func' Pipeline
   0.0005 (  0.6%)    InlineLayers
   0.0015 (  1.8%)    ComputeBounds
   0.0007 (  0.8%)  SplitMain
   0.0008 (  1.0%)  HoistingPass
   0.0019 (  2.2%)  'func' Pipeline
   0.0019 (  2.2%)    PadConstraints
   0.0007 (  0.8%)  Canonicalizer
   0.0007 (  0.8%)  CSE
   0.0000 (  0.0%)    (A) DominanceInfo
   0.0025 (  2.9%)  LowerTileToPXA
   0.0029 (  3.3%)  Canonicalizer
   0.0020 (  2.3%)  CSE
   0.0000 (  0.0%)    (A) DominanceInfo
   0.0104 ( 12.0%)  'func' Pipeline
   0.0036 (  4.1%)    InlineLayers
   0.0035 (  4.0%)    XSMMStencil
   0.0033 (  3.8%)    AffineNormalize
   0.0012 (  1.3%)  Canonicalizer
   0.0053 (  6.1%)  'func' Pipeline
   0.0026 (  3.0%)    TileAccumulate
   0.0027 (  3.1%)    AffineNormalize
   0.0013 (  1.5%)  Canonicalizer
   0.0047 (  5.4%)  'func' Pipeline
   0.0025 (  2.8%)    CPUThread
   0.0023 (  2.6%)    AffineNormalize
   0.0008 (  1.0%)  Canonicalizer
   0.0052 (  6.0%)  'func' Pipeline
   0.0036 (  4.2%)    Fusion
   0.0016 (  1.8%)    AffineNormalize
   0.0008 (  0.9%)  Canonicalizer
   0.0016 (  1.8%)  'func' Pipeline
   0.0016 (  1.8%)    MemRefDataFlowOpt
   0.0008 (  0.9%)  Canonicalizer
   0.0033 (  3.8%)  'func' Pipeline
   0.0016 (  1.8%)    Localize
   0.0000 (  0.0%)      (A) pmlc::dialect::pxa::{anonymous}::LocalizeAnalysis
   0.0017 (  1.9%)    ResizeTmps
   0.0007 (  0.9%)  DeallocPlacement
   0.0016 (  1.9%)  'func' Pipeline
   0.0016 (  1.9%)    AffineNormalize
   0.0008 (  0.9%)  Canonicalizer
   0.0006 (  0.7%)  CSE
   0.0000 (  0.0%)    (A) DominanceInfo
   0.0006 (  0.7%)  ConvertPXAToAffine
   0.0005 (  0.6%)  LoopInvariantCodeMotion
   0.0007 (  0.9%)  Canonicalizer
   0.0005 (  0.6%)  CSE
   0.0000 (  0.0%)    (A) DominanceInfo
   0.0006 (  0.7%)  ConvertAffineToStandard
   0.0008 (  0.9%)  Canonicalizer
   0.0005 (  0.6%)  CSE
   0.0000 (  0.0%)    (A) DominanceInfo
   0.0006 (  0.7%)  LowerSCFToOpenMP
   0.0007 (  0.8%)  Canonicalizer
   0.0006 (  0.6%)  CSE
   0.0000 (  0.0%)    (A) DominanceInfo
   0.0008 (  0.9%)  SCFToStandard
   0.0025 (  2.9%)  ConvertStandardToLLVM
   0.0022 (  2.5%)  TraceLinking
   0.0216 ( 24.9%)  'llvm.func' Pipeline
   0.0216 ( 24.9%)    OpenMPWorkaround
   0.0868 (100.0%)  Total
2021-04-07 05:11:48,605 VERBOSE-3 [default] plaidml_buffer_adopt: 0x3c686d0
2021-04-07 05:11:48,605 VERBOSE-3 [default] plaidml_buffer_alloc: 0x3c67340: 10xsi32
2021-04-07 05:11:48,605 VERBOSE-1 [default] JITing for device: llvm_cpu.0
2021-04-07 05:11:48,614 VERBOSE-3 [default] Doing jit init
2021-04-07 05:11:48,614 VERBOSE-3 [default] Jit init complete
2021-04-07 05:11:48,615 VERBOSE-1 [default] Execution time: 0.438312ms
2021-04-07 05:11:48,615 VERBOSE-3 [default] Doing jit fini
2021-04-07 05:11:48,615 VERBOSE-3 [default] Jit fini complete
2021-04-07 05:11:48,615 VERBOSE-3 [default] plaidml_buffer_free: 0x3c92110: 80
munmap_chunk(): invalid pointer
