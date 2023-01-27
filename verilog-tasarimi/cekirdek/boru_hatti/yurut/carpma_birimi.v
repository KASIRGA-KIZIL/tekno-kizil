// tb_modified_booth_dadda_carpici.v
`timescale 1ns / 1ps

`include "tanimlamalar.vh"

// carpici 33x33-> 66 bitlik, mulhsu icin 1 bit genis.


module carpma_birimi (
    input  wire        clk_i,
    input  wire [ 1:0] kontrol,
    input  wire [31:0] deger1_i,
    input  wire [31:0] deger2_i,
    output reg         bitti,
    output reg  [31:0] sonuc_o
);
    wire [65:0] sonuc;
    reg isaretli;

    reg [32:0] deger1;
    reg [32:0] deger2;
    always @(*) begin
        bitti <= 1'b1; // suanlik carpma kombinasyonel.

        case(kontrol)
        `CARPMA_MUL: begin
            deger1   = {deger1_i[31],deger1_i};
            deger2   = {deger2_i[31],deger2_i};
            isaretli = 1'b1;
            sonuc_o  = sonuc[31:0];
            sonuc_o  = sonuc[63:32];
        end
        `CARPMA_MULH: begin
            deger1   = {deger1_i[31],deger1_i};
            deger2   = {deger2_i[31],deger2_i};
            isaretli = 1'b1;
            sonuc_o  = sonuc[63:32];
        end
        `CARPMA_MULHU: begin
            deger1   = {1'b0,deger1_i};
            deger2   = {1'b0,deger2_i};
            isaretli = 1'b0;
            sonuc_o  = sonuc[63:32];
        end
        `CARPMA_MULHSU: begin
            deger1   = {deger1_i[31],deger1_i};
            deger2   = {1'b0,deger2_i};
            isaretli = 1'b1;
            sonuc_o  = sonuc[63:32];
        end
        endcase
    end

    wallace wall (
        .carpilan_i(deger1),
        .carpan_i(deger2),
        .sonuc_o(sonuc)
    );

endmodule

