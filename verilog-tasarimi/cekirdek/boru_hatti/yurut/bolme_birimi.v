// bolme_birimi.v
`timescale 1ns / 1ps

`include "tanimlamalar.vh"

module bolme_birimi(
input [31:0] bolunen_i,
input [31:0] bolen_i, 
output reg [31:0] bolum_o
);

integer i;
reg [31:0] bolen_r, bolunen_r;
reg [31:0] fark_r;

always @(bolen_i or bolunen_i)begin
  
    bolen_r= bolen_i;
    bolunen_r = bolunen_i;
    fark_r = 32'b0; 
	  
    for(i = 0;i < 32;i = i + 1)begin
	
        fark_r = {fark_r[30:0], bolunen_r[31]};
        bolunen_r = bolunen_r<<1;
        fark_r = fark_r - bolen_r;
		
        if(fark_r[31])begin
	    bolunen_r[0] = 0;
	    fark_r = fark_r + bolen_r;
         end
         else begin
            bolunen_r[0] = 1;
         end
   end
       bolum_o = bolunen_r;
end
	
endmodule
