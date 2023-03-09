`timescale 1ns / 1ps


`include "tanimlamalar.vh"

module tb_getir();

    reg clk_i=1;
    reg rst_i;
    
    //  Denetim Durum Birimi
    reg  ddb_durdur_i;
    reg  ddb_bosalt_i;
    wire ddb_hazir_o;
    wire  ddb_yanlis_tahmin_o;
    
    //  L1 Buyruk Onbellegi
    reg        l1b_bekle_i;
    reg [31:0] l1b_deger_i;
    wire [31:1] l1b_adr_o;
    
    // Yurut
    reg        yrt_atlanan_ps_gecerli_i;
    reg [31:1] yrt_atlanan_ps_i;
    
    // Coz Yazmacoku
    wire  [31:0] cyo_buyruk_o;
    wire  [31:1] cyo_ps_artmis_o;
    wire  [31:1] cyo_ps_o;


    getir gtb(
        .clk_i (clk_i),
        .rst_i (rst_i),
        
        //  Denetim Durum Birimi
        .ddb_durdur_i (ddb_durdur_i),
        .ddb_bosalt_i (ddb_bosalt_i),
        .ddb_hazir_o (ddb_hazir_o),
        .ddb_yanlis_tahmin_o (ddb_yanlis_tahmin_o),
        
        //  L1 Buyruk Onbellegi
        .l1b_bekle_i (l1b_bekle_i),
        .l1b_deger_i (l1b_deger_i),
        .l1b_adr_o (l1b_adr_o),
        
        // Yurut
        .yrt_atlanan_ps_gecerli_i (yrt_atlanan_ps_gecerli_i),
        .yrt_atlanan_ps_i (yrt_atlanan_ps_i),
        
        // Coz Yazmacoku
        .cyo_buyruk_o (cyo_buyruk_o),
        .cyo_ps_artmis_o (cyo_ps_artmis_o),
        .cyo_ps_o (cyo_ps_o)
    );

    always begin
        clk_i = ~clk_i;
        #5;
    end

    
    initial begin
    
        rst_i=0;
        ddb_durdur_i=0;
        ddb_bosalt_i=1;
        l1b_deger_i=32'hf0f0_f0f0;
        yrt_atlanan_ps_i=32'hffff_0000;
        l1b_bekle_i=0;
        
        // Atlanan ps gecerli
        yrt_atlanan_ps_gecerli_i=1;
        #10;
        $display("cyo_buyruk_o: %h",  cyo_buyruk_o);
        $display("cyo_ps_artmis_o: %h",  cyo_ps_artmis_o);
        $display("cyo_ps_o: %h", cyo_ps_o);            
        $display("l1b_adr_o: %h", l1b_adr_o);     
        
        //Atlanan ps gecerli degil
        yrt_atlanan_ps_gecerli_i=0;
        #10;
        $display("cyo_buyruk_o: %h",  cyo_buyruk_o);
        $display("cyo_ps_artmis_o: %h",  cyo_ps_artmis_o);
        $display("cyo_ps_o: %h", cyo_ps_o);            
        $display("l1b_adr_o: %h", l1b_adr_o);  
        
        //ddb bosalt
        ddb_bosalt_i=0;
        #10;
        $display("cyo_buyruk_o: %h",  cyo_buyruk_o);
        $display("cyo_ps_artmis_o: %h",  cyo_ps_artmis_o);
        $display("cyo_ps_o: %h", cyo_ps_o);            
        $display("l1b_adr_o: %h", l1b_adr_o);  
        
           
    end

endmodule
