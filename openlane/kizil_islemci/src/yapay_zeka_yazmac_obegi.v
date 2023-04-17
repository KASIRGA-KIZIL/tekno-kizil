// yapay_zeka_yazmac_obegi.v
`timescale 1ns / 1ps

`include "tanimlamalar.vh"

module yapay_zeka_yazmac_obegi(
   input  wire clk_i,
   input  wire rst_i,
   // okuma arayuzu
   output wire [31:0] oku_deger_o,
   input  wire        oku_en_i,
   // yazma arayuzu
   input  wire [31:0] yaz1_deger_i,
   input  wire [31:0] yaz2_deger_i,
   input  wire        yaz1_en_i,
   input  wire        yaz2_en_i
);
   reg [3:0] adr_oku;
   reg [3:0] adr_yaz;
   
   reg [31:0] yazmaclar[15:0];
   assign oku_deger_o = yazmaclar[adr_yaz];
   
   integer i = 0;
   always@(posedge clk_i) begin
      if (rst_i) begin
         adr_oku <= 4'd0;
         adr_yaz <= 4'd0;
         for(i = 0; i < 16; i = i + 1)
            yazmaclar[i] <= 32'd0;
      end
      else if(yaz1_en_i) begin
         yazmaclar[adr_oku] <= yaz1_deger_i;
         adr_oku            <= adr_oku + 4'd1;
         if(yaz2_en_i)begin
            yazmaclar[adr_oku+1] <= yaz2_deger_i;
            adr_oku <= adr_oku + 4'd2;
         end
      end
      if(oku_en_i)begin
         adr_yaz <= adr_yaz + 4'd1;
      end
   end

endmodule
