// RV32IMCX Buyruklari
`define ADD        32'b0000000??????????000?????0110011
`define ADDI       32'b?????????????????000?????0010011
`define AND        32'b0000000??????????111?????0110011
`define ANDI       32'b?????????????????111?????0010011
`define AUIPC      32'b?????????????????????????0010111
`define BEQ        32'b?????????????????000?????1100011
`define BGE        32'b?????????????????101?????1100011
`define BGEU       32'b?????????????????111?????1100011
`define BLT        32'b?????????????????100?????1100011
`define BLTU       32'b?????????????????110?????1100011
`define BNE        32'b?????????????????001?????1100011

`define C_ADD      32'b0000000000000000_1001??????????10
`define C_ADDI     32'b0000000000000000_000???????????01
`define C_ADDI16SP 32'b0000000000000000_011?00010?????01
`define C_ADDI4SPN 32'b0000000000000000_000???????????00
`define C_AND      32'b0000000000000000_100011???11???01
`define C_ANDI     32'b0000000000000000_100?10????????01
`define C_BEQZ     32'b0000000000000000_110???????????01
`define C_BNEZ     32'b0000000000000000_111???????????01
`define C_EBREAK   32'b0000000000000000_1001000000000010
`define C_J        32'b0000000000000000_101???????????01
`define C_JAL      32'b0000000000000000_001???????????01
`define C_JALR     32'b0000000000000000_1001?????0000010
`define C_JR       32'b0000000000000000_1000?????0000010
`define C_LI       32'b0000000000000000_010???????????01
`define C_LUI      32'b0000000000000000_011???????????01
`define C_LW       32'b0000000000000000_010???????????00
`define C_LWSP     32'b0000000000000000_010???????????10
`define C_MV       32'b0000000000000000_1000??????????10
`define C_NOP      32'b0000000000000000_000?00000?????01
`define C_OR       32'b0000000000000000_100011???10???01
`define C_SLLI     32'b0000000000000000_0000??????????10
`define C_SRAI     32'b0000000000000000_100001????????01
`define C_SRLI     32'b0000000000000000_100000????????01
`define C_SUB      32'b0000000000000000_100011???00???01
`define C_SW       32'b0000000000000000_110???????????00
`define C_SWSP     32'b0000000000000000_110???????????10
`define C_XOR      32'b0000000000000000_100011???01???01

`define DIV        32'b0000001??????????100?????0110011
`define DIVU       32'b0000001??????????101?????0110011
`define EBREAK     32'b00000000000100000000000001110011
`define ECALL      32'b00000000000000000000000001110011
`define FENCE      32'b?????????????????000?????0001111
`define FENCE_I    32'b?????????????????001?????0001111
`define JAL        32'b?????????????????????????1101111
`define JALR       32'b?????????????????000?????1100111
`define LB         32'b?????????????????000?????0000011
`define LBU        32'b?????????????????100?????0000011
`define LH         32'b?????????????????001?????0000011
`define LHU        32'b?????????????????101?????0000011
`define LUI        32'b?????????????????????????0110111
`define LW         32'b?????????????????010?????0000011
`define MUL        32'b0000001??????????000?????0110011
`define MULH       32'b0000001??????????001?????0110011
`define MULHSU     32'b0000001??????????010?????0110011
`define MULHU      32'b0000001??????????011?????0110011
`define OR         32'b0000000??????????110?????0110011
`define ORI        32'b?????????????????110?????0010011
`define REM        32'b0000001??????????110?????0110011
`define REMU       32'b0000001??????????111?????0110011
`define SB         32'b?????????????????000?????0100011
`define SH         32'b?????????????????001?????0100011
`define SLL        32'b0000000??????????001?????0110011
`define SLLI       32'b0000000??????????001?????0010011
`define SLT        32'b0000000??????????010?????0110011
`define SLTI       32'b?????????????????010?????0010011
`define SLTIU      32'b?????????????????011?????0010011
`define SLTU       32'b0000000??????????011?????0110011
`define SRA        32'b0100000??????????101?????0110011
`define SRAI       32'b0100000??????????101?????0010011
`define SRL        32'b0000000??????????101?????0110011
`define SRLI       32'b0000000??????????101?????0010011
`define SUB        32'b0100000??????????000?????0110011
`define SW         32'b?????????????????010?????0100011
`define XOR        32'b0000000??????????100?????0110011
`define XORI       32'b?????????????????100?????0010011

