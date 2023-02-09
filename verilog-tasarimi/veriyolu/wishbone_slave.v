// wishbone_slave.v
`timescale 1ns / 1ps

`include "tanimlamalar.vh"

module wishbone_slave(
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

    input      [0:0]  sel_i  ,
    output reg [0:0]  ack_o  ,

    // input      [0:0]  tgd_i  ,
    // input      [0:0]  tgd_o  ,

    // wb <-> controller interface
    input      [0:0]  device_ready_i,
    input      [31:0] device_rdata_i,
    input      [0:0]  device_rdata_valid_i,
    output     [31:0] device_addr_o ,
    output     [31:0] device_wdata_o,
    output     [0:0]  device_we_o,
    output     [0:0]  device_re_o
);

    //latches
    reg [31:0] data_o_n;
    reg [0:0] ack_o_n;
    
    assign device_addr_o = addr_i;
    assign device_wdata_o = data_i;
    assign device_we_o = we_i;
    assign device_re_o = sel_i & ~we_i & cyc_i & stb_i;

    always@*begin
        if(sel_i)begin
            ack_o_n = 1'b0;
            if(cyc_i && stb_i)begin
                ack_o_n = 1'b1;
                if(~we_i & device_rdata_valid_i)begin//read request
                    data_o_n = device_rdata_i;
                end
            end
            if(ack_o)begin
                ack_o_n = 1'b0;
            end
        end
    end

    always@(posedge clk_i)begin
        if(~rst_i)begin
            data_o <= data_o_n;
            ack_o <= ack_o_n;
        end else begin
            data_o <= 32'b0;
            ack_o <= 1'b0;
        end
    end

endmodule