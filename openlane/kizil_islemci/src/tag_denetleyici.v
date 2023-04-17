// Tag denetleyici
// Ayni anda iki farkli adresteki tag'leri okumak icin 2 tane 256 satirlik RAM'i kontrol eder
// RAM'lerden birisi tek adresleri oteki cift olan adresleri depolamak icin kullanilir.
// Bu sayede Unaligned/Hizasiz okuma yapilabilir.

module tag_denetleyici (
   input wire clk_i,
   input wire rst_i,
   // Port 0: W
   input wire       wen_i,
   input wire [8:0] wadr_i,
   // Port 0: R
   output wire [8:0] data0_o,
   input  wire [8:0] radr0_i,
   // Port 1: R
   output wire [8:0] data1_o,
   input  wire [8:0] radr1_i,
   // RAM256_T0
   output wire       we0_o,
   output wire [7:0] adr0_o,
   input  wire [7:0] datao0_i,
   // RAM256_T1
   output wire       we1_o,
   output wire [7:0] adr1_o,
   input  wire [7:0] datao1_i
);
   reg [511:0] RAM;
   
   wire [7:0] tage;
   wire [7:0] tago;
   
   wire [7:0] tag_addre = wen_i ? wadr_i[8:1] : radr0_i[8:1];
   wire [7:0] tag_addro = wen_i ? wadr_i[8:1] : radr1_i[8:1];
   
   always @(posedge clk_i) begin
       if(rst_i)
           RAM <= 0;
       else
           if(wen_i) RAM[wadr_i] <= 1'b1;
   end
   
   // Gerekli kosullar matematiksel olarak bulunmus olup gerekli ispat en altta gosterilmistir.
   wire [7:0] tag0 = (~radr0_i[0]) ? tage : tago;
   wire [7:0] tag1 = (((~radr0_i[0]) & (radr0_i == radr1_i)) || (( radr0_i[0]) & (radr0_i != radr1_i))) ? tage : tago;
   
   assign data0_o = {RAM[radr0_i],tag0};
   assign data1_o = {RAM[radr1_i],tag1};
   
   
   wire wee = ~wadr_i[0] ? wen_i : 1'b0;
   wire weo =  wadr_i[0] ? wen_i : 1'b0;
   
   // even
   assign we0_o    = wee;
   assign adr0_o   = tag_addre;
   assign tage     = datao0_i;
   
   // odd
   assign we1_o    = weo;
   assign adr1_o   = tag_addro;
   assign tago     = datao1_i;

endmodule


/*
   // Tek adreslere ve cift adreslere nasil yazilmasi gerektiginin ispatlanmasi ve gerekli pattern'in gosterilmesi.
   radr0_i = l1b_adres_i[`ADR] + {{8{1'b0}},l1b_adres_i[1]};
   radr1_i = l1b_adres_i[`ADR];
   
   Possible address combinations, there is a pattern:
   
      radr1_i = 0  radr0 = 0 -> 0, 0 -> tage tage -+-+-+-+-+-+-+- : (~radr0[0]) & (radr0 == radr1)
      
      radr1_i = 0  radr0 = 1 -> 0, 0 -> tage tago ............... : ( radr0[0]) & (radr0 != radr1)
      
      radr1_i = 1  radr0 = 1 -> 0, 0 -> tago tago --------------- : ( radr0[0]) & (radr0 == radr1)
      
      radr1_i = 1  radr0 = 2 -> 0, 1 -> tago tage +++++++++++++++ : (~radr0[0]) & (radr0 != radr1)
      
      radr1_i = 2  radr0 = 2 -> 1, 1 -> tage tage -+-+-+-+-+-+-+- : (~radr0[0]) & (radr0 == radr1)
      
      radr1_i = 2  radr0 = 3 -> 1, 1 -> tage tago ............... : ( radr0[0]) & (radr0 != radr1)
      
      radr1_i = 3  radr0 = 3 -> 1, 1 -> tago tago --------------- : ( radr0[0]) & (radr0 == radr1)
      
      radr1_i = 3  radr0 = 4 -> 1, 2 -> tago tage +++++++++++++++ : (~radr0[0]) & (radr0 != radr1)
      
      radr1_i = 4  radr0 = 4 -> 2, 2 -> tage tage -+-+-+-+-+-+-+- : (~radr0[0]) & (radr0 == radr1)
      
      
      0 -> 0000 -> e --> 0
      1 -> 0001 -> o -> 0
      2 -> 0010 -> e --> 1
      3 -> 0011 -> o -> 1
      4 -> 0100 -> e --> 2
      5 -> 0101 -> o -> 2
      6 -> 0110 -> e --> 3
      7 -> 0111 -> o -> 3
   
*/
