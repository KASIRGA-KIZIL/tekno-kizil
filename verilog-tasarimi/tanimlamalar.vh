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
`define BUYRUK_COZ_BIT 14

`define EBREAK_COZ		14'b00000100011100
`define ECALL_COZ		14'b00000000011100
`define CONV_CLR_W_COZ	14'b00000001100010
`define CONV_CLR_X_COZ	14'b00000000100010
`define CONV_RUN_COZ	14'b00000010000010
`define RVRS_COZ		14'b11110010100100
`define CNTZ_COZ		14'b11000100100100
`define CNTP_COZ		14'b11001000100100
`define CONV_LD_W_COZ	14'b0000??01000010
`define CONV_LD_X_COZ	14'b0000??00000010
`define ADD_COZ		    14'b0000??00001100
`define AND_COZ		    14'b0000??11101100
`define DIV_COZ		    14'b0001??10001100
`define DIVU_COZ		14'b0001??10101100
`define MUL_COZ		    14'b0001??00001100
`define MULH_COZ		14'b0001??00101100
`define MULHSU_COZ		14'b0001??01001100
`define MULHU_COZ		14'b0001??01101100
`define OR_COZ		    14'b0000??11001100
`define REM_COZ		    14'b0001??11001100
`define REMU_COZ		14'b0001??11101100
`define SLL_COZ		    14'b0000??00101100
`define SLT_COZ		    14'b0000??01001100
`define SLTU_COZ		14'b0000??01101100
`define SRA_COZ		    14'b1000??10101100
`define SRL_COZ		    14'b0000??10101100
`define SUB_COZ		    14'b1000??00001100
`define XOR_COZ		    14'b0000??10001100
`define HMDST_COZ		14'b0011??00101100
`define PKG_COZ		    14'b0010??10001100
`define SLADD_COZ		14'b0100??01001100
`define SLLI_COZ		14'b000???00100100
`define SRAI_COZ		14'b100???10100100
`define SRLI_COZ		14'b000???10100100
`define ADDI_COZ		14'b??????00000100
`define ANDI_COZ		14'b??????11100100
`define BEQ_COZ		    14'b??????00011000
`define BGE_COZ		    14'b??????10111000
`define BGEU_COZ		14'b??????11111000
`define BLT_COZ		    14'b??????10011000
`define BLTU_COZ		14'b??????11011000
`define BNE_COZ		    14'b??????00111000
`define FENCE_COZ		14'b??????00000011
`define FENCE_I_COZ		14'b??????00100011
`define JALR_COZ		14'b??????00011001
`define LB_COZ		    14'b??????00000000
`define LBU_COZ		    14'b??????10000000
`define LH_COZ		    14'b??????00100000
`define LHU_COZ		    14'b??????10100000
`define LW_COZ		    14'b??????01000000
`define ORI_COZ		    14'b??????11000100
`define SB_COZ		    14'b??????00001000
`define SH_COZ		    14'b??????00101000
`define SLTI_COZ		14'b??????01000100
`define SLTIU_COZ		14'b??????01100100
`define SW_COZ		    14'b??????01001000
`define XORI_COZ		14'b??????10000100
`define AUIPC_COZ		14'b?????????00101
`define JAL_COZ		    14'b?????????11011
`define LUI_COZ		    14'b?????????01101

// MIKROISLEM KODLARININ PARCALARI
// ...MI[7]...MI[0] Ilgili birime girecek mi girmeyecek mi onu gosteriyor
// Onundeki 4 bit ise o birime giren hangi buyruk oldugunu belirtiyor
// Simdilik toplam 14 bit

`define AMB 4'd0
`define CLA 4'd1
`define BDC 4'd2
`define BOL 4'd3
`define BIB 4'd4
`define DAL 4'd5
`define SIF 4'd6
`define YAP 4'd7
`define SIS 4'd8
`define IMM 4'd9

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
`define BOLVAR 1'b1
`define BOLYOK 1'b0

// MI[4]
`define BIBVAR 1'b1
`define BIBYOK 1'b0

// MI[5]
`define DALVAR 1'b1
`define DALYOK 1'b0

// MI[6]
`define SIFVAR 1'b1
`define SIFYOK 1'b0

// MI[7]
`define YAPVAR 1'b1
`define YAPYOK 1'b0

// MI[8]
`define SISVAR 1'b1
`define SISYOK 1'b0

// IMM ve CMP ilk 5 bitin icine yedirilebilir, bit sayisi azalir
// Cozden sonraki asamalarda compressed olmasinin onemi kalmayacaksa burada tamamen kaldirabiliriz, bu nasil cozdugumuze bagli

// MI[9]
`define IMMVAR 1'b1
`define IMMYOK 1'b0

// MI[9]
//`define CMPVAR 1'b1
//`define CMPYOK 1'b0
// CMPyi kaldirabilirim, dallanma, atlama, bellekyaz ve yazmacyaz, buyruktipi getirebilirim
// ama gereksiz olanlari bosuna koymayalim
// bir de cmp olmasi program sayacinin artisini (+2, +4) etkileyecegi icin burda tutmazsam baska yerde tutmaliyim

