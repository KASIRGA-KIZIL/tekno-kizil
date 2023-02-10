// wb_uart.v
// bu dosya silinecek
// çekirdek öncesi wishbone ve uart denemek için oluşturuldu

`timescale 1ns / 1ps

`include "tanimlamalar.vh"

module wb_uart(
    input clk_i,
    input rst_i,

    input  [31:0]       cekirdek_wb_adres_i,
    input  [31:0]       cekirdek_wb_veri_i,
    input  [ 3:0]       cekirdek_wb_veri_maske_i,
    input               cekirdek_wb_yaz_gecerli_i,
    input               cekirdek_wb_sec_n_i,
    output [31:0]       wb_cekirdek_veri_o,
    output              wb_cekirdek_mesgul_o,

    // WB --- UART
    input               uart_rx_i,
    output              uart_tx_o

);

`ifdef COCOTB_SIM
initial begin
  $dumpfile ("wb_uart.vcd");
  $dumpvars (0, wb_uart);
  #1;
end
`endif

    wire [31:0] wb_uart_adres_w;
    wire [31:0] wb_uart_veri_w;
    wire wb_uart_gecerli_w;
    wire wb_uart_yaz_gecerli_w;

    wire [31:0] uart_wb_oku_veri_w;
    wire uart_wb_oku_veri_gecerli_w;
    wire uart_wb_mesgul_w;

    veriyolu vy(
        .clk_i(clk_i),
        .rst_i(rst_i),

        .cekirdek_wb_adres_i(cekirdek_wb_adres_i),
        .cekirdek_wb_veri_i(cekirdek_wb_veri_i),
        .cekirdek_wb_veri_maske_i(cekirdek_wb_veri_maske_i),
        .cekirdek_wb_yaz_gecerli_i(cekirdek_wb_yaz_gecerli_i),
        .cekirdek_wb_sec_n_i(cekirdek_wb_sec_n_i),
        .wb_cekirdek_veri_o(wb_cekirdek_veri_o),
        .wb_cekirdek_mesgul_o(wb_cekirdek_mesgul_o),

        .uart_wb_oku_veri_i(uart_wb_oku_veri_w),
        .uart_wb_oku_veri_gecerli_i(uart_wb_oku_veri_gecerli_w),
        .uart_wb_mesgul_i(uart_wb_mesgul_w),
        .wb_uart_adres_o(wb_uart_adres_w),
        .wb_uart_veri_o(wb_uart_veri_w),
        .wb_uart_gecerli_o(wb_uart_gecerli_w),
        .wb_uart_yaz_gecerli_o(wb_uart_yaz_gecerli_w)
    );

    uart_denetleyici ud(
        .clk_i(clk_i),
        .rst_i(rst_i),

        .wb_adres_i(wb_uart_adres_w),
        .wb_veri_i(wb_uart_veri_w),
        .wb_gecerli_i(wb_uart_gecerli_w),
        .wb_yaz_gecerli_i(wb_uart_yaz_gecerli_w),
        .wb_oku_veri_o(uart_wb_oku_veri_w),
        .wb_oku_gecerli_o(uart_wb_oku_veri_gecerli_w),
        .uart_mesgul_o(uart_wb_mesgul_w),

        .uart_rx_i(uart_rx_i),
        .uart_tx_o(uart_tx_o)
    );
endmodule
