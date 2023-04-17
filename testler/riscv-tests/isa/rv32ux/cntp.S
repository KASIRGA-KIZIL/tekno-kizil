# See LICENSE for license details.

#*****************************************************************************
# cntp.S
#-----------------------------------------------------------------------------
#
# Test cntp instruction.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Logical tests
  #-------------------------------------------------------------
  # TEST_R_OP( testnum, inst, result, val1 )

  TEST_R_OP( 2, cntp, 0x11, 0xa7c9487b );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------
  # TEST_R_SRC1_EQ_DEST( testnum, inst, result, val1 )

  TEST_R_SRC1_EQ_DEST( 6, cntp, 0x11, 0xa7c9487b );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------
  # TEST_R_DEST_BYPASS( testnum, nop_cycles, inst, result, val1 )

  TEST_R_DEST_BYPASS( 10, 1, cntp, 0x11, 0xa7c9487b );

  ## tek regli icin zero makrosu yok biz ekleyebiliriz test_macros.h'a

  TEST_R_OP( 35, cntp, 0xf , 0x790d258e);
  TEST_R_OP( 36, cntp, 0x13 , 0x23ee7cae);
  TEST_R_OP( 37, cntp, 0x9 , 0x68460188);
  TEST_R_OP( 38, cntp, 0x12 , 0x2eae335d);
  TEST_R_OP( 39, cntp, 0x12 , 0x7d740d57);
  TEST_R_OP( 40, cntp, 0xf , 0x63f85462);
  TEST_R_OP( 41, cntp, 0x13 , 0x3555773e);
  TEST_R_OP( 42, cntp, 0xd , 0x564434d2);
  TEST_R_OP( 43, cntp, 0xf , 0x223e7cc4);
  TEST_R_OP( 44, cntp, 0x10 , 0x2be13e46);
  TEST_R_OP( 45, cntp, 0xf , 0x5c951933);
  TEST_R_OP( 46, cntp, 0x12 , 0x376f255a);
  TEST_R_OP( 47, cntp, 0xc , 0x4356441a);
  TEST_R_OP( 48, cntp, 0xc , 0x6064302f);
  TEST_R_OP( 49, cntp, 0x11 , 0x0c8e3fcb);
  TEST_R_OP( 50, cntp, 0xd , 0x5b880ce8);
  TEST_R_OP( 51, cntp, 0x14 , 0x25e377dd);
  TEST_R_OP( 52, cntp, 0xe , 0x33793830);
  TEST_R_OP( 53, cntp, 0x10 , 0x650a6fac);
  TEST_R_OP( 54, cntp, 0x10 , 0x212773b3);
  TEST_R_OP( 55, cntp, 0xc , 0x084f40d5);
  TEST_R_OP( 56, cntp, 0xd , 0x34594ca1);
  TEST_R_OP( 57, cntp, 0xd , 0x071129ba);
  TEST_R_OP( 58, cntp, 0xd , 0x4c26322e);
  TEST_R_OP( 59, cntp, 0x9 , 0x32442c04);
  TEST_R_OP( 60, cntp, 0x11 , 0x5f7d1c14);
  TEST_R_OP( 61, cntp, 0x10 , 0x24ed3b1c);
  TEST_R_OP( 62, cntp, 0xe , 0x159e410f);
  TEST_R_OP( 63, cntp, 0xd , 0x04a97ab0);
  TEST_R_OP( 64, cntp, 0x10 , 0x2e9e5d60);
  TEST_R_OP( 65, cntp, 0xb , 0x12260d34);
  TEST_R_OP( 66, cntp, 0x11 , 0x3be7094b);
  TEST_R_OP( 67, cntp, 0xf , 0x09a8725f);
  TEST_R_OP( 68, cntp, 0x10 , 0x28b61f99);
  TEST_R_OP( 69, cntp, 0x10 , 0x538675aa);
  TEST_R_OP( 70, cntp, 0xe , 0x129b3417);
  TEST_R_OP( 71, cntp, 0xc , 0x04aa2cd4);
  TEST_R_OP( 72, cntp, 0x11 , 0x71fd1a15);
  TEST_R_OP( 73, cntp, 0xd , 0x2f150661);
  TEST_R_OP( 74, cntp, 0xf , 0x12937ae8);
  TEST_R_OP( 75, cntp, 0xb , 0x02596816);
  TEST_R_OP( 76, cntp, 0x12 , 0x5bec7c68);

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
