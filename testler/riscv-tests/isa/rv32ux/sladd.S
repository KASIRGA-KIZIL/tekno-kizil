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

  TEST_RR_OP( 2, sladd, 0x06bdd3a5, 0x848207d6, 0xfdb9c3f9 );

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

  TEST_RR_OP( 35, sladd, 0x16abc36e , 0x66715c0a, 0x49c90b5a);
  TEST_RR_OP( 36, sladd, 0x4e7d96fd , 0x02ea1163, 0x48a97437);
  TEST_RR_OP( 37, sladd, 0xd26df4a7 , 0x511c60b7, 0x30353339);
  TEST_RR_OP( 38, sladd, 0x1da2dc53 , 0x5062563b, 0x7cde2fdd);
  TEST_RR_OP( 39, sladd, 0x4e52d7e8 , 0x73d85bf6, 0x66a21ffc);
  TEST_RR_OP( 40, sladd, 0x91e0a691 , 0x40822f22, 0x10dc484d);
  TEST_RR_OP( 41, sladd, 0xa3f4afd6 , 0x1bca44d5, 0x6c60262c);
  TEST_RR_OP( 42, sladd, 0x3c282a59 , 0x5e3061e0, 0x7fc76699);
  TEST_RR_OP( 43, sladd, 0x6832272 , 0x7e3d69f7, 0x0a084e84);
  TEST_RR_OP( 44, sladd, 0x2b9cc6e , 0x67b82a13, 0x33497848);
  TEST_RR_OP( 45, sladd, 0xe62e4e9f , 0x531d2215, 0x3ff40a75);
  TEST_RR_OP( 46, sladd, 0xdca26f2a , 0x314b11ac, 0x7a0c4bd2);
  TEST_RR_OP( 47, sladd, 0x43bcd192 , 0x7f7d4c78, 0x44c238a2);
  TEST_RR_OP( 48, sladd, 0x3d39b007 , 0x177b1970, 0x0e437d27);
  TEST_RR_OP( 49, sladd, 0xb3f9bc67 , 0x50122181, 0x13d57965);
  TEST_RR_OP( 50, sladd, 0x2fa49516 , 0x01c13177, 0x2c223228);
  TEST_RR_OP( 51, sladd, 0x933df98a , 0x43b55321, 0x0bd35348);
  TEST_RR_OP( 52, sladd, 0x22512a8c , 0x74f801b0, 0x3861272c);
  TEST_RR_OP( 53, sladd, 0xe8f3224f , 0x65e57d61, 0x1d28278d);
  TEST_RR_OP( 54, sladd, 0xe27c1034 , 0x35df025c, 0x76be0b7c);
  TEST_RR_OP( 55, sladd, 0x7b07445d , 0x394266db, 0x088276a7);
  TEST_RR_OP( 56, sladd, 0x47acf6f4 , 0x7b9a648e, 0x50782dd8);
  TEST_RR_OP( 57, sladd, 0x917a973c , 0x3213113f, 0x2d5474be);
  TEST_RR_OP( 58, sladd, 0x8f370e54 , 0x32314ab2, 0x2ad478f0);
  TEST_RR_OP( 59, sladd, 0xe9d5a1cd , 0x40c119cf, 0x68536e2f);
  TEST_RR_OP( 60, sladd, 0xe7bce1ef , 0x4d105102, 0x4d9c3feb);
  TEST_RR_OP( 61, sladd, 0xdab14fcf , 0x6c5a69e3, 0x01fc7c09);
  TEST_RR_OP( 62, sladd, 0xaca62708 , 0x29856612, 0x599b5ae4);
  TEST_RR_OP( 63, sladd, 0x2729775c , 0x7d0f3765, 0x2d0b0892);
  TEST_RR_OP( 64, sladd, 0x51aef9f4 , 0x01467346, 0x4f221368);
  TEST_RR_OP( 65, sladd, 0x8273ce6c , 0x36b75556, 0x150523c0);
  TEST_RR_OP( 66, sladd, 0xfe570ba7 , 0x6ce85557, 0x248660f9);
  TEST_RR_OP( 67, sladd, 0xc344d050 , 0x234a5448, 0x7cb027c0);
  TEST_RR_OP( 68, sladd, 0x5971bf30 , 0x766924d1, 0x6c9f758e);
  TEST_RR_OP( 69, sladd, 0x47631336 , 0x6d6672e2, 0x6c962d72);
  TEST_RR_OP( 70, sladd, 0x8499b741 , 0x3ba74e98, 0x0d4b1a11);
  TEST_RR_OP( 71, sladd, 0x7200dab , 0x4acd5e60, 0x718550eb);
  TEST_RR_OP( 72, sladd, 0x47b6539c , 0x20e67c5e, 0x05e95ae0);
  TEST_RR_OP( 73, sladd, 0x58d9cc12 , 0x76e44310, 0x6b1145f2);
  TEST_RR_OP( 74, sladd, 0x6c7d9ea8 , 0x134f4d2e, 0x45df044c);
  TEST_RR_OP( 75, sladd, 0xe47d962e , 0x3d362cd5, 0x6a113c84);
  TEST_RR_OP( 76, sladd, 0xc9ec2ae7 , 0x5b6b5de5, 0x13156f1d);
  TEST_RR_OP( 77, sladd, 0x46fe84a0 , 0x13f037a8, 0x1f1e1550);

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
