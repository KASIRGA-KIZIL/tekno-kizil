// cekirdek.v
`timescale 1ns / 1ps

`include "tanimlamalar.vh"

module cekirdek(
    input wire clk_i,
    input wire rst_i,

    input  wire        l1b_bekle_i,
    input  wire [31:0] l1b_deger_i,
    output wire        l1b_chip_select_n_o,
    output wire [31:0] l1b_adres_o

);

    wire [`MI_BIT-1:0] yrt_mikroislem_w;
    wire [       31:0] yrt_deger1_w;
    wire [       31:0] yrt_deger2_w;
    wire [        2:0] yrt_lt_ltu_eq_w;
    wire [        2:0] yrt_buyruk_tipi_w;
    wire [       31:1] yrt_ps_artmis_w;
    wire [        4:0] yrt_rd_adres_w;
    wire               yrt_yapay_zeka_en_w;
    wire               yrt_ebreak_w;
    wire               yrt_ecall_w;
    wire [       31:1] yrt_ps_w;
    wire [4:0] ddb_rs1_adres_w;
    wire [4:0] ddb_rs2_adres_w;
    wire       ddb_gecersiz_buyruk_w;

    /*wire  l1b_chip_select_n_o;*/
    wire [31:0] cyo_buyruk_w;
    wire [31:1] cyo_ps_artmis_w;
    wire [31:1] cyo_l1b_ps_w;

    wire [31:1] gtr_atlanan_ps_w;
    wire  gtr_atlanan_ps_gecerli_w;
    wire [31:1] gy_ps_artmis_w;
    wire [31:0] gy_rd_deger_w;
    wire [31:0] gy_bib_deger_w;
    wire [31:0] gy_carpma_deger_w;
    wire [ 2:0] gy_mikroislem_w;
    wire [31:0] cyo_yonlendir_deger_w;

    wire [ 4:0] cyo_yaz_adres_w;
    wire [31:0] cyo_yaz_deger_w;
    wire        cyo_yaz_yazmac_w;

    wire  gtr_durdur_w;
    wire  gtr_bosalt_w;
    wire [1:0] cyo_yonlendir_kontrol1_w;
    wire [1:0] cyo_yonlendir_kontrol2_w;
    wire       cyo_durdur_w;
    wire       cyo_bosalt_w;


    wire  gtr_yanlis_tahmin_w;
    wire  gtr_hazir_w;
    wire  cyo_gecersiz_buyruk_w;
    wire [4:0] cyo_rs1_adres_w;
    wire [4:0] cyo_rs2_adres_w;
    wire  yrt_yaz_yazmac_w;

    wire yrt_hazir_w;

    wire [4:0] gy_rd_adres_w;

    geri_yaz geri_yaz_dut (
        .yrt_rd_adres_i    (gy_rd_adres_w    ),
        .yrt_rd_deger_i    (gy_rd_deger_w    ),
        .yrt_mikroislem_i  (gy_mikroislem_w  ),
        .yrt_bib_deger_i   (gy_bib_deger_w   ),
        .yrt_carpma_deger_i(gy_carpma_deger_w),
        .yrt_ps_artmis_i   (gy_ps_artmis_w   ),
        .cyo_yaz_adres_o (cyo_yaz_adres_w),
        .cyo_yaz_deger_o (cyo_yaz_deger_w),
        .cyo_yaz_yazmac_o(cyo_yaz_yazmac_w)
    );

    yurut yurut_dut (
        .clk_i (clk_i ),
        .rst_i (rst_i ),
        .ddb_hazir_o (yrt_hazir_w),

        .cyo_mikroislem_i    (yrt_mikroislem_w      ),
        .cyo_rd_adres_i      (yrt_rd_adres_w        ),
        .cyo_ps_artmis_i     (yrt_ps_artmis_w       ),
        .cyo_deger1_i        (yrt_deger1_w          ),
        .cyo_deger2_i        (yrt_deger2_w          ),
        .cyo_yapay_zeka_en_i (yrt_yapay_zeka_en_w   ),
        .cyo_ebreak_i        (yrt_ebreak_w          ),
        .cyo_ecall_i         (yrt_ecall_w           ),
        .cyo_ps_i            (yrt_ps_w              ),
        .cyo_gecersiz_buyruk_i(cyo_gecersiz_buyruk_w),
        .cyo_lt_ltu_eq_i     (yrt_lt_ltu_eq_w    ),
        .cyo_buyruk_tipi_i   (yrt_buyruk_tipi_w  ),
        .gtr_atlanan_ps_o         (gtr_atlanan_ps_w        ),
        .gtr_atlanan_ps_gecerli_o (gtr_atlanan_ps_gecerli_w),
        .gy_rd_adres_o    (gy_rd_adres_w  ),
        .gy_ps_artmis_o   (gy_ps_artmis_w ),
        .gy_rd_deger_o    (gy_rd_deger_w  ),
        .gy_bib_deger_o   (gy_bib_deger_w ),
        .gy_carpma_deger_o(gy_carpma_deger_w),
        .gy_mikroislem_o  (gy_mikroislem_w),
        .cyo_yonlendir_deger_o  (cyo_yonlendir_deger_w)
    );

    coz_yazmacoku coz_yazmacoku_dut (
        .clk_i (clk_i ),
        .rst_i (rst_i ),

        .gtr_buyruk_i     (cyo_buyruk_w    ),
        .gtr_ps_i         (cyo_l1b_ps_w    ),
        .gtr_ps_artmis_i  (cyo_ps_artmis_w ),
        .yrt_mikroislem_o      (yrt_mikroislem_w     ),
        .yrt_deger1_o          (yrt_deger1_w         ),
        .yrt_deger2_o          (yrt_deger2_w         ),
        .yrt_lt_ltu_eq_o       (yrt_lt_ltu_eq_w      ),
        .yrt_buyruk_tipi_o     (yrt_buyruk_tipi_w    ),
        .yrt_yapay_zeka_en_o   (yrt_yapay_zeka_en_w  ),
        .yrt_ecall_o           (yrt_ecall_w          ),
        .yrt_ebreak_o          (yrt_ebreak_w         ),
        .yrt_ps_o              (yrt_ps_w             ),
        .yrt_ps_artmis_o       (yrt_ps_artmis_w      ),
        .yrt_rd_adres_o        (yrt_rd_adres_w       ),
        .yrt_yonlendir_deger_i (cyo_yonlendir_deger_w),
        .gy_yaz_adres_i  (cyo_yaz_adres_w ),
        .gy_yaz_deger_i  (cyo_yaz_deger_w ),
        .gy_yaz_yazmac_i (cyo_yaz_yazmac_w),

        .ddb_durdur_i             (cyo_durdur_w ),
        .ddb_bosalt_i             (cyo_bosalt_w ),
        .ddb_yonlendir_kontrol1_i (cyo_yonlendir_kontrol1_w ),
        .ddb_yonlendir_kontrol2_i (cyo_yonlendir_kontrol2_w ),
        .ddb_rs1_adres_o          (cyo_rs1_adres_w ),
        .ddb_rs2_adres_o          (cyo_rs2_adres_w ),
        .ddb_gecersiz_buyruk_o    (cyo_gecersiz_buyruk_w)
    );

    getir getir_dut (
        .clk_i (clk_i ),
        .rst_i (rst_i ),
        .ddb_durdur_i       (gtr_durdur_w       ),
        .ddb_bosalt_i       (gtr_bosalt_w       ),
        .ddb_hazir_o        (gtr_hazir_w        ),
        .ddb_yanlis_tahmin_o(gtr_yanlis_tahmin_w),
        .l1b_bekle_i         (l1b_bekle_i        ),
        .l1b_deger_i         (l1b_deger_i        ),
        .l1b_chip_select_n_o (l1b_chip_select_n_o),
        .yrt_atlanan_ps_gecerli_i (gtr_atlanan_ps_gecerli_w),
        .yrt_atlanan_ps_i         (gtr_atlanan_ps_w        ),
        .cyo_buyruk_o    (cyo_buyruk_w   ),
        .cyo_ps_artmis_o (cyo_ps_artmis_w),
        .cyo_l1b_ps_o    (cyo_l1b_ps_w   )
    );


    denetim_durum_birimi denetim_durum_birimi_dut (
        .gtr_yanlis_tahmin_i (gtr_yanlis_tahmin_w ),
        .gtr_hazir_i         (gtr_hazir_w         ),
        .gtr_durdur_o        (gtr_durdur_w        ),
        .gtr_bosalt_o        (gtr_bosalt_w        ),
        .cyo_gecersiz_buyruk_i    (cyo_gecersiz_buyruk_w   ),
        .cyo_rs1_adres_i          (cyo_rs1_adres_w         ),
        .cyo_rs2_adres_i          (cyo_rs2_adres_w         ),
        .cyo_yonlendir_kontrol1_o (cyo_yonlendir_kontrol1_w),
        .cyo_yonlendir_kontrol2_o (cyo_yonlendir_kontrol2_w),
        .cyo_durdur_o             (cyo_durdur_w            ),
        .cyo_bosalt_o             (cyo_bosalt_w            ),
        .yrt_yaz_yazmac_i (yrt_mikroislem_w[`YAZMAC]),
        .yrt_hazir_i      (yrt_hazir_w   ),
        .yrt_rd_adres_i   (yrt_rd_adres_w),
        .gy_yaz_yazmac_i (cyo_yaz_yazmac_w),
        .gy_rd_adres_i   (cyo_yaz_adres_w )
    );

    assign l1b_adres_o = {cyo_l1b_ps_w,1'b0};

endmodule


