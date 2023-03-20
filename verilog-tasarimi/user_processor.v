// user_processor.v (islemci)
`timescale 1ns / 1ps


module user_processor(
    input clk,
    input resetn,

    output        iomem_valid,
    input         iomem_ready,
    output [ 3:0] iomem_wstrb,
    output [31:0] iomem_addr,
    output [31:0] iomem_wdata,
    input  [31:0] iomem_rdata,

    output uart_tx_o,
    input  uart_rx_i,

    output spi_cs_o,
    output spi_sck_o,
    output spi_mosi_o,
    input spi_miso_i,

    output pwm0_o,
    output pwm1_o
);
    wire        csb0;
    wire [ 8:0] addr0;
    wire [ 4:0] wmask0;
    wire        spare_wen0;
    wire [40:0] din0;
    wire        csb1;
    wire [ 8:0] addr1;
    wire [40:0] dout1;

    wire  we0;
    wire [7:0] adr0;
    wire [7:0] datai0;
    wire [7:0] datao0;

    wire  we1;
    wire [7:0] adr1;
    wire [7:0] datai1;
    wire [7:0] datao1;

    wire        ram512d0_we0;
    wire [ 8:0] ram512d0_adr0;
    wire [15:0] ram512d0_datai0;
    wire [15:0] ram512d0_datao0;

    wire        ram512d1_we0;
    wire [ 8:0] ram512d1_adr0;
    wire [15:0] ram512d1_datai0;
    wire [15:0] ram512d1_datao0;

    wire [7:0] l1b_tag_adr;

    cekirdek_ramsiz cek_ramsiz (
      .clk (clk ),
      .resetn (resetn ),

      .iomem_valid (iomem_valid ),
      .iomem_ready (iomem_ready ),
      .iomem_wstrb (iomem_wstrb ),
      .iomem_addr  (iomem_addr  ),
      .iomem_wdata (iomem_wdata ),
      .iomem_rdata (iomem_rdata ),

      .l1b_tag_adr_o(l1b_tag_adr),

      .csb0       (csb0       ),
      .addr0      (addr0      ),
      .wmask0     (wmask0     ),
      .spare_wen0 (spare_wen0 ),
      .din0       (din0       ),
      .csb1       (csb1       ),
      .addr1      (addr1      ),
      .dout1      (dout1      ),

      .we0_o    (we0    ),
      .adr0_o   (adr0   ),
      .datao0_i (datao0 ),

      .we1_o    (we1    ),
      .adr1_o   (adr1   ),
      .datao1_i (datao1 ),

      .ram512d0_we0_o    (ram512d0_we0    ),
      .ram512d0_adr0_o   (ram512d0_adr0   ),
      .ram512d0_datao0_i (ram512d0_datao0 ),
      .ram512d1_we0_o    (ram512d1_we0    ),
      .ram512d1_adr0_o   (ram512d1_adr0   ),
      .ram512d1_datao0_i (ram512d1_datao0 ),

      .uart_tx_o (uart_tx_o ),
      .uart_rx_i (uart_rx_i ),

      .spi_cs_o   (spi_cs_o   ),
      .spi_sck_o  (spi_sck_o  ),
      .spi_mosi_o (spi_mosi_o ),
      .spi_miso_i (spi_miso_i ),

      .pwm0_o  (pwm0_o ),
      .pwm1_o  (pwm1_o )
    );

    RAM512 RAM512_d0 (
        .CLK(clk),
        .EN0(1'b1),
        .A0(ram512d0_adr0),
        .Di0(iomem_rdata[15:0]),
        .Do0(ram512d0_datao0),
        .WE0({ram512d0_we0,ram512d0_we0})
    );

    RAM512 RAM512_d1 (
        .CLK(clk),
        .EN0(1'b1),
        .A0(ram512d1_adr0),
        .Di0(iomem_rdata[31:16]),
        .Do0(ram512d1_datao0),
        .WE0({ram512d1_we0,ram512d1_we0})
    );

    RAM256 bffram_t0( // even
        .CLK(clk),
        .EN0(1'b1),
        .A0(adr0),
        .Di0(l1b_tag_adr),
        .Do0(datao0),
        .WE0(we0)
    );

    RAM256 bffram_t1( // odd
        .CLK(clk),
        .EN0(1'b1),
        .A0(adr1),
        .Di0(l1b_tag_adr),
        .Do0(datao1),
        .WE0(we1)
    );

    sram_40b_512_1w_1r_sky130 sram_40b_512_1w_1r_sky130_dut (
        .clk0 (clk ),
        .csb0       (csb0       ),
        .addr0      (addr0      ),
        .wmask0     (wmask0     ),
        .spare_wen0 (spare_wen0 ),
        .din0       (din0 ),
        .clk1  (clk ),
        .csb1  (csb1  ),
        .addr1 (addr1 ),
        .dout1 (dout1 )
    );


endmodule
