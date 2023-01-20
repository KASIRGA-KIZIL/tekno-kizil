// aritmetik_mantik_birimi.v
`timescale 1ns / 1ps

`include "tanimlamalar.vh"


module aritmetik_mantik_birimi(
    // kontrol sinyalleri
    input  wire [ 3:0] kontrol,
    // veri sinyalleri
    input  wire [31:0] deger1_i,
    input  wire [31:0] deger2_i,

    input  wire [ 2:0] lt_ltu_i,  // degerler arasindaki iliski. lt:lessthan, ltu: lessthan_unsigned
    output wire [31:0] sonuc_o
);
    // Mantik sinyalleri
    wire [31:0] sonuc_xor;
    wire [31:0] sonuc_or;
    wire [31:0] sonuc_and;
    wire [31:0] sonuc_sll;
    wire [31:0] sonuc_srl;
    wire [31:0] sonuc_sra;
    wire [31:0] sonuc_slt;
    wire [31:0] sonuc_sltu;

    // Aritmetik Sinyalleri
    wire [31:0] deger2_cla;
    wire [31:0] sonuc_cla;
    wire  elde_cla = (kontrol == `AMB_CIKARMA);

    carry_lookahead_toplayici carry_lookahead_toplayici_dut (
        .a_i (deger1_i ),
        .b_i (deger2_cla ),
        .giren_elde_i (elde_cla ),
        .toplam_o  ( sonuc_cla)
      );

    assign deger2_cla = (kontrol == `AMB_CIKARMA) ? ~deger2_i : deger2_i;

    assign sonuc_xor  =  deger1_i  ^   deger2_i;
    assign sonuc_or   =  deger1_i  |   deger2_i;
    assign sonuc_and  =  deger1_i  &   deger2_i;
    assign sonuc_sll  =  deger1_i  <<  deger2_i;
    assign sonuc_srl  =  deger1_i  >>  deger2_i;
    assign sonuc_sra  =  deger1_i  >>> deger2_i;
    assign sonuc_slt  = (deger1_i  <   deger2_i) ? {31'b0,lt_ltu_i[0]} : 32'b0;
    assign sonuc_sltu = ($signed(deger1_i)  <   $signed(deger2_i)) ? {31'b0,lt_ltu_i[1]}  : 32'b0;

    assign sonuc_o = (kontrol == `AMB_CIKARMA) | (kontrol == `AMB_TOPLAMA) ? sonuc_cla :
                     (kontrol == `AMB_XOR    )                             ? sonuc_xor :
                     (kontrol == `AMB_OR     )                             ? sonuc_or  :
                     (kontrol == `AMB_AND    )                             ? sonuc_and :
                     (kontrol == `AMB_SLL    )                             ? sonuc_sll :
                     (kontrol == `AMB_SRL    )                             ? sonuc_srl :
                     (kontrol == `AMB_SRA    )                             ? sonuc_sra :
                     (kontrol == `AMB_SLT    )                             ? sonuc_slt :
                     (kontrol == `AMB_SLTU   )                             ? sonuc_sltu:
                                                                             32'bx;

endmodule