// MIKROISLEM KODLARI
// Toplam 87 buyruk --> 27si compressed

`define MI_BIT 14

`define GECERSIZ 14'b0000_0_000000000

// Ondeki bitler girdigi birimde kontrol edilecek bitler yani amb buyrugu ise ambnin kontrol sinyalleri

// AMB buyruklari
`define AND_MI   {4'b0_0_0_0, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBYOK, `BOLYOK, `BDCYOK, `CLAYOK, `AMBVAR}
`define OR_MI    {4'b0_0_0_1, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBYOK, `BOLYOK, `BDCYOK, `CLAYOK, `AMBVAR}
`define SLL_MI   {4'b0_0_1_0, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBYOK, `BOLYOK, `BDCYOK, `CLAYOK, `AMBVAR}
`define SLT_MI   {4'b0_0_1_1, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBYOK, `BOLYOK, `BDCYOK, `CLAYOK, `AMBVAR}
`define SLTU_MI  {4'b0_1_0_0, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBYOK, `BOLYOK, `BDCYOK, `CLAYOK, `AMBVAR}
`define SRA_MI   {4'b0_1_0_1, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBYOK, `BOLYOK, `BDCYOK, `CLAYOK, `AMBVAR}
`define SRL_MI   {4'b0_1_1_0, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBYOK, `BOLYOK, `BDCYOK, `CLAYOK, `AMBVAR}
`define XOR_MI   {4'b0_1_1_1, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBYOK, `BOLYOK, `BDCYOK, `CLAYOK, `AMBVAR}
`define AUIPC_MI {4'b1_0_0_0, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBYOK, `BOLYOK, `BDCYOK, `CLAYOK, `AMBVAR}
`define LUI_MI   {4'b1_0_0_1, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBYOK, `BOLYOK, `BDCYOK, `CLAYOK, `AMBVAR}

// IMMLERIN tipleri icin bitleri dogru sekilde kullanirsak anlik degerlerde rahat ederiz
// IMMLI AMB buyruklari
`define ANDI_MI  {4'b0_0_0_0, `IMMVAR, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBYOK, `BOLYOK, `BDCYOK, `CLAYOK, `AMBVAR}
`define ORI_MI   {4'b0_0_0_1, `IMMVAR, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBYOK, `BOLYOK, `BDCYOK, `CLAYOK, `AMBVAR}
`define SLLI_MI  {4'b0_0_1_0, `IMMVAR, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBYOK, `BOLYOK, `BDCYOK, `CLAYOK, `AMBVAR}
`define SLTI_MI  {4'b0_0_1_1, `IMMVAR, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBYOK, `BOLYOK, `BDCYOK, `CLAYOK, `AMBVAR}
`define SLTIU_MI {4'b0_1_0_0, `IMMVAR, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBYOK, `BOLYOK, `BDCYOK, `CLAYOK, `AMBVAR}
`define SRAI_MI  {4'b0_1_0_1, `IMMVAR, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBYOK, `BOLYOK, `BDCYOK, `CLAYOK, `AMBVAR}
`define SRLI_MI  {4'b0_1_1_0, `IMMVAR, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBYOK, `BOLYOK, `BDCYOK, `CLAYOK, `AMBVAR}
`define XORI_MI  {4'b0_1_1_1, `IMMVAR, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBYOK, `BOLYOK, `BDCYOK, `CLAYOK, `AMBVAR}

