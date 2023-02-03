`timescale 1ns / 1ps

`include "tanimlamalar.vh"

`define CYO   0
`define YURUT 1

// yrt   buyrugu bj ise kontrol et.  a.k.a tahmin_et_i       == 1
// getir buyrugu bj ise tahmin et.   a.k.a tahmin_et[`YURUT] == 1

module dallanma_ongorucu(
    input  wire rst_i,
    input  wire clk_i,
    input  wire ddb_durdur_i,
    // Tahmin okuma.
    input  wire [31:1] ps_i,
    input  wire        buyruk_ctipi_i,
    input  wire        buyruk_jtipi_i,
    input  wire        tahmin_et_i,
    output wire [31:1] ongorulen_ps_o,
    output wire        ongorulen_ps_gecerli_o,
    // Kalibrasyon sinyalleri
    input  wire [31:1] atlanan_ps_i,
    input  wire        atlanan_ps_gecerli_i,
    // hata duzeltme
    output reg  [ 1:0] hata_duzelt_o,
    output wire [31:1] yrt_ps_o,
    output wire        yrt_buyruk_ctipi_o
);
    // Boru hatti asamalari, coz ve yurutun psleri vs. burada tut. Dolandirma.
    reg [1:0]  ongorulen_ps_gecerli;
    reg [1:0]  tahmin_et;
    reg [1:0]  buyruk_ctipi;
    reg [31:1] ps [1:0];

    // Ongoru tablolari
    reg [31:1] btb      [31:0]; // branch target buffer
    reg [ 1:0] sayaclar [31:0]; // branch target buffer
    reg [ 6:0] ght            ; // global history table
    reg [1:0]  ght_ptr        ; // global history table pointer

    wire [ 4:0] sayac_oku_adr     = ps_i[5:1] ^ ght[4:0];
    assign ongorulen_ps_gecerli_o = sayaclar[sayac_oku_adr][1];
    assign ongorulen_ps_o         = btb[ps_i[5:1]];

    // (atlar_dedi ve atladi ve ps_dogru) veya (atlamaz_dedi ve atlamadi)
    wire atladi_tahmin_dogru   = ( ongorulen_ps_gecerli[`YURUT] &&  atlanan_ps_gecerli_i && (ps[`CYO] == atlanan_ps_i));
    wire atlamadi_tahmin_dogru = (~ongorulen_ps_gecerli[`YURUT] && ~atlanan_ps_gecerli_i);
    wire tahmin_dogru          = atladi_tahmin_dogru || atlamadi_tahmin_dogru;

    wire [ 4:0] sayac_yaz_adr = ps[`YURUT][5:1] ^ {ght[4:1], ongorulen_ps_gecerli};
    integer loop_counter;
    always@(posedge clk_i) begin
        if(tahmin_et[`YURUT]) begin
            if(~tahmin_dogru) begin
                btb[ps[`YURUT][5:1]] <= atlanan_ps_i;
                for(loop_counter=1 ;loop_counter<5; loop_counter=loop_counter+1) begin
                    ght[loop_counter] <= ght[loop_counter+ght_ptr];
                end
                ght[0] <= atlanan_ps_gecerli_i;
            end
            if(~atladi_tahmin_dogru   &&  (sayaclar[sayac_yaz_adr] != 2'b00)) begin
                if(!buyruk_jtipi_i)
                    sayaclar[sayac_yaz_adr] <= sayaclar[sayac_yaz_adr] -  2'b1;
            end
            if(~atlamadi_tahmin_dogru &&  (sayaclar[sayac_yaz_adr] != 2'b11)) begin
                if(!buyruk_jtipi_i)
                    sayaclar[sayac_yaz_adr] <= sayaclar[sayac_yaz_adr] +  2'b1;
            end
            if(tahmin_et) begin
                ght <= {ght[6:0], sayaclar[sayac_oku_adr][1]};
                ght_ptr <= ght_ptr + 3'd1;
            end
        end
    end

    always@(*) begin
        if(tahmin_et[`YURUT]) begin
            hata_duzelt_o = ( atlanan_ps_gecerli_i &&  (ps[`CYO] == atlanan_ps_i)                                  ) ? `SORUN_YOK     :
                            ( ongorulen_ps_gecerli[`YURUT] &&  ~atlanan_ps_gecerli_i                               ) ? `ATLAMAMALIYDI :
                            (~ongorulen_ps_gecerli[`YURUT] &&   atlanan_ps_gecerli_i                               ) ? `ATLAMALIYDI   :
                            ( ongorulen_ps_gecerli[`YURUT] &&   atlanan_ps_gecerli_i &&  (ps[`CYO] != atlanan_ps_i)) ? `YANLIS_ATLADI :
                                                                                                                       `SORUN_YOK;
        end else begin
            hata_duzelt_o = `SORUN_YOK;
        end
    end

    always@(posedge clk_i) begin
        if(rst_i) begin
            for(loop_counter=0; loop_counter<32; loop_counter=loop_counter+1) begin
                btb[loop_counter]      <= (32'h40000000)>>1;
                sayaclar[loop_counter] <= 2'b00;
            end
            ght <= 0;
            ght_ptr <= 0;
            ongorulen_ps_gecerli = 0;
            tahmin_et = 0;
            buyruk_ctipi = 0;
        end else begin
            if(~ddb_durdur_i) begin
                tahmin_et[`CYO]            <= (|hata_duzelt_o) ? 1'b0 : tahmin_et_i;
                buyruk_ctipi[`CYO]         <= buyruk_ctipi_i;
                ps[`CYO]                   <= ps_i;
                ongorulen_ps_gecerli[`CYO] <= ongorulen_ps_gecerli_o;

                tahmin_et[`YURUT]            <= (|hata_duzelt_o) ? 1'b0 : tahmin_et[`CYO];
                buyruk_ctipi[`YURUT]         <= buyruk_ctipi[`CYO];
                ps[`YURUT]                   <= ps[`CYO];
                ongorulen_ps_gecerli[`YURUT] <= ongorulen_ps_gecerli[`CYO];
            end
        end
    end

    assign yrt_ps_o           = ps[`YURUT];
    assign yrt_buyruk_ctipi_o = buyruk_ctipi[`YURUT];
endmodule
