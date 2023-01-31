// yazmac_obegi.v
`timescale 1ns / 1ps

`include "tanimlamalar.vh"

module yazmac_obegi(
    input  wire clk_i,
    input  wire rst_i,
    // okuma arayuzu
    input  wire [ 4:0] oku1_adr_i, // rs1
    input  wire [ 4:0] oku2_adr_i, // rs2
    output wire [31:0] oku1_deger_o,
    output wire [31:0] oku2_deger_o,
    // yazma arayuzu
    input  wire [ 4:0] yaz_adr_i, // hy
    input  wire [31:0] yaz_deger_i,
    input  wire        yaz_i
);

    reg [31:0] yazmaclar[31:0];
    assign oku1_deger_o = yazmaclar[oku1_adr_i];
    assign oku2_deger_o = yazmaclar[oku2_adr_i];

    integer i = 0;
    always@(posedge clk_i) begin
        if (rst_i) begin
            for(i = 0; i < 32; i = i + 1)
                yazmaclar[i] <= 0;
        end
        else if(yaz_i) begin
            yazmaclar[yaz_adr_i] <=  yaz_deger_i;
        end
    end
endmodule