// Bolme buyruklari ayri birimde olsun
`define DIV_MI  {4'b0_0_0_0, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBYOK, `BOLVAR, `BDCYOK, `CLAYOK, `AMBYOK}
`define DIVU_MI {4'b0_0_0_1, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBYOK, `BOLVAR, `BDCYOK, `CLAYOK, `AMBYOK}
`define REM_MI  {4'b0_0_1_0, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBYOK, `BOLVAR, `BDCYOK, `CLAYOK, `AMBYOK}
`define REMU_MI {4'b0_0_1_1, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBYOK, `BOLVAR, `BDCYOK, `CLAYOK, `AMBYOK}

// Carry Lookahead Toplayici buyruklari
`define ADD_MI {4'b0_0_0_0, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBYOK, `BOLYOK, `BDCYOK, `CLAVAR, `AMBYOK}
`define SUB_MI {4'b0_0_0_1, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBYOK, `BOLYOK, `BDCYOK, `CLAVAR, `AMBYOK}
// cikarmayi amb'ye mi almaliyiz?

// Carry Lookahead IMMLI Toplayici buyruklari
`define ADDI_MI {4'b0_0_0_0, `IMMVAR, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBYOK, `BOLYOK, `BDCYOK, `CLAVAR, `AMBYOK}

// Modified Booth Dadda Carpici buyruklari
`define MUL_MI    {4'b0_0_0_0, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBYOK, `BOLYOK, `BDCVAR, `CLAYOK, `AMBYOK}
`define MULH_MI   {4'b0_0_0_1, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBYOK, `BOLYOK, `BDCVAR, `CLAYOK, `AMBYOK}
`define MULHSU_MI {4'b0_0_1_0, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBYOK, `BOLYOK, `BDCVAR, `CLAYOK, `AMBYOK}
`define MULHU_MI  {4'b0_0_1_1, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBYOK, `BOLYOK, `BDCVAR, `CLAYOK, `AMBYOK}

// BIB buyruklari
`define LB_MI  {4'b0_0_0_0, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBVAR, `BOLYOK, `BDCYOK, `CLAYOK, `AMBYOK}
`define LBU_MI {4'b0_0_0_1, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBVAR, `BOLYOK, `BDCYOK, `CLAYOK, `AMBYOK}
`define LH_MI  {4'b0_0_1_0, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBVAR, `BOLYOK, `BDCYOK, `CLAYOK, `AMBYOK}
`define LHU_MI {4'b0_0_1_1, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBVAR, `BOLYOK, `BDCYOK, `CLAYOK, `AMBYOK}
`define LW_MI  {4'b0_1_0_0, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBVAR, `BOLYOK, `BDCYOK, `CLAYOK, `AMBYOK}

`define SB_MI  {4'b0_1_0_1, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBVAR, `BOLYOK, `BDCYOK, `CLAYOK, `AMBYOK}
`define SH_MI  {4'b0_1_1_0, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBVAR, `BOLYOK, `BDCYOK, `CLAYOK, `AMBYOK}
`define SW_MI  {4'b0_1_1_1, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBVAR, `BOLYOK, `BDCYOK, `CLAYOK, `AMBYOK}

// Out-of-order BIB buyruklari
// Bizim islemci in-order oldugu icin bu buyruklari implement etmemize gerek yok, bos birakin
`define FENCE_MI   {4'b1_0_0_0, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBVAR, `BOLYOK, `BDCYOK, `CLAYOK, `AMBYOK}
`define FENCE_I_MI {4'b1_0_0_1, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBVAR, `BOLYOK, `BDCYOK, `CLAYOK, `AMBYOK}

// Dallanma buyruklari
`define BEQ_MI  {4'b0_0_0_0, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALVAR, `BIBYOK, `BOLYOK, `BDCYOK, `CLAYOK, `AMBYOK}
`define BGE_MI  {4'b0_0_0_1, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALVAR, `BIBYOK, `BOLYOK, `BDCYOK, `CLAYOK, `AMBYOK}
`define BGEU_MI {4'b0_0_1_0, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALVAR, `BIBYOK, `BOLYOK, `BDCYOK, `CLAYOK, `AMBYOK}
`define BLT_MI  {4'b0_0_1_1, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALVAR, `BIBYOK, `BOLYOK, `BDCYOK, `CLAYOK, `AMBYOK}
`define BLTU_MI {4'b0_1_0_0, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALVAR, `BIBYOK, `BOLYOK, `BDCYOK, `CLAYOK, `AMBYOK}
`define BNE_MI  {4'b0_1_0_1, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALVAR, `BIBYOK, `BOLYOK, `BDCYOK, `CLAYOK, `AMBYOK}
`define JAL_MI  {4'b0_1_1_0, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALVAR, `BIBYOK, `BOLYOK, `BDCYOK, `CLAYOK, `AMBYOK}
`define JALR_MI {4'b0_1_1_1, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALVAR, `BIBYOK, `BOLYOK, `BDCYOK, `CLAYOK, `AMBYOK}


// Sifreleme buyruklari
`define HMDST_MI {4'b0_0_0_0, `IMMYOK, `SISYOK, `YAPYOK, `SIFVAR, `DALYOK, `BIBYOK, `BOLYOK, `BDCYOK, `CLAYOK, `AMBYOK}
`define PKG_MI   {4'b0_0_0_1, `IMMYOK, `SISYOK, `YAPYOK, `SIFVAR, `DALYOK, `BIBYOK, `BOLYOK, `BDCYOK, `CLAYOK, `AMBYOK}
`define RVRS_MI  {4'b0_0_1_0, `IMMYOK, `SISYOK, `YAPYOK, `SIFVAR, `DALYOK, `BIBYOK, `BOLYOK, `BDCYOK, `CLAYOK, `AMBYOK}
`define SLADD_MI {4'b0_0_1_1, `IMMYOK, `SISYOK, `YAPYOK, `SIFVAR, `DALYOK, `BIBYOK, `BOLYOK, `BDCYOK, `CLAYOK, `AMBYOK}
`define CNTZ_MI  {4'b0_1_0_0, `IMMYOK, `SISYOK, `YAPYOK, `SIFVAR, `DALYOK, `BIBYOK, `BOLYOK, `BDCYOK, `CLAYOK, `AMBYOK}
`define CNTP_MI  {4'b0_1_0_1, `IMMYOK, `SISYOK, `YAPYOK, `SIFVAR, `DALYOK, `BIBYOK, `BOLYOK, `BDCYOK, `CLAYOK, `AMBYOK}

// Yapay Zeka buyruklari
`define CONV_LD_W_MI  {4'b0_0_0_0, `IMMYOK, `SISYOK, `YAPVAR, `SIFYOK, `DALYOK, `BIBYOK, `BOLYOK, `BDCYOK, `CLAYOK, `AMBYOK}
`define CONV_CLR_W_MI {4'b0_0_0_1, `IMMYOK, `SISYOK, `YAPVAR, `SIFYOK, `DALYOK, `BIBYOK, `BOLYOK, `BDCYOK, `CLAYOK, `AMBYOK}
`define CONV_LD_X_MI  {4'b0_0_1_0, `IMMYOK, `SISYOK, `YAPVAR, `SIFYOK, `DALYOK, `BIBYOK, `BOLYOK, `BDCYOK, `CLAYOK, `AMBYOK}
`define CONV_CLR_X_MI {4'b0_0_1_1, `IMMYOK, `SISYOK, `YAPVAR, `SIFYOK, `DALYOK, `BIBYOK, `BOLYOK, `BDCYOK, `CLAYOK, `AMBYOK}
`define CONV_RUN_MI   {4'b0_1_0_0, `IMMYOK, `SISYOK, `YAPVAR, `SIFYOK, `DALYOK, `BIBYOK, `BOLYOK, `BDCYOK, `CLAYOK, `AMBYOK}

// Sistem buyruklari
`define EBREAK_MI {4'b0_0_0_0, `IMMYOK, `SISVAR, `YAPYOK, `SIFYOK, `DALYOK, `BIBYOK, `BOLYOK, `BDCYOK, `CLAYOK, `AMBYOK}
`define ECALL_MI  {4'b0_0_0_0, `IMMYOK, `SISVAR, `YAPYOK, `SIFYOK, `DALYOK, `BIBYOK, `BOLYOK, `BDCYOK, `CLAYOK, `AMBYOK}

// Anlik tipleri
`define I_Tipi 3'b000
`define S_Tipi 3'b001
`define B_Tipi 3'b010
`define J_Tipi 3'b011
`define U_Tipi 3'b100


// Compressedleri 32 bitlik buyruklara donusturdugumuz icin artik tanimlamamiz gerekmiyor

/*
// Compressed AMB buyruklari
`define C_AND_MI {5'b1_0_0_1_0, `CMPVAR, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBYOK, `BDCYOK, `CLAYOK, `AMBVAR}
`define C_OR_MI  {5'b1_0_0_1_1, `CMPVAR, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBYOK, `BDCYOK, `CLAYOK, `AMBVAR}
`define C_XOR_MI {5'b1_0_1_0_0, `CMPVAR, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBYOK, `BDCYOK, `CLAYOK, `AMBVAR}

// Compressed IMMLI AMB buyruklari
`define C_ANDI_MI {5'b1_0_1_0_0, `CMPVAR, `IMMVAR, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBYOK, `BDCYOK, `CLAYOK, `AMBVAR}
`define C_SLLI_MI {5'b1_0_1_0_1, `CMPVAR, `IMMVAR, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBYOK, `BDCYOK, `CLAYOK, `AMBVAR}
`define C_SRAI_MI {5'b1_0_1_1_0, `CMPVAR, `IMMVAR, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBYOK, `BDCYOK, `CLAYOK, `AMBVAR}
`define C_SRLI_MI {5'b1_0_1_1_1, `CMPVAR, `IMMVAR, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBYOK, `BDCYOK, `CLAYOK, `AMBVAR}

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

// Compressed BIB buyruklari
`define C_LUI_MI  {5'b0_1_0_0_0, `CMPVAR, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBVAR, `BDCYOK, `CLAYOK, `AMBYOK}
`define C_LW_MI   {5'b0_1_0_0_1, `CMPVAR, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBVAR, `BDCYOK, `CLAYOK, `AMBYOK}
`define C_LWSP_MI {5'b0_1_0_1_0, `CMPVAR, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBVAR, `BDCYOK, `CLAYOK, `AMBYOK}
`define C_SW_MI   {5'b0_1_0_1_1, `CMPVAR, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBVAR, `BDCYOK, `CLAYOK, `AMBYOK}
`define C_SWSP_MI {5'b0_1_1_0_0, `CMPVAR, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALYOK, `BIBVAR, `BDCYOK, `CLAYOK, `AMBYOK}

// Compressed Dallanma buyruklari
`define C_BEQZ_MI {5'b0_1_0_0_0, `CMPVAR, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALVAR, `BIBYOK, `BDCYOK, `CLAYOK, `AMBYOK}
`define C_BNEZ_MI {5'b0_1_0_0_1, `CMPVAR, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALVAR, `BIBYOK, `BDCYOK, `CLAYOK, `AMBYOK}
`define C_J_MI    {5'b0_1_0_1_0, `CMPVAR, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALVAR, `BIBYOK, `BDCYOK, `CLAYOK, `AMBYOK}
`define C_JAL_MI  {5'b0_1_0_1_1, `CMPVAR, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALVAR, `BIBYOK, `BDCYOK, `CLAYOK, `AMBYOK}
`define C_JALR_MI {5'b0_1_1_0_0, `CMPVAR, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALVAR, `BIBYOK, `BDCYOK, `CLAYOK, `AMBYOK}
`define C_JR_MI   {5'b0_1_1_0_1, `CMPVAR, `IMMYOK, `SISYOK, `YAPYOK, `SIFYOK, `DALVAR, `BIBYOK, `BDCYOK, `CLAYOK, `AMBYOK}

// Compressed Sistem buyruklari
`define C_EBREAK_MI {5'b0_0_0_0_0, `CMPVAR, `IMMYOK, `SISVAR, `YAPYOK, `SIFYOK, `DALYOK, `BIBYOK, `BDCYOK, `CLAYOK, `AMBYOK}
*/
