// veriyolu.v
`timescale 1ns / 1ps

`include "tanimlamalar.vh"
// Ornek bus kullanimi icin
module veriyolu(
    input clk_i,
    input rst_i,
    
    // Cekirdek --- WB
    input  [31:0]       cekirdek_wb_adres_i,
    input  [31:0]       cekirdek_wb_veri_i,
    input  [ 3:0]       cekirdek_wb_veri_maske_i,
    input               cekirdek_wb_yaz_gecerli_i,
    input               cekirdek_wb_sec_n_i,
    output [31:0]       wb_cekirdek_veri_o,

    // WB --- UART
    input  [31:0]       uart_wb_oku_veri_i,
    input               uart_wb_oku_veri_gecerli_i,
    input               uart_wb_mesgul_i,
    output reg[31:0]    wb_uart_adres_i,
    output reg[31:0]    wb_uart_veri_i,
    output reg          wb_uart_gecerli_i,
    output reg          wb_uart_yaz_gecerli_i
    
    // diger cihazlar icin devami eklenecek
    
);
    localparam  UART = 2'b00,
                SPI  = 2'b01,
                PWM  = 2'b10;

    wire        cihaz_sinyali_w = cekirdek_wb_adres_i[29];
    wire [1:0]  cihaz_secim_w   = cekirdek_wb_adres_i[17:16];


    always@*begin
        wb_uart_adres_i         = 32'b0     ;
        wb_uart_veri_i          = 32'b0     ;
        wb_uart_gecerli_i       = 1'b0      ;
        wb_uart_yaz_gecerli_i   = 1'b0      ;
        case(cihaz_sinyali_w,cihaz_secim_w)
            // Veri bellegi
            // 3'b000:begin

            // end

            // Cihazlar
            // UART
            3'b100:begin
                wb_uart_adres_i         = cekirdek_wb_adres_i       ;
                wb_uart_veri_i          = cekirdek_wb_veri_i        ;
                wb_uart_gecerli_i       = 1'b1                      ;
                wb_uart_yaz_gecerli_i   = cekirdek_wb_yaz_gecerli_i ;
            end
            // SPI
            3'b100:begin

            end
            // PWM
            3'b100:begin

            end

        endcase
    end


endmodule
