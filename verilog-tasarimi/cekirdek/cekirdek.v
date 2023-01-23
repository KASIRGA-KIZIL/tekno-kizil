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

    wire [ 4:0] gy_yaz_adres_w;
    wire [31:0] gy_yaz_deger_w;
    wire        gy_yaz_yazmac_w;

    wire [31:0] yrt_yeni_program_sayaci_w;
    wire        yrt_program_sayaci_gecerli_w;
    wire [31:0] yrt_yurut_program_sayac_w;
    wire        yrt_tahmin_dogru_w;
    wire [ 1:0] yrt_buyruk_tipi_w;
    wire [31:0] yrt_program_sayaci_w;
    wire [ 4:0] yrt_rd_adres_w;
    wire [31:0] yrt_program_sayaci_artmis_w;
    wire [31:0] yrt_rd_deger_w;
    wire [31:0] yrt_bib_deger_w;
    wire [ 2:0] yrt_mikroislem_w;
    wire [31:0] yrt_yonlendir_deger_w;

    wire [`MI_BIT-1:0] cyo_mikroislem_w;
    wire [31:0] cyo_deger1_w;
    wire [31:0] cyo_deger2_w;
    wire [ 2:0] cyo_lt_ltu_eq_w;
    wire [ 1:0] cyo_buyruk_tipi_w;
    wire [31:0] cyo_program_sayaci_artmis_w;
    wire [ 4:0] cyo_rd_adres_w;
    wire        cyo_yapay_zeka_en_w;
    wire [ 4:0] cyo_rs1_adres_w;
    wire [ 4:0] cyo_rs2_adres_w;
    wire        cyo_gecersiz_buyruk_w;

    wire [1:0] ddb_yonlendir_deger1_w;
    wire [1:0] ddb_yonlendir_deger2_w;
    wire       ddb_durdur_coz_w;
    wire       ddb_bosalt_coz_w;
    wire       ddb_durdur_getir_w;
    wire       ddb_bosalt_getir_w;


    denetim_durum_birimi ddb (
        .clk_i (clk_i),
        .rst_i (rst_i),
        // YURUT sinyalleri
        .program_sayaci_gecerli_i (yrt_program_sayaci_gecerli_w),
        .tahmin_dogru_i           (yrt_tahmin_dogru_w          ),
        .yaz_yazmac_yurut_i       (cyo_mikroislem_w[`YAZMAC]   ),
        .rd_adres_yurut_i         (cyo_rd_adres_w              ),
        .bib_bitti_i              (yrt_bib_bitti_w             ),
        .yapay_zeka_bitti_i       (yrt_yapay_zeka_bitti_w      ),
        .carpma_bitti_i           (yrt_carpma_bitti_w          ),
        .bolme_bitti_i            (yrt_bolme_bitti_w           ),
        // COZ sinyalleri
        .coz_gecersiz_buyruk_i (cyo_gecersiz_buyruk_w ),
        .rs1_adres_coz_i       (cyo_rs1_adres_w       ),
        .rs2_adres_coz_i       (cyo_rs2_adres_w       ),
        .yonlendir_deger1_o    (ddb_yonlendir_deger1_w),
        .yonlendir_deger2_o    (ddb_yonlendir_deger2_w),
        .durdur_coz_o          (ddb_durdur_coz_w      ),
        .bosalt_coz_o          (ddb_bosalt_coz_w      ),
        // GETIR sinyalleri
        .getir_bekle_i  (gtr_getir_bekle_w ),
        .durdur_getir_o (ddb_durdur_getir_w),
        .bosalt_getir_o (ddb_bosalt_getir_w),
        // GERIYAZ sinyalleri
        .yaz_yazmac_geriyaz_i (gy_yaz_yazmac_w),
        .rd_adres_geriyaz_i   (gy_yaz_adres_w )
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

    coz_yazmacoku cyo ( // OK
        .clk_i (clk_i),
        .rst_i (rst_i),
        // GETIR'den gelen sinyaller
        .buyruk_i         (gtr_buyruk_W        ),
        .program_sayaci_i (gtr_program_sayaci_W),
        // YURUT'e giden sinyaller
        .mikroislem_o     (cyo_mikroislem_w ),
        .deger1_o         (cyo_deger1_w     ),
        .deger2_o         (cyo_deger2_w     ),
        .lt_ltu_eq_o      (cyo_lt_ltu_eq_w  ),
        .buyruk_tipi_o    (cyo_buyruk_tipi_w),
        // GERIYAZ'a kadar giden sinyaller
        .program_sayaci_artmis_i (gtr_program_sayaci_artmis_w),
        .program_sayaci_artmis_o (cyo_program_sayaci_artmis_w),
        .rd_adres_o              (cyo_rd_adres_w             ),
        // GERIYAZ'dan gelen sinyaller
        .yaz_adres_i  (gy_yaz_adres_w ),
        .yaz_deger_i  (gy_yaz_deger_w ),
        .yaz_yazmac_i (gy_yaz_yazmac_w),
        // Yonlendirme (Forwarding) sinyalleri
        .yonlendir_geriyaz_deger_i (gy_yonlendir_geriyaz_deger_w),
        .yonlendir_yurut_deger_i   (yrt_yonlendir_deger_w       ),
        // Denetim Durum Birimi sinyalleri
        .durdur_i           (ddb_durdur_coz_w      ),
        .bosalt_i           (ddb_bosalt_coz_w      ),
        .yonlendir_deger1_i (ddb_yonlendir_deger1_w),
        .yonlendir_deger2_i (ddb_yonlendir_deger2_w),
        .rs1_adres_o        (cyo_rs1_adres_w       ),
        .rs2_adres_o        (cyo_rs2_adres_w       ),
        .gecersiz_buyruk_o  (cyo_gecersiz_buyruk_w )
    );

    yurut yrt (
        .clk_i (clk_i ),
        .rst_i (rst_i ),
        // Veri yolu icin
        .mikroislem_i            (cyo_mikroislem_w           ),
        .rd_adres_i              (cyo_rd_adres_w             ),
        .program_sayaci_artmis_i (cyo_program_sayaci_artmis_w),
        .deger1_i                (cyo_deger1_w               ),
        .deger2_i                (cyo_deger2_w               ),
        .yapay_zeka_en_i         (cyo_yapay_zeka_en_w        ),
        // Branch ve Jump buyruklari icin. Hepsi ayni cevrimde gidecek
        .lt_ltu_eq_i              (cyo_lt_ltu_eq_w             ),
        .buyruk_tipi_i            (cyo_buyruk_tipi_w           ),
        .yeni_program_sayaci_o    (yrt_yeni_program_sayaci_w   ),
        .program_sayaci_gecerli_o (yrt_program_sayaci_gecerli_w),
        // Dallanma Ongorucu icin. Hepsi ayni cevrimde gidecek
        .program_sayaci_i      (cyo_program_sayaci_w     ),
        .coz_program_sayaci_i  (cyo_coz_program_sayaci_w ),
        .yurut_program_sayac_o (yrt_yurut_program_sayac_w),
        .tahmin_dogru_o        (yrt_tahmin_dogru_w       ),
        .buyruk_tipi_o         (yrt_buyruk_tipi_w        ),
        .program_sayaci_o      (yrt_program_sayaci_w     ),
        // GERIYAZ icin
        .rd_adres_o              (yrt_rd_adres_w             ),
        .program_sayaci_artmis_o (yrt_program_sayaci_artmis_w),
        .rd_deger_o              (yrt_rd_deger_w             ),
        .mikroislem_o            (yrt_mikroislem_w           ),
        .bib_deger_o             (yrt_bib_deger_w            ),
        .yonlendir_deger_o       (yrt_yonlendir_deger_w      )
    );

    geri_yaz gy ( // OK
        .clk_i (clk_i),
        .rst_i (rst_i),
        // YURUT'ten gelenler
        .rd_adres_i              (yrt_rd_adres_w),
        .rd_deger_i              (yrt_rd_deger_w),
        .mikroislem_i            (yrt_mikroislem_w),
        .bib_deger_i             (yrt_bib_deger_w),
        .program_sayaci_artmis_i (yrt_program_sayaci_artmis_w),
        // COZ'e gidenler
        .yaz_adres_o  (gy_yaz_adres_w ),
        .yaz_deger_o  (gy_yaz_deger_w ),
        .yaz_yazmac_o (gy_yaz_yazmac_w)
    );

    /*
    reg [31:0] yurutegirenps;
    reg [31:0] ps_temp;
    
    // ayri bir ps boru hatti olsun burada
    //ps4
    //ps2
    //psimm
    // getirde hesaplansin cekirdekten output olarak islemciye ciksin
    
    
    always @(posedge clk_i) begin
        ps_temp <= getir_ps;
        yurutegirenps <= ps_temp;
    end
    */
    
    
endmodule










