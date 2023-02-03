// wishbone_slave.v
`timescale 1ns / 1ps

`include "tanimlamalar.vh"

module wishbone_slave#(
    parameter CHIP_NO = 0
)(
    //syscon
    input [0:0] clk_i,
    input [0:0] rst_i,
    
    // wb slave <-> wb master interface
    input      [31:0] addr_i ,
    input      [31:0] data_i ,
    output reg [31:0] data_o ,
    input      [0:0]  we_i   ,

    input      [0:0]  cyc_i  ,
    input      [0:0]  stb_i  ,

    input      [1:0]  sel_i  ,
    input      [0:0]  ack_o  ,

    // wb <-> device interface
    input      [0:0]  device_ready_i,
    input      [31:0] device_rdata_i,
    output     [31:0] device_wdata_o,
    output     [31:0] device_addr_o ,
);

    //latches
    reg [31:0] data_o_n;
    reg [0:0] ack_o_n;

    assign device_addr_o = addr_i;
    assign device_wdata_o = data_i;

    always@*begin
        // BUS REQUEST
        if(cyc_i && stb_i && (sel_i == CHIP_NO))begin
            ack_o_n = 1'b1;
            if(!we_i)begin//read request
                data_o_n = device_rdata_i;
            end
        end
        // BUS WAIT
        if(cyc_i && !stb_i)begin
            data_o_n = 32'b0;
            ack_o_n = 1'b0;
        end
    end

    always@(posedge clk_i)begin
        data_o <= data_o_n;
        ack_o <= ack_o_n;
    end

endmodule