// Burasi guncellenecek..., mantik bu

// MIKROISLEM KODLARININ PARCALARI
// Ilgili birime girecek mi girmeyecek mi onu gosteriyor
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


// MIKROISLEM KODLARI
// Toplam 87 buyruk

`define GECERSIZ 13'b00000_00000000

// AMB buyruklari
`define AND_MI {5'b0_0_0_0_0, SISYOK, YAPYOK, SIFYOK, DALYOK, BIBYOK, BDCYOK, CLAYOK, AMBVAR} //7'b0000100
`define AUIPC_MI 7'b0000110
`define LUI_MI 7'b0110100
`define OR_MI 7'b0111010
`define SLL_MI 7'b1000000
`define SLT_MI 7'b1000010
`define SLTU_MI 7'b1000101
`define SRA_MI 7'b1000110
`define SRL_MI 7'b1001000
`define XOR_MI 7'b1001100

// IMMLI AMB buyruklari
`define ANDI_MI 7'b0000101
`define ORI_MI 7'b0111011
`define SLLI_MI 7'b1000001
`define SLTI_MI 7'b1000011
`define SLTIU_MI 7'b1000100
`define SRAI_MI 7'b1000111
`define SRLI_MI 7'b1001001
`define XORI_MI 7'b1001101

// Compressed AMB buyruklari
`define C_AND_MI 7'b0010001
`define C_OR_MI 7'b0100000
`define C_XOR_MI 7'b0100111

// Compressed IMMLI AMB buyruklari
`define C_ANDI_MI 7'b0010010
`define C_SLLI_MI 7'b0100001
`define C_SRAI_MI 7'b0100010
`define C_SRLI_MI 7'b0100011

// Bolme buyruklari, simdilik amb'de olsun?
`define DIV_MI 7'b0101000
`define DIVU_MI 7'b0101001
`define REM_MI 7'b0111100
`define REMU_MI 7'b0111101

// Carry Lookahead Toplayici buyruklari
`define ADD_MI 7'b0000010
`define SUB_MI 7'b1001010 // cikarmayi amb'ye mi almaliyiz?

// Carry Lookahead IMMLI Toplayici buyruklari
`define ADDI_MI 7'b0000011

// Compressed Carry Lookahead Toplayici buyruklari
`define C_ADD_MI 7'b0001101
`define C_MV_MI 7'b0011110
`define C_SUB_MI 7'b0100100

// Compressed IMMLI Carry Lookahead Toplayici buyruklari
`define C_ADDI_MI 7'b0001110
`define C_ADDI16SP_MI 7'b0001111
`define C_ADDI4SPN_MI 7'b0010000
`define C_LI_MI 7'b0011010
`define C_NOP_MI 7'b0011111

// Modified Booth Dadda Carpici buyruklari
`define MUL_MI 7'b0110110
`define MULH_MI 7'b0110111
`define MULHSU_MI 7'b0111000
`define MULHU_MI 7'b0111001

// BIB buyruklari
`define LB_MI 7'b0110000
`define LBU_MI 7'b0110001
`define LH_MI 7'b0110010
`define LHU_MI 7'b0110011
`define LW_MI 7'b0110101

`define SB_MI 7'b0111110
`define SH_MI 7'b0111111
`define SW_MI 7'b1001011

// Compressed BIB buyruklari
`define C_LUI_MI 7'b0011011
`define C_LW_MI 7'b0011100
`define C_LWSP_MI 7'b0011101
`define C_SW_MI 7'b0100101
`define C_SWSP_MI 7'b0100110

// Out-of-order BIB buyruklari
// Bizim islemci in-order oldugu icin bu buyruklari implement etmemize gerek yok, bos birakin
`define FENCE_MI 7'b0101100
`define FENCE_I_MI 7'b0101101

// Dallanma buyruklari
`define BEQ_MI 7'b0000111
`define BGE_MI 7'b0001000
`define BGEU_MI 7'b0001001
`define BLT_MI 7'b0001010
`define BLTU_MI 7'b0001011
`define BNE_MI 7'b0001100
`define JAL_MI 7'b0101110
`define JALR_MI 7'b0101111

// Compressed Dallanma buyruklari
`define C_BEQZ_MI 7'b0010011
`define C_BNEZ_MI 7'b0010100
`define C_J_MI 7'b0010110
`define C_JAL_MI 7'b0010111
`define C_JALR_MI 7'b0011000
`define C_JR_MI 7'b0011001

// Sifreleme buyruklari
`define HMDST_MI 7'b1001110
`define PKG_MI 7'b1001111
`define RVRS_MI 7'b1010000
`define SLADD_MI 7'b1010001
`define CNTZ_MI 7'b1010010
`define CNTP_MI 7'b1010011

// Yapay Zeka buyruklari
`define CONV_LD_W_MI 7'b1010100
`define CONV_CLR_W_MI 7'b1010101
`define CONV_LD_X_MI 7'b1010110
`define CONV_CLR_X_MI 7'b1010111
`define CONV_RUN_MI 7'b1011000

// Sistem buyruklari
`define EBREAK_MI 7'b0101010
`define ECALL_MI 7'b0101011

// Compressed Sistem buyruklari
`define C_EBREAK_MI 7'b0010101
