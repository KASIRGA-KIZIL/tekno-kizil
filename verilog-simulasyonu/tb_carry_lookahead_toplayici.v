`timescale 1ns / 1ps

`include "tanimlamalar.vh"

//Modulde degisiklik yapilmis. Cikarma bir ust modulden kontrol ediliyor.
module tb_carry_lookahead_toplayici;

	reg [31:0] deger1_i;
	reg [31:0] deger2_i;
  	reg        elde_i;
    
	wire [31:0] sonuc_o;

    
   	carry_lookahead_toplayici clat (
	    
           .deger1_i(deger1_i),
           .deger2_i(deger2_i),
           .elde_i(elde_i),
		 
           .sonuc_o(sonuc_o)	
	);
	
	initial begin
	   
	    //Toplama
	   
            deger1_i=  32'd87;
            deger2_i=  32'd95;
            elde_i=0;
	    #5;
	    if(sonuc_o==32'd182) $display("passed"); else $display("FAILED!: %d",sonuc_o);
	
	    deger1_i=  32'd87;
            deger2_i= -32'd95;
            elde_i=0;
	    #5;
	    if(sonuc_o== -32'd8) $display("passed"); else $display("FAILED!: %d",sonuc_o);
	    
	    deger1_i= -32'd87;
            deger2_i=  32'd95;
            elde_i=0;
	    #5;
	    if(sonuc_o== 32'd8) $display("passed"); else $display("FAILED!: %d",sonuc_o);
	    
	    deger1_i= -32'd87;
            deger2_i= -32'd95;
            elde_i=0;
	    #5;
	    if(sonuc_o== -32'd182) $display("passed"); else $display("FAILED!: %d",sonuc_o);
	    
	    deger1_i= -32'd87;
            deger2_i=  32'd0;
            elde_i=0;
	    #5;
	    if(sonuc_o== -32'd87) $display("passed"); else $display("FAILED!: %d",sonuc_o);
	    
	    
	    //Elde
	    deger1_i=  32'd87;
            deger2_i=  32'd95;
            elde_i=1;
	    #5;
	    if(sonuc_o==32'd183) $display("passed"); else $display("FAILED!: %d",sonuc_o);
	    
	    
  end

endmodule
