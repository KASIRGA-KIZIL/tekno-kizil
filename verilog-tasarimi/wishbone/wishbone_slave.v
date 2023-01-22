// wishbone_slave.v
`timescale 1ns / 1ps

`include "tanimlamalar.vh"

module wishbone_slave#(
    parameter CHIP_NO = 0
)(
    //syscon
    input [0:0] clk_i,
    input [0:0] rst_i,
   
    input      [31:0] addr_i ,
    input      [31:0] data_i ,
    output reg [31:0] data_o ,
    input      [0:0]  we_i   ,

    input      [0:0]  cyc_i  ,
    input      [0:0]  stb_i  ,

    input      [1:0]  sel_i  ,
    input      [0:0]  ack_o  ,
    //olmali mi??
    output     [:0]  tga_i  ,
    output     [:0]  tgc_i  ,
    output reg [:0]  tgd_o  ,
    input      [:0]  tgd_i
);


    always@*begin

    end

    always@(posedge clk)begin

    end

endmodule