// denetim_durum_birimi.v
`timescale 1ns / 1ps

`include "tanimlamalar.vh"

module denetim_durum_birimi(
    input clk_i,
    input rst_i,

    input [4:0] rs1_adres_coz_i,
    input [4:0] rs2_adres_coz_i,

    input       yaz_yazmac_geriyaz_i,
    input [4:0] rd_adres_geriyaz_i,

    input       yaz_yazmac_yurut_i,
    input [4:0] rd_adres_yurut_i,

    input getir_bekle_i,
    input bib_bekle_i,
    input carpma_bitti_i,
    input bolme_bitti_i,

    output ddb_kontrol_durdur_getir_o,
    output ddb_kontrol_temizle_getir_o,
    output ddb_kontrol_temizle_coz_o,

    output [1:0]  ddb_kontrol_yonlendir_deger1_o,
    output [1:0]  ddb_kontrol_yonlendir_deger2_o

);


    wire [1:0] ddb_kontrol_yonlendir_deger1_w = (rs1_adres_coz_i == rd_adres_yurut_i  ) ? `YON_YURUT :
                                                (rs1_adres_coz_i == rd_adres_geriyaz_i) ? `YON_GERIYAZ :
                                                                                        `YON_HICBISEY;

    wire [1:0] ddb_kontrol_yonlendir_deger2_w = (rs2_adres_coz_i == rd_adres_yurut_i  ) ? `YON_YURUT :
                                                (rs2_adres_coz_i == rd_adres_geriyaz_i) ? `YON_GERIYAZ :
                                                                                        `YON_HICBISEY;

    wire ddb_kontrol_durdur_getir_o = (!carpma_bitti_i || !bolme_bitti_i)


    always @(posedge clk_i) begin
        if (rst_i) begin
            ddb_kontrol_yonlendir_deger1_o <= `YON_HICBISEY;
            ddb_kontrol_yonlendir_deger2_o <= `YON_HICBISEY;
        end
        else begin
            ddb_kontrol_yonlendir_deger1_o <= ddb_kontrol_yonlendir_deger1_w;
            ddb_kontrol_yonlendir_deger2_o <= ddb_kontrol_yonlendir_deger2_w;
        end
    end

endmodule
