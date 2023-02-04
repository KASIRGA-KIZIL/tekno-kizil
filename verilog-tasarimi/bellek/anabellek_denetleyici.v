// anabellek_denetleyici.v
`timescale 1ns / 1ps


module anabellek_denetleyici(
    // Anabellek <-> Anabellek Denetleyici
    output        iomem_valid,
    input         iomem_ready,
    output [ 3:0] iomem_wstrb,
    output [31:0] iomem_addr,
    output [31:0] iomem_wdata,
    input  [31:0] iomem_rdata,
    // Getir Onbellek Denetleyici <-> Anabellek Denetleyici
    input  [31:0] l1b_addr,
    output [31:0] l1b_dot,
    input         l1b_csb,
    output        l1b_stall,
    // Yurut Onbellek Denetleyici <-> Anabellek Denetleyici
    input  [31:0] l1v_addr,
    input         l1v_csb,
    input  [31:0] l1v_din,
    output [31:0] l1v_dot,
    output        l1v_stall,
    input         l1v_web
);

assign l1b_stall = (~iomem_ready);
assign l1v_stall = (~iomem_ready) || ~l1b_csb;

assign iomem_wstrb = {4{l1v_web}};

assign l1b_dot = iomem_rdata;
assign l1v_dot = iomem_rdata;

assign iomem_addr = ~l1b_csb ? l1b_addr : l1v_addr;
assign iomem_wdata = l1v_din;

assign iomem_valid = ~l1b_csb ? 1'b1 : ~l1v_csb;

endmodule
