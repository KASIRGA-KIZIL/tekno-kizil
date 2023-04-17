`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: TUBITAK TUTEL
// Engineer:
//
// Create Date: 26.04.2022 15:38:31
// Design Name: TEKNOFEST
// Module Name: teknofest_wrapper
// Project Name: TEKNOFEST
// Target Devices: Nexys A7
// Tool Versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////

module teknofest_wrapper(
  input  clk_i,
  input  rst_ni,
  input  program_rx_i,
  output prog_mode_led_o,

  output uart_tx_o,
  input  uart_rx_i,

  output spi_cs_o,
  output spi_sck_o,
  output spi_mosi_o,
  input  spi_miso_i,

  output pwm0_o,
  output pwm1_o
);

// 60 MHz clocking wizard ip
wire clk_wiz_o;
wire dummy;
clk_wiz_0 dutclk (
  .clk_out1(clk_wiz_o),
  .clk_in1(clk_i),
  .reset(~rst_ni),
  .locked(dummy)
);

localparam RAM_DELAY = 16;

parameter integer MEM_WORDS = 4096;
parameter [31:0] PROGADDR_RESET = 32'h4000_0000;
parameter [31:0] STACKADDR = PROGADDR_RESET + (4*MEM_WORDS);
parameter [31:0] PROGADDR_IRQ = 32'h0000_0000;
parameter [31:0] UART_BASE_ADDR = 32'h2000_0000;
parameter [31:0] UART_MASK_ADDR = 32'h0000_000f;
parameter [31:0] SPI_BASE_ADDR = 32'h2001_0000;
parameter [31:0] SPI_MASK_ADDR = 32'h0000_00ff;
parameter [31:0] RAM_BASE_ADDR = 32'h4000_0000;
parameter [31:0] RAM_MASK_ADDR = 32'h000f_ffff;
parameter [31:0] CHIP_IO_BASE_ADDR = SPI_BASE_ADDR + SPI_MASK_ADDR;
parameter [31:0] CHIP_IO_MASK_ADDR = RAM_BASE_ADDR + RAM_MASK_ADDR;
parameter RAM_DEPTH = 131072;

(* mark_debug = "yes" *) wire        iomem_valid;
(* mark_debug = "yes" *) wire        iomem_ready;
(* mark_debug = "yes" *) wire [ 3:0] iomem_wstrb;
(* mark_debug = "yes" *) wire [31:0] iomem_addr;
(* mark_debug = "yes" *) wire [31:0] iomem_wdata;
(* mark_debug = "yes" *) wire [31:0] iomem_rdata;
wire [31:0] main_mem_rdata;

wire [ 3:0] main_mem_wstrb;
wire        main_mem_rd_en;

reg        ram_ready;
reg [63:0] timer;

wire   prog_system_reset;
wire   rst_n;
assign rst_n = prog_system_reset & rst_ni;

user_processor soc (
  .clk           (clk_wiz_o    ),
  .resetn        (rst_n        ),
  .iomem_valid   (iomem_valid  ),
  .iomem_ready   (iomem_ready  ),
  .iomem_wstrb   (iomem_wstrb  ),
  .iomem_addr    (iomem_addr   ),
  .iomem_wdata   (iomem_wdata  ),
  .iomem_rdata   (iomem_rdata  ),
  .spi_cs_o      (spi_cs_o     ),
  .spi_sck_o     (spi_sck_o    ),
  .spi_mosi_o    (spi_mosi_o   ),
  .spi_miso_i    (spi_miso_i   ),
  .uart_tx_o     (uart_tx_o    ),
  .uart_rx_i     (uart_rx_i    ),
  .pwm0_o        (pwm0_o       ),
  .pwm1_o        (pwm1_o       )
);

reg [RAM_DELAY-1:0] ram_shift_q;
wire ram_ready_check;

assign ram_ready_check = iomem_valid & iomem_ready & ((iomem_addr & ~RAM_MASK_ADDR) == RAM_BASE_ADDR);

always @(posedge clk_wiz_o) begin
  if (!rst_ni) begin
    ram_shift_q <= {RAM_DELAY{1'b0}};
  end else begin
    if (ram_ready_check) ram_shift_q <= {RAM_DELAY{1'b0}};
    else ram_shift_q <= {ram_shift_q[RAM_DELAY-2:0],ram_ready};
  end
end

always @(posedge clk_wiz_o) begin
  if (!rst_n) begin
    ram_ready <= 1'b0;
  end else begin
    ram_ready <= iomem_valid & !iomem_ready & ((iomem_addr & ~RAM_MASK_ADDR) == RAM_BASE_ADDR);
  end
end

assign iomem_ready = ram_shift_q[RAM_DELAY-1] | (iomem_valid & (iomem_addr == 32'h3000_0000 || iomem_addr == 32'h3000_0004));

assign iomem_rdata = (iomem_valid & (iomem_addr == 32'h3000_0000)) ? timer[31:0]  :
                     (iomem_valid & (iomem_addr == 32'h3000_0004)) ? timer[63:32] : main_mem_rdata;

assign main_mem_wstrb = iomem_valid & ((iomem_addr & ~RAM_MASK_ADDR) == RAM_BASE_ADDR) ?
                        iomem_wstrb : 4'b0;

assign main_mem_rd_en = iomem_valid & ((iomem_addr & ~RAM_MASK_ADDR) == RAM_BASE_ADDR) & ~(|iomem_wstrb);




teknofest_ram #(
  .NB_COL(4),
  .COL_WIDTH(8),
  .RAM_DEPTH(RAM_DEPTH),
  .INIT_FILE("")  //Yüklenecek program?n yolu
) main_memory
(
  .clk_i           (clk_wiz_o),
  .rst_ni          (rst_ni),
  .wr_addr         (iomem_addr[$clog2(RAM_DEPTH*4)-1:2]),
  .rd_addr         (iomem_addr[$clog2(RAM_DEPTH*4)-1:2]),
  .wr_data         (iomem_wdata),

  .wr_strb         (main_mem_wstrb   ),
  .rd_data         (main_mem_rdata   ),
  .rd_en           (main_mem_rd_en   ),
  .ram_prog_rx_i   (program_rx_i     ),
  .system_reset_o  (prog_system_reset),
  .prog_mode_led_o (prog_mode_led_o  )
);

always @(posedge clk_wiz_o) begin
  if (!rst_n) begin
    timer <= 64'h0;
  end else begin
    timer <= timer + 64'h1;
  end
end

endmodule

