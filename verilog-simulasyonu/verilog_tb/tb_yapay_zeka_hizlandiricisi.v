`timescale 1ns / 1ps

`include "tanimlamalar.vh"

//durumlarin duzenlenmesi lazim, anlamli sonuclar icin
module tb_yapay_zeka_hizlandiricisi();
    
    reg clk_i=1;
    reg rst_i;
    reg ddb_durdur_i;
    
    // Kontrol sinyalleri
    reg [2:0] kontrol_i;
    wire   carpma_rst_o;
    reg         basla_i;
    wire        bitti_o;
    reg        rs2_en_i;
    
    // Veri yolu
    reg  [31:0]      deger1_i;
    reg  [31:0]      deger2_i;
    wire [31:0] carp_deger1_o;
    wire [31:0] carp_deger2_o;

    yapay_zeka_hizlandiricisi yzht(
    
        .clk_i(clk_i),
        .rst_i(rst_i),
        .ddb_durdur_i(ddb_durdur_i),

        // Kontrol sinyalleri
        .kontrol_i(kontrol_i),
        .carpma_rst_o(carpma_rst_o),
        .basla_i(basla_i),
        .bitti_o(bitti_o),
        .rs2_en_i(rs2_en_i),

        // Veri yolu
        .deger1_i(deger1_i),
        .deger2_i(deger2_i),
        .carp_deger1_o(carp_deger1_o),
        .carp_deger2_o(carp_deger2_o)
    
    );
    
    always begin
        clk_i=~clk_i;
        #5;
    end
    
    
    initial begin
        rst_i=0;
        ddb_durdur_i=0;        
        basla_i=1;
        rs2_en_i=1;
        
        kontrol_i=  `YZH_RUN;
        deger1_i= 32'd100;
        deger2_i=32'd5;
        #145;
        $display("carp_deger1_o: %d",carp_deger1_o);
        $display("carp_deger2_o: %d",carp_deger2_o);
        
        kontrol_i=  `YZH_LD_W;
        deger1_i= 32'd100;
        deger2_i=32'd5;
        #10;
        $display("carp_deger1_o: %d",carp_deger1_o);
        $display("carp_deger2_o: %d",carp_deger2_o);
        
        kontrol_i=  `YZH_CLR_W;
        deger1_i= 32'd100;
        deger2_i=32'd5;
        #10;
        $display("carp_deger1_o: %d",carp_deger1_o);
        $display("carp_deger2_o: %d",carp_deger2_o);
        
        kontrol_i=  `YZH_LD_X;
        deger1_i= 32'd100;
        deger2_i=32'd5;
        #10;
        $display("carp_deger1_o: %d",carp_deger1_o);
        $display("carp_deger2_o: %d",carp_deger2_o);
        
        kontrol_i=  `YZH_CLR_X;
        deger1_i= 32'd100;
        deger2_i=32'd5;
        #10;
        $display("carp_deger1_o: %d",carp_deger1_o);
        $display("carp_deger2_o: %d",carp_deger2_o);
        
          
    end
    
    
    
endmodule
