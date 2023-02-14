##### conv.S
# See LICENSE for license details.

#*****************************************************************************
# conv.S
#-----------------------------------------------------------------------------
#
# Test self-modifying code and the conv instructions.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN


  TEST_CASE( 2, x22, 6870, \

      li  x1, 32;
      li  x2, 4;
      li  x31, 189;
      li  x4, 2;
      li  x5, 5;
      li  x6, 16;
      li  x27, 28;
      li  x8, 677;

      li  x9, 323;
      li  x10, 14;
      li  x11, 1819;
      li  x12, 21;
      li  x13, 1455;

      li  x14, 3;

      li  x15, 11111;
      li  x16, 123;

      li  x17, 321;
      li  x18, 136;
      li  x23, 248;
      li  x19, 6577;
      li  x20, 6771;
      li  x21, 28;

      conv.ld.w.en x1, x2;
      conv.ld.w x31, x4;
      conv.ld.w x4, x31;

      conv.ld.x.en x5, x6;
      conv.ld.x x27, x8;
      conv.ld.x x8, x27;

      conv.run x22; \
  )

  conv.clr.x
  conv.clr.w

  TEST_CASE( 25, x22, 0, \
      conv.run x22; \
  )

  conv.ld.w.en x1, x2
  conv.ld.w x31, x4
  conv.ld.w x4, x31

  conv.ld.x.en x5, x6
  conv.ld.x x27, x8
  conv.ld.x x8, x27

  TEST_CASE( 3, x22, 6870, \
      conv.run x22; \
  )

  conv.ld.w.en x9, x10
  conv.ld.w.en x11, x12
  conv.ld.w.en x12, x11
  conv.ld.w x13, x4
  conv.ld.w x4, x13
  conv.ld.w.en x14, x2
  conv.ld.w.en x15, x16

  conv.ld.x.en x17, x18
  conv.ld.x.en x23, x19
  conv.ld.x.en x20, x21
  conv.ld.x.en x20, x21
  conv.ld.x.en x20, x21
  conv.ld.x.en x20, x21

  TEST_CASE( 4, x22, 86003120, \
      conv.run x22; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
