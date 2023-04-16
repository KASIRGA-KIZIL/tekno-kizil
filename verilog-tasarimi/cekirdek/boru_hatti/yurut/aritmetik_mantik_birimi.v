// aritmetik_mantik_birimi.v
`timescale 1ns / 1ps

`include "tanimlamalar.vh"

module aritmetik_mantik_birimi(
   // kontrol_i sinyalleri
   input  wire [ 3:0] kontrol_i,
   // veri sinyalleri
   input  wire [31:0] deger1_i,
   input  wire [31:0] deger2_i,
   output wire [31:0] sonuc_o
);

   // Mantik sinyalleri
   wire [31:0] sonuc_xor;
   wire [31:0] sonuc_or;
   wire [31:0] sonuc_and;
   wire [31:0] sonuc_sll;
   wire [31:0] sonuc_srl;
   wire [31:0] sonuc_sra;
   wire [31:0] sonuc_slt;
   wire [31:0] sonuc_sltu;
   
   // Aritmetik Sinyalleri
   wire [32:0] deger2_top = (kontrol_i == `AMB_CIKARMA) ? {~deger2_i,1'b1} : {deger2_i,1'b0};
   wire [32:0] deger1_top = (kontrol_i == `AMB_CIKARMA) ? { deger1_i,1'b1} : {deger1_i,1'b0};
   wire [32:0] sonuc_top;
   wire elde_cla = (kontrol_i == `AMB_CIKARMA);
   
   `ifdef FPGA
      assign sonuc_top = deger2_top + deger1_top;
   `else
      toplayici`GATE sklanksy_toplayici(
         .a_in(deger1_top),
         .b_in(deger2_top),
         .sum (sonuc_top)
      );
   `endif
   
   assign sonuc_xor  = deger1_i   ^   deger2_i;
   assign sonuc_or   = deger1_i   |   deger2_i;
   assign sonuc_and  = deger1_i   &   deger2_i;
   assign sonuc_sll  = deger1_i   <<  deger2_i[4:0];
   assign sonuc_srl  = deger1_i   >>  deger2_i[4:0];
   assign sonuc_sra  = $signed(deger1_i) >>>  deger2_i[4:0];
   assign sonuc_slt  = ($signed(deger1_i) < $signed(deger2_i)) ? 32'b1 : 32'b0;
   assign sonuc_sltu = ( (deger1_i) < (deger2_i)) ? 32'b1 : 32'b0;
   
   assign sonuc_o = (kontrol_i == `AMB_CIKARMA) | (kontrol_i == `AMB_TOPLAMA) ? sonuc_top[32:1] :
                    (kontrol_i == `AMB_XOR    )                               ? sonuc_xor :
                    (kontrol_i == `AMB_OR     )                               ? sonuc_or  :
                    (kontrol_i == `AMB_AND    )                               ? sonuc_and :
                    (kontrol_i == `AMB_SLL    )                               ? sonuc_sll :
                    (kontrol_i == `AMB_SRL    )                               ? sonuc_srl :
                    (kontrol_i == `AMB_SRA    )                               ? sonuc_sra :
                    (kontrol_i == `AMB_SLT    )                               ? sonuc_slt :
                    (kontrol_i == `AMB_SLTU   )                               ? sonuc_sltu:
                    (kontrol_i == `AMB_GECIR  )                               ? deger2_i  :
                                                                              32'bx;

endmodule
