`timescale 1ns / 1ps

`include "sky130_fd_sc_hd.v"

module tb_wrapper();

localparam OUTPUT_VCD_FILE = "./out.vcd";
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

wire program_rx_i;
wire prog_mode_led_o;
wire uart_tx_o;
wire uart_rx_i;
wire spi_cs_o;
wire spi_sck_o;
wire spi_mosi_o;
wire spi_miso_i;
wire pwm0_o;
wire pwm1_o;

reg clk_i;
reg rst_ni;

wire        iomem_valid;
wire        iomem_ready;
wire [ 3:0] iomem_wstrb;
wire [31:0] iomem_addr;
wire [31:0] iomem_wdata;
wire [31:0] iomem_rdata;
wire [31:0] main_mem_rdata;

wire [ 3:0] main_mem_wstrb;
wire        main_mem_rd_en;

reg        ram_ready;
reg [63:0] timer;

wire   prog_system_reset;
wire   rst_n;
assign rst_n = prog_system_reset & rst_ni;

user_processor soc (
  .clk           (clk_i        ),
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

always @(posedge clk_i) begin
  if (!rst_ni) begin
    ram_shift_q <= {RAM_DELAY{1'b0}};
  end else begin
    if (ram_ready_check) ram_shift_q <= {RAM_DELAY{1'b0}};
    else ram_shift_q <= {ram_shift_q[RAM_DELAY-2:0],ram_ready};
  end
end

always @(posedge clk_i) begin
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
  .INIT_FILE("/home/mehmet/artikson/tekno-kizil/testler/riscv-tests/isa/rv32ui-p-auipc_static.hex")  //Yüklenecek programin yolu
) main_memory
(
  .clk_i           (clk_i ),
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

always #5 clk_i = ~clk_i;

initial begin
  clk_i = 0;
  rst_ni = 0;
  @(posedge clk_i);
  #25;
  rst_ni = 1;
end

initial begin
  $dumpfile("tb_wrapper.vcd");
  $dumpvars(0, tb_wrapper);
  #100000; $finish;
end

endmodule
