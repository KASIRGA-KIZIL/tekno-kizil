// carpma_birimi.v
`timescale 1ns / 1ps

`include "tanimlamalar.vh"

module carpma_birimi (
    input  wire        clk_i,
    input  wire        rst_i,
    input  wire        biriktir_i,
    input  wire [ 1:0] kontrol_i,
    input  wire [31:0] deger1_i,
    input  wire [31:0] deger2_i,
    output wire [31:0] sonuc_o
);
    wire [66:0] sonuc;

    reg [32:0] deger1;
    reg [32:0] deger2;

    always @(*) begin
        case(kontrol_i)
        `CARPMA_MUL: begin
            deger1   = {deger1_i[31],deger1_i};
            deger2   = {deger2_i[31],deger2_i};
        end
        `CARPMA_MULH: begin
            deger1   = {deger1_i[31],deger1_i};
            deger2   = {deger2_i[31],deger2_i};
        end
        `CARPMA_MULHU: begin
            deger1   = {1'b0,deger1_i};
            deger2   = {1'b0,deger2_i};
        end
        `CARPMA_MULHSU: begin
            deger1   = {deger1_i[31],deger1_i};
            deger2   = {1'b0,deger2_i};
        end
        endcase
    end

    carp_biriktir cbd (
      .clk_i (clk_i ),
      .rst_i (rst_i ),
      .biriktir_i(biriktir_i),
      .IN1 (deger1 ),
      .IN2 (deger2 ),
      .result  ( sonuc)
    );

    assign sonuc_o = (kontrol_i == `CARPMA_MUL ) ? sonuc[31: 0] : sonuc[63:32] ;
endmodule
