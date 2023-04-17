# See LICENSE for license details.

#*****************************************************************************
# pkg.S
#-----------------------------------------------------------------------------
#
# Test pkg instruction.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Logical tests
  #-------------------------------------------------------------
  # TEST_RR_OP( testnum, inst, result, val1, val2 )

  TEST_RR_OP( 2, pkg, 0xc3f907d6, 0x848207d6, 0xfdb9c3f9 );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------
  # TEST_RR_SRC1_EQ_DEST( testnum, inst, result, val1, val2 )
  # TEST_RR_SRC2_EQ_DEST( testnum, inst, result, val1, val2 )
  # TEST_RR_SRC12_EQ_DEST( testnum, inst, result, val1 )

  TEST_RR_SRC1_EQ_DEST( 6, pkg, 0xc3f907d6, 0x848207d6, 0xfdb9c3f9 );
  TEST_RR_SRC2_EQ_DEST( 7, pkg, 0xc3f907d6, 0x848207d6, 0xfdb9c3f9 );
  TEST_RR_SRC12_EQ_DEST( 8, pkg, 0x07d607d6, 0x848207d6 );

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

  TEST_RR_DEST_BYPASS( 10, 1, pkg, 0xc3f907d6, 0x848207d6, 0xfdb9c3f9 );

  TEST_RR_SRC12_BYPASS( 16, 1, 1, pkg, 0xc3f907d6, 0x848207d6, 0xfdb9c3f9 );

  TEST_RR_SRC21_BYPASS( 22, 1, 1, pkg, 0xc3f907d6, 0x848207d6, 0xfdb9c3f9 );

  TEST_RR_ZEROSRC1( 24, pkg, 0x07d60000, 0x848207d6 );
  TEST_RR_ZEROSRC2( 25, pkg, 0x000007d6, 0x848207d6 );
  TEST_RR_ZEROSRC12( 26, pkg, 0x00000000 );
  TEST_RR_ZERODEST( 27, pkg, 0x11111111, 0x22222222 );
  
  TEST_RR_OP( 35, pkg, 0x4201c91 , 0x593d1c91, 0x29800420);
  TEST_RR_OP( 36, pkg, 0x2f180dbd , 0x1d6a0dbd, 0x211f2f18);
  TEST_RR_OP( 37, pkg, 0x1247929 , 0x0d447929, 0x06300124);
  TEST_RR_OP( 38, pkg, 0x5e8105f4 , 0x2d9a05f4, 0x02a65e81);
  TEST_RR_OP( 39, pkg, 0x1a7a5f5b , 0x6b895f5b, 0x7d171a7a);
  TEST_RR_OP( 40, pkg, 0x81322f , 0x77fa322f, 0x70620081);
  TEST_RR_OP( 41, pkg, 0x737e1e86 , 0x7c6c1e86, 0x6695737e);
  TEST_RR_OP( 42, pkg, 0x176771b2 , 0x0cf471b2, 0x1b0e1767);
  TEST_RR_OP( 43, pkg, 0x39113c6f , 0x7b813c6f, 0x07e03911);
  TEST_RR_OP( 44, pkg, 0x68461960 , 0x70651960, 0x62786846);
  TEST_RR_OP( 45, pkg, 0x781737bd , 0x6c1137bd, 0x4b807817);
  TEST_RR_OP( 46, pkg, 0x59737e46 , 0x16207e46, 0x36035973);
  TEST_RR_OP( 47, pkg, 0x3f95a7b , 0x7d985a7b, 0x49d203f9);
  TEST_RR_OP( 48, pkg, 0x610b100e , 0x2e6c100e, 0x4527610b);
  TEST_RR_OP( 49, pkg, 0x6d241c99 , 0x40451c99, 0x21896d24);
  TEST_RR_OP( 50, pkg, 0x36b038d , 0x4281038d, 0x7fef036b);
  TEST_RR_OP( 51, pkg, 0x788166a , 0x297c166a, 0x20280788);
  TEST_RR_OP( 52, pkg, 0x61b60d36 , 0x210f0d36, 0x677a61b6);
  TEST_RR_OP( 53, pkg, 0x1190328 , 0x68570328, 0x3a8a0119);
  TEST_RR_OP( 54, pkg, 0x58532ba4 , 0x1ab82ba4, 0x2e7b5853);
  TEST_RR_OP( 55, pkg, 0x852536c , 0x0a21536c, 0x555a0852);
  TEST_RR_OP( 56, pkg, 0x2d6b0214 , 0x0e910214, 0x29ba2d6b);
  TEST_RR_OP( 57, pkg, 0x2ad4fb6 , 0x6eda4fb6, 0x5d9b02ad);
  TEST_RR_OP( 58, pkg, 0x4f6f42e8 , 0x46a542e8, 0x10914f6f);
  TEST_RR_OP( 59, pkg, 0x532c4aeb , 0x0db64aeb, 0x3122532c);
  TEST_RR_OP( 60, pkg, 0x23912a25 , 0x24712a25, 0x0d6f2391);
  TEST_RR_OP( 61, pkg, 0x30d364d1 , 0x099d64d1, 0x571730d3);
  TEST_RR_OP( 62, pkg, 0x644607f6 , 0x1d6907f6, 0x1e586446);
  TEST_RR_OP( 63, pkg, 0xd2c5c95 , 0x15ac5c95, 0x08770d2c);
  TEST_RR_OP( 64, pkg, 0xfca5b27 , 0x07715b27, 0x45620fca);
  TEST_RR_OP( 65, pkg, 0xac27347 , 0x29b37347, 0x08950ac2);
  TEST_RR_OP( 66, pkg, 0x669c7bab , 0x35657bab, 0x093a669c);

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
