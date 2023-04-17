// yurut.v
`timescale 1ns / 1ps

`include "tanimlamalar.vh"

module yurut(
   input wire clk_i,
   input wire rst_i,
   
   // DDB sinyalleri
   input  wire ddb_durdur_i,
   output wire ddb_hazir_o,
   output wire ddb_yonlendir_gecersiz_o,
   
   // Coz-Yazmacoku bolumu sinyallleri
   input  wire [`MI_BIT-1:0] cyo_mikroislem_i,
   input  wire [        4:0] cyo_rd_adres_i,               // Rd'nin adresi
   input  wire [       18:1] cyo_ps_artmis_i,              // Rd=PC+4/2 islemi icin gerekli
   input  wire [       31:0] cyo_deger1_i,                 // Islem birimi girdileri. Yonlendirme ve Immediate secilmis son degerler.
   input  wire [       31:0] cyo_deger2_i,
   input  wire               cyo_yapay_zeka_en_i,          // yapay zeka buyruklari rs2 enable biti
   input  wire [       31:0] cyo_rs2_i,
   
   // Branch ve Jump buyruklari icin. Hepsi ayni cevrimde gidecek
   input  wire [ 2:0] cyo_lt_ltu_eq_i,                // Degerler arasindaki iliski. cyo_lt_ltu_eq_i: {lessthan,lt_unsigned, equal}
   output wire [18:1] gtr_atlanan_ps_o,               // Atlanilan yeni program sayaci, pc+imm veya rs1+imm degerini tasiyor.
   output wire        gtr_atlanan_ps_gecerli_o,       // Yeni program sayacinin gecerli olup olmadiginin sinyali. J tipinde hep gecerli
   
   // GERIYAZ icin
   output reg  [ 4:0] gy_rd_adres_o,              // Rd'nin adresi
   output reg  [18:1] gy_ps_artmis_o,             // Rd=PC+4/2 islemi icin gerekli
   output reg  [31:0] gy_rd_deger_o,              // islem birimlerinden cikan sonuc
   output reg  [ 2:0] gy_mikroislem_o,            // Rd secimi ve write enable sinyalleri
   output wire  [31:0] gy_carp_deger_o,              // islem birimlerinden cikan sonuc
   
   // Yonlendirme icin
   output wire [31:0] cyo_yonlendir_deger_o,
   
   // Bellek Islem Birimi
   input  wire [31:0] bib_veri_i,
   input  wire        bib_durdur_i,
   output wire [31:0] bib_veri_o,
   output wire [31:0] bib_adr_o,
   output wire [ 3:0] bib_veri_maske_o,
   output wire        bib_sec_o
);

   wire [31:0] amb_sonuc_w      ;
   wire [31:0] bol_sonuc_w      ;
   wire [31:0] sifreleme_sonuc_w;
   wire [31:0] bib_sonuc_w;
   
   aritmetik_mantik_birimi amb (
      .kontrol_i(cyo_mikroislem_i[`AMB]),
      .deger1_i(cyo_deger1_i),
      .deger2_i(cyo_deger2_i),
      .sonuc_o(amb_sonuc_w)
   );
   
   sifreleme_birimi sb (
      .kontrol_i(cyo_mikroislem_i[`SIFRELEME]),
      .deger1_i (cyo_deger1_i ),
      .deger2_i (cyo_deger2_i ),
      .sonuc_o  (sifreleme_sonuc_w)
   );
   
   wire [31:0] yzh_deger1;
   wire [31:0] yzh_deger2;
   
   // Carpma girislerini yzh kontrol eder. Eger yzh operasyonu ise carpma ona baglanir
   wire [31:0] carp_deger1 = (cyo_mikroislem_i[`BIRIM] == `BIRIM_CARPMA   ) ? cyo_deger1_i  :
                             (cyo_mikroislem_i[`BIRIM] == `BIRIM_YAPAYZEKA) ? yzh_deger1    :
                                                                              32'bx;
   
   wire [31:0] carp_deger2 = (cyo_mikroislem_i[`BIRIM] == `BIRIM_CARPMA   ) ? cyo_deger2_i  :
                             (cyo_mikroislem_i[`BIRIM] == `BIRIM_YAPAYZEKA) ? yzh_deger2    :
                                                                              32'bx;

   wire yzh_carpma_rst;
   wire cb_rst = rst_i | yzh_carpma_rst;
   carpma_birimi cb(
      .clk_i (clk_i ),
      .rst_i (cb_rst),
      .durdur_i(ddb_durdur_i),
      .kontrol_i(cyo_mikroislem_i[`CARPMA]),
      .deger1_i (carp_deger1),
      .deger2_i (carp_deger2),
      .sonuc_o  (gy_carp_deger_o)
   );
   
   wire bib_bitti;
   wire bib_basla = (cyo_mikroislem_i[`BIRIM] == `BIRIM_BIB);
   bellek_islem_birimi bib (
      .clk_i (clk_i ),
      .rst_i (rst_i ),
      .basla_i (bib_basla),
      .bitti_o (bib_bitti),
      .ddb_durdur_i (ddb_durdur_i),
      .kontrol_i (cyo_mikroislem_i[`BIB] ),
      .adr_i (amb_sonuc_w ),
      .deger_i (cyo_rs2_i),
      .sonuc_o (bib_sonuc_w ),
      .bib_veri_i        (bib_veri_i        ),
      .bib_durdur_i      (bib_durdur_i      ),
      .bib_veri_o        (bib_veri_o        ),
      .bib_adr_o         (bib_adr_o         ),
      .bib_veri_maske_o  (bib_veri_maske_o  ),
      .bib_sec_o         (bib_sec_o         )
   );
   
   wire yzh_bitti;
   wire yzh_basla = (cyo_mikroislem_i[`BIRIM] == `BIRIM_YAPAYZEKA);
   yapay_zeka_hizlandiricisi yzh (
      .clk_i (clk_i ),
      .rst_i (rst_i ),
      .ddb_durdur_i (ddb_durdur_i),
      .kontrol_i (cyo_mikroislem_i[`CONV]),
      .carpma_rst_o(yzh_carpma_rst),
      .basla_i  (yzh_basla),
      .bitti_o  (yzh_bitti),
      .rs2_en_i (cyo_yapay_zeka_en_i),
      .deger1_i (cyo_deger1_i),
      .deger2_i (cyo_deger2_i),
      .carp_deger1_o (yzh_deger1),
      .carp_deger2_o (yzh_deger2)
   );
   
   wire bol_bitti_w;
   wire bol_basla_w = (cyo_mikroislem_i[`BIRIM] == `BIRIM_BOLME);
   bolme_birimi bolb(
      .clk_i (clk_i),
      .rst_i (rst_i),
      .basla_i (bol_basla_w),
      .islem_i (cyo_mikroislem_i[`BOLME]),
      .bolunen_i (cyo_deger1_i),
      .bolen_i (cyo_deger2_i),
      .sonuc_o (bol_sonuc_w),
      .bitti_o  (bol_bitti_w)
   );
   
   // dallanma kosullari
   assign gtr_atlanan_ps_gecerli_o = (cyo_mikroislem_i[`DAL] == `DAL_EQ  ) ?  cyo_lt_ltu_eq_i[0] :
                                     (cyo_mikroislem_i[`DAL] == `DAL_NE  ) ? !cyo_lt_ltu_eq_i[0] :
                                     (cyo_mikroislem_i[`DAL] == `DAL_LT  ) ?  cyo_lt_ltu_eq_i[2] :
                                     (cyo_mikroislem_i[`DAL] == `DAL_GE  ) ? !cyo_lt_ltu_eq_i[2] :
                                     (cyo_mikroislem_i[`DAL] == `DAL_LTU ) ?  cyo_lt_ltu_eq_i[1] :
                                     (cyo_mikroislem_i[`DAL] == `DAL_GEU ) ? !cyo_lt_ltu_eq_i[1] :
                                     (cyo_mikroislem_i[`DAL] == `DAL_JAL ) ?  1'b1               :
                                     (cyo_mikroislem_i[`DAL] == `DAL_JALR) ?  1'b1               :
                                     (cyo_mikroislem_i[`DAL] == `DAL_YOK ) ?  1'b0               :
                                                                              1'b0; // x veya ? yerine 0 cunku dallanma_kosulu surekli okunuyor. Kazayla 1 verirsek gecmis olsun.
   
   // geri yaza gidecek verinin secilmesi
   wire [31:0] rd_deger_sonraki_w = (cyo_mikroislem_i[`BIRIM] == `BIRIM_AMB      ) ? amb_sonuc_w       :
                                    (cyo_mikroislem_i[`BIRIM] == `BIRIM_BOLME    ) ? bol_sonuc_w       :
                                    (cyo_mikroislem_i[`BIRIM] == `BIRIM_SIFRELEME) ? sifreleme_sonuc_w :
                                    (cyo_mikroislem_i[`BIRIM] == `BIRIM_BIB      ) ? bib_sonuc_w       :
                                                                                     32'hxxxx_xxxx;
   
   assign gtr_atlanan_ps_o = amb_sonuc_w[18:1];
   
   assign cyo_yonlendir_deger_o = (cyo_mikroislem_i[`DAL] == `DAL_JAL )|(cyo_mikroislem_i[`DAL] == `DAL_JALR) ? {8'h40,5'b0,cyo_ps_artmis_i,1'b0}:
                                                                                                                 rd_deger_sonraki_w;
   
   // Carpma islemi fiziksel olarak yonlendirilemez
   assign ddb_yonlendir_gecersiz_o = (cyo_mikroislem_i[`BIRIM] == `BIRIM_CARPMA);
   
   always @(posedge clk_i) begin
      if(rst_i) begin
         gy_mikroislem_o <= 0;
      end
      else begin
         if(!ddb_durdur_i)begin
            gy_mikroislem_o <= {cyo_mikroislem_i[`YAZMAC],cyo_mikroislem_i[`GERIYAZ]};
            gy_rd_deger_o   <= rd_deger_sonraki_w;
            gy_rd_adres_o   <= cyo_rd_adres_i;
            gy_ps_artmis_o  <= cyo_ps_artmis_i;
         end
      end
   end
   
   assign ddb_hazir_o = yzh_bitti & bol_bitti_w & bib_bitti;
   
   // Burasi sadece debug icin. Verilog sinyallerini Waveform'da gosterir.
   `ifdef COCOTB_SIM
      wire [31:0] debug_ps = {8'h40,5'b0,gtr_atlanan_ps_o,1'b0} ;
      reg [88*13:1] micro_str;
      always @* begin
         case(cyo_mikroislem_i)
            `NOP_MI:          begin micro_str = "`NOP_MI";     end
            `CONV_CLR_W_MI:   begin micro_str = "`CONV_CLR_W_MI"; end
            `CONV_CLR_X_MI:   begin micro_str = "`CONV_CLR_X_MI"; end
            `CONV_RUN_MI:     begin micro_str = "`CONV_RUN_MI";   end
            `RVRS_MI:         begin micro_str = "`RVRS_MI";       end
            `CNTZ_MI:         begin micro_str = "`CNTZ_MI";       end
            `CNTP_MI:         begin micro_str = "`CNTP_MI";       end
            `CONV_LD_W_MI:    begin micro_str = "`CONV_LD_W_MI";  end
            `CONV_LD_X_MI:    begin micro_str = "`CONV_LD_X_MI";  end
            `ADD_MI:          begin micro_str = "`ADD_MI";        end
            `AND_MI:          begin micro_str = "`AND_MI";        end
            `DIV_MI:          begin micro_str = "`DIV_MI";        end
            `DIVU_MI:         begin micro_str = "`DIVU_MI";       end
            `MUL_MI:          begin micro_str = "`MUL_MI";        end
            `MULH_MI:         begin micro_str = "`MULH_MI";       end
            `MULHSU_MI:       begin micro_str = "`MULHSU_MI";     end
            `MULHU_MI:        begin micro_str = "`MULHU_MI";      end
            `OR_MI:           begin micro_str = "`OR_MI";         end
            `REM_MI:          begin micro_str = "`REM_MI";        end
            `REMU_MI:         begin micro_str = "`REMU_MI";       end
            `SLL_MI:          begin micro_str = "`SLL_MI";        end
            `SLT_MI:          begin micro_str = "`SLT_MI";        end
            `SLTU_MI:         begin micro_str = "`SLTU_MI";       end
            `SRA_MI:          begin micro_str = "`SRA_MI";        end
            `SRL_MI:          begin micro_str = "`SRL_MI";        end
            `SUB_MI:          begin micro_str = "`SUB_MI";        end
            `XOR_MI:          begin micro_str = "`XOR_MI";        end
            `HMDST_MI:        begin micro_str = "`HMDST_MI";      end
            `PKG_MI:          begin micro_str = "`PKG_MI";        end
            `SLADD_MI:        begin micro_str = "`SLADD_MI";      end
            `SLLI_MI:         begin micro_str = "`SLLI_MI";       end
            `SRAI_MI:         begin micro_str = "`SRAI_MI";       end
            `SRLI_MI:         begin micro_str = "`SRLI_MI";       end
            `ADDI_MI:         begin micro_str = "`ADDI_MI";       end
            `ANDI_MI:         begin micro_str = "`ANDI_MI";       end
            `BEQ_MI:          begin micro_str = "`BEQ_MI";        end
            `BGE_MI:          begin micro_str = "`BGE_MI";        end
            `BGEU_MI:         begin micro_str = "`BGEU_MI";       end
            `BLT_MI:          begin micro_str = "`BLT_MI";        end
            `BLTU_MI:         begin micro_str = "`BLTU_MI";       end
            `BNE_MI:          begin micro_str = "`BNE_MI";        end
            `JALR_MI:         begin micro_str = "`JALR_MI";       end
            `LB_MI:           begin micro_str = "`LB_MI";         end
            `LBU_MI:          begin micro_str = "`LBU_MI";        end
            `LH_MI:           begin micro_str = "`LH_MI";         end
            `LHU_MI:          begin micro_str = "`LHU_MI";        end
            `LW_MI:           begin micro_str = "`LW_MI";         end
            `ORI_MI:          begin micro_str = "`ORI_MI";        end
            `SB_MI:           begin micro_str = "`SB_MI";         end
            `SH_MI:           begin micro_str = "`SH_MI";         end
            `SLTI_MI:         begin micro_str = "`SLTI_MI";       end
            `SLTIU_MI:        begin micro_str = "`SLTIU_MI";      end
            `SW_MI:           begin micro_str = "`SW_MI";         end
            `XORI_MI:         begin micro_str = "`XORI_MI";       end
            `AUIPC_MI:        begin micro_str = "`AUIPC_MI";      end
            `JAL_MI:          begin micro_str = "`JAL_MI";        end
            `LUI_MI:          begin micro_str = "`LUI_MI";        end
            default:          begin micro_str = "DEFAULT_MI";     end
         endcase
      end
   `endif
endmodule
