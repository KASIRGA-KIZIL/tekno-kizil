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

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
