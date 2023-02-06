# See LICENSE for license details.

#*****************************************************************************
# hmdst.S
#-----------------------------------------------------------------------------
#
# Test hmdst instruction.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Logical tests
  #-------------------------------------------------------------
  # TEST_RR_OP( testnum, inst, result, val1, val2 )

  TEST_RR_OP( 2, hmdst, 0xb, 0x95ef299f, 0x1065418b );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------
  # TEST_RR_SRC1_EQ_DEST( testnum, inst, result, val1, val2 )
  # TEST_RR_SRC2_EQ_DEST( testnum, inst, result, val1, val2 )
  # TEST_RR_SRC12_EQ_DEST( testnum, inst, result, val1 )

  TEST_RR_SRC1_EQ_DEST( 6, hmdst, 0xb, 0x95ef299f, 0x1065418b );
  TEST_RR_SRC2_EQ_DEST( 7, hmdst, 0xb, 0x95ef299f, 0x1065418b );
  TEST_RR_SRC12_EQ_DEST( 8, hmdst, 0x0, 0x95ef299f );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------
  # TEST_RR_DEST_BYPASS( testnum, nop_cycles, inst, result, val1, val2 )
  # TEST_RR_SRC12_BYPASS( testnum, src1_nops, src2_nops, inst, result, val1, val2 )
  # TEST_RR_SRC21_BYPASS( testnum, src1_nops, src2_nops, inst, result, val1, val2 )
  # TEST_RR_ZEROSRC1( testnum, inst, result, val )
  # TEST_RR_ZEROSRC2( testnum, inst, result, val )
  # TEST_RR_ZEROSRC12( testnum, inst, result )
  # TEST_RR_ZERODEST( testnum, inst, val1, val2 )

  TEST_RR_DEST_BYPASS( 10, 1, hmdst, 0xb, 0x95ef299f, 0x1065418b );

  TEST_RR_SRC12_BYPASS( 16, 1, 1, hmdst, 0xb, 0x95ef299f, 0x1065418b );

  TEST_RR_SRC21_BYPASS( 22, 1, 1, hmdst, 0xb, 0x95ef299f, 0x1065418b );

  TEST_RR_ZEROSRC1( 24, hmdst, 0x14, 0x95ef299f );
  TEST_RR_ZEROSRC2( 25, hmdst, 0x14, 0x95ef299f );
  TEST_RR_ZEROSRC12( 26, hmdst, 0x0 );
  TEST_RR_ZERODEST( 27, hmdst, 0x11111111, 0x22222222 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
