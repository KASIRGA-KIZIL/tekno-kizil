# See LICENSE for license details.

#*****************************************************************************
# rvrs.S
#-----------------------------------------------------------------------------
#
# Test rvrs instruction.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Logical tests
  #-------------------------------------------------------------
  # TEST_R_OP( testnum, inst, result, val1 )

  TEST_R_OP( 2, rvrs, 0x6ba760d3, 0xd360a76b );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------
  # TEST_R_SRC1_EQ_DEST( testnum, inst, result, val1 )

  TEST_R_SRC1_EQ_DEST( 6, rvrs, 0x6ba760d3, 0xd360a76b );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------
  # TEST_R_DEST_BYPASS( testnum, nop_cycles, inst, result, val1 )

  TEST_R_DEST_BYPASS( 10, 1, rvrs, 0x6ba760d3, 0xd360a76b );

  ## tek regli icin zero makrosu yok biz ekleyebiliriz test_macros.h'a

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
