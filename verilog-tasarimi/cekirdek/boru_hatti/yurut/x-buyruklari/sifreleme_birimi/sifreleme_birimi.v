// sifreleme_birimi.v

`timescale 1ns / 1ps

`include "tanimlamalar.vh"

module sifreleme_birimi(
   input [2:0] kontrol_i,
   input [31:0] deger1_i,
   input [31:0] deger2_i,
   output reg [31:0] sonuc_o
);

   wire [5:0] hamming_uzakligi;
   hamming_distance hd_inst(
      .deger1_i(deger1_i),
      .deger2_i(deger2_i),
      .hamming_uzakligi(hamming_uzakligi)
   );
   
   wire [31:0] pkg_sonuc;
   pkg_unit pu_inst(
      .deger1_i(deger1_i),
      .deger2_i(deger2_i),
      .pkg_sonuc(pkg_sonuc)
   );
   
   wire [31:0] rvrs_sonuc;
   rvrs_unit ru_inst(
      .deger_i(deger1_i),
      .rvrs_sonuc(rvrs_sonuc)
   );
   
   wire [31:0] sladd_sonuc;
   sladd_unit su_inst(
      .deger1_i(deger1_i),
      .deger2_i(deger2_i),
      .sladd_sonuc(sladd_sonuc)
   );
   
   wire [5:0] sifir_sayisi;
   zero_counter zc_inst(
      .deger_i(deger1_i),
      .sifir_sayisi(sifir_sayisi)
   );
   
   wire [5:0] bir_sayisi;
   popcount pc_inst(
      .deger_i(deger1_i),
      .bir_sayisi(bir_sayisi)
   );
   
   always@*begin
      case(kontrol_i)
         `SIFRELEME_HMDST:
            sonuc_o = {26'b0,hamming_uzakligi};
         `SIFRELEME_PKG:
            sonuc_o = pkg_sonuc;
         `SIFRELEME_RVRS:
            sonuc_o = rvrs_sonuc;
         `SIFRELEME_SLADD:
            sonuc_o = sladd_sonuc;
         `SIFRELEME_CNTZ:
            sonuc_o = {26'b0,sifir_sayisi};
         `SIFRELEME_CNTP:
            sonuc_o = {26'b0,bir_sayisi};
         default:
            sonuc_o = 32'b0;
      endcase
   end


endmodule
