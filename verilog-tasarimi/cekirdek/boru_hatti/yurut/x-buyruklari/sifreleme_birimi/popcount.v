// popcount.v

`timescale 1ns / 1ps

module popcount(
   input [31:0] deger_i,
   output reg [5:0] bir_sayisi
);

   integer i;
   always @* begin
      bir_sayisi = 6'b0;
      for(i = 0;i<32;i = i+1)begin
         if(deger_i[i])begin
            bir_sayisi = bir_sayisi + 6'b1;
         end
      end
   end
endmodule
