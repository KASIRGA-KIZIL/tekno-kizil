`timescale 1ns / 1ps

`include "tanimlamalar.vh"

module tb_aritmetik_mantik_birimi();

    reg [3:0] kontrol_i;
    
    reg [31:0] deger1_i;
    reg [31:0] deger2_i;

    wire [31:0] sonuc_o;

    aritmetik_mantik_birimi ambt (
	    
        .kontrol_i(kontrol_i),
        .deger1_i(deger1_i),
        .deger2_i(deger2_i),
		 
        .sonuc_o(sonuc_o)	
    );
    
    initial begin
        
        kontrol_i=`AMB_TOPLAMA ;
        deger1_i=32'd80;
        deger2_i=32'd70;
        #10;
        if(sonuc_o==32'd150) $display("passed"); else $display("FAILED!: %d",sonuc_o);
        
        kontrol_i=`AMB_CIKARMA ;
        deger1_i=32'd80;
        deger2_i=32'd70;
        #10;
        if(sonuc_o==32'd10) $display("passed"); else $display("FAILED!: %d",sonuc_o);
        
        kontrol_i=`AMB_XOR;
        deger1_i=32'hf0f0_f0f0;
        deger2_i=32'hff0f_0f0f;
        #10;
        if(sonuc_o==32'h0fff_ffff) $display("passed"); else $display("FAILED!: %d",sonuc_o);
        
        kontrol_i=`AMB_OR;
        deger1_i=32'hf0f0_f0f0;
        deger2_i=32'hff0f_0f0f;
        #10;
        if(sonuc_o==32'hffff_ffff) $display("passed"); else $display("FAILED!: %d",sonuc_o);
        
        kontrol_i=`AMB_AND;
        deger1_i=32'hf0f0_f0f0;
        deger2_i=32'hff0f_0f0f;
        #10;
        if(sonuc_o==32'hf000_0000) $display("passed"); else $display("FAILED!: %d",sonuc_o);
        
        kontrol_i=`AMB_SLL;
        deger1_i=32'hf0f0_f0f0;
        deger2_i=32'h0000_0004;
        #10;
        if(sonuc_o==32'h0f0f_0f00) $display("passed"); else $display("FAILED!: %d",sonuc_o);
        
        kontrol_i=`AMB_SRL;
        deger1_i=32'hf0f0_f0f0;
        deger2_i=32'h0000_0004;
        #10;
        if(sonuc_o==32'h0f0f_0f0f) $display("passed"); else $display("FAILED!: %d",sonuc_o);
        
        kontrol_i=`AMB_SRA;
        deger1_i=32'hf0f0_f0f0;
        deger2_i=32'h0000_0004;
        #10;
        if(sonuc_o==32'hff0f_0f0f) $display("passed"); else $display("FAILED!: %d",sonuc_o);
        
        kontrol_i=`AMB_SLT;
        deger1_i=32'hf0f0_f0f0;
        deger2_i=32'h0000_0004;
        #10;
        if(sonuc_o==32'h0000_0001) $display("passed"); else $display("FAILED!: %d",sonuc_o);
        
        kontrol_i=`AMB_SLTU;
        deger1_i=32'hf0f0_f0f0;
        deger2_i=32'h0000_0004;
        #10;
        if(sonuc_o==32'h0000_0000) $display("passed"); else $display("FAILED!: %d",sonuc_o);

        kontrol_i=`AMB_GECIR;
        deger1_i=32'hf0f0_f0f0;
        deger2_i=32'h0000_0004;
        #10;
        if(sonuc_o==32'h0000_0004) $display("passed"); else $display("FAILED!: %d",sonuc_o);
        
    end


endmodule
