// denetim_durum_birimi.v
`timescale 1ns / 1ps

`include "tanimlamalar.vh"

module denetim_durum_birimi(
    input clk_i,
    input rst_i,

    // YURUT sinyalleri
    input program_sayaci_gecerli_i,     // Dallanma veya atlama varsa 1
    input tahmin_dogru_i,               // Dallanma ongorucu dogru tahmin ettiyse 1
    input yaz_yazmac_yurut_i,           // Rd geri yaziliyor ise 1
    input [4:0] rd_adres_yurut_i,       // Rd nin adresi
    input bib_bitti_i,                  // Bellek islem birimi bitik
    input yapay_zeka_bitti_i,           // Yapay zeka birimi bitik
    input carpma_bitti_i,               // Carpma birimi bitik
    input bolme_bitti_i,                // Bolme birimi bitik

    // COZ sinyalleri
    input  coz_gecersiz_buyruk_i,       // exceptionlari nasil implement ediyoruz? CSRS ?
    input  [4:0] rs1_adres_coz_i,       // RS1 adresi
    input  [4:0] rs2_adres_coz_i,       // RS2 adresi
    output [1:0] yonlendir_deger1_o,    // Yonlendirme(Forwarding) deger1 icin kontrol sinyali
    output [1:0] yonlendir_deger2_o,    // Yonlendirme(Forwarding) deger2 icin kontrol sinyali
    output durdur_coz_o,
    output bosalt_coz_o,

    // GETIR sinyalleri
    input  getir_bekle_i,               // Getir hazir degil. L1 miss oldu vs. Buyruk gecersiz
    output durdur_getir_o,
    output bosalt_getir_o,

    // GERIYAZ sinyalleri
    input       yaz_yazmac_geriyaz_i,   // Rd geri yaziliyor ise 1
    input [4:0] rd_adres_geriyaz_i      // Rd nin adresi
);


    assign  yonlendir_deger1_o = (((rs1_adres_coz_i == rd_adres_yurut_i  ) && yaz_yazmac_yurut_i  ) && (rs1_adres_coz_i != 0)) ? `YON_YURUT :
                                 (((rs1_adres_coz_i == rd_adres_geriyaz_i) && yaz_yazmac_geriyaz_i) && (rs1_adres_coz_i != 0)) ? `YON_GERIYAZ :
                                                                                                                                 `YON_HICBISEY;

    assign  yonlendir_deger2_o = (((rs2_adres_coz_i == rd_adres_yurut_i  ) && yaz_yazmac_yurut_i  ) && (rs2_adres_coz_i != 0)) ? `YON_YURUT :
                                 (((rs2_adres_coz_i == rd_adres_geriyaz_i) && yaz_yazmac_geriyaz_i) && (rs2_adres_coz_i != 0)) ? `YON_GERIYAZ :
                                                                                                                                 `YON_HICBISEY;

    wire yurut_hazir_degil = (!bolme_bitti_i || !bib_bitti_i || !yapay_zeka_bitti_i || !carpma_bitti_i || !bolme_bitti_i);

    assign durdur_getir_o = yurut_hazir_degil;
    assign durdur_coz_o   = yurut_hazir_degil || getir_bekle_i;

    assign bosalt_getir_o = program_sayaci_gecerli_i ? !tahmin_dogru_i : 1'b0; // Atlama/dallanam varsa ve tahmin yanlissa bosalt. Tahmin dogruysa bosaltma
    assign bosalt_coz_o   = program_sayaci_gecerli_i ? !tahmin_dogru_i : 1'b0;


endmodule
