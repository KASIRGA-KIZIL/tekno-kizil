// veriyolu_denetleyici.v
`timescale 1ns / 1ps

`include "tanimlamalar.vh"

module veriyolu_denetleyici(
    // Cekirdek --- VYD
    input [31:0]cekirdek_vyd_adres_i,
    input [31:0]cekirdek_vyd_veri_i,
    input [ 3:0]cekirdek_vyd_veri_maske_i,
    input cekirdek_vyd_sec_i,
    input cekirdek_vyd_yaz_etkin_i,
    output vyd_cekirdek_veri_o,
    output vyd_cekirdek_veri_hazir_o,
    output vyd_cekirdek_durdur_o,

    // VYD --- WB
    output [31:0]       vyd_wb_adres_o,
    output [31:0]       vyd_wb_veri_o,
    output              vyd_wb_yaz_etkin_o,
    output              vyd_wb_sec_o,
    input  [31:0]       wb_vyd_veri_i,
    input               wb_vyd_veri_hazir_i,
    input               wb_vyd_mesgul_i

    // VYD --- VB
    input       [31:0] bib_veri_i,
    input              bib_durdur_i,
    output      [31:0] bib_veri_o,
    output      [31:0] bib_adr_o,
    output      [ 3:0] bib_veri_maske_o,
    output             bib_yaz_etkin_o,
    output             bib_sec_o, // active low
);
    assign vyd_cekirdek_veri_o = wb_vyd_veri_hazir_i ? wb_vyd_veri_i : bib_veri_i;
    assign vyd_cekirdek_veri_hazir_o = wb_vyd_veri_hazir_i | ~bib_durdur_i;
    assign vyd_cekirdek_durdur_o = wb_vyd_mesgul_i | bib_durdur_i;

    assign vyd_wb_adres_o = (vyd_wb_yaz_etkin_o | vyd_wb_sec_o) ? cekirdek_vyd_adres_i : 32'b0;
    assign vyd_wb_veri_o = (vyd_wb_yaz_etkin_o | vyd_wb_sec_o) ? cekirdek_vyd_veri_i : 32'b0;
    assign vyd_wb_yaz_etkin_o = cekirdek_vyd_adres_i[29] ? cekirdek_vyd_yaz_etkin_i : 1'b0;
    assign vyd_wb_sec_o = cekirdek_vyd_adres_i[29] ? cekirdek_vyd_sec_i : 1'b0;

    assign bib_veri_o = (bib_yaz_etkin_o | bib_sec_o) ? cekirdek_vyd_adres_i : 32'b0;
    assign bib_adr_o = (bib_yaz_etkin_o | bib_sec_o) ? cekirdek_vyd_adres_i : 32'b0;
    assign bib_veri_maske_o = cekirdek_vyd_veri_maske_i;
    assign bib_yaz_etkin_o = ~cekirdek_vyd_adres_i[29] ? cekirdek_vyd_yaz_etkin_i : 1'b0;
    assign bib_sec_o = ~cekirdek_vyd_adres_i[29] ? cekirdek_vyd_sec_i : 1'b0;

endmodule
