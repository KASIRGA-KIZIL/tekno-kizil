
#!/usr/bin/env python3
#
# This is free and unencumbered software released into the public domain.
#
# Anyone is free to copy, modify, publish, use, compile, sell, or
# distribute this software, either in source code form or as a compiled
# binary, for any purpose, commercial or non-commercial, and by any
# means.

from sys import argv

binfile = argv[1]
nwords = 1000000 #int(argv[2])

with open(binfile, "rb") as f:
    bindata = f.read()

assert len(bindata) < 4*nwords
assert len(bindata) % 4 == 0

cnt = 0
each = ""
print("\
module progmem (\n\
    // Closk & reset\n\
    input wire clk,\n\
    input wire rstn,\n\
\n\
    // PicoRV32 bus interface\n\
    input  wire        valid,\n\
    output wire        ready,\n\
    input  wire [31:0] addr,\n\
    output wire [31:0] rdata\n\
);\n\
\n\
  // ============================================================================\n\
\n\
  localparam MEM_SIZE_BITS = 10;  // In 32-bit words\n\
  localparam MEM_SIZE = 1 << MEM_SIZE_BITS;\n\
  localparam MEM_ADDR_MASK = 32'h0010_0000;\n\
\n\
  // ============================================================================\n\
\n\
  wire [MEM_SIZE_BITS-1:0] mem_addr;\n\
  reg  [             31:0] mem_data;\n\
  reg  [             31:0] mem      [0:MEM_SIZE];\n\
\n\
  initial begin\n\
")

for i in range(nwords):
    if i < len(bindata) // 4:
        w = bindata[4*i : 4*i+4]
        each = "%02x%02x%02x%02x" % (w[3], w[2], w[1], w[0])
        print("  mem['" + "h"+ ("%0.4X" % cnt) + "] <= 32'h" + each + ";")
        cnt = cnt + 1
    #else:
        #print("0")

print("\n\
  end\n\
\n\
  always @(posedge clk) mem_data <= mem[mem_addr];\n\
\n\
  // ============================================================================\n\
\n\
  reg o_ready;\n\
\n\
  always @(posedge clk or negedge rstn)\n\
    if (!rstn) o_ready <= 1'd0;\n\
    else o_ready <= valid && ((addr & MEM_ADDR_MASK) != 0);\n\
\n\
  // Output connectins\n\
  assign ready    = o_ready;\n\
  assign rdata    = mem_data;\n\
  assign mem_addr = addr[MEM_SIZE_BITS+1:2];\n\
\n\
endmodule\n\
")

