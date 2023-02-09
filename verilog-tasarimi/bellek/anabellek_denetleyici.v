// anabellek_denetleyici.v
`timescale 1ns / 1ps

`define BUYRUK 1
`define VERI   0

module anabellek_denetleyici(
    input wire clk_i,
    input wire rst_i,
    // Anabellek <-> Anabellek Denetleyici
    output wire        iomem_valid,
    input  wire        iomem_ready,
    output wire [ 3:0] iomem_wstrb,
    output wire [31:0] iomem_addr,
    output wire [31:0] iomem_wdata,
    input  wire [31:0] iomem_rdata,
    // L1B <-> Anabellek Denetleyici
    input  wire        l1b_iomem_valid,
    output wire        l1b_iomem_ready,
    input  wire [31:0] l1b_iomem_addr,
    output wire [31:0] l1b_iomem_rdata,
    // L1V <-> Anabellek Denetleyici
    input  wire        l1v_iomem_valid,
    output wire        l1v_iomem_ready,
    input  wire [ 3:0] l1v_iomem_wstrb,
    input  wire [31:0] l1v_iomem_addr,
    input  wire [31:0] l1v_iomem_wdata,
    output wire [31:0] l1v_iomem_rdata
);
    reg switch;

    assign iomem_wstrb = l1v_iomem_wstrb;
    assign iomem_wdata = l1v_iomem_wdata;

    assign iomem_valid = (switch == `BUYRUK) ? l1b_iomem_valid : l1v_iomem_valid;
    assign iomem_addr  = (switch == `BUYRUK) ? l1b_iomem_addr  : l1v_iomem_addr ;

    assign l1b_iomem_rdata = iomem_rdata;
    assign l1v_iomem_rdata = iomem_rdata;

    assign l1b_iomem_ready = (switch == `BUYRUK) ? iomem_ready : 1'b0;
    assign l1v_iomem_ready = (switch == `BUYRUK) ?  1'b0 : iomem_ready;

    always @(posedge clk_i) begin
        if(rst_i) begin
            switch <= `BUYRUK;
        end else begin
            case({l1b_iomem_valid,l1v_iomem_valid})
            2'b00: switch <= `BUYRUK;
            2'b01: switch <= `VERI;
            2'b10: switch <= `BUYRUK;
            2'b11: switch <=  switch;
            endcase
        end
    end

endmodule
