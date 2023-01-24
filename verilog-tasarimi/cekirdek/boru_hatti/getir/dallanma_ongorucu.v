`timescale 1ns / 1ps

`define CYO   0
`define YURUT 1

// yrt   buyrugu bj ise kontrol et.  a.k.a tahmin_et_i       == 1
// getir buyrugu bj ise tahmin et.   a.k.a tahmin_et[`YURUT] == 1

module dallanma_ongorucu(
    input  wire rst_i,
    input  wire clk_i,
    // Tahmin okuma.
    input  wire [31:1] ps_i,
    input  wire        buyruk_ctipi_i,
    input  wire        tahmin_et_i,
    output wire [31:1] ongorulen_ps_o,
    output wire        ongorulen_ps_gecerli_o,
    // Kalibrasyon sinyalleri
    input  wire [31:1] atlanan_ps_i,
    input  wire        atlanan_ps_gecerli_i,
    // hata duzeltme
    output wire [ 1:0] hata_duzelt_o,
    output wire [31:1] yrt_ps_o,
    output wire        yrt_buyruk_ctipi_o
);
    // Boru hatti asamalari, coz ve yurutun psleri vs. burada tut. Dolandirma.
    reg [1:0]  atlanan_ps_gecerli;
    reg [1:0]  tahmin_et;
    reg [1:0]  buyruk_ctipi;
    reg [31:1] ps [1:0];

    // Ongoru tablolari
    reg [31:1] btb      [31:0]; // branch target buffer
    reg [ 1:0] sayaclar [31:0]; // branch target buffer
    reg [ 6:0] ght            ; // global history table

    wire [ 4:0] sayac_oku_adr     = ps_i[5:1] ^ ght[4:0];
    assign ongorulen_ps_gecerli_o = sayaclar[sayac_oku_adr][1];
    assign ongorulen_ps_o         = btb[ps_i[5:1]];

    // (atlar_dedi ve atladi ve ps_dogru) veya (atlamaz_dedi ve atlamadi)
    wire atladi_tahmin_dogru   = ( atlanan_ps_gecerli[`YURUT] &&  atlanan_ps_gecerli_i && (ps[`CYO] == atlanan_ps_i));
    wire atlamadi_tahmin_dogru = (~atlanan_ps_gecerli[`YURUT] && ~atlanan_ps_gecerli_i);
    wire tahmin_dogru          = atladi_tahmin_dogru || atlamadi_tahmin_dogru;

    wire [ 4:0] sayac_yaz_adr = ps[`YURUT][5:1] ^ ght[6:1];
    always@(posedge clk_g) begin
        if(tahmin_et[`YURUT]) begin
            if(~tahmin_dogru) begin
                if(~atladi_tahmin_dogru   &&  (sayaclar[sayac_yaz_adr] != 2'b00)) begin
                    sayaclar[sayac_yaz_adr] <= sayaclar[sayac_yaz_adr] -  2'b1;
                end
                if(~atlamadi_tahmin_dogru &&  (sayaclar[sayac_yaz_adr] != 2'b11)) begin
                    sayaclar[sayac_yaz_adr] <= sayaclar[sayac_yaz_adr] +  2'b1;
                end
                btb[ps[`YURUT][5:1]] <= atlanan_ps_i;
            end
        end
    end

    integer loop_counter;
    always@(posedge clk_g) begin
        if(rst_i) begin
            for(loop_counter=0; loop_counter<32; loop_counter=loop_counter+1) begin
                sayaclar[loop_counter] <= 0;
            end
        end else begin
            tahmin_et[`CYO]    <= tahmin_et_i;
            buyruk_ctipi[`CYO] <= buyruk_ctipi_i;
            ps[`CYO]           <= ps_i;

            tahmin_et[`YURUT]    <= tahmin_et[`CYO];
            buyruk_ctipi[`YURUT] <= buyruk_ctipi[`CYO];
            ps[`YURUT]           <= ps[`CYO];
        end
    end

    assign yrt_ps_o           = ps[`YURUT];
    assign yrt_buyruk_ctipi_o = buyruk_ctipi[`YURUT];
    assign ongorulen_ps_o     = btb[ps_i[6:2]];
endmodule
