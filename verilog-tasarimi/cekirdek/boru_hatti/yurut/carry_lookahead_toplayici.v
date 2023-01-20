// carry_lookahead_toplayici.v
`timescale 1ns / 1ps

`include "tanimlamalar.vh"

module carry_lookahead_toplayici #(parameter BIT = 32)(
input  [BIT-1:0] a_i, b_i, 
input  islem_i,
output reg [BIT-1:0] toplam_o
);

reg [BIT-1:0] elde_r=0;
wire [BIT-1:0] cikan_w= ~b_i;
integer i;
  
always@(*)begin
    if(islem_i)begin
        elde_r[0] = (a_i[0] & cikan_w[0]) | (a_i[0] & 1) | (cikan_w[0] & 1);
        toplam_o[0] = a_i[0] ^ cikan_w[0] ^ 1;
        for ( i = 1; i < BIT; i=i+1) begin
            elde_r[i] = (a_i[i] & cikan_w[i]) | (a_i[i] & elde_r[i-1]) | (cikan_w[i] & elde_r[i-1]);
            toplam_o[i] = a_i[i] ^ cikan_w[i] ^ elde_r[i-1];
        end
    
    end
    else begin
        elde_r[0] = a_i[0] & b_i[0];
        toplam_o[0] = a_i[0] ^ b_i[0];
        for ( i = 1; i < BIT; i=i+1) begin
            elde_r[i] = (a_i[i] & b_i[i]) | (a_i[i] & elde_r[i-1]) | (b_i[i] & elde_r[i-1]);
            toplam_o[i] = a_i[i] ^ b_i[i] ^ elde_r[i-1];
        end
    end
end

endmodule
