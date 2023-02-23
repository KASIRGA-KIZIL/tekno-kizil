// tb_coz_yazmacoku.v
`timescale 1ns / 1ps

`include "tanimlamalar.vh"

module tb_coz_yazmacoku();
    reg clk_i=1;
    reg rst_i;
    
    // GETIR'den gelen sinyaller
    reg [31:0] gtr_buyruk_i;
    reg [31:1] gtr_ps_i;
    reg [31:1] gtr_ps_artmis_i;  // Rd=PC+4/2 islemi icin gerekli
    
    // YURUT'e giden sinyaller
    wire [`MI_BIT-1:0] yrt_mikroislem_o;         // mikroislem buyruklara ait tum bilgiyi bitleriyle veriyor
    wire [       31:0] yrt_deger1_o;             // Yurut birim girdileri. Yonlendirme ve Immediate secilmis son degerler.
    wire [       31:0] yrt_deger2_o;
    wire [        2:0] yrt_lt_ltu_eq_o;          // Dallanma ve atlama icin gerekli. Degerler arasindaki iliski. lt_ltu_eq_i: {lessthan,lt_unsigned, equal}
    wire               yrt_yapay_zeka_en_o;      // Yapay zeka biriminin rs2 icin yazma(enable) sinyali
    wire [       31:0] yrt_rs2_o;
    
        
    wire [       31:1] yrt_ps_artmis_o;      // GERIYAZ'a kadar giden sinyaller
    wire [        4:0] yrt_rd_adres_o;       // GERIYAZ'a kadar giden sinyaller
        
    reg  [       31:0] yrt_yonlendir_deger_i; // Yonlendirme (Forwarding) sinyalleri
    
    // GERIYAZ'dan gelen sinyaller
    reg [ 4:0] gy_yaz_adres_i;     // Rd'nin adresi
    reg [31:0] gy_yaz_deger_i;     // Rd'nin degeri
    reg        gy_yaz_yazmac_i;           // Rd'ye sonuc yazilacak mi
    
    // Denetim Durum Birimi sinyalleri
    reg      ddb_durdur_i;             // COZ'u durdur
    reg       ddb_bosalt_i;             // COZ'u bosalt
    reg [1:0] ddb_yonlendir_kontrol1_i; // YURUT ve GERIYAZ'dan gelen degerleri yonlendir
    reg [1:0] ddb_yonlendir_kontrol2_i;
    wire [4:0] ddb_rs1_adres_o;          // Suanki buyrugun rs adresleri. Yonlendirme icin.
    wire [4:0] ddb_rs2_adres_o;

    coz_yazmacoku cyo(
        .clk_i (clk_i),
        .rst_i (rst_i),
        
        // GETIR'den gelen sinyaller
        .gtr_buyruk_i (gtr_buyruk_i),
        .gtr_ps_i (gtr_ps_i),
        .gtr_ps_artmis_i (gtr_ps_artmis_i),  // Rd=PC+4/2 islemi icin gerekli
        
        // YURUT'e giden sinyaller
        .yrt_mikroislem_o (yrt_mikroislem_o),         // mikroislem buyruklara ait tum bilgiyi bitleriyle veriyor
        .yrt_deger1_o (yrt_deger1_o),             // Yurut birim girdileri. Yonlendirme ve Immediate secilmis son degerler.
        .yrt_deger2_o (yrt_deger2_o),
        .yrt_lt_ltu_eq_o (yrt_lt_ltu_eq_o),          // Dallanma ve atlama icin gerekli. Degerler arasindaki iliski. lt_ltu_eq_i: {lessthan,lt_unsigned, equal}
        .yrt_yapay_zeka_en_o (yrt_yapay_zeka_en_o),      // Yapay zeka biriminin rs2 icin yazma(enable) sinyali
        .yrt_rs2_o (yrt_rs2_o),
        
            
        .yrt_ps_artmis_o (yrt_ps_artmis_o),      // GERIYAZ'a kadar giden sinyaller
        .yrt_rd_adres_o (yrt_rd_adres_o),       // GERIYAZ'a kadar giden sinyaller
            
        .yrt_yonlendir_deger_i (yrt_yonlendir_deger_i), // Yonlendirme (Forwarding) sinyalleri
        
        // GERIYAZ'dan gelen sinyaller
        .gy_yaz_adres_i (gy_yaz_adres_i),     // Rd'nin adresi
        .gy_yaz_deger_i (gy_yaz_deger_i),     // Rd'nin degeri
        .gy_yaz_yazmac_i(gy_yaz_yazmac_i),           // Rd'ye sonuc yazilacak mi
        
        // Denetim Durum Birimi sinyalleri
        .ddb_durdur_i (ddb_durdur_i),             // COZ'u durdur
        .ddb_bosalt_i (ddb_bosalt_i),             // COZ'u bosalt
        .ddb_yonlendir_kontrol1_i (ddb_yonlendir_kontrol1_i), // YURUT ve GERIYAZ'dan gelen degerleri yonlendir
        .ddb_yonlendir_kontrol2_i (ddb_yonlendir_kontrol2_i),
        .ddb_rs1_adres_o (ddb_rs1_adres_o),          // Suanki buyrugun rs adresleri. Yonlendirme icin.
        .ddb_rs2_adres_o (ddb_rs2_adres_o)   
    );

    always begin
        clk_i = ~clk_i;
        #5;
    end


    initial begin
        rst_i = 1'b1;
        #100;
        rst_i = 0;
        ddb_durdur_i=0;             
        ddb_bosalt_i=0;
        gtr_ps_i=31'd100;
        gtr_ps_artmis_i=31'd101;
        
        
        gtr_buyruk_i = `EBREAK;  
        #10; if(yrt_mikroislem_o == `NOP_MI) $display("passed"); else $display("EBREAK: FAILED!: %h", yrt_mikroislem_o);
        
        gtr_buyruk_i = `ECALL;  
        #10; if(yrt_mikroislem_o == `NOP_MI) $display("passed"); else $display("ECALL: FAILED!: %h", yrt_mikroislem_o);
        
        gtr_buyruk_i = `CONV_CLR_W; 
        #10; if(yrt_mikroislem_o == `CONV_CLR_W_MI) $display("passed"); else $display("CONV_CLR_W: FAILED!: %h", yrt_mikroislem_o);
        
        gtr_buyruk_i = `CONV_CLR_X; 
        #10; if(yrt_mikroislem_o == `CONV_CLR_X_MI) $display("passed"); else $display("CONV_CLR_X: FAILED!: %h", yrt_mikroislem_o);
        
        gtr_buyruk_i = `CONV_RUN; 
        #10; if(yrt_mikroislem_o == `CONV_RUN_MI) $display("passed"); else $display("CONV_RUN: FAILED!: %h", yrt_mikroislem_o);
        
        gtr_buyruk_i = `RVRS; 
        #10; if(yrt_mikroislem_o == `RVRS_MI) $display("passed"); else $display("RVRS: FAILED!: %h", yrt_mikroislem_o);
        
        gtr_buyruk_i = `CNTZ; #10; 
        if(yrt_mikroislem_o == `CNTZ_MI) $display("passed"); else $display("CNTZ: FAILED!: %h", yrt_mikroislem_o);
        
        gtr_buyruk_i = `CNTP; #10; 
        if(yrt_mikroislem_o == `CNTP_MI) $display("passed"); else $display("CNTP: FAILED!: %h", yrt_mikroislem_o);
        
        gtr_buyruk_i = `CONV_LD_W; 
        #10; if(yrt_mikroislem_o == `CONV_LD_W_MI) $display("passed"); else $display("CONV_LD_W: FAILED!: %h", yrt_mikroislem_o);
        
        gtr_buyruk_i = `CONV_LD_X; 
        #10; if(yrt_mikroislem_o == `CONV_LD_X_MI) $display("passed"); else $display("CONV_LD_X: FAILED!: %h", yrt_mikroislem_o);
        
        gtr_buyruk_i = `ADD; 
        #10; if(yrt_mikroislem_o == `ADD_MI) $display("passed"); else $display("ADD: FAILED!: %h", yrt_mikroislem_o);
        
        gtr_buyruk_i = `AND; 
        #10; if(yrt_mikroislem_o == `AND_MI) $display("passed"); else $display("AND: FAILED!: %h", yrt_mikroislem_o);
        
        gtr_buyruk_i = `DIV; 
        #10; if(yrt_mikroislem_o == `DIV_MI) $display("passed"); else $display("DIV: FAILED!: %h", yrt_mikroislem_o);
        
        gtr_buyruk_i = `DIVU; 
        #10; if(yrt_mikroislem_o == `DIVU_MI) $display("passed"); else $display("DIVU: FAILED!: %h", yrt_mikroislem_o);
        
        gtr_buyruk_i = `MUL; 
        #10; if(yrt_mikroislem_o == `MUL_MI) $display("passed"); else $display("MUL: FAILED!: %h", yrt_mikroislem_o);
        
        gtr_buyruk_i = `MULH; 
        #10; if(yrt_mikroislem_o == `MULH_MI) $display("passed"); else $display("MULH: FAILED!: %h", yrt_mikroislem_o);
        
        gtr_buyruk_i = `MULHSU; 
        #10; if(yrt_mikroislem_o == `MULHSU_MI) $display("passed"); else $display("MULHSU: FAILED!: %h", yrt_mikroislem_o);
        
        gtr_buyruk_i = `MULHU; 
        #10; if(yrt_mikroislem_o == `MULHU_MI) $display("passed"); else $display("MULHU: FAILED!: %h", yrt_mikroislem_o);
        
        gtr_buyruk_i = `OR; 
        #10; if(yrt_mikroislem_o == `OR_MI) $display("passed"); else $display("OR: FAILED!: %h", yrt_mikroislem_o);
        
        gtr_buyruk_i = `REM; 
        #10; if(yrt_mikroislem_o == `REM_MI) $display("passed"); else $display("REM: FAILED!: %h", yrt_mikroislem_o);
        
        gtr_buyruk_i = `REMU; 
        #10; if(yrt_mikroislem_o == `REMU_MI) $display("passed"); else $display("REMU: FAILED!: %h", yrt_mikroislem_o);
        
        gtr_buyruk_i = `SLL; 
        #10; if(yrt_mikroislem_o == `SLL_MI) $display("passed"); else $display("SLL: FAILED!: %h", yrt_mikroislem_o);
        
        gtr_buyruk_i = `SLT; 
        #10; if(yrt_mikroislem_o == `SLT_MI) $display("passed"); else $display("SLT: FAILED!: %h", yrt_mikroislem_o);
        
        gtr_buyruk_i = `SLTU; 
        #10; if(yrt_mikroislem_o == `SLTU_MI) $display("passed"); else $display("SLTU: FAILED!: %h", yrt_mikroislem_o);
        
        gtr_buyruk_i = `SRA; 
        #10; if(yrt_mikroislem_o == `SRA_MI) $display("passed"); else $display("SRA: FAILED!: %h", yrt_mikroislem_o);
        
        gtr_buyruk_i = `SRL; 
        #10; if(yrt_mikroislem_o == `SRL_MI) $display("passed"); else $display("SRL: FAILED!: %h", yrt_mikroislem_o);
        
        gtr_buyruk_i = `SUB; 
        #10; if(yrt_mikroislem_o == `SUB_MI) $display("passed"); else $display("SUB: FAILED!: %h", yrt_mikroislem_o);
        
        gtr_buyruk_i = `XOR; 
        #10; if(yrt_mikroislem_o == `XOR_MI) $display("passed"); else $display("XOR: FAILED!: %h", yrt_mikroislem_o);
        
        gtr_buyruk_i = `HMDST; 
        #10; if(yrt_mikroislem_o == `HMDST_MI) $display("passed"); else $display("HMDST: FAILED!: %h", yrt_mikroislem_o);
        
        gtr_buyruk_i = `PKG; 
        #10; if(yrt_mikroislem_o == `PKG_MI) $display("passed"); else $display("PKG: FAILED!: %h", yrt_mikroislem_o);
        
        gtr_buyruk_i = `SLADD; 
        #10; if(yrt_mikroislem_o == `SLADD_MI) $display("passed"); else $display("SLADD: FAILED!: %h", yrt_mikroislem_o);
        
        gtr_buyruk_i = `SLLI; 
        #10; if(yrt_mikroislem_o == `SLLI_MI) $display("passed"); else $display("SLLI: FAILED!: %h", yrt_mikroislem_o);
        
        gtr_buyruk_i = `SRAI; 
        #10; if(yrt_mikroislem_o == `SRAI_MI) $display("passed"); else $display("SRAI: FAILED!: %h", yrt_mikroislem_o);
        
        gtr_buyruk_i = `SRLI; 
        #10; if(yrt_mikroislem_o == `SRLI_MI) $display("passed"); else $display("SRLI: FAILED!: %h", yrt_mikroislem_o);
        
        gtr_buyruk_i = `ADDI; 
        #10; if(yrt_mikroislem_o == `ADDI_MI) $display("passed"); else $display("ADDI: FAILED!: %h", yrt_mikroislem_o);
        
        gtr_buyruk_i = `ANDI; 
        #10; if(yrt_mikroislem_o == `ANDI_MI) $display("passed"); else $display("ANDI: FAILED!: %h", yrt_mikroislem_o);
        
        gtr_buyruk_i = `BEQ; 
        #10; if(yrt_mikroislem_o == `BEQ_MI) $display("passed"); else $display("BEQ: FAILED!: %h", yrt_mikroislem_o);
        
        gtr_buyruk_i = `BGE; 
        #10; if(yrt_mikroislem_o == `BGE_MI) $display("passed"); else $display("BGE: FAILED!: %h", yrt_mikroislem_o);
        
        gtr_buyruk_i = `BGEU; 
        #10; if(yrt_mikroislem_o == `BGEU_MI) $display("passed"); else $display("BGEU: FAILED!: %h", yrt_mikroislem_o);
        
        gtr_buyruk_i = `BLT; 
        #10; if(yrt_mikroislem_o == `BLT_MI) $display("passed"); else $display("BLT: FAILED!: %h", yrt_mikroislem_o);
        
        gtr_buyruk_i = `BLTU; 
        #10; if(yrt_mikroislem_o == `BLTU_MI) $display("passed"); else $display("BLTU: FAILED!: %h", yrt_mikroislem_o);
        
        gtr_buyruk_i = `BNE; 
        #10; if(yrt_mikroislem_o == `BNE_MI) $display("passed"); else $display("BNE: FAILED!: %h", yrt_mikroislem_o);
        
        gtr_buyruk_i = `FENCE; 
        #10; if(yrt_mikroislem_o == `NOP_MI) $display("passed"); else $display("FENCE: FAILED!: %h", yrt_mikroislem_o);
        
        gtr_buyruk_i = `FENCE_I; 
        #10; if(yrt_mikroislem_o == `NOP_MI) $display("passed"); else $display("FENCE_I: FAILED!: %h", yrt_mikroislem_o);
        
        gtr_buyruk_i = `JALR; 
        #10; if(yrt_mikroislem_o == `JALR_MI) $display("passed"); else $display("JALR: FAILED!: %h", yrt_mikroislem_o);
        
        gtr_buyruk_i = `LB; 
        #10; if(yrt_mikroislem_o == `LB_MI) $display("passed"); else $display("LB: FAILED!: %h", yrt_mikroislem_o);
        
        gtr_buyruk_i = `LBU; 
        #10; if(yrt_mikroislem_o == `LBU_MI) $display("passed"); else $display("LBU: FAILED!: %h", yrt_mikroislem_o);
        
        gtr_buyruk_i = `LH; 
        #10; if(yrt_mikroislem_o == `LH_MI) $display("passed"); else $display("LH: FAILED!: %h", yrt_mikroislem_o);
        
        gtr_buyruk_i = `LHU; 
        #10; if(yrt_mikroislem_o == `LHU_MI) $display("passed"); else $display("LHU: FAILED!: %h", yrt_mikroislem_o);
        
        gtr_buyruk_i = `LW; 
        #10; if(yrt_mikroislem_o == `LW_MI) $display("passed"); else $display("LW: FAILED!: %h", yrt_mikroislem_o);
        
        gtr_buyruk_i = `ORI; 
        #10; if(yrt_mikroislem_o == `ORI_MI) $display("passed"); else $display("ORI: FAILED!: %h", yrt_mikroislem_o);
        
        gtr_buyruk_i = `SB; 
        #10; if(yrt_mikroislem_o == `SB_MI) $display("passed"); else $display("SB: FAILED!: %h", yrt_mikroislem_o);
        
        gtr_buyruk_i = `SH; 
        #10; if(yrt_mikroislem_o == `SH_MI) $display("passed"); else $display("SH: FAILED!: %h", yrt_mikroislem_o);
        
        gtr_buyruk_i = `SLTI; 
        #10; if(yrt_mikroislem_o == `SLTI_MI) $display("passed"); else $display("SLTI: FAILED!: %h", yrt_mikroislem_o);
        
        gtr_buyruk_i = `SLTIU; 
        #10; if(yrt_mikroislem_o == `SLTIU_MI) $display("passed"); else $display("SLTIU: FAILED!: %h", yrt_mikroislem_o);
        
        gtr_buyruk_i = `SW; 
        #10; if(yrt_mikroislem_o == `SW_MI) $display("passed"); else $display("SW: FAILED!: %h", yrt_mikroislem_o);
        
        gtr_buyruk_i = `XORI; 
        #10; if(yrt_mikroislem_o == `XORI_MI) $display("passed"); else $display("XORI: FAILED!: %h", yrt_mikroislem_o);
        
        gtr_buyruk_i = `AUIPC; 
        #10; if(yrt_mikroislem_o == `AUIPC_MI) $display("passed"); else $display("AUIPC: FAILED!: %h", yrt_mikroislem_o);
        
        gtr_buyruk_i = `JAL; 
        #10; if(yrt_mikroislem_o == `JAL_MI) $display("passed"); else $display("JAL: FAILED!: %h", yrt_mikroislem_o);
        
        gtr_buyruk_i = `LUI; 
        #10; if(yrt_mikroislem_o == `LUI_MI) $display("passed"); else $display("LUI: FAILED!: %h", yrt_mikroislem_o);
        
        $finish;
    end

endmodule
