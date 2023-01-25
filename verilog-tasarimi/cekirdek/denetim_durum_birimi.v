// denetim_durum_birimi.v
`timescale 1ns / 1ps

`include "tanimlamalar.vh"

module denetim_durum_birimi(
    // GETIR sinyalleri
    input  wire gtr_yanlis_tahmin_i,       // Dallanma ongorucu, ongoremedi
    input  wire gtr_hazir_i,               // Getir hazir degil. L1 miss oldu vs. Buyruk gecersiz
    output wire gtr_durdur_o,
    output wire gtr_bosalt_o,

    // COZ sinyalleri
    input  wire       cyo_gecersiz_buyruk_i,    // exceptionlari nasil implement ediyoruz? CSRS ?
    input  wire [4:0] cyo_rs1_adres_i,          // RS1 adresi
    input  wire [4:0] cyo_rs2_adres_i,          // RS2 adresi
    output wire [1:0] cyo_yonlendir_kontrol1_o, // Yonlendirme(Forwarding) deger1 icin kontrol sinyali
    output wire [1:0] cyo_yonlendir_kontrol2_o, // Yonlendirme(Forwarding) deger2 icin kontrol sinyali
    output wire       cyo_durdur_o,
    output wire       cyo_bosalt_o,

    // YURUT sinyalleri
    input wire       yrt_yaz_yazmac_i,     // Rd geri yaziliyor ise 1
    input wire       yrt_hazir_i,          // Birden fazla cevrim suren bolme vs. icin
    input wire [4:0] yrt_rd_adres_i,       // Rd nin adresi

    // GERIYAZ sinyalleri
    input       gy_yaz_yazmac_i,   // Rd geri yaziliyor ise 1
    input [4:0] gy_rd_adres_i      // Rd nin adresi
);


    assign  cyo_yonlendir_kontrol1_o = (((cyo_rs1_adres_i == yrt_rd_adres_i) && yrt_yaz_yazmac_i) && (cyo_rs1_adres_i != 0)) ? `YON_YURUT :
                                       (((cyo_rs1_adres_i == gy_rd_adres_i ) && gy_yaz_yazmac_i ) && (cyo_rs1_adres_i != 0)) ? `YON_GERIYAZ :
                                                                                                                               `YON_HICBISEY;

    assign  cyo_yonlendir_kontrol2_o = (((cyo_rs2_adres_i == yrt_rd_adres_i) && yrt_yaz_yazmac_i) && (cyo_rs2_adres_i != 0)) ? `YON_YURUT :
                                       (((cyo_rs2_adres_i == gy_rd_adres_i ) && gy_yaz_yazmac_i ) && (cyo_rs2_adres_i != 0)) ? `YON_GERIYAZ :
                                                                                                                               `YON_HICBISEY;

    assign gtr_durdur_o = ~yrt_hazir_i;
    assign cyo_durdur_o = ~yrt_hazir_i || ~gtr_hazir_i;

    assign gtr_bosalt_o = gtr_yanlis_tahmin_i ;
    assign cyo_bosalt_o = gtr_yanlis_tahmin_i ;


endmodule