`define HMDST      32'b0000101_?????_?????_001_?????_0110011
`define PKG        32'b0000100_?????_?????_100_?????_0110011
`define RVRS       32'b011010111000_?????_101_?????_0010011
`define SLADD      32'b0010000_?????_?????_010_?????_0110011
`define CNTZ       32'b0110000_00001_?????_001_?????_0010011
`define CNTP       32'b0110000_00010_?????_001_?????_0010011

`define CONV_LD_W  32'b?_000000_?????_?????_010_00000_0001011
`define CONV_CLR_W 32'b0000000_00000_00000_011_00000_0001011
`define CONV_LD_X  32'b?_000000_?????_?????_000_00000_0001011
`define CONV_CLR_X 32'b0000000_00000_00000_001_00000_0001011
`define CONV_RUN   32'b0000000_00000_00000_100_?????_0001011

// Cozulmesi gereken bitler 14 bit 30:29, 27, 25, 21:20, 14:12, 6:2
`define BUYRUK_COZ_BIT

`define EBREAK_COZ 	   {`EBREAK[30:29], `EBREAK[27], `EBREAK[25], `EBREAK[21:20], `EBREAK[14:12], `EBREAK[6:2]}
`define ECALL_COZ 	   {`ECALL[30:29], `ECALL[27], `ECALL[25], `ECALL[21:20], `ECALL[14:12], `ECALL[6:2]}
`define CONV_CLR_W_COZ {`CONV_CLR_W[30:29], `CONV_CLR_W[27], `CONV_CLR_W[25], `CONV_CLR_W[21:20], `CONV_CLR_W[14:12], `CONV_CLR_W[6:2]}
`define CONV_CLR_X_COZ {`CONV_CLR_X[30:29], `CONV_CLR_X[27], `CONV_CLR_X[25], `CONV_CLR_X[21:20], `CONV_CLR_X[14:12], `CONV_CLR_X[6:2]}
`define CONV_RUN_COZ   {`CONV_RUN[30:29], `CONV_RUN[27], `CONV_RUN[25], `CONV_RUN[21:20], `CONV_RUN[14:12], `CONV_RUN[6:2]}
`define RVRS_COZ 	   {`RVRS[30:29], `RVRS[27], `RVRS[25], `RVRS[21:20], `RVRS[14:12], `RVRS[6:2]}
`define CNTZ_COZ 	   {`CNTZ[30:29], `CNTZ[27], `CNTZ[25], `CNTZ[21:20], `CNTZ[14:12], `CNTZ[6:2]}
`define CNTP_COZ 	   {`CNTP[30:29], `CNTP[27], `CNTP[25], `CNTP[21:20], `CNTP[14:12], `CNTP[6:2]}
`define CONV_LD_W_COZ  {`CONV_LD_W[30:29], `CONV_LD_W[27], `CONV_LD_W[25], `CONV_LD_W[21:20], `CONV_LD_W[14:12], `CONV_LD_W[6:2]}
`define CONV_LD_X_COZ  {`CONV_LD_X[30:29], `CONV_LD_X[27], `CONV_LD_X[25], `CONV_LD_X[21:20], `CONV_LD_X[14:12], `CONV_LD_X[6:2]}
`define ADD_COZ 	   {`ADD[30:29], `ADD[27], `ADD[25], `ADD[21:20], `ADD[14:12], `ADD[6:2]}
`define AND_COZ 	   {`AND[30:29], `AND[27], `AND[25], `AND[21:20], `AND[14:12], `AND[6:2]}
`define DIV_COZ 	   {`DIV[30:29], `DIV[27], `DIV[25], `DIV[21:20], `DIV[14:12], `DIV[6:2]}
`define DIVU_COZ 	   {`DIVU[30:29], `DIVU[27], `DIVU[25], `DIVU[21:20], `DIVU[14:12], `DIVU[6:2]}
`define MUL_COZ 	   {`MUL[30:29], `MUL[27], `MUL[25], `MUL[21:20], `MUL[14:12], `MUL[6:2]}
`define MULH_COZ 	   {`MULH[30:29], `MULH[27], `MULH[25], `MULH[21:20], `MULH[14:12], `MULH[6:2]}
`define MULHSU_COZ 	   {`MULHSU[30:29], `MULHSU[27], `MULHSU[25], `MULHSU[21:20], `MULHSU[14:12], `MULHSU[6:2]}
`define MULHU_COZ 	   {`MULHU[30:29], `MULHU[27], `MULHU[25], `MULHU[21:20], `MULHU[14:12], `MULHU[6:2]}
`define OR_COZ 	       {`OR[30:29], `OR[27], `OR[25], `OR[21:20], `OR[14:12], `OR[6:2]}
`define REM_COZ 	   {`REM[30:29], `REM[27], `REM[25], `REM[21:20], `REM[14:12], `REM[6:2]}
`define REMU_COZ 	   {`REMU[30:29], `REMU[27], `REMU[25], `REMU[21:20], `REMU[14:12], `REMU[6:2]}
`define SLL_COZ 	   {`SLL[30:29], `SLL[27], `SLL[25], `SLL[21:20], `SLL[14:12], `SLL[6:2]}
`define SLT_COZ 	   {`SLT[30:29], `SLT[27], `SLT[25], `SLT[21:20], `SLT[14:12], `SLT[6:2]}
`define SLTU_COZ 	   {`SLTU[30:29], `SLTU[27], `SLTU[25], `SLTU[21:20], `SLTU[14:12], `SLTU[6:2]}
`define SRA_COZ 	   {`SRA[30:29], `SRA[27], `SRA[25], `SRA[21:20], `SRA[14:12], `SRA[6:2]}
`define SRL_COZ 	   {`SRL[30:29], `SRL[27], `SRL[25], `SRL[21:20], `SRL[14:12], `SRL[6:2]}
`define SUB_COZ 	   {`SUB[30:29], `SUB[27], `SUB[25], `SUB[21:20], `SUB[14:12], `SUB[6:2]}
`define XOR_COZ 	   {`XOR[30:29], `XOR[27], `XOR[25], `XOR[21:20], `XOR[14:12], `XOR[6:2]}
`define HMDST_COZ 	   {`HMDST[30:29], `HMDST[27], `HMDST[25], `HMDST[21:20], `HMDST[14:12], `HMDST[6:2]}
`define PKG_COZ 	   {`PKG[30:29], `PKG[27], `PKG[25], `PKG[21:20], `PKG[14:12], `PKG[6:2]}
`define SLADD_COZ 	   {`SLADD[30:29], `SLADD[27], `SLADD[25], `SLADD[21:20], `SLADD[14:12], `SLADD[6:2]}
`define SLLI_COZ 	   {`SLLI[30:29], `SLLI[27], `SLLI[25], `SLLI[21:20], `SLLI[14:12], `SLLI[6:2]}
`define SRAI_COZ 	   {`SRAI[30:29], `SRAI[27], `SRAI[25], `SRAI[21:20], `SRAI[14:12], `SRAI[6:2]}
`define SRLI_COZ 	   {`SRLI[30:29], `SRLI[27], `SRLI[25], `SRLI[21:20], `SRLI[14:12], `SRLI[6:2]}
`define ADDI_COZ 	   {`ADDI[30:29], `ADDI[27], `ADDI[25], `ADDI[21:20], `ADDI[14:12], `ADDI[6:2]}
`define ANDI_COZ 	   {`ANDI[30:29], `ANDI[27], `ANDI[25], `ANDI[21:20], `ANDI[14:12], `ANDI[6:2]}
`define BEQ_COZ 	   {`BEQ[30:29], `BEQ[27], `BEQ[25], `BEQ[21:20], `BEQ[14:12], `BEQ[6:2]}
`define BGE_COZ 	   {`BGE[30:29], `BGE[27], `BGE[25], `BGE[21:20], `BGE[14:12], `BGE[6:2]}
`define BGEU_COZ 	   {`BGEU[30:29], `BGEU[27], `BGEU[25], `BGEU[21:20], `BGEU[14:12], `BGEU[6:2]}
`define BLT_COZ 	   {`BLT[30:29], `BLT[27], `BLT[25], `BLT[21:20], `BLT[14:12], `BLT[6:2]}
`define BLTU_COZ 	   {`BLTU[30:29], `BLTU[27], `BLTU[25], `BLTU[21:20], `BLTU[14:12], `BLTU[6:2]}
`define BNE_COZ 	   {`BNE[30:29], `BNE[27], `BNE[25], `BNE[21:20], `BNE[14:12], `BNE[6:2]}
`define FENCE_COZ 	   {`FENCE[30:29], `FENCE[27], `FENCE[25], `FENCE[21:20], `FENCE[14:12], `FENCE[6:2]}
`define FENCE_I_COZ    {`FENCE_I[30:29], `FENCE_I[27], `FENCE_I[25], `FENCE_I[21:20], `FENCE_I[14:12], `FENCE_I[6:2]}
`define JALR_COZ 	   {`JALR[30:29], `JALR[27], `JALR[25], `JALR[21:20], `JALR[14:12], `JALR[6:2]}
`define LB_COZ 	       {`LB[30:29], `LB[27], `LB[25], `LB[21:20], `LB[14:12], `LB[6:2]}
`define LBU_COZ 	   {`LBU[30:29], `LBU[27], `LBU[25], `LBU[21:20], `LBU[14:12], `LBU[6:2]}
`define LH_COZ 	       {`LH[30:29], `LH[27], `LH[25], `LH[21:20], `LH[14:12], `LH[6:2]}
`define LHU_COZ 	   {`LHU[30:29], `LHU[27], `LHU[25], `LHU[21:20], `LHU[14:12], `LHU[6:2]}
`define LW_COZ 	       {`LW[30:29], `LW[27], `LW[25], `LW[21:20], `LW[14:12], `LW[6:2]}
`define ORI_COZ 	   {`ORI[30:29], `ORI[27], `ORI[25], `ORI[21:20], `ORI[14:12], `ORI[6:2]}
`define SB_COZ 	       {`SB[30:29], `SB[27], `SB[25], `SB[21:20], `SB[14:12], `SB[6:2]}
`define SH_COZ 	       {`SH[30:29], `SH[27], `SH[25], `SH[21:20], `SH[14:12], `SH[6:2]}
`define SLTI_COZ 	   {`SLTI[30:29], `SLTI[27], `SLTI[25], `SLTI[21:20], `SLTI[14:12], `SLTI[6:2]}
`define SLTIU_COZ 	   {`SLTIU[30:29], `SLTIU[27], `SLTIU[25], `SLTIU[21:20], `SLTIU[14:12], `SLTIU[6:2]}
`define SW_COZ 	       {`SW[30:29], `SW[27], `SW[25], `SW[21:20], `SW[14:12], `SW[6:2]}
`define XORI_COZ 	   {`XORI[30:29], `XORI[27], `XORI[25], `XORI[21:20], `XORI[14:12], `XORI[6:2]}
`define AUIPC_COZ 	   {`AUIPC[30:29], `AUIPC[27], `AUIPC[25], `AUIPC[21:20], `AUIPC[14:12], `AUIPC[6:2]}
`define JAL_COZ 	   {`JAL[30:29], `JAL[27], `JAL[25], `JAL[21:20], `JAL[14:12], `JAL[6:2]}
`define LUI_COZ 	   {`LUI[30:29], `LUI[27], `LUI[25], `LUI[21:20], `LUI[14:12], `LUI[6:2]}

