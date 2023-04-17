// zero_counter.v

// Kullanilan algoritma belirtilen makalede anlatilmaktadir.
// https://ieeexplore.ieee.org/abstract/document/4539802
// Low-Power Leading-Zero Counting and Anticipation Logic for High-Speed Floating Point Units

`timescale 1ns / 1ps

module zero_counter(
   input wire [31:0] deger_i,
   output wire [5:0] sifir_sayisi
);

   reg [31:0] ters_deger;
   
   integer i;
   always @(*) begin
      for(i = 0; i< 32; i=i+1)
         ters_deger[i] = deger_i[31-i];
   end
   
   wire [3:0] alt_sifir_sayisi;
   wire [3:0] ust_sifir_sayisi;
   wire alt_hepsi_sifir;
   wire ust_hepsi_sifir;
   
   zero_counter_16 zc16_ust_dut (
      .A (ters_deger[31:16]),
      .Z (ust_sifir_sayisi),
      .V (ust_hepsi_sifir)
   );
   
   zero_counter_16 zc16_alt_dut (
      .A (ters_deger[15:0]),
      .Z (alt_sifir_sayisi),
      .V (alt_hepsi_sifir)
   );
   
   assign sifir_sayisi = ust_hepsi_sifir &  alt_hepsi_sifir ? 6'd32                           :
                         ust_hepsi_sifir & ~alt_hepsi_sifir ? 5'd16 + {1'b0,alt_sifir_sayisi} :
                                                             ({2'b0,ust_sifir_sayisi})        ;
   
endmodule
