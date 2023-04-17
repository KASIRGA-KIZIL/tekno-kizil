// cekirdek.v
`timescale 1ns / 1ps

`include "tanimlamalar.vh"

// COZ-YAZMAC-OKU + YURUT + GERI-YAZ
module arka_taraf(
   input wire clk_i,
   input wire rst_i,
   
   // getir arayuzu
   output wire        gtr_durdur_w,
   output wire        gtr_bosalt_w,
   input  wire        gtr_hazir_w,
   input  wire        gtr_yanlis_tahmin_w,
   output wire [18:1] gtr_atlanan_ps_w,
   output wire        gtr_atlanan_ps_gecerli_w,
   input  wire [31:0] cyo_buyruk_w,
   input  wire [18:1] cyo_ps_artmis_w,
   input  wire [18:1] cyo_ps_w,
   
   // Bellek Islem Birimi
   input  wire [31:0] bib_veri_i,
   input  wire        bib_durdur_i,
   output wire [31:0] bib_veri_o,
   output wire [31:0] bib_adr_o,
   output wire [ 3:0] bib_veri_maske_o,
   output wire        bib_sec_o
);

   wire yrt_durdur_w;
   wire yrt_yonlendir_gecersiz_w;
   
   wire [`MI_BIT-1:0] yrt_mikroislem_w;
   wire [       31:0] yrt_deger1_w;
   wire [       31:0] yrt_deger2_w;
   wire [        2:0] yrt_lt_ltu_eq_w;
   wire [       18:1] yrt_ps_artmis_w;
   wire [        4:0] yrt_rd_adres_w;
   wire               yrt_yapay_zeka_en_w;
   wire [       31:0] yrt_rs2_w;

   wire [18:1] gy_ps_artmis_w;
   wire [31:0] gy_rd_deger_w;
   wire [ 2:0] gy_mikroislem_w;
   wire [31:0] gy_carp_deger_w;
   wire [31:0] cyo_yonlendir_deger_w;
   
   wire [ 4:0] cyo_yaz_adres_w;
   wire [31:0] cyo_yaz_deger_w;
   wire        cyo_yaz_yazmac_w;
   
   wire [1:0] cyo_yonlendir_kontrol1_w;
   wire [1:0] cyo_yonlendir_kontrol2_w;
   wire       cyo_durdur_w;
   wire       cyo_bosalt_w;
   
   
   wire [4:0] cyo_rs1_adres_w;
   wire [4:0] cyo_rs2_adres_w;
   
   wire yrt_hazir_w;
   
   wire [4:0] gy_rd_adres_w;
   
   geri_yaz geri_yaz_dut (
      .yrt_rd_adres_i   (gy_rd_adres_w    ),
      .yrt_rd_deger_i   (gy_rd_deger_w    ),
      .yrt_mikroislem_i (gy_mikroislem_w  ),
      .yrt_ps_artmis_i  (gy_ps_artmis_w   ),
      .yrt_carp_deger_i (gy_carp_deger_w ),
      .cyo_yaz_adres_o  (cyo_yaz_adres_w),
      .cyo_yaz_deger_o  (cyo_yaz_deger_w),
      .cyo_yaz_yazmac_o (cyo_yaz_yazmac_w)
   );
   
   yurut yurut_dut (
      .clk_i                    (clk_i ),
      .rst_i                    (rst_i ),
      .ddb_durdur_i             (yrt_durdur_w ),
      .ddb_hazir_o              (yrt_hazir_w),
      .ddb_yonlendir_gecersiz_o (yrt_yonlendir_gecersiz_w),
      
      .cyo_mikroislem_i         (yrt_mikroislem_w      ),
      .cyo_rd_adres_i           (yrt_rd_adres_w        ),
      .cyo_ps_artmis_i          (yrt_ps_artmis_w       ),
      .cyo_deger1_i             (yrt_deger1_w          ),
      .cyo_deger2_i             (yrt_deger2_w          ),
      .cyo_yapay_zeka_en_i      (yrt_yapay_zeka_en_w   ),
      .cyo_rs2_i                (yrt_rs2_w          ),
      .cyo_lt_ltu_eq_i          (yrt_lt_ltu_eq_w    ),
      .gtr_atlanan_ps_o         (gtr_atlanan_ps_w        ),
      .gtr_atlanan_ps_gecerli_o (gtr_atlanan_ps_gecerli_w),
      .gy_rd_adres_o            (gy_rd_adres_w  ),
      .gy_ps_artmis_o           (gy_ps_artmis_w ),
      .gy_rd_deger_o            (gy_rd_deger_w  ),
      .gy_mikroislem_o          (gy_mikroislem_w),
      .gy_carp_deger_o          (gy_carp_deger_w),
      .cyo_yonlendir_deger_o    (cyo_yonlendir_deger_w),
      .bib_veri_i               (bib_veri_i        ),
      .bib_durdur_i             (bib_durdur_i      ),
      .bib_veri_o               (bib_veri_o        ),
      .bib_adr_o                (bib_adr_o         ),
      .bib_veri_maske_o         (bib_veri_maske_o  ),
      .bib_sec_o                (bib_sec_o       )
   );
   
   coz_yazmacoku coz_yazmacoku_dut (
      .clk_i                    (clk_i ),
      .rst_i                    (rst_i ),
      
      .gtr_buyruk_i             (cyo_buyruk_w    ),
      .gtr_ps_i                 (cyo_ps_w        ),
      .gtr_ps_artmis_i          (cyo_ps_artmis_w ),
      .yrt_mikroislem_o         (yrt_mikroislem_w     ),
      .yrt_deger1_o             (yrt_deger1_w         ),
      .yrt_deger2_o             (yrt_deger2_w         ),
      .yrt_lt_ltu_eq_o          (yrt_lt_ltu_eq_w      ),
      .yrt_yapay_zeka_en_o      (yrt_yapay_zeka_en_w  ),
      .yrt_rs2_o                (yrt_rs2_w            ),
      .yrt_ps_artmis_o          (yrt_ps_artmis_w      ),
      .yrt_rd_adres_o           (yrt_rd_adres_w       ),
      .yrt_yonlendir_deger_i    (cyo_yonlendir_deger_w),
      .gy_yaz_adres_i           (cyo_yaz_adres_w ),
      .gy_yaz_deger_i           (cyo_yaz_deger_w ),
      .gy_yaz_yazmac_i          (cyo_yaz_yazmac_w),
      
      .ddb_durdur_i             (cyo_durdur_w ),
      .ddb_bosalt_i             (cyo_bosalt_w ),
      .ddb_yonlendir_kontrol1_i (cyo_yonlendir_kontrol1_w ),
      .ddb_yonlendir_kontrol2_i (cyo_yonlendir_kontrol2_w ),
      .ddb_rs1_adres_o          (cyo_rs1_adres_w ),
      .ddb_rs2_adres_o          (cyo_rs2_adres_w )
   );
   
   // Durdurma/ bosaltma ve yonlendirmeden sorumlu. Bunlari yaparak hazard onler vs.
   denetim_durum_birimi denetim_durum_birimi_dut (
      .clk_i                    (clk_i ),
      .rst_i                    (rst_i ),
      .gtr_yanlis_tahmin_i      (gtr_yanlis_tahmin_w ),
      .gtr_hazir_i              (gtr_hazir_w         ),
      .gtr_durdur_o             (gtr_durdur_w        ),
      .gtr_bosalt_o             (gtr_bosalt_w        ),
      .cyo_rs1_adres_i          (cyo_rs1_adres_w         ),
      .cyo_rs2_adres_i          (cyo_rs2_adres_w         ),
      .cyo_yonlendir_kontrol1_o (cyo_yonlendir_kontrol1_w),
      .cyo_yonlendir_kontrol2_o (cyo_yonlendir_kontrol2_w),
      .cyo_durdur_o             (cyo_durdur_w            ),
      .cyo_bosalt_o             (cyo_bosalt_w            ),
      .yrt_durdur_o             (yrt_durdur_w),
      .yrt_yonlendir_gecersiz_i (yrt_yonlendir_gecersiz_w),
      .yrt_yaz_yazmac_i         (yrt_mikroislem_w[`YAZMAC]),
      .yrt_hazir_i              (yrt_hazir_w   ),
      .yrt_rd_adres_i           (yrt_rd_adres_w),
      .gy_yaz_yazmac_i          (cyo_yaz_yazmac_w),
      .gy_rd_adres_i            (cyo_yaz_adres_w )
   );

endmodule
