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
    output wire        l1v_sec_o
);
    reg [ 2:0] kontrol;

    wire [31:0] lh_sonuc = adr_i[1] ? {{16{l1v_veri_i[31]}},l1v_veri_i[31:16]} :
                                      {{16{l1v_veri_i[15]}},l1v_veri_i[15: 0]} ;

    wire [31:0] lhu_sonuc = adr_i[1] ? {{16{1'b0}},l1v_veri_i[31:16]} :
                                       {{16{1'b0}},l1v_veri_i[15: 0]} ;

    wire [31:0] lbu_sonuc = (adr_i[1:0] == 2'b00) ? {{24{1'b0}},l1v_veri_i[ 7: 0]} :
                            (adr_i[1:0] == 2'b01) ? {{24{1'b0}},l1v_veri_i[15: 8]} :
                            (adr_i[1:0] == 2'b10) ? {{24{1'b0}},l1v_veri_i[23:16]} :
                                                    {{24{1'b0}},l1v_veri_i[31:24]} ;

    wire [31:0] lb_sonuc = (adr_i[1:0] == 2'b00) ? {{24{l1v_veri_i[ 7]}},l1v_veri_i[ 7: 0]} :
                           (adr_i[1:0] == 2'b01) ? {{24{l1v_veri_i[15]}},l1v_veri_i[15: 8]} :
                           (adr_i[1:0] == 2'b10) ? {{24{l1v_veri_i[23]}},l1v_veri_i[23:16]} :
                                                   {{24{l1v_veri_i[31]}},l1v_veri_i[31:24]} ;

    assign bitti_o = basla_i ? ~l1v_durdur_i : 1'b1;


    // TODO zaten asagida yapilmis?
    //assign sonuc_o = l1v_veri_i;

    assign l1v_sec_o = basla_i;

    assign l1v_veri_maske_o = (kontrol_i == `BIB_SB)  ? 4'b0001 :
                              (kontrol_i == `BIB_SH)  ? 4'b0011 :
                              (kontrol_i == `BIB_SW)  ? 4'b1111 :
                                                        4'b1111;

    assign l1v_yaz_gecerli_o = basla_i && ((kontrol_i == `BIB_SB) || (kontrol_i == `BIB_SH) || (kontrol_i == `BIB_SW));

    // BIB_LW casei silinebilir?
    assign sonuc_o = (kontrol == `BIB_LB ) ? lb_sonuc   :
                     (kontrol == `BIB_LH ) ? lh_sonuc   :
                     (kontrol == `BIB_LW ) ? l1v_veri_i :
                     (kontrol == `BIB_LBU) ? lbu_sonuc  :
                     (kontrol == `BIB_LHU) ? lhu_sonuc  :
                                            l1v_veri_i  ;


    assign l1v_veri_o = deger_i;
    assign l1v_adr_o  = {adr_i[31:2],2'b0};

    always @(posedge clk_i)begin
        kontrol  <= kontrol_i;
    end

endmodule
