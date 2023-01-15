// tb_coz.v
`timescale 1ns / 1ps

`include "tanimlamalar.vh"

module tb_coz();

    localparam [31:0] ADD                = 32'b0000000??????????000?????0110011;
    localparam [31:0] ADDI               = 32'b?????????????????000?????0010011;
    localparam [31:0] AND                = 32'b0000000??????????111?????0110011;
    localparam [31:0] ANDI               = 32'b?????????????????111?????0010011;
    localparam [31:0] AUIPC              = 32'b?????????????????????????0010111;
    localparam [31:0] BEQ                = 32'b?????????????????000?????1100011;
    localparam [31:0] BGE                = 32'b?????????????????101?????1100011;
    localparam [31:0] BGEU               = 32'b?????????????????111?????1100011;
    localparam [31:0] BLT                = 32'b?????????????????100?????1100011;
    localparam [31:0] BLTU               = 32'b?????????????????110?????1100011;
    localparam [31:0] BNE                = 32'b?????????????????001?????1100011;

    localparam [31:0] C_ADD              = 32'b0000000000000000_1001??????????10;
    localparam [31:0] C_ADDI             = 32'b0000000000000000_000???????????01;
    localparam [31:0] C_ADDI16SP         = 32'b0000000000000000_011?00010?????01;
    localparam [31:0] C_ADDI4SPN         = 32'b0000000000000000_000???????????00;
    localparam [31:0] C_AND              = 32'b0000000000000000_100011???11???01;
    localparam [31:0] C_ANDI             = 32'b0000000000000000_100?10????????01;
    localparam [31:0] C_BEQZ             = 32'b0000000000000000_110???????????01;
    localparam [31:0] C_BNEZ             = 32'b0000000000000000_111???????????01;
    localparam [31:0] C_EBREAK           = 32'b0000000000000000_1001000000000010;
    localparam [31:0] C_J                = 32'b0000000000000000_101???????????01;
    localparam [31:0] C_JAL              = 32'b0000000000000000_001???????????01;
    localparam [31:0] C_JALR             = 32'b0000000000000000_1001?????0000010;
    localparam [31:0] C_JR               = 32'b0000000000000000_1000?????0000010;
    localparam [31:0] C_LI               = 32'b0000000000000000_010???????????01;
    localparam [31:0] C_LUI              = 32'b0000000000000000_011???????????01;
    localparam [31:0] C_LW               = 32'b0000000000000000_010???????????00;
    localparam [31:0] C_LWSP             = 32'b0000000000000000_010???????????10;
    localparam [31:0] C_MV               = 32'b0000000000000000_1000??????????10;
    localparam [31:0] C_NOP              = 32'b0000000000000000_000?00000?????01;
    localparam [31:0] C_OR               = 32'b0000000000000000_100011???10???01;
    localparam [31:0] C_SLLI             = 32'b0000000000000000_0000??????????10;
    localparam [31:0] C_SRAI             = 32'b0000000000000000_100001????????01;
    localparam [31:0] C_SRLI             = 32'b0000000000000000_100000????????01;
    localparam [31:0] C_SUB              = 32'b0000000000000000_100011???00???01;
    localparam [31:0] C_SW               = 32'b0000000000000000_110???????????00;
    localparam [31:0] C_SWSP             = 32'b0000000000000000_110???????????10;
    localparam [31:0] C_XOR              = 32'b0000000000000000_100011???01???01;

    localparam [31:0] DIV                = 32'b0000001??????????100?????0110011;
    localparam [31:0] DIVU               = 32'b0000001??????????101?????0110011;
    localparam [31:0] EBREAK             = 32'b00000000000100000000000001110011;
    localparam [31:0] ECALL              = 32'b00000000000000000000000001110011;
    localparam [31:0] FENCE              = 32'b?????????????????000?????0001111;
    localparam [31:0] FENCE_I            = 32'b?????????????????001?????0001111;
    localparam [31:0] JAL                = 32'b?????????????????????????1101111;
    localparam [31:0] JALR               = 32'b?????????????????000?????1100111;
    localparam [31:0] LB                 = 32'b?????????????????000?????0000011;
    localparam [31:0] LBU                = 32'b?????????????????100?????0000011;
    localparam [31:0] LH                 = 32'b?????????????????001?????0000011;
    localparam [31:0] LHU                = 32'b?????????????????101?????0000011;
    localparam [31:0] LUI                = 32'b?????????????????????????0110111;
    localparam [31:0] LW                 = 32'b?????????????????010?????0000011;
    localparam [31:0] MUL                = 32'b0000001??????????000?????0110011;
    localparam [31:0] MULH               = 32'b0000001??????????001?????0110011;
    localparam [31:0] MULHSU             = 32'b0000001??????????010?????0110011;
    localparam [31:0] MULHU              = 32'b0000001??????????011?????0110011;
    localparam [31:0] OR                 = 32'b0000000??????????110?????0110011;
    localparam [31:0] ORI                = 32'b?????????????????110?????0010011;
    localparam [31:0] REM                = 32'b0000001??????????110?????0110011;
    localparam [31:0] REMU               = 32'b0000001??????????111?????0110011;
    localparam [31:0] SB                 = 32'b?????????????????000?????0100011;
    localparam [31:0] SH                 = 32'b?????????????????001?????0100011;
    localparam [31:0] SLL                = 32'b0000000??????????001?????0110011;
    localparam [31:0] SLLI               = 32'b0000000??????????001?????0010011;
    localparam [31:0] SLT                = 32'b0000000??????????010?????0110011;
    localparam [31:0] SLTI               = 32'b?????????????????010?????0010011;
    localparam [31:0] SLTIU              = 32'b?????????????????011?????0010011;
    localparam [31:0] SLTU               = 32'b0000000??????????011?????0110011;
    localparam [31:0] SRA                = 32'b0100000??????????101?????0110011;
    localparam [31:0] SRAI               = 32'b0100000??????????101?????0010011;
    localparam [31:0] SRL                = 32'b0000000??????????101?????0110011;
    localparam [31:0] SRLI               = 32'b0000000??????????101?????0010011;
    localparam [31:0] SUB                = 32'b0100000??????????000?????0110011;
    localparam [31:0] SW                 = 32'b?????????????????010?????0100011;
    localparam [31:0] XOR                = 32'b0000000??????????100?????0110011;
    localparam [31:0] XORI               = 32'b?????????????????100?????0010011;

    localparam [31:0] HMDST              = 32'b0000101_?????_?????_001_?????_0110011;
    localparam [31:0] PKG                = 32'b0000100_?????_?????_100_?????_0110011;
    localparam [31:0] RVRS               = 32'b011010111000_?????_101_?????_0010011;
    localparam [31:0] SLADD              = 32'b0010000_?????_?????_010_?????_0110011;
    localparam [31:0] CNTZ               = 32'b0110000_00001_?????_001_?????_0010011;
    localparam [31:0] CNTP               = 32'b0110000_00010_?????_001_?????_0010011;

    localparam [31:0] CONV_LD_W          = 32'b?_000000_?????_?????_010_00000_0001011;
    localparam [31:0] CONV_CLR_W         = 32'b0000000_00000_00000_011_00000_0001011;
    localparam [31:0] CONV_LD_X          = 32'b?_000000_?????_?????_000_00000_0001011;
    localparam [31:0] CONV_CLR_X         = 32'b0000000_00000_00000_001_00000_0001011;
    localparam [31:0] CONV_RUN           = 32'b0000000_00000_00000_100_?????_0001011;

    reg clk_i = 0;
    reg rst_i = 0;

    reg duraklat_i = 0;

    reg [31:0] buyruk_i;

    wire [6:0] buyruk_mikroislem_o;
    wire [4:0] rd_o;
    wire [4:0] rs1_o;
    wire [4:0] rs2_o;
    wire [31:0] i_imm_o;
    wire [31:0] s_imm_o;
    wire [31:0] b_imm_o;
    wire [31:0] u_imm_o;
    wire [31:0] j_imm_o;
    wire [9:0] nzuimm_o;


    coz cz(
        .clk_i(clk_i),
        .rst_i(rst_i),

        .duraklat_i(duraklat_i),

        .buyruk_i(buyruk_i),

        .buyruk_mikroislem_o(buyruk_mikroislem_o),

        .rd_o(rd_o),
        .rs1_o(rs1_o),
        .rs2_o(rs2_o),

        .i_imm_o(i_imm_o),
        .s_imm_o(s_imm_o),
        .b_imm_o(b_imm_o),
        .u_imm_o(u_imm_o),
        .j_imm_o(j_imm_o),

        .nzuimm_o(nzuimm_o)
    );

    always begin
        #5;
        clk_i = ~clk_i;
    end



    integer i = 0;

    initial begin
        rst_i = 1'b1;
        #100;
        rst_i = 0;

        buyruk_i = EBREAK; #10; if(buyruk_mikroislem_o == `EBREAK_MI) $display("passed"); else $display("EBREAK: FAILED!: %h", buyruk_mikroislem_o);
        buyruk_i = ECALL; #10; if(buyruk_mikroislem_o == `ECALL_MI) $display("passed"); else $display("ECALL: FAILED!: %h", buyruk_mikroislem_o);
        buyruk_i = CONV_CLR_W; #10; if(buyruk_mikroislem_o == `CONV_CLR_W_MI) $display("passed"); else $display("CONV_CLR_W: FAILED!: %h", buyruk_mikroislem_o);
        buyruk_i = CONV_CLR_X; #10; if(buyruk_mikroislem_o == `CONV_CLR_X_MI) $display("passed"); else $display("CONV_CLR_X: FAILED!: %h", buyruk_mikroislem_o);
        buyruk_i = CONV_RUN; #10; if(buyruk_mikroislem_o == `CONV_RUN_MI) $display("passed"); else $display("CONV_RUN: FAILED!: %h", buyruk_mikroislem_o);
        buyruk_i = RVRS; #10; if(buyruk_mikroislem_o == `RVRS_MI) $display("passed"); else $display("RVRS: FAILED!: %h", buyruk_mikroislem_o);
        buyruk_i = CNTZ; #10; if(buyruk_mikroislem_o == `CNTZ_MI) $display("passed"); else $display("CNTZ: FAILED!: %h", buyruk_mikroislem_o);
        buyruk_i = CNTP; #10; if(buyruk_mikroislem_o == `CNTP_MI) $display("passed"); else $display("CNTP: FAILED!: %h", buyruk_mikroislem_o);
        buyruk_i = CONV_LD_W; #10; if(buyruk_mikroislem_o == `CONV_LD_W_MI) $display("passed"); else $display("CONV_LD_W: FAILED!: %h", buyruk_mikroislem_o);
        buyruk_i = CONV_LD_X; #10; if(buyruk_mikroislem_o == `CONV_LD_X_MI) $display("passed"); else $display("CONV_LD_X: FAILED!: %h", buyruk_mikroislem_o);
        buyruk_i = ADD; #10; if(buyruk_mikroislem_o == `ADD_MI) $display("passed"); else $display("ADD: FAILED!: %h", buyruk_mikroislem_o);
        buyruk_i = AND; #10; if(buyruk_mikroislem_o == `AND_MI) $display("passed"); else $display("AND: FAILED!: %h", buyruk_mikroislem_o);
        buyruk_i = DIV; #10; if(buyruk_mikroislem_o == `DIV_MI) $display("passed"); else $display("DIV: FAILED!: %h", buyruk_mikroislem_o);
        buyruk_i = DIVU; #10; if(buyruk_mikroislem_o == `DIVU_MI) $display("passed"); else $display("DIVU: FAILED!: %h", buyruk_mikroislem_o);
        buyruk_i = MUL; #10; if(buyruk_mikroislem_o == `MUL_MI) $display("passed"); else $display("MUL: FAILED!: %h", buyruk_mikroislem_o);
        buyruk_i = MULH; #10; if(buyruk_mikroislem_o == `MULH_MI) $display("passed"); else $display("MULH: FAILED!: %h", buyruk_mikroislem_o);
        buyruk_i = MULHSU; #10; if(buyruk_mikroislem_o == `MULHSU_MI) $display("passed"); else $display("MULHSU: FAILED!: %h", buyruk_mikroislem_o);
        buyruk_i = MULHU; #10; if(buyruk_mikroislem_o == `MULHU_MI) $display("passed"); else $display("MULHU: FAILED!: %h", buyruk_mikroislem_o);
        buyruk_i = OR; #10; if(buyruk_mikroislem_o == `OR_MI) $display("passed"); else $display("OR: FAILED!: %h", buyruk_mikroislem_o);
        buyruk_i = REM; #10; if(buyruk_mikroislem_o == `REM_MI) $display("passed"); else $display("REM: FAILED!: %h", buyruk_mikroislem_o);
        buyruk_i = REMU; #10; if(buyruk_mikroislem_o == `REMU_MI) $display("passed"); else $display("REMU: FAILED!: %h", buyruk_mikroislem_o);
        buyruk_i = SLL; #10; if(buyruk_mikroislem_o == `SLL_MI) $display("passed"); else $display("SLL: FAILED!: %h", buyruk_mikroislem_o);
        buyruk_i = SLT; #10; if(buyruk_mikroislem_o == `SLT_MI) $display("passed"); else $display("SLT: FAILED!: %h", buyruk_mikroislem_o);
        buyruk_i = SLTU; #10; if(buyruk_mikroislem_o == `SLTU_MI) $display("passed"); else $display("SLTU: FAILED!: %h", buyruk_mikroislem_o);
        buyruk_i = SRA; #10; if(buyruk_mikroislem_o == `SRA_MI) $display("passed"); else $display("SRA: FAILED!: %h", buyruk_mikroislem_o);
        buyruk_i = SRL; #10; if(buyruk_mikroislem_o == `SRL_MI) $display("passed"); else $display("SRL: FAILED!: %h", buyruk_mikroislem_o);
        buyruk_i = SUB; #10; if(buyruk_mikroislem_o == `SUB_MI) $display("passed"); else $display("SUB: FAILED!: %h", buyruk_mikroislem_o);
        buyruk_i = XOR; #10; if(buyruk_mikroislem_o == `XOR_MI) $display("passed"); else $display("XOR: FAILED!: %h", buyruk_mikroislem_o);
        buyruk_i = HMDST; #10; if(buyruk_mikroislem_o == `HMDST_MI) $display("passed"); else $display("HMDST: FAILED!: %h", buyruk_mikroislem_o);
        buyruk_i = PKG; #10; if(buyruk_mikroislem_o == `PKG_MI) $display("passed"); else $display("PKG: FAILED!: %h", buyruk_mikroislem_o);
        buyruk_i = SLADD; #10; if(buyruk_mikroislem_o == `SLADD_MI) $display("passed"); else $display("SLADD: FAILED!: %h", buyruk_mikroislem_o);
        buyruk_i = C_EBREAK; #10; if(buyruk_mikroislem_o == `C_EBREAK_MI) $display("passed"); else $display("C_EBREAK: FAILED!: %h", buyruk_mikroislem_o);
        buyruk_i = SLLI; #10; if(buyruk_mikroislem_o == `SLLI_MI) $display("passed"); else $display("SLLI: FAILED!: %h", buyruk_mikroislem_o);
        buyruk_i = SRAI; #10; if(buyruk_mikroislem_o == `SRAI_MI) $display("passed"); else $display("SRAI: FAILED!: %h", buyruk_mikroislem_o);
        buyruk_i = SRLI; #10; if(buyruk_mikroislem_o == `SRLI_MI) $display("passed"); else $display("SRLI: FAILED!: %h", buyruk_mikroislem_o);
        buyruk_i = C_JALR; #10; if(buyruk_mikroislem_o == `C_JALR_MI) $display("passed"); else $display("C_JALR: FAILED!: %h", buyruk_mikroislem_o);
        buyruk_i = C_JR; #10; if(buyruk_mikroislem_o == `C_JR_MI) $display("passed"); else $display("C_JR: FAILED!: %h", buyruk_mikroislem_o);
        buyruk_i = ADDI; #10; if(buyruk_mikroislem_o == `ADDI_MI) $display("passed"); else $display("ADDI: FAILED!: %h", buyruk_mikroislem_o);
        buyruk_i = ANDI; #10; if(buyruk_mikroislem_o == `ANDI_MI) $display("passed"); else $display("ANDI: FAILED!: %h", buyruk_mikroislem_o);
        buyruk_i = BEQ; #10; if(buyruk_mikroislem_o == `BEQ_MI) $display("passed"); else $display("BEQ: FAILED!: %h", buyruk_mikroislem_o);
        buyruk_i = BGE; #10; if(buyruk_mikroislem_o == `BGE_MI) $display("passed"); else $display("BGE: FAILED!: %h", buyruk_mikroislem_o);
        buyruk_i = BGEU; #10; if(buyruk_mikroislem_o == `BGEU_MI) $display("passed"); else $display("BGEU: FAILED!: %h", buyruk_mikroislem_o);
        buyruk_i = BLT; #10; if(buyruk_mikroislem_o == `BLT_MI) $display("passed"); else $display("BLT: FAILED!: %h", buyruk_mikroislem_o);
        buyruk_i = BLTU; #10; if(buyruk_mikroislem_o == `BLTU_MI) $display("passed"); else $display("BLTU: FAILED!: %h", buyruk_mikroislem_o);
        buyruk_i = BNE; #10; if(buyruk_mikroislem_o == `BNE_MI) $display("passed"); else $display("BNE: FAILED!: %h", buyruk_mikroislem_o);
        buyruk_i = C_ADDI16SP; #10; if(buyruk_mikroislem_o == `C_ADDI16SP_MI) $display("passed"); else $display("C_ADDI16SP: FAILED!: %h", buyruk_mikroislem_o);
        buyruk_i = C_AND; #10; if(buyruk_mikroislem_o == `C_AND_MI) $display("passed"); else $display("C_AND: FAILED!: %h", buyruk_mikroislem_o);
        buyruk_i = C_NOP; #10; if(buyruk_mikroislem_o == `C_NOP_MI) $display("passed"); else $display("C_NOP: FAILED!: %h", buyruk_mikroislem_o);
        buyruk_i = C_OR; #10; if(buyruk_mikroislem_o == `C_OR_MI) $display("passed"); else $display("C_OR: FAILED!: %h", buyruk_mikroislem_o);
        buyruk_i = C_SUB; #10; if(buyruk_mikroislem_o == `C_SUB_MI) $display("passed"); else $display("C_SUB: FAILED!: %h", buyruk_mikroislem_o);
        buyruk_i = C_XOR; #10; if(buyruk_mikroislem_o == `C_XOR_MI) $display("passed"); else $display("C_XOR: FAILED!: %h", buyruk_mikroislem_o);
        buyruk_i = FENCE; #10; if(buyruk_mikroislem_o == `FENCE_MI) $display("passed"); else $display("FENCE: FAILED!: %h", buyruk_mikroislem_o);
        buyruk_i = FENCE_I; #10; if(buyruk_mikroislem_o == `FENCE_I_MI) $display("passed"); else $display("FENCE_I: FAILED!: %h", buyruk_mikroislem_o);
        buyruk_i = JALR; #10; if(buyruk_mikroislem_o == `JALR_MI) $display("passed"); else $display("JALR: FAILED!: %h", buyruk_mikroislem_o);
        buyruk_i = LB; #10; if(buyruk_mikroislem_o == `LB_MI) $display("passed"); else $display("LB: FAILED!: %h", buyruk_mikroislem_o);
        buyruk_i = LBU; #10; if(buyruk_mikroislem_o == `LBU_MI) $display("passed"); else $display("LBU: FAILED!: %h", buyruk_mikroislem_o);
        buyruk_i = LH; #10; if(buyruk_mikroislem_o == `LH_MI) $display("passed"); else $display("LH: FAILED!: %h", buyruk_mikroislem_o);
        buyruk_i = LHU; #10; if(buyruk_mikroislem_o == `LHU_MI) $display("passed"); else $display("LHU: FAILED!: %h", buyruk_mikroislem_o);
        buyruk_i = LW; #10; if(buyruk_mikroislem_o == `LW_MI) $display("passed"); else $display("LW: FAILED!: %h", buyruk_mikroislem_o);
        buyruk_i = ORI; #10; if(buyruk_mikroislem_o == `ORI_MI) $display("passed"); else $display("ORI: FAILED!: %h", buyruk_mikroislem_o);
        buyruk_i = SB; #10; if(buyruk_mikroislem_o == `SB_MI) $display("passed"); else $display("SB: FAILED!: %h", buyruk_mikroislem_o);
        buyruk_i = SH; #10; if(buyruk_mikroislem_o == `SH_MI) $display("passed"); else $display("SH: FAILED!: %h", buyruk_mikroislem_o);
        buyruk_i = SLTI; #10; if(buyruk_mikroislem_o == `SLTI_MI) $display("passed"); else $display("SLTI: FAILED!: %h", buyruk_mikroislem_o);
        buyruk_i = SLTIU; #10; if(buyruk_mikroislem_o == `SLTIU_MI) $display("passed"); else $display("SLTIU: FAILED!: %h", buyruk_mikroislem_o);
        buyruk_i = SW; #10; if(buyruk_mikroislem_o == `SW_MI) $display("passed"); else $display("SW: FAILED!: %h", buyruk_mikroislem_o);
        buyruk_i = XORI; #10; if(buyruk_mikroislem_o == `XORI_MI) $display("passed"); else $display("XORI: FAILED!: %h", buyruk_mikroislem_o);
        buyruk_i = AUIPC; #10; if(buyruk_mikroislem_o == `AUIPC_MI) $display("passed"); else $display("AUIPC: FAILED!: %h", buyruk_mikroislem_o);
        buyruk_i = C_ANDI; #10; if(buyruk_mikroislem_o == `C_ANDI_MI) $display("passed"); else $display("C_ANDI: FAILED!: %h", buyruk_mikroislem_o);
        buyruk_i = C_SRAI; #10; if(buyruk_mikroislem_o == `C_SRAI_MI) $display("passed"); else $display("C_SRAI: FAILED!: %h", buyruk_mikroislem_o);
        buyruk_i = C_SRLI; #10; if(buyruk_mikroislem_o == `C_SRLI_MI) $display("passed"); else $display("C_SRLI: FAILED!: %h", buyruk_mikroislem_o);
        buyruk_i = JAL; #10; if(buyruk_mikroislem_o == `JAL_MI) $display("passed"); else $display("JAL: FAILED!: %h", buyruk_mikroislem_o);
        buyruk_i = LUI; #10; if(buyruk_mikroislem_o == `LUI_MI) $display("passed"); else $display("LUI: FAILED!: %h", buyruk_mikroislem_o);
        buyruk_i = 32'b0000000000000000_1001????????1?10; #10; if(buyruk_mikroislem_o == `C_ADD_MI) $display("passed"); else $display("C_ADD: FAILED!: %h", buyruk_mikroislem_o);
        buyruk_i = C_MV; #10; if(buyruk_mikroislem_o == `C_MV_MI) $display("passed"); else $display("C_MV: FAILED!: %h", buyruk_mikroislem_o);
        buyruk_i = C_ADDI; #10; if(buyruk_mikroislem_o == `C_ADDI_MI) $display("passed"); else $display("C_ADDI: FAILED!: %h", buyruk_mikroislem_o);
        buyruk_i = 32'b0000000000000000_0000000100001?00; #10; if(buyruk_mikroislem_o == `C_ADDI4SPN_MI) $display("passed"); else $display("C_ADDI4SPN: FAILED!: %h", buyruk_mikroislem_o);
        buyruk_i = C_BEQZ; #10; if(buyruk_mikroislem_o == `C_BEQZ_MI) $display("passed"); else $display("C_BEQZ: FAILED!: %h", buyruk_mikroislem_o);
        buyruk_i = C_BNEZ; #10; if(buyruk_mikroislem_o == `C_BNEZ_MI) $display("passed"); else $display("C_BNEZ: FAILED!: %h", buyruk_mikroislem_o);
        buyruk_i = C_J; #10; if(buyruk_mikroislem_o == `C_J_MI) $display("passed"); else $display("C_J: FAILED!: %h", buyruk_mikroislem_o);
        buyruk_i = C_JAL; #10; if(buyruk_mikroislem_o == `C_JAL_MI) $display("passed"); else $display("C_JAL: FAILED!: %h", buyruk_mikroislem_o);
        buyruk_i = C_LI; #10; if(buyruk_mikroislem_o == `C_LI_MI) $display("passed"); else $display("C_LI: FAILED!: %h", buyruk_mikroislem_o);
        buyruk_i = C_LUI; #10; if(buyruk_mikroislem_o == `C_LUI_MI) $display("passed"); else $display("C_LUI: FAILED!: %h", buyruk_mikroislem_o);
        buyruk_i = C_LW; #10; if(buyruk_mikroislem_o == `C_LW_MI) $display("passed"); else $display("C_LW: FAILED!: %h", buyruk_mikroislem_o);
        buyruk_i = C_LWSP; #10; if(buyruk_mikroislem_o == `C_LWSP_MI) $display("passed"); else $display("C_LWSP: FAILED!: %h", buyruk_mikroislem_o);
        buyruk_i = C_SLLI; #10; if(buyruk_mikroislem_o == `C_SLLI_MI) $display("passed"); else $display("C_SLLI: FAILED!: %h", buyruk_mikroislem_o);
        buyruk_i = C_SW; #10; if(buyruk_mikroislem_o == `C_SW_MI) $display("passed"); else $display("C_SW: FAILED!: %h", buyruk_mikroislem_o);
        buyruk_i = C_SWSP; #10; if(buyruk_mikroislem_o == `C_SWSP_MI) $display("passed"); else $display("C_SWSP: FAILED!: %h", buyruk_mikroislem_o);

        //buyruk_i = ADD; #10; if(buyruk_mikroislem_o == `ADD_MI) $display("passed"); else $display("failed");

        //buyruk_i = 32'b00000001111111111111001100110011;
        //#10;
        //$display("asdasd: %h", buyruk_mikroislem_o);
        $finish;
    end

endmodule
