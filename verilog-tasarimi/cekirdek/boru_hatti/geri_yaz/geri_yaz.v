// geri_yaz.v
`timescale 1ns / 1ps

`include "tanimlamalar.vh"


module geri_yaz(
    input clk_i,
    input rst_i,

    // YURUT'ten gelenler
    input [ 4:0] rd_adres_i,
    input [31:0] rd_deger_i,
    input [ 2:0] mikroislem_i,
    input [31:0] bib_deger_i,
    input [31:0] program_sayaci_artmis_i,

    // COZ'e gidenler
    output reg [4:0] yaz_adres_o,
    output reg [31:0] yaz_deger_o,
    output reg yaz_yazmac_o
);

    assign yaz_deger_o = (mikroislem_i[`GERIYAZ] == `GERIYAZ_KAYNAK_BIB  ) ? bib_deger_i :
                         (mikroislem_i[`GERIYAZ] == `GERIYAZ_KAYNAK_YURUT) ? rd_deger_i :
                         (mikroislem_i[`GERIYAZ] == `GERIYAZ_KAYNAK_PC   ) ? program_sayaci_artmis_i :
                                                                           32'hxxxx_xxxx;

    assign yaz_adres_o   <= rd_adres_i;
    assign yaz_yazmac_o <= mikroislem_i[`YAZMAC];

endmodule
