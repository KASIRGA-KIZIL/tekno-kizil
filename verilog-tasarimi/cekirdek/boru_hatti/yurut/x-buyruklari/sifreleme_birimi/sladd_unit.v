// sladd_unit.v

`timescale 1ns / 1ps

module sladd_unit(
   input [31:0] deger1_i,
   input [31:0] deger2_i,
   output [31:0] sladd_sonuc
);
   assign sladd_sonuc = deger2_i + (deger1_i << 1);
endmodule
