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
  
  TEST_R_OP( 35, rvrs, 0xa0155d61 , 0x615d15a0);
  TEST_R_OP( 36, rvrs, 0x8c38fa5e , 0x5efa388c);
  TEST_R_OP( 37, rvrs, 0xa37bf0a , 0x0abf370a);
  TEST_R_OP( 38, rvrs, 0xdd595a5d , 0x5d5a59dd);
  TEST_R_OP( 39, rvrs, 0x7e763e16 , 0x163e767e);
  TEST_R_OP( 40, rvrs, 0x1d2bf76c , 0x6cf72b1d);
  TEST_R_OP( 41, rvrs, 0xe21bba6c , 0x6cba1be2);
  TEST_R_OP( 42, rvrs, 0x7815412e , 0x2e411578);
  TEST_R_OP( 43, rvrs, 0xcc38d663 , 0x63d638cc);
  TEST_R_OP( 44, rvrs, 0x1214ad6b , 0x6bad1412);
  TEST_R_OP( 45, rvrs, 0xa4d765c , 0x5c764d0a);
  TEST_R_OP( 46, rvrs, 0x81403340 , 0x40334081);
  TEST_R_OP( 47, rvrs, 0x1a3b4771 , 0x71473b1a);
  TEST_R_OP( 48, rvrs, 0x4e2fd04d , 0x4dd02f4e);
  TEST_R_OP( 49, rvrs, 0xb20c3735 , 0x35370cb2);
  TEST_R_OP( 50, rvrs, 0x781c0604 , 0x04061c78);
  TEST_R_OP( 51, rvrs, 0x3907f901 , 0x01f90739);
  TEST_R_OP( 52, rvrs, 0xf2675776 , 0x765767f2);
  TEST_R_OP( 53, rvrs, 0x4c108256 , 0x5682104c);
  TEST_R_OP( 54, rvrs, 0x2062cd42 , 0x42cd6220);
  TEST_R_OP( 55, rvrs, 0x3a628f45 , 0x458f623a);
  TEST_R_OP( 56, rvrs, 0x5d687608 , 0x0876685d);
  TEST_R_OP( 57, rvrs, 0x88101d74 , 0x741d1088);
  TEST_R_OP( 58, rvrs, 0x7851e06d , 0x6de05178);
  TEST_R_OP( 59, rvrs, 0x6e5cef27 , 0x27ef5c6e);
  TEST_R_OP( 60, rvrs, 0x322aa137 , 0x37a12a32);
  TEST_R_OP( 61, rvrs, 0x58590b66 , 0x660b5958);
  TEST_R_OP( 62, rvrs, 0xc241d26e , 0x6ed241c2);
  TEST_R_OP( 63, rvrs, 0x66613d21 , 0x213d6166);
  TEST_R_OP( 64, rvrs, 0x51068e17 , 0x178e0651);
  TEST_R_OP( 65, rvrs, 0xec599378 , 0x789359ec);
  TEST_R_OP( 66, rvrs, 0x7f317877 , 0x7778317f);
  TEST_R_OP( 67, rvrs, 0xf347df05 , 0x05df47f3);
  TEST_R_OP( 68, rvrs, 0xdc44326c , 0x6c3244dc);
  TEST_R_OP( 69, rvrs, 0xb734383c , 0x3c3834b7);

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
