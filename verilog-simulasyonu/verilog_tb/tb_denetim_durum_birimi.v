`timescale 1ns / 1ps

`include "tanimlamalar.vh"

module tb_denetim_durum_birimi();

    reg clk_i=1;
    reg rst_i;
    // GETIR sinyalleri
    reg gtr_yanlis_tahmin_i;       // Dallanma ongorucu, ongoremedi
    reg gtr_hazir_i;               // Getir hazir degil. L1 miss oldu vs. Buyruk gecersiz
    wire gtr_durdur_o;
    wire gtr_bosalt_o;
    
    // COZ sinyalleri
    reg [4:0] cyo_rs1_adres_i;          // RS1 adresi
    reg [4:0] cyo_rs2_adres_i;          // RS2 adresi
    wire [1:0] cyo_yonlendir_kontrol1_o; // Yonlendirme(Forwarding) deger1 icin kontrol sinyali
    wire [1:0] cyo_yonlendir_kontrol2_o; // Yonlendirme(Forwarding) deger2 icin kontrol sinyali
    wire       cyo_durdur_o;
    wire       cyo_bosalt_o;
    
    // YURUT sinyalleri
    wire      yrt_durdur_o;
    reg       yrt_yaz_yazmac_i;         // Rd geri yaziliyor ise 1
    reg       yrt_hazir_i;              // Birden fazla cevrim suren bolme vs. icin
    reg [4:0] yrt_rd_adres_i;           // Rd nin adresi
    reg       yrt_yonlendir_gecerli_i;  

    //Geri yaz sinyalleri
     reg       gy_yaz_yazmac_i;   // Rd geri yaziliyor ise 1
     reg [4:0] gy_rd_adres_i;   
    
    denetim_durum_birimi ddbtb(
        .clk_i (clk_i),
        .rst_i (rst_i),
        // GETIR sinyalleri
        .gtr_yanlis_tahmin_i (gtr_yanlis_tahmin_i),       // Dallanma ongorucu, ongoremedi
        .gtr_hazir_i  (gtr_hazir_i),               // Getir hazir degil. L1 miss oldu vs. Buyruk gecersiz
        .gtr_durdur_o (gtr_durdur_o),
        .gtr_bosalt_o (gtr_bosalt_o),
        
        // COZ sinyalleri
        .cyo_rs1_adres_i (cyo_rs1_adres_i),          // RS1 adresi
        .cyo_rs2_adres_i (cyo_rs2_adres_i),          // RS2 adresi
        .cyo_yonlendir_kontrol1_o (cyo_yonlendir_kontrol1_o), // Yonlendirme(Forwarding) deger1 icin kontrol sinyali
        .cyo_yonlendir_kontrol2_o (cyo_yonlendir_kontrol2_o), // Yonlendirme(Forwarding) deger2 icin kontrol sinyali
        .cyo_durdur_o (cyo_durdur_o),
        .cyo_bosalt_o (cyo_bosalt_o),
        
        // YURUT sinyalleri
        .yrt_durdur_o (yrt_durdur_o),
        .yrt_yaz_yazmac_i (yrt_yaz_yazmac_i),         // Rd geri yaziliyor ise 1
        .yrt_hazir_i  (yrt_hazir_i),              // Birden fazla cevrim suren bolme vs. icin
        .yrt_rd_adres_i (yrt_rd_adres_i),           // Rd nin adresi
        .yrt_yonlendir_gecerli_i (yrt_yonlendir_gecerli_i),
        .gy_yaz_yazmac_i (gy_yaz_yazmac_i),
        .gy_rd_adres_i (gy_rd_adres_i)    
    );
    
    
    always begin
        clk_i=~clk_i;
        #5;
    end
    
    
    initial begin
        rst_i=0;
        
        //Getir sinyalleri
        gtr_yanlis_tahmin_i=0; 
        gtr_hazir_i=0; 
        #10; 
        $display("gtr_durdur_o: %b",gtr_durdur_o);
        $display("gtr_bosalt_o: %b",gtr_bosalt_o);
        
        gtr_yanlis_tahmin_i=1; 
        gtr_hazir_i=0; 
        #10; 
        $display("gtr_durdur_o: %b",gtr_durdur_o);
        $display("gtr_bosalt_o: %b",gtr_bosalt_o);       
        
        
        gtr_yanlis_tahmin_i=0; 
        gtr_hazir_i=1; 
        #10; 
        $display("gtr_durdur_o: %b",gtr_durdur_o);
        $display("gtr_bosalt_o: %b",gtr_bosalt_o);       
        
        gtr_yanlis_tahmin_i=1; 
        gtr_hazir_i=1; 
        #10; 
        $display("gtr_durdur_o: %b",gtr_durdur_o);
        $display("gtr_bosalt_o: %b",gtr_bosalt_o);       
        
        
        //Coz sinyalleri
        cyo_rs1_adres_i= 5'b11111;
        cyo_rs2_adres_i= 5'b11111;
        yrt_rd_adres_i = 5'b11111;
        gy_rd_adres_i =  5'b11111;
        yrt_yonlendir_gecerli_i=1;
        yrt_yaz_yazmac_i=1;
        yrt_hazir_i=0;
        #10;
        $display("cyo_yonlendir_kontrol1_o: %b",cyo_yonlendir_kontrol1_o);
        $display("cyo_yonlendir_kontrol2_o: %b",cyo_yonlendir_kontrol2_o); 
        $display("cyo_durdur_o: %b",cyo_durdur_o);
        $display("cyo_bosalt_o: %b",cyo_bosalt_o);
        
        cyo_rs1_adres_i= 5'b11111;
        cyo_rs2_adres_i= 5'b11110;
        #10
        $display("cyo_yonlendir_kontrol1_o: %b",cyo_yonlendir_kontrol1_o);
        $display("cyo_yonlendir_kontrol2_o: %b",cyo_yonlendir_kontrol2_o); 
        $display("cyo_durdur_o: %b",cyo_durdur_o);
        $display("cyo_bosalt_o: %b",cyo_bosalt_o);
        
        yrt_yonlendir_gecerli_i=0;
        #10;
        $display("cyo_yonlendir_kontrol1_o: %b",cyo_yonlendir_kontrol1_o);
        $display("cyo_yonlendir_kontrol2_o: %b",cyo_yonlendir_kontrol2_o); 
        $display("cyo_durdur_o: %b",cyo_durdur_o);
        $display("cyo_bosalt_o: %b",cyo_bosalt_o); 
        
        yrt_yonlendir_gecerli_i=1;
        yrt_yaz_yazmac_i=0;
        #10;
        $display("cyo_yonlendir_kontrol1_o: %b",cyo_yonlendir_kontrol1_o);
        $display("cyo_yonlendir_kontrol2_o: %b",cyo_yonlendir_kontrol2_o); 
        $display("cyo_durdur_o: %b",cyo_durdur_o);
        $display("cyo_bosalt_o: %b",cyo_bosalt_o);
        
        yrt_yonlendir_gecerli_i=1;
        yrt_yaz_yazmac_i=1;
        yrt_hazir_i=0;
        #10;
        $display("cyo_yonlendir_kontrol1_o: %b",cyo_yonlendir_kontrol1_o);
        $display("cyo_yonlendir_kontrol2_o: %b",cyo_yonlendir_kontrol2_o); 
        $display("cyo_durdur_o: %b",cyo_durdur_o);
        $display("cyo_bosalt_o: %b",cyo_bosalt_o);
        
        yrt_yonlendir_gecerli_i=1;
        yrt_yaz_yazmac_i=0;
        gy_rd_adres_i =  5'b11111;
        gy_yaz_yazmac_i =1; 
        #10;
        $display("cyo_yonlendir_kontrol1_o: %b",cyo_yonlendir_kontrol1_o);
        $display("cyo_yonlendir_kontrol2_o: %b",cyo_yonlendir_kontrol2_o); 
        $display("cyo_durdur_o: %b",cyo_durdur_o);
        $display("cyo_bosalt_o: %b",cyo_bosalt_o);
        
        gy_rd_adres_i =  5'b11110;
        gy_yaz_yazmac_i =1; 
        #10;
        $display("cyo_yonlendir_kontrol1_o: %b",cyo_yonlendir_kontrol1_o);
        $display("cyo_yonlendir_kontrol2_o: %b",cyo_yonlendir_kontrol2_o); 
        $display("cyo_durdur_o: %b",cyo_durdur_o);
        $display("cyo_bosalt_o: %b",cyo_bosalt_o);
        
        gy_rd_adres_i =  5'b11110;
        gy_yaz_yazmac_i =0; 
        #10;
        $display("cyo_yonlendir_kontrol1_o: %b",cyo_yonlendir_kontrol1_o);
        $display("cyo_yonlendir_kontrol2_o: %b",cyo_yonlendir_kontrol2_o); 
        $display("cyo_durdur_o: %b",cyo_durdur_o);
        $display("cyo_bosalt_o: %b",cyo_bosalt_o);
        
        //Yurut sinyalleri
        $display("yrt_durdur_o : %b",yrt_durdur_o );
        
        gtr_hazir_i=0;
        #10;
        $display("yrt_durdur_o : %b",yrt_durdur_o );
   
    
    end
   
    
endmodule
