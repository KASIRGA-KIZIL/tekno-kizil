// carry_lookahead_toplayici.v
`timescale 1ns / 1ps

`include "tanimlamalar.vh"

module carry_lookahead_toplayici #(parameter BIT = 32)(
input  [BIT-1:0] a, b, 
input   giren_elde, 
output reg [BIT-1:0] toplam, 
input  clk);
reg [BIT-1:0] elde=0;

integer i;
  always @(posedge clk) begin
    elde [0] <= a[0] & b[0];
    toplam[0] <= a[0] ^ b[0] ^ giren_elde;
    for ( i = 1; i < BIT; i=i+1) begin
      elde[i] <= (a[i] & b[i]) | (a[i] & elde[i-1]) | (b[i] & elde[i-1]);
      toplam[i] <= a[i] ^ b[i] ^ elde[i-1];
    end
  end
endmodule
