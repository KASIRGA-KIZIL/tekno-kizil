// carpma_birimi.v
`timescale 1ns / 1ps

`include "tanimlamalar.vh"

module carpma_birimi (
   input  wire        clk_i,
   input  wire        rst_i,
   input  wire        durdur_i,
   input  wire [ 1:0] kontrol_i,
   input  wire [31:0] deger1_i,
   input  wire [31:0] deger2_i,
   output wire [31:0] sonuc_o
);

   wire [66:0] sonuc;
   
   reg [32:0] deger1;
   reg [32:0] deger2;
   
   reg [1:0] kontrol;
   
   // Carpmalari 33 bit signed yap. Unsigned ise 32 bit'lik sinyalleri 33 e genislet
   always @(*) begin
      case(kontrol_i)
         `CARPMA_MUL: begin
            deger1   = {deger1_i[31],deger1_i};
            deger2   = {deger2_i[31],deger2_i};
         end
         `CARPMA_MULH: begin
            deger1   = {deger1_i[31],deger1_i};
            deger2   = {deger2_i[31],deger2_i};
         end
         `CARPMA_MULHU: begin
            deger1   = {1'b0,deger1_i};
            deger2   = {1'b0,deger2_i};
         end
         `CARPMA_MULHSU: begin
            deger1   = {deger1_i[31],deger1_i};
            deger2   = {1'b0,deger2_i};
         end
      endcase
   end
   
   `ifdef FPGA
      wire [66:0] a = {{34{deger1[32]}},deger1};
      wire [66:0] b = {{34{deger2[32]}},deger2};
      reg  [32:0] biriktirici;
      reg  [66:0] regli_sonuc;
      wire [67:0] carpma_sonucu = ((a) * (b)) + {35'b0,biriktirici};
      assign sonuc = regli_sonuc;
      always @(posedge clk_i) begin
         if(rst_i)begin
            biriktirici <= 33'b0;
         end else begin
            if(~durdur_i)
               biriktirici <= carpma_sonucu[32:0];
         end
         if(~durdur_i)
            regli_sonuc <= carpma_sonucu[66:0];
      end
   `else
      carp_biriktir cbd (
         .clk_i (clk_i ),
         .rst_i (rst_i ),
         .durdur_i(durdur_i),
         .IN1 (deger1 ),
         .IN2 (deger2 ),
         .result  ( sonuc)
      );
   `endif
   
   
   always @(posedge clk_i) begin
      if(~durdur_i)
         kontrol <= kontrol_i;
   end
   assign sonuc_o = (kontrol == `CARPMA_MUL ) ? sonuc[31: 0] : sonuc[63:32] ;
endmodule
