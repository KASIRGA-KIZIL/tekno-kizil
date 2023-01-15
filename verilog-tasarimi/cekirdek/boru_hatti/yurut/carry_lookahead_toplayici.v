// carry_lookahead_toplayici.v
`timescale 1ns / 1ps

`include "tanimlamalar.vh"

module carry_lookahead_toplayici #(parameter BIT = 32)(
input  [BIT-1:0] a_i, b_i, 
input   giren_elde_i, 
output reg [BIT-1:0] toplam_o
);

reg [BIT-1:0] elde_r=0;
integer i;
  
always@(*)begin
    elde_r[0] = a_i[0] & b_i[0];
    toplam_o[0] = a_i[0] ^ b_i[0] ^ giren_elde_i;
    for ( i = 1; i < BIT; i=i+1) begin
        elde_r[i] = (a_i[i] & b_i[i]) | (a_i[i] & elde_r[i-1]) | (b_i[i] & elde_r[i-1]);
        toplam_o[i] = a_i[i] ^ b_i[i] ^ elde_r[i-1];
    end
end
endmodule
