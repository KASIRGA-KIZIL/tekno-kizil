// bellek_islem_birimi.v
`timescale 1ns / 1ps

`include "tanimlamalar.vh"

module bellek_islem_birimi(
    input  wire clk_i,
    input  wire rst_i,
    input  wire basla_i,
    output wire bitti_o,

    // yurut
    input  wire [ 2:0] kontrol_i,
    input  wire [31:0] adr_i,
    input  wire [31:0] deger_i,
    output wire [31:0] sonuc_o,

    // l1 veri bellegi <-> bib
    input  wire [31:0] l1v_veri_i,
    input  wire        l1v_durdur_i,
    output wire [31:0] l1v_veri_o,
    output wire [31:0] l1v_adr_o,
    output wire [ 3:0] l1v_veri_maske_o,
    output wire        l1v_yaz_gecerli_o,
    output wire        l1v_sec_n_o
);
    reg [ 2:0] kontrol;

    assign bitti_o = basla_i ? ~l1v_durdur_i : 1'b1;


    // TODO zaten asagida yapilmis?
    //assign sonuc_o = l1v_veri_i;

    assign l1v_sec_n_o = ~basla_i;

    assign l1v_veri_maske_o = (kontrol_i == `BIB_SB)  ? 4'b0001 :
                              (kontrol_i == `BIB_SH)  ? 4'b0011 :
                              (kontrol_i == `BIB_SW)  ? 4'b1111 :
                                                        4'b1111;

    assign l1v_yaz_gecerli_o = basla_i && ((kontrol_i == `BIB_SB) || (kontrol_i == `BIB_SH) || (kontrol_i == `BIB_SW));

    // BIB_LW casei silinebilir?
    assign sonuc_o = (kontrol == `BIB_LB ) ? {{24{l1v_veri_i[ 7]}},l1v_veri_i[7:0]}  :
                     (kontrol == `BIB_LH ) ? {{16{l1v_veri_i[15]}},l1v_veri_i[15:0]} :
                     (kontrol == `BIB_LW ) ? l1v_veri_i                              :
                     (kontrol == `BIB_LBU) ? {24'b0,l1v_veri_i[ 7:0]}                :
                     (kontrol == `BIB_LHU) ? {16'b0,l1v_veri_i[15:0]}                :
                                              l1v_veri_i;

    assign l1v_veri_o = deger_i;
    assign l1v_adr_o  = adr_i;

    always @(posedge clk_i)begin
        kontrol  <= kontrol_i;
    end

endmodule