// MIKROISLEM KODLARININ PARCALARI
// MI[7]...MI[0] Ilgili birime girecek mi girmeyecek mi onu gosteriyor
// Onundeki 5 bit ise o birime giren hangi buyruk oldugunu belirtiyor
// Simdilik toplam 15 bit

// MI[0]
`define AMBVAR 1'b1
`define AMBYOK 1'b0

// MI[1]
`define CLAVAR 1'b1
`define CLAYOK 1'b0

// MI[2]
`define BDCVAR 1'b1
`define BDCYOK 1'b0

// MI[3]
`define BIBVAR 1'b1
`define BIBYOK 1'b0

// MI[4]
`define DALVAR 1'b1
`define DALYOK 1'b0

// MI[5]
`define SIFVAR 1'b1
`define SIFYOK 1'b0

// MI[6]
`define YAPVAR 1'b1
`define YAPYOK 1'b0

// MI[7]
`define SISVAR 1'b1
`define SISYOK 1'b0

// IMM ve CMP ilk 5 bitin icine yedirilebilir, bit sayisi azalir
// Cozden sonraki asamalarda compressed olmasinin onemi kalmayacaksa burada tamamen kaldirabiliriz, bu nasil cozdugumuze bagli

// MI[8]
`define IMMVAR 1'b1
`define IMMYOK 1'b0

