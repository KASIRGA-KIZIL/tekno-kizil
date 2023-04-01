// anabellek_denetleyici.v
`timescale 1ns / 1ps

`define VERI   1
`define BUYRUK 0

module anabellek_denetleyici(
    input wire clk_i,
    input wire rst_i,
    // Anabellek <-> Anabellek Denetleyici
    output reg         iomem_valid,
    input  wire        iomem_ready,
    output reg  [ 3:0] iomem_wstrb,
    output reg  [31:0] iomem_addr,
    output reg  [31:0] iomem_wdata,
    input  wire [31:0] iomem_rdata,
    // Timer <-> Anabellek Denetleyici
    input  wire        timer_iomem_valid,
    input  wire [31:0] timer_iomem_addr,
    output reg  [31:0] timer_iomem_rdata,
    // L1B <-> Anabellek Denetleyici
    input  wire        l1b_iomem_valid,
    output reg         l1b_iomem_ready,
    input  wire [18:2] l1b_iomem_addr,
    output reg  [31:0] l1b_iomem_rdata,
    // L1V <-> Anabellek Denetleyici
    input  wire        l1v_iomem_valid,
    output reg         l1v_iomem_ready,
    input  wire [ 3:0] l1v_iomem_wstrb,
    input  wire [18:2] l1v_iomem_addr,
    input  wire [31:0] l1v_iomem_wdata,
    output reg  [31:0] l1v_iomem_rdata
);
    reg switch;

    always @(posedge clk_i) begin
        iomem_wstrb <= timer_iomem_valid ? 4'b0 : ((switch == `VERI) ? l1v_iomem_wstrb : 4'b0);

        iomem_wdata <= l1v_iomem_wdata;

        iomem_valid <= timer_iomem_valid ? 1'b1 : ((switch == `BUYRUK) ? l1b_iomem_valid : l1v_iomem_valid);

        iomem_addr  <= timer_iomem_valid ? timer_iomem_addr : ((switch == `BUYRUK) ? {8'h40,5'b0,l1b_iomem_addr,2'b0}   : {8'h40,5'b0,l1v_iomem_addr,2'b0} ) ;

        l1b_iomem_rdata   <= iomem_rdata;
        l1v_iomem_rdata   <= iomem_rdata;
        timer_iomem_rdata <= iomem_rdata;

        l1b_iomem_ready <= timer_iomem_valid ? 1'b0 : ((switch == `BUYRUK) ? iomem_ready : 1'b0);
        l1v_iomem_ready <= timer_iomem_valid ? 1'b0 : ((switch == `VERI)   ? iomem_ready : 1'b0);
    end

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
