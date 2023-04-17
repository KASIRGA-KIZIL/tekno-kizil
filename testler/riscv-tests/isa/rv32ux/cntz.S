# See LICENSE for license details.

#*****************************************************************************
# cntz.S
#-----------------------------------------------------------------------------
#
# Test cntz instruction.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Logical tests
  #-------------------------------------------------------------
  # TEST_R_OP( testnum, inst, result, val1 )

  TEST_R_OP( 2, cntz, 0x2, 0xdab54f04 );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------
  # TEST_R_SRC1_EQ_DEST( testnum, inst, result, val1 )

  TEST_R_SRC1_EQ_DEST( 6, cntz, 0x2, 0xdab54f04 );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------
  # TEST_R_DEST_BYPASS( testnum, nop_cycles, inst, result, val1 )

  TEST_R_DEST_BYPASS( 10, 1, cntz, 0x2, 0xdab54f04 );

  ## tek regli icin zero makrosu yok biz ekleyebiliriz test_macros.h'a
  
  TEST_R_OP( 35, cntz, 0x1 , 0x6f7f4e12);
  TEST_R_OP( 36, cntz, 0x0 , 0x41be1bed);
  TEST_R_OP( 37, cntz, 0x0 , 0x32f9456f);
  TEST_R_OP( 38, cntz, 0x0 , 0x292c186f);
  TEST_R_OP( 39, cntz, 0x1 , 0x7ddf792a);
  TEST_R_OP( 40, cntz, 0x2 , 0x6cb2668c);
  TEST_R_OP( 41, cntz, 0x0 , 0x503a13ab);
  TEST_R_OP( 42, cntz, 0x0 , 0x210b3a95);
  TEST_R_OP( 43, cntz, 0x0 , 0x6b160c4b);
  TEST_R_OP( 44, cntz, 0x0 , 0x2d36620d);
  TEST_R_OP( 45, cntz, 0x3 , 0x570513d8);
  TEST_R_OP( 46, cntz, 0x1 , 0x58f4182e);
  TEST_R_OP( 47, cntz, 0x0 , 0x7a9b5115);
  TEST_R_OP( 48, cntz, 0x1 , 0x6b4d2a62);
  TEST_R_OP( 49, cntz, 0x0 , 0x40f06d37);
  TEST_R_OP( 50, cntz, 0x0 , 0x590b6ccb);
  TEST_R_OP( 51, cntz, 0x0 , 0x50217069);
  TEST_R_OP( 52, cntz, 0x2 , 0x033e7ebc);
  TEST_R_OP( 53, cntz, 0x0 , 0x4fcf6e49);
  TEST_R_OP( 54, cntz, 0x0 , 0x05b65f3d);
  TEST_R_OP( 55, cntz, 0x0 , 0x3f9e0269);
  TEST_R_OP( 56, cntz, 0x0 , 0x158c518b);

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