// MI[9]
`define CMPVAR 1'b1
`define CMPYOK 1'b0
// CMPyi kaldirabilirim, dallanma, atlama, bellekyaz ve yazmacyaz, buyruktipi getirebilirim
// ama gereksiz olanlari bosuna koymayalim

// MIKROISLEM KODLARI
// Toplam 87 buyruk

`define MI_BIT 15

`define GECERSIZ 15'b00000_00_00000000

// Ondeki bitler girdigi birimde kontrol edilecek bitler yani amb buyrugu ise ambnin kontrol sinyalleri

// AMB buyruklari
`define AND_MI   {5'b0_0_0_0_0, `CMPYOK, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBYOK, `BDCYOK, `CLAYOK, `AMBVAR}
`define AUIPC_MI {5'b0_0_0_0_1, `CMPYOK, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBYOK, `BDCYOK, `CLAYOK, `AMBVAR} 
`define LUI_MI   {5'b0_0_0_1_0, `CMPYOK, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBYOK, `BDCYOK, `CLAYOK, `AMBVAR}  
`define OR_MI    {5'b0_0_0_1_1, `CMPYOK, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBYOK, `BDCYOK, `CLAYOK, `AMBVAR} 
`define SLL_MI   {5'b0_0_1_0_0, `CMPYOK, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBYOK, `BDCYOK, `CLAYOK, `AMBVAR}  
`define SLT_MI   {5'b0_0_1_0_1, `CMPYOK, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBYOK, `BDCYOK, `CLAYOK, `AMBVAR}  
`define SLTU_MI  {5'b0_0_1_1_0, `CMPYOK, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBYOK, `BDCYOK, `CLAYOK, `AMBVAR}   
`define SRA_MI   {5'b0_0_1_1_1, `CMPYOK, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBYOK, `BDCYOK, `CLAYOK, `AMBVAR}  
`define SRL_MI   {5'b0_1_0_0_0, `CMPYOK, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBYOK, `BDCYOK, `CLAYOK, `AMBVAR}  
`define XOR_MI   {5'b0_1_0_0_1, `CMPYOK, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBYOK, `BDCYOK, `CLAYOK, `AMBVAR}  

// IMMLI AMB buyruklari
`define ANDI_MI  {5'b0_1_0_1_0, `CMPYOK, `IMMVAR, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBYOK, `BDCYOK, `CLAYOK, `AMBVAR}
`define ORI_MI   {5'b0_1_0_1_1, `CMPYOK, `IMMVAR, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBYOK, `BDCYOK, `CLAYOK, `AMBVAR}
`define SLLI_MI  {5'b0_1_1_0_0, `CMPYOK, `IMMVAR, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBYOK, `BDCYOK, `CLAYOK, `AMBVAR}
`define SLTI_MI  {5'b0_1_1_0_1, `CMPYOK, `IMMVAR, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBYOK, `BDCYOK, `CLAYOK, `AMBVAR}
`define SLTIU_MI {5'b0_1_1_1_0, `CMPYOK, `IMMVAR, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBYOK, `BDCYOK, `CLAYOK, `AMBVAR}
`define SRAI_MI  {5'b0_1_1_1_1, `CMPYOK, `IMMVAR, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBYOK, `BDCYOK, `CLAYOK, `AMBVAR}
`define SRLI_MI  {5'b1_0_0_0_0, `CMPYOK, `IMMVAR, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBYOK, `BDCYOK, `CLAYOK, `AMBVAR}
`define XORI_MI  {5'b1_0_0_0_1, `CMPYOK, `IMMVAR, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBYOK, `BDCYOK, `CLAYOK, `AMBVAR}

