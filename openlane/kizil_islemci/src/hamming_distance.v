// hamming_distance.v

`timescale 1ns / 1ps

module hamming_distance(
   input [31:0] deger1_i,
   input [31:0] deger2_i,
   output [5:0] hamming_uzakligi
);
   wire [31:0]bit_farklari;
   assign bit_farklari = deger1_i ^ deger2_i;
   
   wire [5:0]fark_sayisi;
   popcount hd_pc_inst(
      .deger_i(bit_farklari),
      .bir_sayisi(fark_sayisi)
   );
   assign hamming_uzakligi = fark_sayisi;

endmodule
