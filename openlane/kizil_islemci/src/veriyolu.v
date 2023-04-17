// veriyolu.v
`timescale 1ns / 1ps

`include "tanimlamalar.vh"

// Wishbone master ve cevre birimleri arasindaki konusma
module veriyolu(
   input clk_i,
   input rst_i,
   
   // VYD --- WB
   input  [31:0] vy_adres_i,
   input  [31:0] vy_veri_i,
   input  [ 3:0] vy_veri_maske_i,
   input         vy_sec_i,
   output [31:0] vy_veri_o,
   output        vy_durdur_o,
   
   output uart_tx_o,
   input  uart_rx_i,
   
   output spi_cs_o,
   output spi_sck_o,
   output spi_mosi_o,
   input  spi_miso_i,
   
   output pwm0_o,
   output pwm1_o
);

   // Wishbone sinyalleri
   wire [ 7:0] wb_adr;
   wire [31:0] wb_dat;
   wire        wb_we ;
   wire        wb_stb;
   wire [ 3:0] wb_sel;
   
   wire        uart_cyc;
   wire        uart_ack;
   wire [31:0] uart_dat;
   
   wire        spi_cyc;
   wire        spi_ack;
   wire [31:0] spi_dat;
   
   wire        pwm_cyc;
   wire        pwm_ack;
   wire [31:0] pwm_dat;
   
   wishbone_master wm(
      .clk_i(clk_i),
      .rst_i(rst_i),
      
      .vy_adres_i       (vy_adres_i       ),
      .vy_veri_i        (vy_veri_i        ),
      .vy_veri_maske_i  (vy_veri_maske_i  ),
      .vy_sec_i         (vy_sec_i         ),
      .vy_veri_o        (vy_veri_o        ),
      .vy_durdur_o      (vy_durdur_o      ),
      
      .adr_o (wb_adr),
      .dat_o (wb_dat),
      .we_o  (wb_we ),
      .stb_o (wb_stb),
      .sel_o (wb_sel),
      
      .uart_cyc_o (uart_cyc),
      .uart_ack_i (uart_ack),
      .uart_dat_i (uart_dat),
      
      .spi_cyc_o (spi_cyc),
      .spi_ack_i (spi_ack),
      .spi_dat_i (spi_dat),
      
      .pwm_cyc_o (pwm_cyc),
      .pwm_ack_i (pwm_ack),
      .pwm_dat_i (pwm_dat)
   );
   
   uart_denetleyici uart_denetleyici_dut (
      .clk_i(clk_i),
      .rst_i(rst_i),
      .wb_adr_i (wb_adr[3:2]),
      .wb_dat_i (wb_dat     ),
      .wb_we_i  (wb_we      ),
      .wb_stb_i (wb_stb     ),
      .wb_sel_i (wb_sel     ),
      .wb_cyc_i (uart_cyc   ),
      .wb_ack_o (uart_ack   ),
      .wb_dat_o (uart_dat   ),
      
      .uart_rx_i  (uart_rx_i ),
      .uart_tx_o  (uart_tx_o )
   );
   
   pwm_denetleyici pwm_denetleyici_dut (
      .clk_i(clk_i),
      .rst_i(rst_i),
      .wb_adr_i (wb_adr[5:0]),
      .wb_dat_i (wb_dat     ),
      .wb_we_i  (wb_we      ),
      .wb_stb_i (wb_stb     ),
      .wb_sel_i (wb_sel     ),
      .wb_cyc_i (pwm_cyc   ),
      .wb_ack_o (pwm_ack   ),
      .wb_dat_o (pwm_dat   ),
      
      .pwm0_o  (pwm0_o ),
      .pwm1_o  (pwm1_o )
   );
   
   spi_denetleyici spi_denetleyici_dut (
      .clk_i(clk_i),
      .rst_i(rst_i),
      .wb_adr_i (wb_adr[4:0]),
      .wb_dat_i (wb_dat     ),
      .wb_we_i  (wb_we      ),
      .wb_stb_i (wb_stb     ),
      .wb_sel_i (wb_sel     ),
      .wb_cyc_i (spi_cyc   ),
      .wb_ack_o (spi_ack   ),
      .wb_dat_o (spi_dat   ),
      
      .spi_miso_i(spi_miso_i),
      .spi_mosi_o(spi_mosi_o),
      .spi_cs_o(spi_cs_o),
      .spi_sck_o(spi_sck_o)
   );

endmodule
