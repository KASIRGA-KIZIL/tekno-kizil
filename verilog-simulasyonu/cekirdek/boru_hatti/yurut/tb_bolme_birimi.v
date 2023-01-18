//tb_bolme_birimi
`timescale 1ns / 1ps

`include "tanimlamalar.vh"

module tb_bolme_birimi;

reg [31:0] bolen_i;
reg [31:0] bolunen_i;
wire [31:0] bolum_o;

bolme_birimi bolb (
    .bolunen_i(bolunen_i),
    .bolen_i(bolen_i), 
	.bolum_o(bolum_o)
);

initial begin
    //495 / 5= 99
	bolunen_i = 32'd495;
	bolen_i =   32'd5;
    #10;
		
	//2048 / 16 = 128
    bolunen_i = 32'd2048;
	bolen_i =   32'd16;
    #10;
		
	//67 / 6 = 11
	bolunen_i = 32'd67;
	bolen_i =   32'd6;
    #10;
        
    //111 / 112 = 0
    bolunen_i = 32'd111;
	bolen_i =   32'd112;
    #10;
        
    //90 / 33 = 2
    bolunen_i = 32'd90;
    bolen_i =   32'd33;
    #10;
        
    // 10000000 / 6 =  1 666 666
    bolunen_i = 32'd10000000;
    bolen_i =   32'd6;
    #10;
    
    $finish;
end
      
	
endmodule
