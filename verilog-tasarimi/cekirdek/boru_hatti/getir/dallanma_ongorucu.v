// dallanma_ongorucu.v
`timescale 1ns / 1ps

`include "tanimlamalar.vh"

`define CYO   0
`define YURUT 1

// Dallanma ve atlama buyruklarinin tahmininden sorumlu.
// Ayrica return adress stack (RAS) kullanarak fonksiyonlardan donusu hizlandirir.

// Calisma mantigi:
// Getirdeki buyruk branch veya jump ise tahmin  et.  a.k.a tahmin_et_i       == 1
// Yurutteki buyruk branch veya jump ise kontrol et.  a.k.a tahmin_et[`YURUT] == 1
// Kontrol ederken tahmin yanlis ise HATA DUZELT hatanin ne oldugunu bulur.
// Gerekli hata duzeltme sinyali gonderilir ve global history table sayaclari ve dizisi guncellenir.

module dallanma_ongorucu(
   input  wire rst_i,
   input  wire clk_i,
   input  wire ddb_durdur_i,
   // Tahmin okuma.
   input  wire [18:1] ps_i,
   input  wire        buyruk_ctipi_i,
   input  wire        buyruk_jal_tipi_i,
   input  wire        buyruk_jalr_tipi_i,
   input  wire        tahmin_et_i,
   input  wire        ras_pop,
   input  wire        ras_push,
   input  wire [18:1] imm_i,
   output wire [18:1] ongorulen_ps_o,
   output wire        ongorulen_ps_gecerli_o,
   // Kalibrasyon sinyalleri
   input  wire [18:1] atlanan_ps_i,
   input  wire        atlanan_ps_gecerli_i,
   // hata duzeltme
   output reg  [ 1:0] hata_duzelt_o,
   output wire [18:1] yrt_ps_o,
   output wire        yrt_buyruk_ctipi_o
);
   // Boru hatti asamalari, coz ve yurutun psleri vs. burada tut. Dolandirma.
   reg [1:0]  ongorulen_ps_gecerli;
   reg [1:0]  tahmin_et;
   reg [1:0]  buyruk_ctipi;
   reg [18:1] ps [1:0];
   
   // ras
   reg [18:1] ras       [3:0];
   
   // Ongoru tablolari
   reg [ 1:0] sayaclar [31:0]; // branch target buffer
   reg [ 6:0] ght            ; // global history table
   reg [1:0]  ght_ptr        ; // global history table pointer
   
   wire [ 4:0] sayac_oku_adr     = ps_i[5:1] ^ ght[4:0];
   assign ongorulen_ps_gecerli_o = (buyruk_jal_tipi_i || buyruk_jalr_tipi_i) ? 1'b1 : sayaclar[sayac_oku_adr][1];
   assign ongorulen_ps_o         = ras_pop ? ras[0] : (ps_i+imm_i);
   
   // (atlar_dedi ve atladi ve ps_dogru) veya (atlamaz_dedi ve atlamadi)
   wire atladi_tahmin_dogru   = ( ongorulen_ps_gecerli[`YURUT] &&  atlanan_ps_gecerli_i && (ps[`CYO] == atlanan_ps_i));
   wire atlamadi_tahmin_dogru = (~ongorulen_ps_gecerli[`YURUT] && ~atlanan_ps_gecerli_i);
   wire tahmin_dogru          = atladi_tahmin_dogru || atlamadi_tahmin_dogru;
   
   reg [2:0] ght_counter;
   wire [4:0] sayac_yaz_adr = ps[`YURUT][5:1] ^ ght[ght_ptr+:5]; // Burada yanlizca alt bitlere erisilcek. Ust bitler sadece geri sarmak icin gerekli.
   integer loop_counter;
   always@(posedge clk_i) begin
      if(rst_i) begin
         for(loop_counter=0; loop_counter<32; loop_counter=loop_counter+1) begin
            sayaclar[loop_counter] <= 2'b00;
         end
         ras[0] <= 0;
         ras[1] <= 0;
         ras[2] <= 0;
         ras[3] <= 0;
         ght <= 0;
         ght_ptr <= 0;
      end else begin
         if(tahmin_et[`YURUT]) begin
            ght_ptr <= ght_ptr - 2'd1;
            if(~tahmin_dogru) begin // tahmin yanlis ise history table'i geri sar
               ght_ptr <= 2'd0;
               ght[0] <= atlanan_ps_gecerli_i;
               for(ght_counter=1 ;ght_counter<5; ght_counter=ght_counter+1) begin
                  ght[ght_counter] <= ght[ght_counter+ght_ptr-2'b1];
               end
               for(ght_counter=5 ;ght_counter<7; ght_counter=ght_counter+1) begin
                  ght[ght_counter] <= 1'd0;
               end
            end
            // sayaclari branch'ler icin guncelle
            if(~atladi_tahmin_dogru   &&  (sayaclar[sayac_yaz_adr] != 2'b00)) begin
               if(!buyruk_jalr_tipi_i || !buyruk_jal_tipi_i)
                  sayaclar[sayac_yaz_adr] <= sayaclar[sayac_yaz_adr] -  2'b1;
            end
            if(~atlamadi_tahmin_dogru &&  (sayaclar[sayac_yaz_adr] != 2'b11)) begin
               if(!buyruk_jalr_tipi_i || !buyruk_jal_tipi_i)
                  sayaclar[sayac_yaz_adr] <= sayaclar[sayac_yaz_adr] +  2'b1;
            end
         end
         if(tahmin_et_i && ~ddb_durdur_i) begin
            if(ras_push && !ras_pop) begin
               ras[3] <= ras[2];
               ras[2] <= ras[1];
               ras[1] <= ras[0];
               ras[0] <= ps_i + (buyruk_ctipi_i ? 18'd1 : 18'd2);
            end
      
            if(ras_pop && !ras_push) begin
               ras[3] <= 18'd0;
               ras[2] <= ras[3];
               ras[1] <= ras[2];
               ras[0] <= ras[1];
            end
      
            if(ras_push && ras_pop) begin
               ras[0] <= ps_i + (buyruk_ctipi_i ? 18'd1 : 18'd2);
            end
            if(!(buyruk_jal_tipi_i || buyruk_jalr_tipi_i)) begin // Sadece branchler de ght'yi guncelle
               ght[6:0] <= {ght[5:0], sayaclar[sayac_oku_adr][1]};
               ght_ptr <= ght_ptr + 2'd1;
            end
         end
      end
   end
   
   always@(*) begin
      if(tahmin_et[`YURUT]) begin // Tahmin sonucunu kontrol et
         hata_duzelt_o = ( atlanan_ps_gecerli_i &&  (ps[`CYO] == atlanan_ps_i)                                  ) ? `SORUN_YOK     :
                         ( ongorulen_ps_gecerli[`YURUT] &&  ~atlanan_ps_gecerli_i                               ) ? `ATLAMAMALIYDI :
                         (~ongorulen_ps_gecerli[`YURUT] &&   atlanan_ps_gecerli_i &&  (ps[`CYO] != atlanan_ps_i)) ? `ATLAMALIYDI   :
                         ( ongorulen_ps_gecerli[`YURUT] &&   atlanan_ps_gecerli_i &&  (ps[`CYO] != atlanan_ps_i)) ? `YANLIS_ATLADI :
                                                                                                                    `SORUN_YOK;
      end else begin // Tahmin yoksa sorun da yok
         hata_duzelt_o = `SORUN_YOK;
      end
   end
   
   always@(posedge clk_i) begin
      if(rst_i) begin
         ongorulen_ps_gecerli <= 0;
         tahmin_et            <= 0;
         buyruk_ctipi         <= 0;
      end else begin // Gerekli sinyalleri pipe'line gibi otele. Bu sayede sinyallerin disari cikip dolanmasina gerek yok. Yosys optimizasyonu.
         if(~ddb_durdur_i) begin
            tahmin_et[`CYO]              <= (|hata_duzelt_o) ? 1'b0 : tahmin_et_i;
            buyruk_ctipi[`CYO]           <= buyruk_ctipi_i;
            ps[`CYO]                     <= ps_i;
            ongorulen_ps_gecerli[`CYO]   <= ongorulen_ps_gecerli_o;
      
            tahmin_et[`YURUT]            <= (|hata_duzelt_o) ? 1'b0 : tahmin_et[`CYO];
            buyruk_ctipi[`YURUT]         <= buyruk_ctipi[`CYO];
            ps[`YURUT]                   <= ps[`CYO];
            ongorulen_ps_gecerli[`YURUT] <= ongorulen_ps_gecerli[`CYO];
         end
      end
   end
   
   assign yrt_ps_o           = ps[`YURUT]; // Eger geri sarilcak ise yurutteki buyrugun ps'si gerekli.
   assign yrt_buyruk_ctipi_o = buyruk_ctipi[`YURUT];  // Ps+2 mi yoksa PS+4 mu
endmodule
