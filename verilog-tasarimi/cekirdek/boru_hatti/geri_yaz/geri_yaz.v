// geri_yaz.v
`timescale 1ns / 1ps

`include "tanimlamalar.vh"


module geri_yaz(
    // YURUT'ten gelenler
    input [ 4:0] yrt_rd_adres_i,
    input [31:0] yrt_rd_deger_i,
    input [ 2:0] yrt_mikroislem_i,
    input [31:0] yrt_carpma_deger_i,
    input [31:1] yrt_ps_artmis_i,

    // COZ'e gidenler
    output [ 4:0] cyo_yaz_adres_o,
    output [31:0] cyo_yaz_deger_o,
    output        cyo_yaz_yazmac_o
);

    assign cyo_yaz_deger_o = (yrt_mikroislem_i[`GERIYAZ] == `GERIYAZ_KAYNAK_YURUT ) ? yrt_rd_deger_i        :
                             (yrt_mikroislem_i[`GERIYAZ] == `GERIYAZ_KAYNAK_PC    ) ? {yrt_ps_artmis_i,1'b0}:
                             (yrt_mikroislem_i[`GERIYAZ] == `GERIYAZ_KAYNAK_CARPMA) ? yrt_carpma_deger_i    :
                                                                                     32'hxxxx_xxxx;

    assign cyo_yaz_adres_o  = yrt_rd_adres_i;
    assign cyo_yaz_yazmac_o = yrt_mikroislem_i[`YAZMAC];

endmodule
