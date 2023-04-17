// bolme_birimi.v
`timescale 1ns / 1ps

`include "tanimlamalar.vh"

module bolme_birimi(
   input clk_i,
   input rst_i,
   input basla_i,
   input [1:0] islem_i, //00 DIVU, 01 REMU, 10 DIV, 11 REM
   input [31:0] bolunen_i,
   input [31:0] bolen_i,
   output wire [31:0] sonuc_o,
   output reg bitti_o = 1
);
   reg [32:0] sonuc;
   assign sonuc_o = sonuc[31:0];

   reg [32:0] bolen_r = 0;
   reg [32:0] bolen_sonraki_r = 0;

   reg [32:0] bolunen_r = 0;
   reg [32:0] bolunen1_r = 0;
   reg [32:0] bolunen1_sonraki_r = 0;
   reg [32:0] bolunen_sonraki_r = 0;

   reg [32:0] fark_r = 0;
   reg [32:0] fark1_r = 0;
   reg [32:0] fark1_sonraki_r = 0;
   reg [32:0] fark_sonraki_r = 0;

   reg [18:0] cevrim_r = 19'd1;
   reg [18:0] cevrim_sonraki_r = 19'd1;

   reg[32:0] gecici_fark_r = 0;
   reg[32:0] gecici_fark1_r = 0;

   wire isaret_bolunen_r = bolunen_i[31];
   wire isaret_bolen_r = bolen_i[31];

   wire [31:0] tmp_bolen = ~bolen_i + 1;
   wire [31:0] tmp_bolunen = ~bolunen_i + 1;
   always @(*)begin
      bolen_sonraki_r = bolen_r;
      fark1_sonraki_r = fark1_r;
      bolunen1_sonraki_r = bolunen1_r ;
      bolunen_sonraki_r = bolunen_r;
      fark_sonraki_r = fark_r;
      cevrim_sonraki_r = cevrim_r;
      sonuc = 33'dx;
      gecici_fark_r = 33'bx;
      bitti_o = 1;

      if(basla_i) begin
         bitti_o = 0;

         case({cevrim_r[18], cevrim_r[0]})
            2'b01: begin // ilk cevrim
               // Isaretli bolme yapiliyorsa ve isatetler farkliysa sayilarin negatifi aliniyor ve sifirla genisletiliyor.
               // Cikarma isleminde tasmalari onlemek icin sifirla bir bit genisletme yapiliyor.
               if(islem_i[1] & bolen_i[31]) begin
                  bolen_sonraki_r = {1'b0,tmp_bolen};
               end
               else begin
                  bolen_sonraki_r= {1'b0, bolen_i};
               end

               if(islem_i[1] & bolunen_i[31])begin
                  bolunen_sonraki_r = {1'b0,tmp_bolunen};
               end
               else begin
                  bolunen_sonraki_r ={1'b0, bolunen_i};
               end

               cevrim_sonraki_r = cevrim_r<<1;
            end

            2'b00: begin // Bolme islemi yapiliyor.
               // Cevrim sayisini dusurmek icin bir cevirimde iki adim ilerleniyor.
               // Birinci adim
               fark1_sonraki_r = {fark_r[31:0], bolunen_r[32]} - bolen_r;
               gecici_fark1_r = fark1_sonraki_r;
               bolunen1_sonraki_r = bolunen_r<<1;

               if(fark1_sonraki_r[32])begin
                  bolunen1_sonraki_r[0] = 0;
                  fark1_sonraki_r = gecici_fark1_r + bolen_r;
               end
               else begin
                  bolunen1_sonraki_r[0] = 1;
               end

               // İkinci adim
               fark_sonraki_r = {fark1_sonraki_r[31:0], bolunen1_sonraki_r[32]} - bolen_r;
               gecici_fark_r = fark_sonraki_r;
               bolunen_sonraki_r = bolunen1_sonraki_r<<1;

               if(fark_sonraki_r[32])begin
                 bolunen_sonraki_r[0] = 0;
                 fark_sonraki_r = gecici_fark_r + bolen_r;
               end
               else begin
                  bolunen_sonraki_r[0] = 1;
               end

               cevrim_sonraki_r = cevrim_r<<1;
            end

            2'b10: begin // son cevrim. islem girisine gore sonuclar ataniyor.
               casez({islem_i, (isaret_bolen_r ^ isaret_bolunen_r)})
                  {`BOLME_DIVU, 1'b?}: sonuc = bolunen1_r;
                  {`BOLME_REMU, 1'b?}: sonuc = fark1_r;
                  {`BOLME_DIV, 1'b0}: sonuc = bolunen1_r;
                  {`BOLME_DIV, 1'b1}: sonuc = (~bolunen1_r) + 1;
                  {`BOLME_REM, 1'b0}: begin
                      case (isaret_bolunen_r)
                        1'b0: begin
                           sonuc = fark1_r;
                        end
                        1'b1: begin
                           sonuc = (~fark1_r)+1 ;
                        end
                     endcase
                  end
                  {`BOLME_REM, 1'b1}: begin
                     case (isaret_bolunen_r)
                        1'b0: begin
                           sonuc = fark1_r;
                        end
                        1'b1: begin
                           sonuc = (~fark1_r)+1 ;
                        end
                     endcase
                  end
                  default: sonuc = 33'hxxxx_xxxx;
               endcase

            cevrim_sonraki_r = 19'd1;
            fark_sonraki_r = 0;
            bolen_sonraki_r = 0;
            bolunen_sonraki_r = 0;
            bolunen1_sonraki_r = 0;
            fark1_sonraki_r = 0;

            if(islem_i[0] && (bolen_i==0))
               sonuc = {1'b0,bolunen_i};
            if(!islem_i[0] && (bolen_i == 0))
               sonuc = -1;
               bitti_o= 1;
            end

            default: begin
               bolen_sonraki_r = 33'dx;
               bolunen_sonraki_r = 33'dx;
               fark_sonraki_r = 33'dx;
               bolunen1_sonraki_r = 33'dx;
               fark1_sonraki_r = 33'dx;
               cevrim_sonraki_r = 1;
               sonuc = 33'dx;
               bitti_o = 1;
            end
         endcase
      end
      else begin
         bolen_sonraki_r = 33'dx;
         bolunen_sonraki_r = 33'dx;
         fark_sonraki_r = 33'dx;
         bolunen1_sonraki_r = 33'dx;
         fark1_sonraki_r = 33'dx;
         cevrim_sonraki_r = 1;
         sonuc = 33'dx;
         bitti_o = 1;
      end
   end

   always @(posedge clk_i)begin
      if(rst_i | !basla_i) begin
         bolen_r    <= 0;
         bolunen_r  <= 0;
         fark_r     <= 0;
         cevrim_r   <= 1;
         fark1_r    <= 0;
         bolunen1_r <= 0;
      end
      else begin
         fark1_r    <= fark1_sonraki_r;
         bolunen1_r <= bolunen1_sonraki_r;
         bolen_r    <= bolen_sonraki_r;
         bolunen_r  <= bolunen_sonraki_r;
         fark_r     <= fark_sonraki_r;
         cevrim_r   <= cevrim_sonraki_r;
      end
   end

endmodule
