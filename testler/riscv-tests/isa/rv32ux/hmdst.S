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
  
  TEST_RR_OP( 28, hmdst, 0xe , 0x12345678, 0x87654321);
  TEST_RR_OP( 29, hmdst, 0xb , 0xdeadbeef, 0xabadcafe);
  TEST_RR_OP( 30, hmdst, 0x15, 0xabcdef01, 0x12345678);
  TEST_RR_OP( 31, hmdst, 0x11, 0xdeadbeef, 0x12345678);
  TEST_RR_OP( 32, hmdst, 0x14, 0x98765432, 0xABCDEF01);
  TEST_RR_OP( 33, hmdst, 0xb , 0x1234ABCD, 0x5678CDEF);
  TEST_RR_OP( 34, hmdst, 0xa , 0xCAFEBABE, 0xDEADBEEF);
  TEST_RR_OP( 35, hmdst, 0xb , 0x53e46473, 0x72e02b3f);
  TEST_RR_OP( 36, hmdst, 0xd , 0x2b5b72c9, 0x3aea6638);
  TEST_RR_OP( 37, hmdst, 0xf , 0x7c6f47d1, 0x7845390d);
  TEST_RR_OP( 38, hmdst, 0xc , 0x227d3c45, 0x205204ed);
  TEST_RR_OP( 39, hmdst, 0x11 , 0x76061272, 0x48b83335);
  TEST_RR_OP( 40, hmdst, 0x12 , 0x7c01383e, 0x71562795);
  TEST_RR_OP( 41, hmdst, 0xe , 0x1f766a69, 0x2a7c1d6f);
  TEST_RR_OP( 42, hmdst, 0xc , 0x29481d13, 0x6b5a747f);
  TEST_RR_OP( 43, hmdst, 0x15 , 0x6a534d7f, 0x2cb830c1);
  TEST_RR_OP( 44, hmdst, 0xc , 0x4bb62116, 0x1be8318f);
  TEST_RR_OP( 45, hmdst, 0xb , 0x397275af, 0x79f9640a);
  TEST_RR_OP( 46, hmdst, 0xe , 0x1b35470d, 0x7b2e74bc);
  TEST_RR_OP( 47, hmdst, 0x13 , 0x4f700da9, 0x3aae447c);
  TEST_RR_OP( 48, hmdst, 0xf , 0x5caf7ab2, 0x167d2491);
  TEST_RR_OP( 49, hmdst, 0xc , 0x4d2a3553, 0x07ab1e1a);
  TEST_RR_OP( 50, hmdst, 0xf , 0x68977d34, 0x4acc48ad);
  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
