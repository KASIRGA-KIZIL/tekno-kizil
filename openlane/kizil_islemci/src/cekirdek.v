// cekirdek.v
`timescale 1ns / 1ps

`include "tanimlamalar.vh"

module cekirdek(
   input wire clk_i,
   input wire rst_i,
   
   // L1 buyruk bellegi
   input  wire        l1b_bekle_i,
   input  wire [31:0] l1b_deger_i,
   output wire [18:1] l1b_adres_o,
   
   // Bellek Islem Birimi
   input  wire [31:0] bib_veri_i,
   input  wire        bib_durdur_i,
   output wire [31:0] bib_veri_o,
   output wire [31:0] bib_adr_o,
   output wire [ 3:0] bib_veri_maske_o,
   output wire        bib_sec_o
);

   wire [18:1] l1b_adr_w;
   assign l1b_adres_o = l1b_adr_w;
   
   wire [31:0] cyo_buyruk_w;
   wire [18:1] cyo_ps_artmis_w;
   wire [18:1] cyo_ps_w;
   
   wire [18:1] gtr_atlanan_ps_w;
   wire        gtr_atlanan_ps_gecerli_w;
   
   wire  gtr_durdur_w;
   wire  gtr_bosalt_w;
   
   wire  gtr_yanlis_tahmin_w;
   wire  gtr_hazir_w;
   
   // COZ/ YURUT/ GERIYAZ
   arka_taraf arka_taraf_dut (
     .clk_i                    (clk_i ),
     .rst_i                    (rst_i ),
     .gtr_durdur_w             (gtr_durdur_w             ),
     .gtr_bosalt_w             (gtr_bosalt_w             ),
     .gtr_hazir_w              (gtr_hazir_w              ),
     .gtr_yanlis_tahmin_w      (gtr_yanlis_tahmin_w      ),
     .gtr_atlanan_ps_w         (gtr_atlanan_ps_w         ),
     .gtr_atlanan_ps_gecerli_w (gtr_atlanan_ps_gecerli_w ),
     .cyo_buyruk_w             (cyo_buyruk_w    ),
     .cyo_ps_artmis_w          (cyo_ps_artmis_w ),
     .cyo_ps_w                 (cyo_ps_w        ),
     .bib_veri_i               (bib_veri_i       ),
     .bib_durdur_i             (bib_durdur_i     ),
     .bib_veri_o               (bib_veri_o       ),
     .bib_adr_o                (bib_adr_o        ),
     .bib_veri_maske_o         (bib_veri_maske_o ),
     .bib_sec_o                (bib_sec_o        )
   );

   // GETIR
   getir getir_dut (
       .clk_i                    (clk_i ),
       .rst_i                    (rst_i ),
       .ddb_durdur_i             (gtr_durdur_w       ),
       .ddb_bosalt_i             (gtr_bosalt_w       ),
       .ddb_hazir_o              (gtr_hazir_w        ),
       .ddb_yanlis_tahmin_o      (gtr_yanlis_tahmin_w),
       .l1b_bekle_i              (l1b_bekle_i        ),
       .l1b_deger_i              (l1b_deger_i        ),
       .l1b_adr_o                (l1b_adr_w          ),
       .yrt_atlanan_ps_gecerli_i (gtr_atlanan_ps_gecerli_w),
       .yrt_atlanan_ps_i         (gtr_atlanan_ps_w        ),
       .cyo_buyruk_o             (cyo_buyruk_w   ),
       .cyo_ps_artmis_o          (cyo_ps_artmis_w),
       .cyo_ps_o                 (cyo_ps_w   )
   );

endmodule
