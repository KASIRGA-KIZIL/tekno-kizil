`timescale 1ns / 1ps
`include "tanimlamalar.vh"

module tb_coz_yazmacoku;

  // Parameters

  // Ports
  reg clk_i = 0;
  reg rst_i = 0;
  reg [31:0] buyruk_i;
  reg buyruk_gecerli_i = 0;
  reg [31:0] program_sayaci_i;
  wire [`MI_BIT-1:0] mikroislem_o;
  wire [31:0] deger1_o;
  wire [31:0] deger2_o;
  wire [ 2:0] lt_ltu_eq_o;
  wire [ 1:0] buyruk_tipi_o;
  wire yapay_zeka_en_o;
  reg [31:0] program_sayaci_artmis_i;
  wire [31:0] program_sayaci_artmis_o;
  wire [ 4:0] rd_adres_o;
  reg [4:0] yaz_adres_i;
  reg [31:0] yaz_deger_i;
  reg yaz_yazmac_i = 0;
  reg [31:0] yonlendir_geriyaz_deger_i;
  reg [31:0] yonlendir_yurut_deger_i;
  reg durdur_i = 0;
  reg bosalt_i = 0;
  reg [1:0] yonlendir_deger1_i;
  reg [1:0] yonlendir_deger2_i;
  wire [4:0] rs1_adres_o;
  wire [4:0] rs2_adres_o;
  wire gecersiz_buyruk_o;

  coz_yazmacoku 
  coz_yazmacoku_dut (
    .clk_i (clk_i ),
    .rst_i (rst_i ),
    .buyruk_i (buyruk_i ),
    .buyruk_gecerli_i (buyruk_gecerli_i ),
    .program_sayaci_i (program_sayaci_i ),
    .mikroislem_o (mikroislem_o ),
    .deger1_o (deger1_o ),
    .deger2_o (deger2_o ),
    .lt_ltu_eq_o (lt_ltu_eq_o ),
    .buyruk_tipi_o (buyruk_tipi_o ),
    .yapay_zeka_en_o (yapay_zeka_en_o ),
    .program_sayaci_artmis_i (program_sayaci_artmis_i ),
    .program_sayaci_artmis_o (program_sayaci_artmis_o ),
    .rd_adres_o (rd_adres_o ),
    .yaz_adres_i (yaz_adres_i ),
    .yaz_deger_i (yaz_deger_i ),
    .yaz_yazmac_i (yaz_yazmac_i ),
    .yonlendir_geriyaz_deger_i (yonlendir_geriyaz_deger_i ),
    .yonlendir_yurut_deger_i (yonlendir_yurut_deger_i ),
    .durdur_i (durdur_i ),
    .bosalt_i (bosalt_i ),
    .yonlendir_deger1_i (yonlendir_deger1_i ),
    .yonlendir_deger2_i (yonlendir_deger2_i ),
    .rs1_adres_o (rs1_adres_o ),
    .rs2_adres_o (rs2_adres_o ),
    .gecersiz_buyruk_o  ( gecersiz_buyruk_o)
  );

  initial begin
    rst_i = 1'b1;
    #100;
    rst_i = 0;

    buyruk_gecerli_i = 1'b1;

    buyruk_i = `EBREAK; #10; if(mikroislem_o == `EBREAK_MI) $display("passed"); else $display("EBREAK: FAILED!: %h", mikroislem_o);
    buyruk_i = `ECALL; #10; if(mikroislem_o == `ECALL_MI) $display("passed"); else $display("ECALL: FAILED!: %h", mikroislem_o);
    buyruk_i = `CONV_CLR_W; #10; if(mikroislem_o == `CONV_CLR_W_MI) $display("passed"); else $display("CONV_CLR_W: FAILED!: %h", mikroislem_o);
    buyruk_i = `CONV_CLR_X; #10; if(mikroislem_o == `CONV_CLR_X_MI) $display("passed"); else $display("CONV_CLR_X: FAILED!: %h", mikroislem_o);
    buyruk_i = `CONV_RUN; #10; if(mikroislem_o == `CONV_RUN_MI) $display("passed"); else $display("CONV_RUN: FAILED!: %h", mikroislem_o);
    buyruk_i = `RVRS; #10; if(mikroislem_o == `RVRS_MI) $display("passed"); else $display("RVRS: FAILED!: %h", mikroislem_o);
    buyruk_i = `CNTZ; #10; if(mikroislem_o == `CNTZ_MI) $display("passed"); else $display("CNTZ: FAILED!: %h", mikroislem_o);
    buyruk_i = `CNTP; #10; if(mikroislem_o == `CNTP_MI) $display("passed"); else $display("CNTP: FAILED!: %h", mikroislem_o);
    buyruk_i = `CONV_LD_W; #10; if(mikroislem_o == `CONV_LD_W_MI) $display("passed"); else $display("CONV_LD_W: FAILED!: %h", mikroislem_o);
    buyruk_i = `CONV_LD_X; #10; if(mikroislem_o == `CONV_LD_X_MI) $display("passed"); else $display("CONV_LD_X: FAILED!: %h", mikroislem_o);
    buyruk_i = `ADD; #10; if(mikroislem_o == `ADD_MI) $display("passed"); else $display("ADD: FAILED!: %h", mikroislem_o);
    buyruk_i = `AND; #10; if(mikroislem_o == `AND_MI) $display("passed"); else $display("AND: FAILED!: %h", mikroislem_o);
    buyruk_i = `DIV; #10; if(mikroislem_o == `DIV_MI) $display("passed"); else $display("DIV: FAILED!: %h", mikroislem_o);
    buyruk_i = `DIVU; #10; if(mikroislem_o == `DIVU_MI) $display("passed"); else $display("DIVU: FAILED!: %h", mikroislem_o);
    buyruk_i = `MUL; #10; if(mikroislem_o == `MUL_MI) $display("passed"); else $display("MUL: FAILED!: %h", mikroislem_o);
    buyruk_i = `MULH; #10; if(mikroislem_o == `MULH_MI) $display("passed"); else $display("MULH: FAILED!: %h", mikroislem_o);
    buyruk_i = `MULHSU; #10; if(mikroislem_o == `MULHSU_MI) $display("passed"); else $display("MULHSU: FAILED!: %h", mikroislem_o);
    buyruk_i = `MULHU; #10; if(mikroislem_o == `MULHU_MI) $display("passed"); else $display("MULHU: FAILED!: %h", mikroislem_o);
    buyruk_i = `OR; #10; if(mikroislem_o == `OR_MI) $display("passed"); else $display("OR: FAILED!: %h", mikroislem_o);
    buyruk_i = `REM; #10; if(mikroislem_o == `REM_MI) $display("passed"); else $display("REM: FAILED!: %h", mikroislem_o);
    buyruk_i = `REMU; #10; if(mikroislem_o == `REMU_MI) $display("passed"); else $display("REMU: FAILED!: %h", mikroislem_o);
    buyruk_i = `SLL; #10; if(mikroislem_o == `SLL_MI) $display("passed"); else $display("SLL: FAILED!: %h", mikroislem_o);
    buyruk_i = `SLT; #10; if(mikroislem_o == `SLT_MI) $display("passed"); else $display("SLT: FAILED!: %h", mikroislem_o);
    buyruk_i = `SLTU; #10; if(mikroislem_o == `SLTU_MI) $display("passed"); else $display("SLTU: FAILED!: %h", mikroislem_o);
    buyruk_i = `SRA; #10; if(mikroislem_o == `SRA_MI) $display("passed"); else $display("SRA: FAILED!: %h", mikroislem_o);
    buyruk_i = `SRL; #10; if(mikroislem_o == `SRL_MI) $display("passed"); else $display("SRL: FAILED!: %h", mikroislem_o);
    buyruk_i = `SUB; #10; if(mikroislem_o == `SUB_MI) $display("passed"); else $display("SUB: FAILED!: %h", mikroislem_o);
    buyruk_i = `XOR; #10; if(mikroislem_o == `XOR_MI) $display("passed"); else $display("XOR: FAILED!: %h", mikroislem_o);
    buyruk_i = `HMDST; #10; if(mikroislem_o == `HMDST_MI) $display("passed"); else $display("HMDST: FAILED!: %h", mikroislem_o);
    buyruk_i = `PKG; #10; if(mikroislem_o == `PKG_MI) $display("passed"); else $display("PKG: FAILED!: %h", mikroislem_o);
    buyruk_i = `SLADD; #10; if(mikroislem_o == `SLADD_MI) $display("passed"); else $display("SLADD: FAILED!: %h", mikroislem_o);
    buyruk_i = `SLLI; #10; if(mikroislem_o == `SLLI_MI) $display("passed"); else $display("SLLI: FAILED!: %h", mikroislem_o);
    buyruk_i = `SRAI; #10; if(mikroislem_o == `SRAI_MI) $display("passed"); else $display("SRAI: FAILED!: %h", mikroislem_o);
    buyruk_i = `SRLI; #10; if(mikroislem_o == `SRLI_MI) $display("passed"); else $display("SRLI: FAILED!: %h", mikroislem_o);
    buyruk_i = `ADDI; #10; if(mikroislem_o == `ADDI_MI) $display("passed"); else $display("ADDI: FAILED!: %h", mikroislem_o);
    buyruk_i = `ANDI; #10; if(mikroislem_o == `ANDI_MI) $display("passed"); else $display("ANDI: FAILED!: %h", mikroislem_o);
    buyruk_i = `BEQ; #10; if(mikroislem_o == `BEQ_MI) $display("passed"); else $display("BEQ: FAILED!: %h", mikroislem_o);
    buyruk_i = `BGE; #10; if(mikroislem_o == `BGE_MI) $display("passed"); else $display("BGE: FAILED!: %h", mikroislem_o);
    buyruk_i = `BGEU; #10; if(mikroislem_o == `BGEU_MI) $display("passed"); else $display("BGEU: FAILED!: %h", mikroislem_o);
    buyruk_i = `BLT; #10; if(mikroislem_o == `BLT_MI) $display("passed"); else $display("BLT: FAILED!: %h", mikroislem_o);
    buyruk_i = `BLTU; #10; if(mikroislem_o == `BLTU_MI) $display("passed"); else $display("BLTU: FAILED!: %h", mikroislem_o);
    buyruk_i = `BNE; #10; if(mikroislem_o == `BNE_MI) $display("passed"); else $display("BNE: FAILED!: %h", mikroislem_o);
    buyruk_i = `FENCE; #10; if(mikroislem_o == `FENCE_MI) $display("passed"); else $display("FENCE: FAILED!: %h", mikroislem_o);
    buyruk_i = `FENCE_I; #10; if(mikroislem_o == `FENCE_I_MI) $display("passed"); else $display("FENCE_I: FAILED!: %h", mikroislem_o);
    buyruk_i = `JALR; #10; if(mikroislem_o == `JALR_MI) $display("passed"); else $display("JALR: FAILED!: %h", mikroislem_o);
    buyruk_i = `LB; #10; if(mikroislem_o == `LB_MI) $display("passed"); else $display("LB: FAILED!: %h", mikroislem_o);
    buyruk_i = `LBU; #10; if(mikroislem_o == `LBU_MI) $display("passed"); else $display("LBU: FAILED!: %h", mikroislem_o);
    buyruk_i = `LH; #10; if(mikroislem_o == `LH_MI) $display("passed"); else $display("LH: FAILED!: %h", mikroislem_o);
    buyruk_i = `LHU; #10; if(mikroislem_o == `LHU_MI) $display("passed"); else $display("LHU: FAILED!: %h", mikroislem_o);
    buyruk_i = `LW; #10; if(mikroislem_o == `LW_MI) $display("passed"); else $display("LW: FAILED!: %h", mikroislem_o);
    buyruk_i = `ORI; #10; if(mikroislem_o == `ORI_MI) $display("passed"); else $display("ORI: FAILED!: %h", mikroislem_o);
    buyruk_i = `SB; #10; if(mikroislem_o == `SB_MI) $display("passed"); else $display("SB: FAILED!: %h", mikroislem_o);
    buyruk_i = `SH; #10; if(mikroislem_o == `SH_MI) $display("passed"); else $display("SH: FAILED!: %h", mikroislem_o);
    buyruk_i = `SLTI; #10; if(mikroislem_o == `SLTI_MI) $display("passed"); else $display("SLTI: FAILED!: %h", mikroislem_o);
    buyruk_i = `SLTIU; #10; if(mikroislem_o == `SLTIU_MI) $display("passed"); else $display("SLTIU: FAILED!: %h", mikroislem_o);
    buyruk_i = `SW; #10; if(mikroislem_o == `SW_MI) $display("passed"); else $display("SW: FAILED!: %h", mikroislem_o);
    buyruk_i = `XORI; #10; if(mikroislem_o == `XORI_MI) $display("passed"); else $display("XORI: FAILED!: %h", mikroislem_o);
    buyruk_i = `AUIPC; #10; if(mikroislem_o == `AUIPC_MI) $display("passed"); else $display("AUIPC: FAILED!: %h", mikroislem_o);
    buyruk_i = `JAL; #10; if(mikroislem_o == `JAL_MI) $display("passed"); else $display("JAL: FAILED!: %h", mikroislem_o);
    buyruk_i = `LUI; #10; if(mikroislem_o == `LUI_MI) $display("passed"); else $display("LUI: FAILED!: %h", mikroislem_o);
    $finish;
  end

  always
    #5  clk_i = ! clk_i ;

endmodule
