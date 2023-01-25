// denetim_durum_birimi.v
`timescale 1ns / 1ps

`include "tanimlamalar.vh"

module denetim_durum_birimi(
    input clk_i,
    input rst_i,

    // YURUT sinyalleri
    input wire       yrt_yaz_yazmac_i,     // Rd geri yaziliyor ise 1
    input wire       yrt_hazir_i,
    input wire [4:0] yrt_rd_adres_i,       // Rd nin adresi

    // COZ sinyalleri
    input  wire       cyo_gecersiz_buyruk_i,    // exceptionlari nasil implement ediyoruz? CSRS ?
    input  wire [4:0] cyo_rs1_adres_i,          // RS1 adresi
    input  wire [4:0] cyo_rs2_adres_i,          // RS2 adresi
    output wire [1:0] cyo_yonlendir_kontrol1_o, // Yonlendirme(Forwarding) deger1 icin kontrol sinyali
    output wire [1:0] cyo_yonlendir_kontrol2_o, // Yonlendirme(Forwarding) deger2 icin kontrol sinyali
    output wire       cyo_durdur_o,
    output wire       cyo_bosalt_o,

    // GETIR sinyalleri
    input  gtr_bekle_i,               // Getir hazir degil. L1 miss oldu vs. Buyruk gecersiz
    output gtr_durdur_o,
    output gtr_bosalt_o,

    // GERIYAZ sinyalleri
    input       gy_yaz_yazmac_i,   // Rd geri yaziliyor ise 1
    input [4:0] gy_rd_adres_i      // Rd nin adresi
);


    assign  yonlendir_kontrol1_o = (((rs1_adres_coz_i == rd_adres_yurut_i  ) && yaz_yazmac_yurut_i  ) && (rs1_adres_coz_i != 0)) ? `YON_YURUT :
                                   (((rs1_adres_coz_i == rd_adres_geriyaz_i) && yaz_yazmac_geriyaz_i) && (rs1_adres_coz_i != 0)) ? `YON_GERIYAZ :
                                                                                                                                   `YON_HICBISEY;

    assign  yonlendir_kontrol2_o = (((rs2_adres_coz_i == rd_adres_yurut_i  ) && yaz_yazmac_yurut_i  ) && (rs2_adres_coz_i != 0)) ? `YON_YURUT :
                                   (((rs2_adres_coz_i == rd_adres_geriyaz_i) && yaz_yazmac_geriyaz_i) && (rs2_adres_coz_i != 0)) ? `YON_GERIYAZ :
                                                                                                                                   `YON_HICBISEY;

    wire yurut_hazir_degil = (!bolme_bitti_i || !bib_bitti_i || !yapay_zeka_bitti_i || !carpma_bitti_i || !bolme_bitti_i);

    assign durdur_getir_o = yurut_hazir_degil;
    assign durdur_coz_o   = yurut_hazir_degil || getir_bekle_i;

    assign bosalt_getir_o = program_sayaci_gecerli_i ? !tahmin_dogru_i : 1'b0; // Atlama/dallanam varsa ve tahmin yanlissa bosalt. Tahmin dogruysa bosaltma
    assign bosalt_coz_o   = program_sayaci_gecerli_i ? !tahmin_dogru_i : 1'b0;


endmodule
