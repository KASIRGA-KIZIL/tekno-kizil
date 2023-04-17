module progmem (
    // Closk & reset
    input wire clk,
    input wire rstn,

    // PicoRV32 bus interface
    input  wire        valid,
    output wire        ready,
    input  wire [31:0] addr,
    output wire [31:0] rdata
);

  // ============================================================================

  localparam MEM_SIZE_BITS = 10;  // In 32-bit words
  localparam MEM_SIZE = 1 << MEM_SIZE_BITS;
  localparam MEM_ADDR_MASK = 32'h0010_0000;

  // ============================================================================

  wire [MEM_SIZE_BITS-1:0] mem_addr;
  reg  [             31:0] mem_data;
  reg  [             31:0] mem      [0:MEM_SIZE];

  initial begin

  mem['h0000] <= 32'h200107b7;
  mem['h0001] <= 32'h09800713;
  mem['h0002] <= 32'h00e7a623;
  mem['h0003] <= 32'h000f0737;
  mem['h0004] <= 32'h00170713;
  mem['h0005] <= 32'h00e7a023;
  mem['h0006] <= 32'h00002737;
  mem['h0007] <= 32'h00e7a823;
  mem['h0008] <= 32'h20010737;
  mem['h0009] <= 32'h00472783;
  mem['h000A] <= 32'h0027f793;
  mem['h000B] <= 32'hfe078ce3;
  mem['h000C] <= 32'h09800793;
  mem['h000D] <= 32'h00f72623;
  mem['h000E] <= 32'h000f07b7;
  mem['h000F] <= 32'h00578793;
  mem['h0010] <= 32'h00f72023;
  mem['h0011] <= 32'h000027b7;
  mem['h0012] <= 32'h00f72823;
  mem['h0013] <= 32'h20010737;
  mem['h0014] <= 32'h00472783;
  mem['h0015] <= 32'h0027f793;
  mem['h0016] <= 32'hfe078ce3;
  mem['h0017] <= 32'h09800793;
  mem['h0018] <= 32'h00f72623;
  mem['h0019] <= 32'h000f07b7;
  mem['h001A] <= 32'h00978793;
  mem['h001B] <= 32'h00f72023;
  mem['h001C] <= 32'h000027b7;
  mem['h001D] <= 32'h00f72823;
  mem['h001E] <= 32'h20010737;
  mem['h001F] <= 32'h00472783;
  mem['h0020] <= 32'h0027f793;
  mem['h0021] <= 32'hfe078ce3;
  mem['h0022] <= 32'h09800793;
  mem['h0023] <= 32'h00f72623;
  mem['h0024] <= 32'h000f07b7;
  mem['h0025] <= 32'h00d78793;
  mem['h0026] <= 32'h00f72023;
  mem['h0027] <= 32'h000027b7;
  mem['h0028] <= 32'h00f72823;
  mem['h0029] <= 32'h0000006f;

  end

  always @(posedge clk) mem_data <= mem[mem_addr];

  // ============================================================================

  reg o_ready;

  always @(posedge clk or negedge rstn)
    if (!rstn) o_ready <= 1'd0;
    else o_ready <= valid && ((addr & MEM_ADDR_MASK) != 0);

  // Output connectins
  assign ready    = o_ready;
  assign rdata    = mem_data;
  assign mem_addr = addr[MEM_SIZE_BITS+1:2];

endmodule

