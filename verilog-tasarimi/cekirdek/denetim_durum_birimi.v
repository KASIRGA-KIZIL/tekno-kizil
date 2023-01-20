// denetim_durum_birimi.v
`timescale 1ns / 1ps

`include "tanimlamalar.vh"

module denetim_durum_birimi(
    input clk_i,
    input rst_i,

    input program_sayaci_guncelle_i,

    input coz_gecersiz_buyruk_i, // exceptionlari nasil implement ediyoruz? CSRS ?

    input getir_gecersiz_buyruk_i,

    input tahmin_dogru_i,

    input [4:0] rs1_adres_coz_i,
    input [4:0] rs2_adres_coz_i,

    input       yaz_yazmac_geriyaz_i,
    input [4:0] rd_adres_geriyaz_i,

    input       yaz_yazmac_yurut_i,
    input [4:0] rd_adres_yurut_i,

    input getir_bekle_i,
    input bib_bitti_i,
    input yapay_zeka_bitti_i,
    input carpma_bitti_i,
    input bolme_bitti_i,

    output ddb_kontrol_durdur_getir_o,
    output ddb_kontrol_durdur_coz_o,
    output ddb_kontrol_temizle_getir_o,
    output ddb_kontrol_temizle_coz_o,

    output [1:0]  ddb_kontrol_yonlendir_deger1_o,
    output [1:0]  ddb_kontrol_yonlendir_deger2_o

);


    assign  ddb_kontrol_yonlendir_deger1_o = (((rs1_adres_coz_i == rd_adres_yurut_i  ) && yaz_yazmac_yurut_i  ) && (rs1_adres_coz_i != 0)) ? `YON_YURUT :
                                             (((rs1_adres_coz_i == rd_adres_geriyaz_i) && yaz_yazmac_geriyaz_i) && (rs1_adres_coz_i != 0)) ? `YON_GERIYAZ :
                                                                                                                                             `YON_HICBISEY;

    assign  ddb_kontrol_yonlendir_deger2_o = (((rs2_adres_coz_i == rd_adres_yurut_i  ) && yaz_yazmac_yurut_i  ) && (rs2_adres_coz_i != 0)) ? `YON_YURUT :
                                             (((rs2_adres_coz_i == rd_adres_geriyaz_i) && yaz_yazmac_geriyaz_i) && (rs2_adres_coz_i != 0)) ? `YON_GERIYAZ :
                                                                                                                                             `YON_HICBISEY;

    wire yurut_hazir_degil = (getir_bekle_i || !bolme_bitti_i || !bib_bitti_i || !yapay_zeka_bitti_i || !carpma_bitti_i || !bolme_bitti_i);

    wire ddb_kontrol_durdur_getir_o = yurut_hazir_degil;
    wire ddb_kontrol_durdur_coz_o   = yurut_hazir_degil || getir_gecersiz_buyruk_i;

    ddb_kontrol_temizle_getir_o = tahmin_dogru_i ? 1'b0 : program_sayaci_guncelle_o;
    ddb_kontrol_temizle_coz_o   = tahmin_dogru_i ? 1'b0 : program_sayaci_guncelle_o;


endmodule
