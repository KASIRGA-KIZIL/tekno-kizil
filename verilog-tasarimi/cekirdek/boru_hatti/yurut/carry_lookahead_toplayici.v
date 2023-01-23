// carry_lookahead_toplayici.v
`timescale 1ns / 1ps

`include "tanimlamalar.vh"

// Port isimlerini degistirmeyelim. Islemci genelinde operandlar icin deger1 deger2 kullaniyoruz.
module carry_lookahead_toplayici #(parameter BIT = 32)(
input  [BIT-1:0] deger1_i, deger2_i,
input  elde_i,
output reg [BIT-1:0] sonuc_o
);

reg [BIT-1:0] elde_r=0;
wire [BIT-1:0] cikan_w= ~deger2_i;
integer i;

always@(*)begin
    if(elde_i)begin
        elde_r[0] = (deger1_i[0] & cikan_w[0]) | (deger1_i[0] & 1) | (cikan_w[0] & 1);
        sonuc_o[0] = deger1_i[0] ^ cikan_w[0] ^ 1;
        for ( i = 1; i < BIT; i=i+1) begin
            elde_r[i] = (deger1_i[i] & cikan_w[i]) | (deger1_i[i] & elde_r[i-1]) | (cikan_w[i] & elde_r[i-1]);
            sonuc_o[i] = deger1_i[i] ^ cikan_w[i] ^ elde_r[i-1];
        end

    end
    else begin
        elde_r[0] = deger1_i[0] & deger2_i[0];
        sonuc_o[0] = deger1_i[0] ^ deger2_i[0];
        for ( i = 1; i < BIT; i=i+1) begin
            elde_r[i] = (deger1_i[i] & deger2_i[i]) | (deger1_i[i] & elde_r[i-1]) | (deger2_i[i] & elde_r[i-1]);
            sonuc_o[i] = deger1_i[i] ^ deger2_i[i] ^ elde_r[i-1];
        end
    end
end

endmodule
