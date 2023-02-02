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
reg[BIT-1:0] islenen_r;
reg carryIn_r;
integer i;

always@(*)begin

    if(elde_i)begin
        islenen_r=deger2_i;
        carryIn_r=1'b1;
    end
    
    else begin
        islenen_r=deger2_i;
        carryIn_r=1'b0;
    end
   
   
    elde_r[0] = ( deger1_i[0] & islenen_r[0]) | ( deger1_i[0] & carryIn_r) | (  islenen_r[0] & carryIn_r);
    sonuc_o[0] =  deger1_i[0] ^  islenen_r[0] ^ carryIn_r;
    
    for ( i = 1; i < BIT; i=i+1) begin
        elde_r[i] = ( deger1_i[i] &   islenen_r[i]) | ( deger1_i[i] & elde_r[i-1]) | (  islenen_r[i] & elde_r[i-1]);
        sonuc_o[i] =  deger1_i[i] ^  islenen_r[i] ^ elde_r[i-1]; 
    end
end

endmodule

