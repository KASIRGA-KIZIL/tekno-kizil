// yazmac_obegi.v
`timescale 1ns / 1ps

`include "tanimlamalar.vh"

module yazmac_obegi(
    input clk_i,
    input rst_i,

    input [4:0] ky1_adres_i,
    input [4:0] ky2_adres_i,
    input [4:0] hy_adres_i,

    input [31:0] hy_deger_i,

    input yaz_i,

    output reg [31:0] ky1_deger_o,
    output reg [31:0] ky2_deger_o
);
    
    reg [31:0] yazmac_obegi [31:0];

    always@* begin
        ky1_deger_o = yazmac_obegi[ky1_adres_i];
        ky2_deger_o = yazmac_obegi[ky2_adres_i];
    end

    integer i = 0;
    always@(posedge clk_i) begin
        if (rst_i) begin
            for(i = 0; i < 32; i = i + 1)
                yazmac_obegi[i] <= 0;
        end
        else if(yaz_g) begin
            yazmac_obegi[hy_adres_i] <= hy_deger_i;
        end
    end
endmodule
