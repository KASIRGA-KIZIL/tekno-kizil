`timescale 1ns / 1ps

`include "tanimlamalar.vh"

module tb_carpma_birimi();

	reg        clk_i=1;
	reg        rst_i;
	
	reg        durdur_i;
	reg  [1:0] kontrol_i;
	 
	reg [31:0] deger1_i;
	reg [31:0] deger2_i;

	wire [31:0] sonuc_o;

	// Instantiate the Unit Under Test (UUT)
	carpma_birimi cbt (
	    .clk_i(clk_i),
	    .rst_i(rst_i),
	    
	    .durdur_i(durdur_i),
	    .kontrol_i(kontrol_i),
            .deger1_i(deger1_i),
            .deger2_i(deger2_i),
		 
            .sonuc_o(sonuc_o)	
	);
	
	always begin
        clk_i=~clk_i;
        #5;
    end
	
	initial begin
        rst_i=1;   
	    durdur_i=0;
	    
	    //MUL
	    kontrol_i=`CARPMA_MUL;
	    deger1_i=32'd121;
	    deger2_i=32'd70;
	    #6;
	    if(sonuc_o==32'd8470) $display("passed"); else $display("FAILED!: %d",sonuc_o);
	 
	    deger1_i=32'd121;
	    deger2_i=-32'd70;
	    #10;
	    if(sonuc_o==-32'd8470) $display("passed"); else $display("FAILED!: %d",sonuc_o);
	   
	    deger1_i=-32'd121;
	    deger2_i= 32'd70;
	    #10;
	    if(sonuc_o==-32'd8470) $display("passed"); else $display("FAILED!: %d",sonuc_o);
	    
	    deger1_i=32'h0f00_0000;
	    deger2_i=32'h0f00_0000;
	    #10;
	    if(sonuc_o==32'd0) $display("passed"); else $display("FAILED!: %d",sonuc_o);
	   
	    deger1_i=32'd121;
	    deger2_i= -32'd1;
	    #10;
	    if(sonuc_o==-32'd121) $display("passed"); else $display("FAILED!: %d",sonuc_o);
	   
	    deger1_i=-32'd121;
	    deger2_i= 32'd0;
	    #10;
	    if(sonuc_o==32'd0) $display("passed"); else $display("FAILED!: %d",sonuc_o);
	
	     
	    //MULH
	    kontrol_i=`CARPMA_MULH;	
	    deger1_i=32'h0011_0000;
	    deger2_i=32'h0003_0000;
	    #10;
	    if(sonuc_o==32'd51) $display("passed"); else $display("FAILED!: %d",sonuc_o);
	    
	    deger1_i=32'h0011_0000;
	    deger2_i=32'hffff_ffff;
	    #10;
	    if(sonuc_o==32'hffff_ffff) $display("passed"); else $display("FAILED!: %d",sonuc_o);
	    
	    deger1_i=32'hffff_ffff;
	    deger2_i=32'h0011_0000;
	    #10;
	    if(sonuc_o==32'hffff_ffff) $display("passed"); else $display("FAILED!: %d",sonuc_o);
	    
	    deger1_i=32'h0011_0000;
	    deger2_i=32'h0000_0000;
	    #10;
	    if(sonuc_o==32'd0) $display("passed"); else $display("FAILED!: %d",sonuc_o);
	
	
	    //MULHU
	    kontrol_i=`CARPMA_MULHU;	
	    deger1_i=32'h0011_0000;
	    deger2_i=32'h0003_0000;
	    #10;
	    if(sonuc_o==32'd51) $display("passed"); else $display("FAILED!: %d",sonuc_o);
	
	    deger1_i=32'h0011_0000;
	    deger2_i=32'hffff_ffff;
	    #10;
	    if(sonuc_o==32'h0010_ffff) $display("passed"); else $display("FAILED!: %d",sonuc_o);
	    
	    deger1_i=32'hffff_ffff;
	    deger2_i=32'h0011_0000;
	    #10;
	    if(sonuc_o==32'h0010_ffff) $display("passed"); else $display("FAILED!: %d",sonuc_o);
	    
	    deger1_i=32'h0011_0000;
	    deger2_i=32'h0000_0000;
	    #10;
	    if(sonuc_o==32'd0) $display("passed"); else $display("FAILED!: %d",sonuc_o);
	
	    
	    //MULHSU
	    kontrol_i=`CARPMA_MULHSU;	
	    deger1_i=32'h0011_0000;
	    deger2_i=32'h0003_0000;
	    #10;
	    if(sonuc_o==32'd51) $display("passed"); else $display("FAILED!: %d",sonuc_o);
	
	    deger1_i=32'h0011_0000;
	    deger2_i=32'hffff_ffff;
	    #10;
	    if(sonuc_o==32'h0010_ffff) $display("passed"); else $display("FAILED!: %d",sonuc_o);
	    
	    deger1_i=32'hffff_ffff;
	    deger2_i=32'h0011_0000;
	    #10;
	    if(sonuc_o==32'hffff_ffff) $display("passed"); else $display("FAILED!: %d",sonuc_o);
	    
	    deger1_i=32'h0011_0000;
	    deger2_i=32'h0000_0000;
	    #10;
	    if(sonuc_o==32'd0) $display("passed"); else $display("FAILED!: %d",sonuc_o);
	
	     
	    //RST_i
	    rst_i=0;
	    if(sonuc_o==32'd0) $display("passed"); else $display("FAILED!: %d",sonuc_o);
	    
    end
	
	
	
endmodule