// Compressed AMB buyruklari
`define C_AND_MI {5'b1_0_0_1_0, `CMPVAR, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBYOK, `BDCYOK, `CLAYOK, `AMBVAR}
`define C_OR_MI  {5'b1_0_0_1_1, `CMPVAR, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBYOK, `BDCYOK, `CLAYOK, `AMBVAR}
`define C_XOR_MI {5'b1_0_1_0_0, `CMPVAR, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBYOK, `BDCYOK, `CLAYOK, `AMBVAR}

// Compressed IMMLI AMB buyruklari
`define C_ANDI_MI {5'b1_0_1_0_0, `CMPVAR, `IMMVAR, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBYOK, `BDCYOK, `CLAYOK, `AMBVAR}
`define C_SLLI_MI {5'b1_0_1_0_1, `CMPVAR, `IMMVAR, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBYOK, `BDCYOK, `CLAYOK, `AMBVAR}
`define C_SRAI_MI {5'b1_0_1_1_0, `CMPVAR, `IMMVAR, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBYOK, `BDCYOK, `CLAYOK, `AMBVAR}
`define C_SRLI_MI {5'b1_0_1_1_1, `CMPVAR, `IMMVAR, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBYOK, `BDCYOK, `CLAYOK, `AMBVAR}

// Bolme buyruklari, simdilik amb'de olsun?
`define DIV_MI  {5'b1_1_0_0_0, `CMPYOK, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBYOK, `BDCYOK, `CLAYOK, `AMBVAR}
`define DIVU_MI {5'b1_1_0_0_1, `CMPYOK, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBYOK, `BDCYOK, `CLAYOK, `AMBVAR}
`define REM_MI  {5'b1_1_0_1_0, `CMPYOK, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBYOK, `BDCYOK, `CLAYOK, `AMBVAR}
`define REMU_MI {5'b1_1_0_1_1, `CMPYOK, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBYOK, `BDCYOK, `CLAYOK, `AMBVAR}

// Carry Lookahead Toplayici buyruklari
`define ADD_MI {5'b0_0_0_0_0, `CMPYOK, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBYOK, `BDCYOK, `CLAVAR, `AMBYOK}
`define SUB_MI {5'b0_0_0_0_1, `CMPYOK, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBYOK, `BDCYOK, `CLAVAR, `AMBYOK}
// cikarmayi amb'ye mi almaliyiz?

// Carry Lookahead IMMLI Toplayici buyruklari
`define ADDI_MI {5'b0_0_0_1_0, `CMPYOK, `IMMVAR, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBYOK, `BDCYOK, `CLAVAR, `AMBYOK}

// Compressed Carry Lookahead Toplayici buyruklari
`define C_ADD_MI {5'b0_0_0_1_1, `CMPVAR, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBYOK, `BDCYOK, `CLAVAR, `AMBYOK}
`define C_MV_MI  {5'b0_0_1_0_0, `CMPVAR, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBYOK, `BDCYOK, `CLAVAR, `AMBYOK}
`define C_SUB_MI {5'b0_0_1_0_1, `CMPVAR, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBYOK, `BDCYOK, `CLAVAR, `AMBYOK}

// Compressed IMMLI Carry Lookahead Toplayici buyruklari
`define C_ADDI_MI     {5'b0_0_1_1_0, `CMPVAR, `IMMVAR, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBYOK, `BDCYOK, `CLAVAR, `AMBYOK}
`define C_ADDI16SP_MI {5'b0_0_1_1_1, `CMPVAR, `IMMVAR, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBYOK, `BDCYOK, `CLAVAR, `AMBYOK}
`define C_ADDI4SPN_MI {5'b0_1_0_0_0, `CMPVAR, `IMMVAR, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBYOK, `BDCYOK, `CLAVAR, `AMBYOK}
`define C_LI_MI       {5'b0_1_0_0_1, `CMPVAR, `IMMVAR, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBYOK, `BDCYOK, `CLAVAR, `AMBYOK}
`define C_NOP_MI      {5'b0_1_0_1_0, `CMPVAR, `IMMVAR, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBYOK, `BDCYOK, `CLAVAR, `AMBYOK}

