// denetim_durum_birimi.v
`timescale 1ns / 1ps

`include "tanimlamalar.vh"

module denetim_durum_birimi(
    input clk_i,
    input rst_i,

    input [4:0] rs1_adres_coz_i,
    input [4:0] rs2_adres_coz_i,
    input       yaz_yazmac_geriyaz_i,
    input       yaz_yazmac_yurut_i,
    input [4:0] rd_adres_yurut_i,
    input [4:0] rd_adres_geriyaz_i,

    output ddb_kontrol_durdur_coz_o,
    output [1:0]  ddb_kontrol_yonlendir_deger1_o,
    output [1:0]  ddb_kontrol_yonlendir_deger2_o

);


wire [1:0] ddb_kontrol_yonlendir_deger1_w = (rs1_adres_coz_i == rd_adres_yurut_i  ) ? `YON_YURUT :
                                            (rs1_adres_coz_i == rd_adres_geriyaz_i) ? `YON_GERIYAZ :
                                                                                      `YON_HICBISEY;

wire [1:0] ddb_kontrol_yonlendir_deger2_w = (rs2_adres_coz_i == rd_adres_yurut_i  ) ? `YON_YURUT :
                                            (rs2_adres_coz_i == rd_adres_geriyaz_i) ? `YON_GERIYAZ :
                                                                                      `YON_HICBISEY;



always @(posedge clk_i) begin
    ddb_kontrol_yonlendir_deger1_o <= ddb_kontrol_yonlendir_deger1_w;
    ddb_kontrol_yonlendir_deger2_o <= ddb_kontrol_yonlendir_deger2_w;
end
endmodule
