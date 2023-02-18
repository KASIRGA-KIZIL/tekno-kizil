`timescale 1ns / 1ps

`include "tanimlamalar.vh"

module tb_sifreleme_birimi();

    reg [2:0] kontrol_i;
    
    reg [31:0] deger1_i;
    reg [31:0] deger2_i;

    wire [31:0] sonuc_o;

    sifreleme_birimi sbt (
	    
        .kontrol_i(kontrol_i),
	   
        .deger1_i(deger1_i),
        .deger2_i(deger2_i),
		 
        .sonuc_o(sonuc_o)	
    );
    

    initial begin
    
        kontrol_i= `SIFRELEME_HMDST;
        deger1_i=32'hf0f0_f0f0;
        deger2_i=32'hfff0_f0f0;
        #10;
        if(sonuc_o==32'd4) $display("passed"); else $display("FAILED!: %d",sonuc_o);
        
        kontrol_i=`SIFRELEME_PKG;
        deger1_i=32'hffff_000f;
        deger2_i=32'hffff_0f0f;
        #10;
        if(sonuc_o==32'h0f0f000f) $display("passed"); else $display("FAILED!: %h",sonuc_o);
    
        kontrol_i=`SIFRELEME_RVRS;
        deger1_i=32'hffff_0000;
        deger2_i=32'h0000_0000;
        #10;
        if(sonuc_o==32'h0000_ffff) $display("passed"); else $display("FAILED!: %h",sonuc_o);
        
        kontrol_i=`SIFRELEME_SLADD;
        deger1_i=32'd16;
        deger2_i=32'd38;
        #10;
        if(sonuc_o==32'd70) $display("passed"); else $display("FAILED!: %h",sonuc_o);
        
        kontrol_i=`SIFRELEME_CNTZ;
        deger1_i=32'hffff_0000;
        deger2_i=32'h0000_0000;
        #10;
        if(sonuc_o==32'd16) $display("passed"); else $display("FAILED!: %h",sonuc_o);
        
        kontrol_i=`SIFRELEME_CNTP;
        deger1_i=32'hf000_0000;
        deger2_i=32'h0000_0000;
        #10;
        if(sonuc_o==32'd4) $display("passed"); else $display("FAILED!: %h",sonuc_o);
    
    
    
    end

endmodule
