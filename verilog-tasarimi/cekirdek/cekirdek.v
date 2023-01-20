// cekirdek.v
`timescale 1ns / 1ps

`include "tanimlamalar.vh"

module cekirdek(
    input clk_i,
    input rst_i,

    input [31:0] l1b_buyruk_i,
    input l1b_buyruk_gecerli_i,
    input l1b_hazir_i,
    
    input [31:0] program_sayaci_i,

    input [31:0] oku_veri_i,
    input oku_veri_gecerli_i,

    output [31:0] l1b_ps_o,
    output l1b_ps_gecerli_o
    
);

    wire [31:0] coz_ps_w;
    wire [31:0] coz_buyruk_w;
    wire coz_gecerli_w;
    wire coz_buyruk_compressed_w;

    wire [4:0] rd_adres_w;
    wire [31:0] deger1_w;
    wire [31:0] deger2_w;
    wire [2:0] lt_ltu_eq_w;
    wire [31:0] program_sayaci_artmis_w;
    wire yz_en_w;

    wire [MI_BIT-1:0] mikroislem_w;

    wire [4:0] yrt_rd_adres_w;
    wire [31:0] yrt_rd_deger_w;
    wire yrt_yaz_yazmac_w;
    wire [31:0] yrt_program_sayaci_artmis_w;

    wire [4:0] yaz_adres_w;
    wire [31:0] yaz_deger_w;
    wire yaz_yazmac_w;


    denetim_durum_birimi ddb(
        .clk_i(clk_i),
        .rst_i(rst_i),

        .rs1_adres_coz_i(),
        .rs2_adres_coz_i(),
        .yaz_yazmac_geriyaz_i(),
        .yaz_yazmac_yurut_i(),
        .rd_adres_yurut_i(),
        .rd_adres_geriyaz_i(),

        .ddb_kontrol_durdur_coz_o(),
        .ddb_kontrol_yonlendir_deger1_o(),
        .ddb_kontrol_yonlendir_deger2_o()
    );

    getir gtr(
        .clk_i(clk_i),
        .rst_i(rst_i),
        // denetim durum birimi sinyalleri 
        .ddb_ps_al_gecerli_i(),
        .ddb_ps_al_i(),
        // onbellekten gelen guncelleme sinyalleri 
        .l1b_buy_i(l1b_buyruk_i),
        .l1b_gecerli_i(l1b_buyruk_gecerli_i),
        .l1b_hazir_i(l1b_hazir_i),
        .l1b_duraklat_i(),
        .l1b_oku_adres_kabul_i(), // buna gerek olmayabilir
        // yurutten gelen dallanma guncelleme bitleri
        .y_guncelleme_gecerli_i(),
        .y_yanlis_ongoru_i(),
        .y_atladi_i(),
        .y_dallanma_ps_i(), 
        .y_atlanan_ps_i(),
        .y_buy_i(),
        .y_siradaki_ps_gecerli_i(),
        .y_siradaki_ps_i(),
        // coz'e giden cikis sinyalleri
        // Not: ongoru varsa vermek gerekebilir?  
        .coz_ps_o(coz_ps_w),
        .coz_buy_o(coz_buyruk_w), //Not: butun buyruklarin en onemsiz iki biti 2'b11
        .coz_gecerli_o(coz_gecerli_w), 
        .coz_buyruk_compressed_o(coz_buyruk_compressed_w),  
        // onbellege giden cikis sinyalleri   
        .l1b_ps_o(l1b_ps_o),
        .l1b_ps_gecerli_o(l1b_ps_gecerli_o)
    );

    coz_yazmacoku cyo(
        .clk_i(clk_i),
        .rst_i(rst_i),

        // compressed buyruklar getirde normal buyruklara donusturulecek
        .buyruk_i(coz_buyruk_w),
        .buyruk_gecerli_i(coz_gecerli_w),
        //.program_sayaci_i(coz_ps_w)),

        // geri yazdan gelenler
        .yaz_adres_i(yaz_adres_w),
        .yaz_deger_i(yaz_deger_w),
        .yaz_yazmac_i(yaz_yazmac_w),

        .mikroislem_o(mikroislem_w),

        .rd_adres_o(rd_adres_w), // geri yaza kadar gitmesi lazim
        //.yaz_yazmac_o(),     // geri yaza kadar gitmesi lazim

        .deger1_o(deger1_w), // her seyi secilmis ALU'lara giden iki deger
        .deger2_o(deger2_w),

        // Branch buyruklari icin gerekli (if(r1<r2) rd=pc+imm) vs.
        .lt_ltu_eq_o(lt_ltu_eq_w),  // degerler arasindaki iliski. lt:lessthan, ltu: lessthan_unsigned, eq: equal

        // DDB yonlendirme sinyalleri ve geriyaz/yurut bolumunden veri yonlendirmeleri
        .ddb_kontrol_yonlendir_deger1_i(),
        .ddb_kontrol_yonlendir_deger2_i(),

        .yonlendir_geri_yaz_deger_i(),
        .yonlendir_yurut_deger_i(),

        // coz_ps_w yi yurute vermek icin bir asama cekirdekte bekletsek daha iyi olmaz mi?
        // aynisi diger degisime ugramadan gecen degerler icin?
        .program_sayaci_artmis_i(coz_ps_w), // geri yaza kadar gitmesi lazim
        .program_sayaci_artmis_o(program_sayaci_artmis_w), // geri yaza kadar gitmesi lazim

        .output reg yz_en_o(yz_en_w)
    );

    yurut yrt(
        .clk_i(clk_i),
        .rst_i(rst_i),

        .mikroislem_i(mikroislem_w),
        //.yaz_yazmac_i(),

        .rd_adres_i(rd_adres_w),               // geri yaza kadar gitmesi lazim
        .program_sayaci_artmis_i(program_sayaci_artmis_w),  // geri yaza kadar gitmesi lazim

        .deger1_i(deger1_w), // anlik/yazmac vs. secilmis son ALU girdileri
        .deger2_i(deger2_w),

        // jump ve branch icin
        .lt_ltu_eq_i(lt_ltu_eq_w),        // degerler arasindaki iliski. lt_ltu_i[0]: lessthan r1<r2, lt_ltu_i[1]: lt unsigned r1<r2 unsigned

        .program_sayaci_o(),  // ayni cevrimde gitmeli
        .program_sayaci_guncelle_o(), // ayni cevrimde gitmeli

        .yz_en_i(yz_en_w), // yapay zeka icin enable biti

        .rd_adres_o(yrt_rd_adres_w),              // geri yaza kadar gitmesi lazim
        .program_sayaci_artmis_o(yrt_program_sayaci_artmis_w), // geri yaza kadar gitmesi lazim

        .rd_deger_o(yrt_rd_deger_w), // islem birimlerinden cikan sonuc
        .yaz_yazmac_o(yrt_yaz_yazmac_w)
    );

    geri_yaz gy(
        .clk_i(clk_i),
        .rst_i(rst_i),

        .sec_geri_yaz_i(),

        .rd_adres_i(yrt_rd_adres_w),
        .rd_deger_i(yrt_rd_deger_w),
        .yaz_yazmac_i(yrt_yaz_yazmac_w),

        .bib_deger_i(),
        .program_sayaci_artmis_i(yrt_program_sayaci_artmis_w),

        .yaz_adres_o(yaz_adres_w),
        .yaz_deger_o(yaz_deger_w),
        .yaz_yazmac_o(yaz_yazmac_w)
    );


endmodule
