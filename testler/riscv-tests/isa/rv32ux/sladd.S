# See LICENSE for license details.

#*****************************************************************************
# sladd.S
#-----------------------------------------------------------------------------
#
# Test sladd instruction.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Logical tests
  #-------------------------------------------------------------
  # TEST_RR_OP( testnum, inst, result, val1, val2 )

  TEST_RR_OP( 2, sladd, 0xc3f907d6, 0x848207d6, 0xfdb9c3f9 );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------
  # TEST_RR_SRC1_EQ_DEST( testnum, inst, result, val1, val2 )
  # TEST_RR_SRC2_EQ_DEST( testnum, inst, result, val1, val2 )
  # TEST_RR_SRC12_EQ_DEST( testnum, inst, result, val1 )

  TEST_RR_SRC1_EQ_DEST( 6, sladd, 0xe855b853, 0x6f49396e, 0x09c34577 );
  TEST_RR_SRC2_EQ_DEST( 7, sladd, 0xe855b853, 0x6f49396e, 0x09c34577 );

  ## bunda overflow var, normalde sonuc 0x14ddbac4a
  TEST_RR_SRC12_EQ_DEST( 8, sladd, 0x4ddbac4a, 0x6f49396e );

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

  TEST_RR_DEST_BYPASS( 10, 1, sladd, 0xe855b853, 0x6f49396e, 0x09c34577 );

  TEST_RR_SRC12_BYPASS( 16, 1, 1, sladd, 0xe855b853, 0x6f49396e, 0x09c34577 );

  TEST_RR_SRC21_BYPASS( 22, 1, 1, sladd, 0xe855b853, 0x6f49396e, 0x09c34577 );

  TEST_RR_ZEROSRC1( 24, sladd, 0x6f49396e, 0x6f49396e );
  TEST_RR_ZEROSRC2( 25, sladd, 0xde9272dc, 0x6f49396e );
  TEST_RR_ZEROSRC12( 26, sladd, 0x00000000 );
  TEST_RR_ZERODEST( 27, sladd, 0x11111111, 0x22222222 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
