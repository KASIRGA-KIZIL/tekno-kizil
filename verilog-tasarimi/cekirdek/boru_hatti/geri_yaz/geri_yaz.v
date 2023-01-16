// geri_yaz.v
`timescale 1ns / 1ps

`include "tanimlamalar.vh"

// denetim durum birimi ile iliskisinin kurulmasi gerek

module geri_yaz(
    input clk_i,
    input rst_i,
    
    input [4:0] rd_adres_i,
    input [31:0] rd_deger_i,
    input yaz_yazmac_i,
    
    output [4:0] yaz_adres_o,
    output [31:0] yaz_deger_o,
    output yaz_yazmac_o


);
    reg [4:0] rd_adres_r = 0;
    assign rd_adres_o = rd_adres_r;
    
    reg [31:0] rd_deger_r = 0;
    assign rd_deger_o = rd_deger_r;

    reg yaz_yazmac_r = 0;
    assign yaz_yazmac_o = yaz_yazmac_r;

    always @(posedge clk_i) begin
        if(rst_i) begin
            rd_adres_r <= 0;
            rd_deger_r <= 0;
            yaz_yazmac_r <= 0;
        end
        else begin
            rd_adres_r <= rd_adres_i;
            rd_deger_r <= rd_deger_i;
            yaz_yazmac_r <= yaz_yazmac_i;
        end
    end
endmodule
