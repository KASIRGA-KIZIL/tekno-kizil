// cekirdek.v
`timescale 1ns / 1ps

`include "tanimlamalar.vh"

module cekirdek(
    input wire clk_i,
    input wire rst_i,
    //
    input  wire        l1b_bekle_i,
    input  wire [31:0] l1b_deger_i,
    output wire        l1b_chip_select_n_o,
    output wire [31:0] l1b_adres_o

);

    wire [`MI_BIT-1:0] yrt_mikroislem_o;
    wire [       31:0] yrt_deger1_o;
    wire [       31:0] yrt_deger2_o;
    wire [        2:0] yrt_lt_ltu_eq_o;
    wire [        1:0] yrt_buyruk_tipi_o;
    wire yrt_yapay_zeka_en_o;
    wire [       31:0] yrt_ps_artmis_o;
    wire [        4:0] yrt_rd_adres_o;
    wire [4:0] ddb_rs1_adres_o;
    wire [4:0] ddb_rs2_adres_o;
    wire ddb_gecersiz_buyruk_o;

    wire  ddb_hazir_o;
    /*wire  l1b_chip_select_n_o;*/
    wire [31:0] cyo_buyruk_o;
    wire [31:0] cyo_ps_artmis_o;
    wire [31:1] cyo_l1b_ps_o;

    wire [31:0] gtr_atlanan_ps_o;
    wire  gtr_atlanan_ps_gecerli_o;
    wire [ 4:0] gy_rd_adres_o;
    wire [31:0] gy_ps_artmis_o;
    wire [31:0] gy_rd_deger_o;
    wire [31:0] gy_bib_deger_o;
    wire [ 2:0] gy_mikroislem_o;
    wire [31:0] cyo_yonlendir_deger_o;

    wire [4:0] cyo_yaz_adres_o;
    wire [31:0] cyo_yaz_deger_o;
    wire cyo_yaz_yazmac_o;

    geri_yaz geri_yaz_dut (
        .clk_i (clk_i ),
        .yrt_rd_adres_i   (gy_rd_adres_o  ),//
        .yrt_rd_deger_i   (gy_rd_deger_o  ),//
        .yrt_mikroislem_i (gy_mikroislem_o),//
        .yrt_bib_deger_i  (gy_bib_deger_o ),//
        .yrt_ps_artmis_i  (gy_ps_artmis_o ),//
        .cyo_yaz_adres_o (cyo_yaz_adres_o ),//
        .cyo_yaz_deger_o (cyo_yaz_deger_o ),//
        .cyo_yaz_yazmac_o(cyo_yaz_yazmac_o) //
    );

    yurut yurut_dut (
        .clk_i (clk_i ),
        .rst_i (rst_i ),
        .ddb_hazir_o (ddb_hazir_o),
        .cyo_mikroislem_i    (yrt_mikroislem_o   ),//
        .cyo_rd_adres_i      (yrt_rd_adres_o     ),//
        .cyo_ps_artmis_i     (yrt_ps_artmis_o    ),//
        .cyo_deger1_i        (yrt_deger1_o       ),//
        .cyo_deger2_i        (yrt_deger2_o       ),//
        .cyo_yapay_zeka_en_i (yrt_yapay_zeka_en_o),//
        .cyo_lt_ltu_eq_i     (yrt_lt_ltu_eq_o    ),//
        .cyo_buyruk_tipi_i   (yrt_buyruk_tipi_o  ),//
        .gtr_atlanan_ps_o         (gtr_atlanan_ps_o         ),//
        .gtr_atlanan_ps_gecerli_o (gtr_atlanan_ps_gecerli_o ),//
        .gy_rd_adres_o   (gy_rd_adres_o   ),//
        .gy_ps_artmis_o  (gy_ps_artmis_o  ),//
        .gy_rd_deger_o   (gy_rd_deger_o   ),//
        .gy_bib_deger_o  (gy_bib_deger_o  ),//
        .gy_mikroislem_o (gy_mikroislem_o ),//
        .cyo_yonlendir_deger_o  ( cyo_yonlendir_deger_o)//
    );

    coz_yazmacoku coz_yazmacoku_dut (
        .clk_i (clk_i ),
        .rst_i (rst_i ),
        .gtr_buyruk_i     (cyo_buyruk_o    ),//
        .gtr_ps_i         (cyo_l1b_ps_o    ),//
        .gtr_ps_artmis_i  (cyo_ps_artmis_o ),//
        .yrt_mikroislem_o      (yrt_mikroislem_o      ),//
        .yrt_deger1_o          (yrt_deger1_o          ),//
        .yrt_deger2_o          (yrt_deger2_o          ),//
        .yrt_lt_ltu_eq_o       (yrt_lt_ltu_eq_o       ),//
        .yrt_buyruk_tipi_o     (yrt_buyruk_tipi_o     ),//
        .yrt_yapay_zeka_en_o   (yrt_yapay_zeka_en_o   ),//
        .yrt_ps_artmis_o       (yrt_ps_artmis_o       ),//
        .yrt_rd_adres_o        (yrt_rd_adres_o        ),//
        .yrt_yonlendir_deger_i (cyo_yonlendir_deger_o ),//
        .gy_yaz_adres_i  (cyo_yaz_adres_o ),//
        .gy_yaz_deger_i  (cyo_yaz_deger_o ),//
        .gy_yaz_yazmac_i (cyo_yaz_yazmac_o),//
        .ddb_durdur_i             (ddb_durdur_i ),
        .ddb_bosalt_i             (ddb_bosalt_i ),
        .ddb_yonlendir_kontrol1_i (ddb_yonlendir_kontrol1_i ),
        .ddb_yonlendir_kontrol2_i (ddb_yonlendir_kontrol2_i ),
        .ddb_rs1_adres_o          (ddb_rs1_adres_o ),
        .ddb_rs2_adres_o          (ddb_rs2_adres_o ),
        .ddb_gecersiz_buyruk_o    (ddb_gecersiz_buyruk_o)
    );

    getir getir_dut (
        .clk_i (clk_i ),
        .rst_i (rst_i ),
        .ddb_durdur_i (ddb_durdur_i ),
        .ddb_bosalt_i (ddb_bosalt_i ),
        .ddb_hazir_o  (ddb_hazir_o  ),
        .ddb_yanlis_tahmin_o(ddb_yanlis_tahmin_o),
        .l1b_bekle_i         (l1b_bekle_i         ),//
        .l1b_deger_i         (l1b_deger_i         ),//
        .l1b_chip_select_n_o (l1b_chip_select_n_o ),//
        .yrt_atlanan_ps_gecerli_i (gtr_atlanan_ps_gecerli_o),//
        .yrt_atlanan_ps_i         (gtr_atlanan_ps_o        ),//
        .cyo_buyruk_o    (cyo_buyruk_o    ),//
        .cyo_ps_artmis_o (cyo_ps_artmis_o ),//
        .cyo_l1b_ps_o    (cyo_l1b_ps_o    ) //
    );

    assign l1b_adres_o = {cyo_l1b_ps_o,1'b0};

endmodule

