`timescale 1ns / 1ps

`include "tanimlamalar.vh"

module tb_cekirdek();

    reg clk_i;
    reg rst_i;
    
    // l1 buyruk bellegi
    reg        l1b_bekle_i;
    reg [31:0] l1b_deger_i;
    wire [31:0] l1b_adres_o;
    
    // Bellek Islem Birimi
    reg [31:0] bib_veri_i;
    reg        bib_durdur_i;
    wire [31:0] bib_veri_o;
    wire [31:0] bib_adr_o;
    wire [ 3:0] bib_veri_maske_o;
    wire        bib_yaz_gecerli_o;
    wire        bib_sec_o;

    cekirdek ctb(
        .clk_i (clk_i),
        .rst_i (rst_i),
        
        // l1 buyruk bellegi
        .l1b_bekle_i (l1b_bekle_i),
        .l1b_deger_i (l1b_deger_i),
        .l1b_adres_o (l1b_adres_o),
        
        // Bellek Islem Birimi
        .bib_veri_i   (bib_veri_i),
        .bib_durdur_i (bib_durdur_i),
        .bib_veri_o   (bib_veri_o),
        .bib_adr_o    (bib_adr_o),
        .bib_veri_maske_o  (bib_veri_maske_o),
        .bib_yaz_gecerli_o (bib_yaz_gecerli_o),
        .bib_sec_o    (bib_sec_o)
    );
    
    
    always begin
        clk_i=~clk_i;
        #5;
    end
    
    
    initial begin
    
    end
endmodule
