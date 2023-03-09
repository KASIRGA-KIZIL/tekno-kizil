`timescale 1ns / 1ps

`include "tanimlamalar.vh"

module tb_dallanma_ongorucu();

    reg rst_i;
    reg clk_i=1;
    reg ddb_durdur_i;
    // Tahmin okuma.
    reg [18:1]  ps_i;
    reg         buyruk_ctipi_i;  
    reg         buyruk_jal_tipi_i;
    reg         buyruk_jalr_tipi_i;
    reg         tahmin_et_i;
    reg         ras_pop;
    reg         ras_push;
    reg [18:1]  imm_i;
    wire [18:1] ongorulen_ps_o;
    wire        ongorulen_ps_gecerli_o;
    // Kalibrasyon sinyalleri
    reg [31:1] atlanan_ps_i;
    reg        atlanan_ps_gecerli_i;
    // hata duzeltme
    wire  [ 1:0] hata_duzelt_o;
    wire [18:1]  yrt_ps_o;
    wire         yrt_buyruk_ctipi_o;

    dallanma_ongorucu dotb(
        .rst_i (rst_i),
        .clk_i (clk_i),
        .ddb_durdur_i (ddb_durdur_i),
        // Tahmin okuma.
        .ps_i (ps_i),
        .buyruk_ctipi_i (buyruk_ctipi_i),
        .buyruk_jal_tipi_i (buyruk_jal_tipi_i),
        .buyruk_jalr_tipi_i (buyruk_jalr_tipi_i),
        .tahmin_et_i    (tahmin_et_i),
        .ras_pop (ras_pop), 
        .ras_push (ras_push),
        .imm_i (imm_i),   
        .ongorulen_ps_o (ongorulen_ps_o),
        .ongorulen_ps_gecerli_o (ongorulen_ps_gecerli_o),
        // Kalibrasyon sinyalleri
        .atlanan_ps_i (atlanan_ps_i),
        .atlanan_ps_gecerli_i (atlanan_ps_gecerli_i),
        // hata duzeltme
        .hata_duzelt_o (hata_duzelt_o),
        .yrt_ps_o (yrt_ps_o),
        .yrt_buyruk_ctipi_o (yrt_buyruk_ctipi_o)
    );
    
    
    always begin
        clk_i = ~clk_i;
        #5;
    end

    
    initial begin
        rst_i=0;
        ddb_durdur_i=0;
        ps_i=18'b000000_111111_000000;
        imm_i=18'b000000_000000_111111;
        tahmin_et_i=1;
        ras_pop=1;
        ras_push=1;        
        atlanan_ps_i=18'b000000_111111_100000;
        atlanan_ps_gecerli_i=1;
        buyruk_ctipi_i=1;
        buyruk_jal_tipi_i=1;
        buyruk_jalr_tipi_i=1;
    
        #10;
        $display("ongorulen_ps_o: %h",  ongorulen_ps_o);
        $display("ongorulen_ps_gecerli_o: %h",  ongorulen_ps_gecerli_o);
        $display("hata_duzelt_o: %h",   hata_duzelt_o);
        $display("yrt_ps_o: %h", yrt_ps_o);            
        $display("yrt_buyruk_ctipi_o: %h", yrt_buyruk_ctipi_o); 
        
        buyruk_ctipi_i=1;
        buyruk_jal_tipi_i=1;
        buyruk_jalr_tipi_i=0;
        #10;
        $display("ongorulen_ps_o: %h",  ongorulen_ps_o);
        $display("ongorulen_ps_gecerli_o: %h",  ongorulen_ps_gecerli_o);
        $display("hata_duzelt_o: %h",   hata_duzelt_o);
        $display("yrt_ps_o: %h", yrt_ps_o);            
        $display("yrt_buyruk_ctipi_o: %h", yrt_buyruk_ctipi_o);
        
        buyruk_ctipi_i=1;
        buyruk_jal_tipi_i=0;
        buyruk_jalr_tipi_i=1;
        #10;
        $display("ongorulen_ps_o: %h",  ongorulen_ps_o);
        $display("ongorulen_ps_gecerli_o: %h",  ongorulen_ps_gecerli_o);
        $display("hata_duzelt_o: %h",   hata_duzelt_o);
        $display("yrt_ps_o: %h", yrt_ps_o);            
        $display("yrt_buyruk_ctipi_o: %h", yrt_buyruk_ctipi_o);         
        
        buyruk_ctipi_i=1;
        buyruk_jal_tipi_i=0;
        buyruk_jalr_tipi_i=0;
        #10;
        $display("ongorulen_ps_o: %h",  ongorulen_ps_o);
        $display("ongorulen_ps_gecerli_o: %h",  ongorulen_ps_gecerli_o);
        $display("hata_duzelt_o: %h",   hata_duzelt_o);
        $display("yrt_ps_o: %h", yrt_ps_o);            
        $display("yrt_buyruk_ctipi_o: %h", yrt_buyruk_ctipi_o);  
        
        buyruk_ctipi_i=0;
        buyruk_jal_tipi_i=1;
        buyruk_jalr_tipi_i=1;
        #10;
        $display("ongorulen_ps_o: %h",  ongorulen_ps_o);
        $display("ongorulen_ps_gecerli_o: %h",  ongorulen_ps_gecerli_o);
        $display("hata_duzelt_o: %h",   hata_duzelt_o);
        $display("yrt_ps_o: %h", yrt_ps_o);            
        $display("yrt_buyruk_ctipi_o: %h", yrt_buyruk_ctipi_o);  
        
        buyruk_ctipi_i=0;
        buyruk_jal_tipi_i=1;
        buyruk_jalr_tipi_i=0;
        #10;
        $display("ongorulen_ps_o: %h",  ongorulen_ps_o);
        $display("ongorulen_ps_gecerli_o: %h",  ongorulen_ps_gecerli_o);
        $display("hata_duzelt_o: %h",   hata_duzelt_o);
        $display("yrt_ps_o: %h", yrt_ps_o);            
        $display("yrt_buyruk_ctipi_o: %h", yrt_buyruk_ctipi_o); 
        
        buyruk_ctipi_i=0;
        buyruk_jal_tipi_i=0;
        buyruk_jalr_tipi_i=1;
        #10;
        $display("ongorulen_ps_o: %h",  ongorulen_ps_o);
        $display("ongorulen_ps_gecerli_o: %h",  ongorulen_ps_gecerli_o);
        $display("hata_duzelt_o: %h",   hata_duzelt_o);
        $display("yrt_ps_o: %h", yrt_ps_o);            
        $display("yrt_buyruk_ctipi_o: %h", yrt_buyruk_ctipi_o);
        
        buyruk_ctipi_i=0;
        buyruk_jal_tipi_i=0;
        buyruk_jalr_tipi_i=0;
        #10;
        $display("ongorulen_ps_o: %h",  ongorulen_ps_o);
        $display("ongorulen_ps_gecerli_o: %h",  ongorulen_ps_gecerli_o);
        $display("hata_duzelt_o: %h",   hata_duzelt_o);
        $display("yrt_ps_o: %h", yrt_ps_o);            
        $display("yrt_buyruk_ctipi_o: %h", yrt_buyruk_ctipi_o);     
    end
    
    
endmodule
