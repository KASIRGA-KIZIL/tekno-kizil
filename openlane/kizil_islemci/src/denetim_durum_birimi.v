// denetim_durum_birimi.v
`timescale 1ns / 1ps

`include "tanimlamalar.vh"

`define ASAMA_GETIR   0
`define ASAMA_COZ     1
`define ASAMA_YURUT   2
`define ASAMA_GERIYAZ 3

module denetim_durum_birimi(
   input wire clk_i,
   input wire rst_i,
   // GETIR sinyalleri
   input  wire gtr_yanlis_tahmin_i,       // Dallanma ongorucu, ongoremedi
   input  wire gtr_hazir_i,               // Getir hazir degil. L1 miss oldu vs. Buyruk gecersiz
   output wire gtr_durdur_o,
   output wire gtr_bosalt_o,
   
   // COZ sinyalleri
   input  wire [4:0] cyo_rs1_adres_i,          // RS1 adresi
   input  wire [4:0] cyo_rs2_adres_i,          // RS2 adresi
   output wire [1:0] cyo_yonlendir_kontrol1_o, // Yonlendirme(Forwarding) deger1 icin kontrol sinyali
   output wire [1:0] cyo_yonlendir_kontrol2_o, // Yonlendirme(Forwarding) deger2 icin kontrol sinyali
   output wire       cyo_durdur_o,
   output wire       cyo_bosalt_o,
   
   // YURUT sinyalleri
   output wire      yrt_durdur_o,
   input wire       yrt_yonlendir_gecersiz_i,
   input wire       yrt_yaz_yazmac_i,         // Rd geri yaziliyor ise 1
   input wire       yrt_hazir_i,              // Birden fazla cevrim suren bolme vs. icin
   input wire [4:0] yrt_rd_adres_i,           // Rd nin adresi
   
   // GERIYAZ sinyalleri
   input       gy_yaz_yazmac_i,   // Rd geri yaziliyor ise 1
   input [4:0] gy_rd_adres_i      // Rd nin adresi
);

   reg bos_basla;
   reg durmus;
   // Eger ileriki bir asamada bulunan verinin adres esitse ve yazma yapiliyor ise yonlendirilmesi. X0 haric.
   wire yurut_yonlendir1   = (((cyo_rs1_adres_i == yrt_rd_adres_i) && yrt_yaz_yazmac_i) && (cyo_rs1_adres_i != 0));
   wire geriyaz_yonlendir1 = (((cyo_rs1_adres_i == gy_rd_adres_i ) && gy_yaz_yazmac_i ) && (cyo_rs1_adres_i != 0));
   // Nereye yonlendirilecegi
   assign cyo_yonlendir_kontrol1_o = (~yrt_yonlendir_gecersiz_i && yurut_yonlendir1) ? `YON_YURUT :
                                     (geriyaz_yonlendir1)                            ? `YON_GERIYAZ :
                                                                                       `YON_YOK;
   
   wire yurut_yonlendir2   = (((cyo_rs2_adres_i == yrt_rd_adres_i) && yrt_yaz_yazmac_i) && (cyo_rs2_adres_i != 0));
   wire geriyaz_yonlendir2 = (((cyo_rs2_adres_i == gy_rd_adres_i ) && gy_yaz_yazmac_i ) && (cyo_rs2_adres_i != 0));
   assign cyo_yonlendir_kontrol2_o = (~yrt_yonlendir_gecersiz_i && yurut_yonlendir2) ? `YON_YURUT :
                                     (geriyaz_yonlendir2)                            ? `YON_GERIYAZ :
                                                                                       `YON_YOK;
   
   
   wire durmali = (yrt_yonlendir_gecersiz_i && (yurut_yonlendir1 || yurut_yonlendir2));
   
   reg [7:0] counter;
   
   // Baslangicta 256 cevrim islemci durdurulur. Cache'lerdeki valid bitlerinin temizlenmesi icin.
   // Carpma islemi yonlendirme istendiyse getir ve coz durmali. Carpmanin yurutte yonlendirmesi yok.
   
   assign gtr_durdur_o = (counter != 8'hff) ? 1'b1 : ~yrt_hazir_i || ~gtr_hazir_i || (~durmus && durmali);
   assign cyo_durdur_o = (counter != 8'hff) ? 1'b1 : ~yrt_hazir_i || ~gtr_hazir_i || (~durmus && durmali);
   assign yrt_durdur_o = (counter != 8'hff) ? 1'b1 : ~gtr_hazir_i;
   
   assign gtr_bosalt_o = bos_basla || gtr_yanlis_tahmin_i ; // Baslangicta pipeline'lar bosaltilmali.
   assign cyo_bosalt_o = bos_basla || gtr_yanlis_tahmin_i ; // Baslangicta pipeline'lar bosaltilmali.
   
   always @(posedge clk_i) begin
      if(rst_i)begin
         bos_basla <= 1'b1;
         durmus    <= 1'b0;
         counter   <= 8'b0;
      end else begin
         counter <= (counter != 8'hff) ? (counter + 8'b1) : counter;
         bos_basla <= 1'b0;
         if(gtr_hazir_i)
            durmus    <= durmus ? 1'b0 : durmali; // Getir hazir ise ve islemci durmus ise artik durmasina gerek yok. Artik durmus degil.
      end
   end
endmodule
