// geri_yaz.v
`timescale 1ns / 1ps

`include "tanimlamalar.vh"

// denetim durum birimi ile iliskisinin kurulmasi gerek

module geri_yaz(
    input clk_i,
    input rst_i,

    input [1:0] sec_geri_yaz_i,

    input [4:0] rd_adres_i,
    input [31:0] rd_deger_i,
    input yaz_yazmac_i,

    input [31:0] bib_deger_i, // geri yaza kadar gitmesi lazim
    input [31:0] program_sayaci_artmis_i, // geri yaza kadar gitmesi lazim

    output reg [4:0] yaz_adres_o,
    output reg [31:0] yaz_deger_o,
    output reg yaz_yazmac_o


);
    yaz_deger_w =   (sec_geri_yaz_i == `GERIYAZ_BIB  ) ? bib_deger_i :
                    (sec_geri_yaz_i == `GERIYAZ_YURUT) ? rd_deger_i :
                    (sec_geri_yaz_i == `GERIYAZ_PCART) ? program_sayaci_artmis_i :
                                                        32'hxxxx_xxxx;
    always @(posedge clk_i) begin
        if(rst_i) begin
            rd_adres_r <= 0;
            rd_deger_r <= 0;
            yaz_yazmac_r <= 0;
        end
        else begin
            rd_adres_o <= rd_adres_i;
            yaz_yazmac_o <= yaz_yazmac_i;
            yaz_deger_o <= yaz_deger_w;
        end
    end
endmodule
