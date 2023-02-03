// user_processor.v (islemci)
`timescale 1ns / 1ps

`include "tanimlamalar.vh"

module user_processor(
    input clk,
    input resetn,

    output iomem_valid,
    input iomem_ready,

    output [3:0] iomem_wstrb,
    output [31:0] iomem_addr,
    output [31:0] iomem_wdata,
    input [31:0] iomem_rdata,

    output spi_cs_o,
    output spi_sck_o,
    output spi_mosi_o,
    output spi_miso_i,

    output uart_tx_o,
    input uart_rx_i,

    output pwm0_o,
    output pwm1_o
);

    cekirdek 
    cekirdek_dut (
      .clk_i (clk ),
      .rst_i (resetn ),
      .l1b_bekle_i (l1b_bekle_i ),
      .l1b_deger_i (l1b_deger_i ),
      .l1b_chip_select_n_o (l1b_chip_select_n_o ),
      .l1b_adres_o  (l1b_adres_o)
    );

    anabellek_denetleyici 
    anabellek_denetleyici_dut (
      .clk_i (clk ),
      .rst_i (resetn ),
      .ddb_durdur (ddb_durdur ),
      .iomem_valid (iomem_valid ),
      .iomem_ready (iomem_ready ),
      .iomem_wstrb (iomem_wstrb ),
      .iomem_addr (iomem_addr ),
      .iomem_wdata (iomem_wdata ),
      .iomem_rdata (iomem_rdata ),
      .go_csb (go_csb ),
      .go_web (go_web ),
      .go_addr (go_addr ),
      .go_din (go_din ),
      .go_dot (go_dot ),
      .go_oku_valid (go_oku_valid ),
      .go_stall (go_stall ),
      .yo_csb (yo_csb ),
      .yo_web (yo_web ),
      .yo_addr (yo_addr ),
      .yo_din (yo_din ),
      .yo_dot (yo_dot ),
      .yo_oku_valid (yo_oku_valid ),
      .yo_stall  (yo_stall)
    );

    buyruk_onbellegi 
    buyruk_onbellegi_dut (
      .addr (addr ),
      .clk (clk ),
      .csb (csb ),
      .dout (dout ),
      .main_addr (main_addr ),
      .main_csb (main_csb ),
      .main_dout (main_dout ),
      .main_stall (main_stall ),
      .rst (resetn ),
      .stall  ( stall)
    );

    veri_onbellegi 
    veri_onbellegi_dut (
      .addr (addr ),
      .clk (clk ),
      .csb (csb ),
      .dout (dout ),
      .main_addr (main_addr ),
      .main_csb (main_csb ),
      .main_dout (main_dout ),
      .main_stall (main_stall ),
      .rst (resetn ),
      .stall  ( stall)
    );

    wishbone
    wishbone_dut #(.SLAVE_SAYISI(3))(
        .clk_i (clk_i),
        .rst_i (resetn)


    );

    uart_denetleyici
    uart_denetleyici_dut(
       .clk_i(clk),
       .rst_i(resetn),
       .uart_tx_o(uart_tx_o),
       .uart_rx_i(uart_rx_i)
   );

    spi_denetleyici 
    spi_denetleyici_dut(
       .clk_i(clk),
       .rst_i(resetn),
       .spi_cs_o(spi_cs_o),
       .spi_sck_o(spi_sck_o),
       .spi_mosi_o(spi_mosi_o),
       .spi_miso_i(spi_miso_i)    
   );

    pwm_denetleyici
    pwm_denetleyici_dut(
       .clk_i(clk),
       .rst_i(resetn),
       .pwm0_o(pwm0_o),
       .pwm1_o(pwm1_o)
   );


endmodule