// Modified Booth Dadda Carpici buyruklari
`define MUL_MI    {5'b0_0_0_0_0, `CMPYOK, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBYOK, `BDCVAR, `CLAYOK, `AMBYOK}
`define MULH_MI   {5'b0_0_0_0_1, `CMPYOK, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBYOK, `BDCVAR, `CLAYOK, `AMBYOK}
`define MULHSU_MI {5'b0_0_0_1_0, `CMPYOK, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBYOK, `BDCVAR, `CLAYOK, `AMBYOK}
`define MULHU_MI  {5'b0_0_0_1_1, `CMPYOK, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBYOK, `BDCVAR, `CLAYOK, `AMBYOK}

// BIB buyruklari
`define LB_MI  {5'b0_0_0_0_0, `CMPYOK, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBVAR, `BDCYOK, `CLAYOK, `AMBYOK}
`define LBU_MI {5'b0_0_0_0_1, `CMPYOK, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBVAR, `BDCYOK, `CLAYOK, `AMBYOK}
`define LH_MI  {5'b0_0_0_1_0, `CMPYOK, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBVAR, `BDCYOK, `CLAYOK, `AMBYOK}
`define LHU_MI {5'b0_0_0_1_1, `CMPYOK, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBVAR, `BDCYOK, `CLAYOK, `AMBYOK}
`define LW_MI  {5'b0_0_1_0_0, `CMPYOK, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBVAR, `BDCYOK, `CLAYOK, `AMBYOK}

`define SB_MI  {5'b0_0_1_0_1, `CMPYOK, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBVAR, `BDCYOK, `CLAYOK, `AMBYOK}
`define SH_MI  {5'b0_0_1_1_0, `CMPYOK, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBVAR, `BDCYOK, `CLAYOK, `AMBYOK}
`define SW_MI  {5'b0_0_1_1_1, `CMPYOK, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBVAR, `BDCYOK, `CLAYOK, `AMBYOK}

// Compressed BIB buyruklari
`define C_LUI_MI  {5'b0_1_0_0_0, `CMPYOK, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBVAR, `BDCYOK, `CLAYOK, `AMBYOK}
`define C_LW_MI   {5'b0_1_0_0_1, `CMPYOK, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBVAR, `BDCYOK, `CLAYOK, `AMBYOK}
`define C_LWSP_MI {5'b0_1_0_1_0, `CMPYOK, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBVAR, `BDCYOK, `CLAYOK, `AMBYOK}
`define C_SW_MI   {5'b0_1_0_1_1, `CMPYOK, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBVAR, `BDCYOK, `CLAYOK, `AMBYOK}
`define C_SWSP_MI {5'b0_1_1_0_0, `CMPYOK, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBVAR, `BDCYOK, `CLAYOK, `AMBYOK}

// Out-of-order BIB buyruklari
// Bizim islemci in-order oldugu icin bu buyruklari implement etmemize gerek yok, bos birakin
`define FENCE_MI   {5'b0_1_1_0_1, `CMPYOK, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBVAR, `BDCYOK, `CLAYOK, `AMBYOK}
`define FENCE_I_MI {5'b0_1_1_1_0, `CMPYOK, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBVAR, `BDCYOK, `CLAYOK, `AMBYOK}

// Dallanma buyruklari
`define BEQ_MI  {5'b0_0_0_0_0, `CMPYOK, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALVAR, `BIBYOK, `BDCYOK, `CLAYOK, `AMBYOK}
`define BGE_MI  {5'b0_0_0_0_1, `CMPYOK, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALVAR, `BIBYOK, `BDCYOK, `CLAYOK, `AMBYOK}
`define BGEU_MI {5'b0_0_0_1_0, `CMPYOK, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALVAR, `BIBYOK, `BDCYOK, `CLAYOK, `AMBYOK}
`define BLT_MI  {5'b0_0_0_1_1, `CMPYOK, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALVAR, `BIBYOK, `BDCYOK, `CLAYOK, `AMBYOK}
`define BLTU_MI {5'b0_0_1_0_0, `CMPYOK, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALVAR, `BIBYOK, `BDCYOK, `CLAYOK, `AMBYOK}
`define BNE_MI  {5'b0_0_1_0_1, `CMPYOK, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALVAR, `BIBYOK, `BDCYOK, `CLAYOK, `AMBYOK}
`define JAL_MI  {5'b0_0_1_1_0, `CMPYOK, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALVAR, `BIBYOK, `BDCYOK, `CLAYOK, `AMBYOK}
`define JALR_MI {5'b0_0_1_1_1, `CMPYOK, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALVAR, `BIBYOK, `BDCYOK, `CLAYOK, `AMBYOK}

// Compressed Dallanma buyruklari
`define C_BEQZ_MI {5'b0_1_0_0_0, `CMPVAR, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALVAR, `BIBYOK, `BDCYOK, `CLAYOK, `AMBYOK}
`define C_BNEZ_MI {5'b0_1_0_0_1, `CMPVAR, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALVAR, `BIBYOK, `BDCYOK, `CLAYOK, `AMBYOK}
`define C_J_MI    {5'b0_1_0_1_0, `CMPVAR, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALVAR, `BIBYOK, `BDCYOK, `CLAYOK, `AMBYOK}
`define C_JAL_MI  {5'b0_1_0_1_1, `CMPVAR, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALVAR, `BIBYOK, `BDCYOK, `CLAYOK, `AMBYOK}
`define C_JALR_MI {5'b0_1_1_0_0, `CMPVAR, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALVAR, `BIBYOK, `BDCYOK, `CLAYOK, `AMBYOK}
`define C_JR_MI   {5'b0_1_1_0_1, `CMPVAR, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALVAR, `BIBYOK, `BDCYOK, `CLAYOK, `AMBYOK}

