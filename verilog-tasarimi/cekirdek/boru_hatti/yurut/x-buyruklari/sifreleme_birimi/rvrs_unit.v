// rvrs_unit.v

`timescale 1ns / 1ps

module rvrs_unit(
   input [31:0] deger_i,
   output [31:0] rvrs_sonuc
);
   assign rvrs_sonuc = {deger_i[7:0], deger_i[15:8], deger_i[23:16], deger_i[31:24]};
endmodule
