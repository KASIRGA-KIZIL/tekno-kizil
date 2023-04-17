// pkg_unit.v

`timescale 1ns / 1ps

module pkg_unit(
   input [31:0] deger1_i,
   input [31:0] deger2_i,
   output [31:0] pkg_sonuc
);
   assign pkg_sonuc = {deger2_i[15:0],deger1_i[15:0]};
endmodule