// Sifreleme buyruklari
`define HMDST_MI {5'b0_0_0_0_0, `CMPYOK, `IMMYOK, `SISYOK, `YAPYOK, `SIFVAR, `DALYOK, `BIBYOK, `BDCYOK, `CLAYOK, `AMBYOK}
`define PKG_MI   {5'b0_0_0_0_1, `CMPYOK, `IMMYOK, `SISYOK, `YAPYOK, `SIFVAR, `DALYOK, `BIBYOK, `BDCYOK, `CLAYOK, `AMBYOK}
`define RVRS_MI  {5'b0_0_0_1_0, `CMPYOK, `IMMYOK, `SISYOK, `YAPYOK, `SIFVAR, `DALYOK, `BIBYOK, `BDCYOK, `CLAYOK, `AMBYOK}
`define SLADD_MI {5'b0_0_0_1_1, `CMPYOK, `IMMYOK, `SISYOK, `YAPYOK, `SIFVAR, `DALYOK, `BIBYOK, `BDCYOK, `CLAYOK, `AMBYOK}
`define CNTZ_MI  {5'b0_0_1_0_0, `CMPYOK, `IMMYOK, `SISYOK, `YAPYOK, `SIFVAR, `DALYOK, `BIBYOK, `BDCYOK, `CLAYOK, `AMBYOK}
`define CNTP_MI  {5'b0_0_1_0_1, `CMPYOK, `IMMYOK, `SISYOK, `YAPYOK, `SIFVAR, `DALYOK, `BIBYOK, `BDCYOK, `CLAYOK, `AMBYOK}

// Yapay Zeka buyruklari
`define CONV_LD_W_MI  {5'b0_0_0_0_0, `CMPYOK, `IMMYOK, `SISYOK, `YAPVAR, `SIFYOK, `DALYOK, `BIBYOK, `BDCYOK, `CLAYOK, `AMBYOK}
`define CONV_CLR_W_MI {5'b0_0_0_0_1, `CMPYOK, `IMMYOK, `SISYOK, `YAPVAR, `SIFYOK, `DALYOK, `BIBYOK, `BDCYOK, `CLAYOK, `AMBYOK}
`define CONV_LD_X_MI  {5'b0_0_0_1_0, `CMPYOK, `IMMYOK, `SISYOK, `YAPVAR, `SIFYOK, `DALYOK, `BIBYOK, `BDCYOK, `CLAYOK, `AMBYOK}
`define CONV_CLR_X_MI {5'b0_0_0_1_1, `CMPYOK, `IMMYOK, `SISYOK, `YAPVAR, `SIFYOK, `DALYOK, `BIBYOK, `BDCYOK, `CLAYOK, `AMBYOK}
`define CONV_RUN_MI   {5'b0_0_1_0_0, `CMPYOK, `IMMYOK, `SISYOK, `YAPVAR, `SIFYOK, `DALYOK, `BIBYOK, `BDCYOK, `CLAYOK, `AMBYOK}

// Sistem buyruklari
`define EBREAK_MI {5'b0_0_0_0_0, `CMPYOK, `IMMYOK, `SISVAR, `YAPYOK, `SIFYOK, `DALYOK, `BIBYOK, `BDCYOK, `CLAYOK, `AMBYOK}
`define ECALL_MI  {5'b0_0_0_0_0, `CMPYOK, `IMMYOK, `SISVAR, `YAPYOK, `SIFYOK, `DALYOK, `BIBYOK, `BDCYOK, `CLAYOK, `AMBYOK}

// Compressed Sistem buyruklari
`define C_EBREAK_MI {5'b0_0_0_0_0, `CMPVAR, `IMMYOK, `SISVAR, `YAPYOK, `SIFYOK, `DALYOK, `BIBYOK, `BDCYOK, `CLAYOK, `AMBYOK}
