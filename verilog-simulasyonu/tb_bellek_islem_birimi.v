`timescale 1ns / 1ps

//kontrol_i disinda baska girisler icin de durumlar olusturulmasi gerekebilir.

`include "tanimlamalar.vh"

module tb_bellek_islem_birimi();

    //Temel
    reg clk_i=1;
    reg rst_i;
    reg basla_i;
    wire bitti_o;
    reg ddb_durdur_i;

    // Yurut
    reg [ 2:0] kontrol_i;
    reg [31:0] adr_i;
    reg [31:0] deger_i;
    wire [31:0] sonuc_o;

    // Bellek Islem Birimi <-> disarisi
    reg [31:0] bib_veri_i;
    reg        bib_durdur_i;
    wire [31:0] bib_veri_o;
    wire [31:0] bib_adr_o;
    wire [ 3:0] bib_veri_maske_o;
    wire        bib_yaz_gecerli_o;
    wire        bib_sec_o;


    bellek_islem_birimi bibt(
    
        //Temel
        .clk_i(clk_i),
        .rst_i(rst_i),
        .basla_i(basla_i),
        .bitti_o(bitti_o),
        .ddb_durdur_i(ddb_durdur_i),

        // Yurut
        .kontrol_i(kontrol_i),
        .adr_i(adr_i),
        .deger_i(deger_i),
        .sonuc_o(sonuc_o),

        // Bellek Islem Birimi <-> disarisi
        .bib_veri_i(bib_veri_i),
        .bib_durdur_i(bib_durdur_i),
        .bib_veri_o(bib_veri_o),
        .bib_adr_o(bib_adr_o),
        .bib_veri_maske_o(bib_veri_maske_o),
        .bib_yaz_gecerli_o(bib_yaz_gecerli_o),
        .bib_sec_o(bib_sec_o)


    );
    
    always begin
        clk_i=~clk_i;
        #1;
    end

    initial begin
    
        rst_i=0;
        basla_i=1;
        ddb_durdur_i=1;
        bib_durdur_i=1;
        
        kontrol_i=  `BIB_SB;
        adr_i= 32'h0000_00f0;
        deger_i=32'h0000_0030;
        bib_veri_i=32'h0000_0040;
        #10;
        $display("sonuc_o: %h",sonuc_o);
        $display("bib_veri_o: %h",bib_veri_o);
        $display("bib_adr_o: %h",bib_adr_o);
        $display("bib_veri_maske_o: %h",bib_veri_maske_o);
        
        
        kontrol_i=  `BIB_SH;
        adr_i= 32'h0000_00f0;
        deger_i=32'h0000_0030;
        bib_veri_i=32'h0000_0040;
        #10;
        $display("sonuc_o: %h",sonuc_o);
        $display("bib_veri_o: %h",bib_veri_o);
        $display("bib_adr_o: %h",bib_adr_o);
        $display("bib_veri_maske_o: %h",bib_veri_maske_o);
        
        kontrol_i=  `BIB_SW;
        adr_i= 32'h0000_00f0;
        deger_i=32'h0000_0030;
        bib_veri_i=32'h0000_0040;
        #10;
        $display("sonuc_o: %h",sonuc_o);
        $display("bib_veri_o: %h",bib_veri_o);
        $display("bib_adr_o: %h",bib_adr_o);
        $display("bib_veri_maske_o: %h",bib_veri_maske_o);
        
        kontrol_i=  `BIB_LB;
        adr_i= 32'h0000_00f0;
        deger_i=32'h0000_0030;
        bib_veri_i=32'h0000_0040;
        #10;
        $display("sonuc_o: %h",sonuc_o);
        $display("bib_veri_o: %h",bib_veri_o);
        $display("bib_adr_o: %h",bib_adr_o);
        $display("bib_veri_maske_o: %h",bib_veri_maske_o);
        
        kontrol_i=  `BIB_LW;
        adr_i= 32'h0000_00f0;
        deger_i=32'h0000_0030;
        bib_veri_i=32'h0000_0040;
        #10;
        $display("sonuc_o: %h",sonuc_o);
        $display("bib_veri_o: %h",bib_veri_o);
        $display("bib_adr_o: %h",bib_adr_o);
        $display("bib_veri_maske_o: %h",bib_veri_maske_o);
        
        kontrol_i=  `BIB_LBU;
        adr_i= 32'h0000_00f0;
        deger_i=32'h0000_0030;
        bib_veri_i=32'h0000_0040;
        #10;
        $display("sonuc_o: %h",sonuc_o);
        $display("bib_veri_o: %h",bib_veri_o);
        $display("bib_adr_o: %h",bib_adr_o);
        $display("bib_veri_maske_o: %h",bib_veri_maske_o);
        
        kontrol_i=  `BIB_LH;
        adr_i= 32'h0000_00f0;
        deger_i=32'h0000_0030;
        bib_veri_i=32'h0000_0040;
        #10;
        $display("sonuc_o: %h",sonuc_o);
        $display("bib_veri_o: %h",bib_veri_o);
        $display("bib_adr_o: %h",bib_adr_o);
        $display("bib_veri_maske_o: %h",bib_veri_maske_o);
        
        kontrol_i=  `BIB_LHU;
        adr_i= 32'h0000_00f0;
        deger_i=32'h0000_0030;
        bib_veri_i=32'h0000_0040;
        #10;
        $display("sonuc_o: %h",sonuc_o);
        $display("bib_veri_o: %h",bib_veri_o);
        $display("bib_adr_o: %h",bib_adr_o);
        $display("bib_veri_maske_o: %h",bib_veri_maske_o);
              
    end
    
    
    
    
endmodule
