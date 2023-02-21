`timescale 1ns / 1ps

//BIB ve yapay zeka buyruklari eklenecek
`include "tanimlamalar.vh"

module tb_yurut();
 
 
    reg clk_i=1;
    reg rst_i;

    // DDB sinyalleri
    reg ddb_durdur_i;
    wire ddb_hazir_o;
    wire ddb_yonlendir_gecerli_o;
    
    // Coz-Yazmacoku bolumu sinyallleri
    reg [`MI_BIT-1:0] cyo_mikroislem_i;
    reg [        4:0] cyo_rd_adres_i;               // Rd'nin adresi
    reg [       31:1] cyo_ps_artmis_i;              // Rd=PC+4/2 islemi icin gerekli
    reg [       31:0] cyo_deger1_i;                 // Islem birimi girdileri. Yonlendirme ve Immediate secilmis son degerler.
    reg [       31:0] cyo_deger2_i;
    reg               cyo_yapay_zeka_en_i;          // yapay zeka buyruklari rs2 enable biti
    reg [       31:0] cyo_rs2_i;
    
    // Branch ve Jump buyruklari icin. Hepsi ayni cevrimde gidecek
    reg [ 2:0]  cyo_lt_ltu_eq_i;                // Degerler arasindaki iliski. cyo_lt_ltu_eq_i: {lessthan,lt_unsigned, equal}
    wire [31:1] gtr_atlanan_ps_o;               // Atlanilan yeni program sayaci, pc+imm veya rs1+imm degerini tasiyor.
    wire        gtr_atlanan_ps_gecerli_o;       // Yeni program sayacinin gecerli olup olmadiginin sinyali. J tipinde hep gecerli
    
    // GERIYAZ icin
    wire  [ 4:0] gy_rd_adres_o;              // Rd'nin adresi
    wire  [31:1] gy_ps_artmis_o;             // Rd=PC+4/2 islemi icin gerekli
    wire  [31:0] gy_rd_deger_o;              // islem birimlerinden cikan sonuc
    wire  [31:0] gy_carpma_deger_o;          // Carpma Biriminin ciktisi.
    wire  [ 2:0] gy_mikroislem_o;            // Rd secimi ve write enable sinyalleri
    
    // Yonlendirme icin
    wire [31:0] cyo_yonlendir_deger_o;
    
    // Bellek Islem Birimi
    reg  [31:0] bib_veri_i;
    reg         bib_durdur_i;
    wire [31:0] bib_veri_o;
    wire [31:0] bib_adr_o;
    wire [ 3:0] bib_veri_maske_o;
    wire        bib_yaz_gecerli_o;
    wire        bib_sec_o;

    
    
    yurut ytb(
    
        .clk_i(clk_i),
        .rst_i(rst_i),
        
        // DDB sinyalleri
        .ddb_durdur_i(ddb_durdur_i),
        .ddb_hazir_o(ddb_hazir_o),
        .ddb_yonlendir_gecerli_o(ddb_yonlendir_gecerli_o),
        
        // Coz-Yazmacoku bolumu sinyallleri
        .cyo_mikroislem_i(cyo_mikroislem_i),
        .cyo_rd_adres_i(cyo_rd_adres_i),               // Rd'nin adresi
        .cyo_ps_artmis_i(cyo_ps_artmis_i),              // Rd=PC+4/2 islemi icin gerekli
        .cyo_deger1_i(cyo_deger1_i),                 // Islem birimi girdileri. Yonlendirme ve Immediate secilmis son degerler.
        .cyo_deger2_i(cyo_deger2_i),
        .cyo_yapay_zeka_en_i(cyo_yapay_zeka_en_i),          // yapay zeka buyruklari rs2 enable biti
        .cyo_rs2_i(cyo_rs2_i),
        
        // Branch ve Jump buyruklari icin. Hepsi ayni cevrimde gidecek
        .cyo_lt_ltu_eq_i(cyo_lt_ltu_eq_i),                // Degerler arasindaki iliski. cyo_lt_ltu_eq_i: {lessthan,lt_unsigned, equal}
        .gtr_atlanan_ps_o (gtr_atlanan_ps_o),               // Atlanilan yeni program sayaci, pc+imm veya rs1+imm degerini tasiyor.
        .gtr_atlanan_ps_gecerli_o (gtr_atlanan_ps_gecerli_o),       // Yeni program sayacinin gecerli olup olmadiginin sinyali. J tipinde hep gecerli
        
        // GERIYAZ icin
        .gy_rd_adres_o(gy_rd_adres_o),              // Rd'nin adresi
        .gy_ps_artmis_o(gy_ps_artmis_o),             // Rd=PC+4/2 islemi icin gerekli
        .gy_rd_deger_o(gy_rd_deger_o),              // islem birimlerinden cikan sonuc
        .gy_carpma_deger_o(gy_carpma_deger_o),          // Carpma Biriminin ciktisi.
        .gy_mikroislem_o(gy_mikroislem_o),            // Rd secimi ve write enable sinyalleri
        
        // Yonlendirme icin
        .cyo_yonlendir_deger_o(cyo_yonlendir_deger_o),
        
        // Bellek Islem Birimi
        .bib_veri_i(bib_veri_i),
        .bib_durdur_i(bib_durdur_i),
        .bib_veri_o(bib_veri_o),
        .bib_adr_o(bib_adr_o),
        .bib_veri_maske_o (bib_veri_maske_o),
        .bib_yaz_gecerli_o(bib_yaz_gecerli_o),
        .bib_sec_o(bib_sec_o)
    );

    always begin
        clk_i=~clk_i;
        #5;
    end

    initial begin
        rst_i=0;
        ddb_durdur_i=0;
        cyo_rd_adres_i=4'b0100;
        cyo_ps_artmis_i=31'd100;
        
        //Aritmetik mantik birimi
        cyo_mikroislem_i=`ADD_MI;
        cyo_deger1_i=32'd50;
        cyo_deger2_i=32'd40;
        #10;
        $display("ADD_MI");
        $display("gy_mikroislem_o: %h",gy_mikroislem_o);
        $display("gy_rd_deger_o: %h",  gy_rd_deger_o);
        $display("gy_rd_adres_o: %h",  gy_rd_adres_o);
        $display("gy_ps_artmis_o: %h", gy_ps_artmis_o);
        
        cyo_mikroislem_i=`SUB_MI;
        cyo_deger1_i=32'd50;
        cyo_deger2_i=32'd40;
        #10;
        $display("SUB_MI");
        $display("gy_mikroislem_o: %h",gy_mikroislem_o);
        $display("gy_rd_deger_o: %h",  gy_rd_deger_o);
        $display("gy_rd_adres_o: %h",  gy_rd_adres_o);
        $display("gy_ps_artmis_o: %h", gy_ps_artmis_o);
        
        cyo_mikroislem_i=`XOR_MI;
        cyo_deger1_i=32'hf0f0_f0f0;
        cyo_deger2_i=32'hff0f_0f0f;
        #10;
        $display("XOR_MI");
        $display("gy_mikroislem_o: %h",gy_mikroislem_o);
        $display("gy_rd_deger_o: %h",  gy_rd_deger_o);
        $display("gy_rd_adres_o: %h",  gy_rd_adres_o);
        $display("gy_ps_artmis_o: %h", gy_ps_artmis_o);
        
        cyo_mikroislem_i=`OR_MI;
        cyo_deger1_i=32'hf0f0_f0f0;
        cyo_deger2_i=32'h0f0f_0f0f;
        #10;
        $display("OR_MI");
        $display("gy_mikroislem_o: %h",gy_mikroislem_o);
        $display("gy_rd_deger_o: %h",  gy_rd_deger_o);
        $display("gy_rd_adres_o: %h",  gy_rd_adres_o);
        $display("gy_ps_artmis_o: %h", gy_ps_artmis_o);
        
        cyo_mikroislem_i=`AND_MI;
        cyo_deger1_i=32'hf0f0_f0f0;
        cyo_deger2_i=32'h0f0f_0f0f;
        #10;
        $display("AND_MI");
        $display("gy_mikroislem_o: %h",gy_mikroislem_o);
        $display("gy_rd_deger_o: %h",  gy_rd_deger_o);
        $display("gy_rd_adres_o: %h",  gy_rd_adres_o);
        $display("gy_ps_artmis_o: %h", gy_ps_artmis_o);
        
        cyo_mikroislem_i=`SLL_MI;
        cyo_deger1_i=32'hf0f0_f0f0;
        cyo_deger2_i=32'h0000_0004;
        #10;
        $display("SLL_MI");
        $display("gy_mikroislem_o: %h",gy_mikroislem_o);
        $display("gy_rd_deger_o: %h",  gy_rd_deger_o);
        $display("gy_rd_adres_o: %h",  gy_rd_adres_o);
        $display("gy_ps_artmis_o: %h", gy_ps_artmis_o);
        
        cyo_mikroislem_i=`SRL_MI;
        cyo_deger1_i=32'hf0f0_f0f0;
        cyo_deger2_i=32'h0000_0004;
        #10;
        $display("SRL_MI");
        $display("gy_mikroislem_o: %h",gy_mikroislem_o);
        $display("gy_rd_deger_o: %h",  gy_rd_deger_o);
        $display("gy_rd_adres_o: %h",  gy_rd_adres_o);
        $display("gy_ps_artmis_o: %h", gy_ps_artmis_o);
        
        cyo_mikroislem_i=`SRA_MI;
        cyo_deger1_i=32'hf0f0_f0f0;
        cyo_deger2_i=32'h0000_0004;
        #10;
        $display("SRA_MI");
        $display("gy_mikroislem_o: %h",gy_mikroislem_o);
        $display("gy_rd_deger_o: %h",  gy_rd_deger_o);
        $display("gy_rd_adres_o: %h",  gy_rd_adres_o);
        $display("gy_ps_artmis_o: %h", gy_ps_artmis_o);
        
        cyo_mikroislem_i=`SLT_MI;
        cyo_deger1_i=32'hf0f0_f0f0;
        cyo_deger2_i=32'h0000_0004;
        #10;
        $display("SLT_MI");
        $display("gy_mikroislem_o: %h",gy_mikroislem_o);
        $display("gy_rd_deger_o: %h",  gy_rd_deger_o);
        $display("gy_rd_adres_o: %h",  gy_rd_adres_o);
        $display("gy_ps_artmis_o: %h", gy_ps_artmis_o);
        
        cyo_mikroislem_i=`SLTU_MI;
        cyo_deger1_i=32'hf0f0_f0f0;
        cyo_deger2_i=32'h0000_0004;
        #10;
        $display("SLTU_MI");
        $display("gy_mikroislem_o: %h",gy_mikroislem_o);
        $display("gy_rd_deger_o: %h",  gy_rd_deger_o);
        $display("gy_rd_adres_o: %h",  gy_rd_adres_o);
        $display("gy_ps_artmis_o: %h", gy_ps_artmis_o);
        
        //Carpma birimi
        cyo_mikroislem_i=`MUL_MI;
        cyo_deger1_i=32'hf0f0_f0f0;
        cyo_deger2_i=32'h0000_0004;
        #10;
        $display("MUL_MI");
        $display("gy_mikroislem_o: %h",gy_mikroislem_o);
        $display("gy_carpma_deger_o: %h",  gy_carpma_deger_o);
        $display("gy_rd_adres_o: %h",  gy_rd_adres_o);
        $display("gy_ps_artmis_o: %h", gy_ps_artmis_o);
        
        cyo_mikroislem_i=`MULH_MI;
        cyo_deger1_i=32'hf0f0_f0f0;
        cyo_deger2_i=32'h0000_0004;
        #10;
        $display("MULH_MI");
        $display("gy_mikroislem_o: %h",gy_mikroislem_o);
        $display("gy_carpma_deger_o: %h",  gy_carpma_deger_o);
        $display("gy_rd_adres_o: %h",  gy_rd_adres_o);
        $display("gy_ps_artmis_o: %h", gy_ps_artmis_o);
        
        cyo_mikroislem_i=`MULHSU_MI;
        cyo_deger1_i=32'hf0f0_f0f0;
        cyo_deger2_i=32'h0000_0004;
        #10;
        $display("MULHSU_MI");
        $display("gy_mikroislem_o: %h",gy_mikroislem_o);
        $display("gy_carpma_deger_o: %h",  gy_carpma_deger_o);
        $display("gy_rd_adres_o: %h",  gy_rd_adres_o);
        $display("gy_ps_artmis_o: %h", gy_ps_artmis_o);
        
        cyo_mikroislem_i=`MULHU_MI;
        cyo_deger1_i=32'hf0f0_f0f0;
        cyo_deger2_i=32'h0000_0004;
        #10;
        $display("MULHU_MI");
        $display("gy_mikroislem_o: %h",gy_mikroislem_o);
        $display("gy_carpma_deger_o: %h",  gy_carpma_deger_o);
        $display("gy_rd_adres_o: %h",  gy_rd_adres_o);
        $display("gy_ps_artmis_o: %h", gy_ps_artmis_o);
        
        //Bolme Birimi
        
        cyo_mikroislem_i=`DIV_MI;
        cyo_deger1_i=32'd40;
        cyo_deger2_i=32'd10;
        #350;
        $display("DIV_MI");
        $display("gy_mikroislem_o: %h",gy_mikroislem_o);
        $display("gy_rd_deger_o: %d",  gy_rd_deger_o);
        $display("gy_rd_adres_o: %h",  gy_rd_adres_o);
        $display("gy_ps_artmis_o: %h", gy_ps_artmis_o);
        
        cyo_mikroislem_i=`DIVU_MI;
        cyo_deger1_i=32'd400;
        cyo_deger2_i=32'd3;
        #350;
        $display("DIVU_MI");
        $display("gy_mikroislem_o: %h",gy_mikroislem_o);
        $display("gy_rd_deger_o: %h",  gy_rd_deger_o);
        $display("gy_rd_adres_o: %h",  gy_rd_adres_o);
        $display("gy_ps_artmis_o: %h", gy_ps_artmis_o);
        
        cyo_mikroislem_i=`REM_MI;
        cyo_deger1_i=32'd400;
        cyo_deger2_i=32'd3;
        #350;
        $display("REM_MI");
        $display("gy_mikroislem_o: %h",gy_mikroislem_o);
        $display("gy_rd_deger_o: %h",  gy_rd_deger_o);
        $display("gy_rd_adres_o: %h",  gy_rd_adres_o);
        $display("gy_ps_artmis_o: %h", gy_ps_artmis_o);
        
        cyo_mikroislem_i=`REMU_MI;
        cyo_deger1_i=32'd400;
        cyo_deger2_i=32'd3;
        #350;
        $display("REMU_MI");
        $display("gy_mikroislem_o: %h",gy_mikroislem_o);
        $display("gy_rd_deger_o: %h",  gy_rd_deger_o);
        $display("gy_rd_adres_o: %h",  gy_rd_adres_o);
        $display("gy_ps_artmis_o: %h", gy_ps_artmis_o);
        
        
    
    end



endmodule
