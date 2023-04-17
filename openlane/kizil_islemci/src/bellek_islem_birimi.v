// bellek_islem_birimi.v
`timescale 1ns / 1ps

`include "tanimlamalar.vh"

module bellek_islem_birimi(
   input  wire clk_i,
   input  wire rst_i,
   input  wire basla_i,
   output wire bitti_o,
   input  wire ddb_durdur_i,
   
   // yurut
   input  wire [ 2:0] kontrol_i,
   input  wire [31:0] adr_i,
   input  wire [31:0] deger_i,
   output wire [31:0] sonuc_o,
   
   // Bellek Islem Birimi <-> disarisi
   input  wire [31:0] bib_veri_i,
   input  wire        bib_durdur_i,
   output wire [31:0] bib_veri_o,
   output wire [31:0] bib_adr_o,
   output wire [ 3:0] bib_veri_maske_o,
   output wire        bib_sec_o
);

   // x_sonuc sinyalleri gerekli byte'i kaydirarak nihai sonucu elde eder. Kaydirma adrese goredir.
   wire [31:0] lh_sonuc = adr_i[1] ? {{16{bib_veri_i[31]}},bib_veri_i[31:16]} :
                                     {{16{bib_veri_i[15]}},bib_veri_i[15: 0]} ;
   
   wire [31:0] lhu_sonuc = adr_i[1] ? {{16{1'b0}},bib_veri_i[31:16]} :
                                      {{16{1'b0}},bib_veri_i[15: 0]} ;
   
   wire [31:0] lbu_sonuc = (adr_i[1:0] == 2'b00) ? {{24{1'b0}},bib_veri_i[ 7: 0]} :
                           (adr_i[1:0] == 2'b01) ? {{24{1'b0}},bib_veri_i[15: 8]} :
                           (adr_i[1:0] == 2'b10) ? {{24{1'b0}},bib_veri_i[23:16]} :
                                                   {{24{1'b0}},bib_veri_i[31:24]} ;
   
   wire [31:0] lb_sonuc = (adr_i[1:0] == 2'b00) ? {{24{bib_veri_i[ 7]}},bib_veri_i[ 7: 0]} :
                          (adr_i[1:0] == 2'b01) ? {{24{bib_veri_i[15]}},bib_veri_i[15: 8]} :
                          (adr_i[1:0] == 2'b10) ? {{24{bib_veri_i[23]}},bib_veri_i[23:16]} :
                                                  {{24{bib_veri_i[31]}},bib_veri_i[31:24]} ;
   
   // half ise yari maske kullanilir
   wire [3:0] sh_mask = adr_i[1] ? 4'b1100:
                                   4'b0011;
   
   // byte ise bir bitlik maske kullanilir
   wire [3:0] sb_mask =  (adr_i[1:0] == 2'b00) ? 4'b0001 :
                         (adr_i[1:0] == 2'b01) ? 4'b0010 :
                         (adr_i[1:0] == 2'b10) ? 4'b0100 :
                                                 4'b1000 ;
   
   // eger baslanmadiysa her zaman bitti sinyali verilir
   assign bitti_o = basla_i ? ~bib_durdur_i : 1'b1;
   
   assign bib_sec_o = (ddb_durdur_i) ? 1'b0 : basla_i;
   
   assign bib_veri_maske_o = (kontrol_i == `BIB_SB)  ? sb_mask :
                             (kontrol_i == `BIB_SH)  ? sh_mask :
                             (kontrol_i == `BIB_SW)  ? 4'b1111 :
                                                       4'b0000 ;
   
   assign sonuc_o = (kontrol_i == `BIB_LB ) ? lb_sonuc   :
                    (kontrol_i == `BIB_LH ) ? lh_sonuc   :
                    (kontrol_i == `BIB_LW ) ? bib_veri_i :
                    (kontrol_i == `BIB_LBU) ? lbu_sonuc  :
                    (kontrol_i == `BIB_LHU) ? lhu_sonuc  :
                                             bib_veri_i  ;
   
   // Gonderilen veri adres byte kadar kaydirilir
   assign bib_veri_o = (kontrol_i == `BIB_SB)  ? (deger_i << (mylog2(sb_mask)*8))           :
                       (kontrol_i == `BIB_SH)  ? ((sh_mask[3]) ? (deger_i << 16) : deger_i ):
                       (kontrol_i == `BIB_SW)  ?  deger_i :
                                                  deger_i ;
   
   assign bib_adr_o  = {adr_i[31:2],2'b0};
   
   // sentezlenebilen lookup table. 2 bitlik Log fonksiyonu icin
   function automatic [1:0] mylog2;
      input [3:0] data;
      begin
          mylog2 = data[0] ? 2'd0 :
                   data[1] ? 2'd1 :
                   data[2] ? 2'd2 :
                             2'd3 ;
      end
   endfunction
endmodule
