// vga_denetleyici.v
`timescale 1ns / 1ps

`include "tanimlamalar.vh"


module vga_denetleyici (
    input wire clk_i,
    input wire rst_i,
    input  wire [ 18:0] wb_adr_i, // 10 bit ust 9 bit alt
    input  wire [31:0]  wb_dat_i,
    input  wire         wb_we_i ,
    input  wire         wb_stb_i,
    input  wire [ 3:0]  wb_sel_i,
    input  wire         wb_cyc_i,
    output reg          wb_ack_o,
    output reg  [31:0]  wb_dat_o,

//    VGA Side
    output wire [ 9:0] o_VGA_R,
    output wire [ 9:0] o_VGA_G,
    output wire [ 9:0] o_VGA_B,
    output wire        o_VGA_H_SYNC,
    output wire        o_VGA_V_SYNC,
    output wire        o_VGA_SYNC,
    output wire        o_VGA_BLANK,
    output wire        o_VGA_CLOCK
    
    ,input clk_27mhz
);

    reg [479:0] mem [639:0];

    integer i = 0;
    initial begin
        for(i=0; i<640; i=i+1)
            mem[i] = {480{1'b1}};
    end

    wire [ 9:0] o_Hori;
    wire [ 9:0] o_Verti;
    wire [ 9:0] i_Red = {9{mem[o_Hori][o_Verti]}};
    wire [ 9:0] i_Green = {9{mem[o_Hori][o_Verti]}};
    wire [ 9:0] i_Blue = {9{mem[o_Hori][o_Verti]}};

    vga vga_dut(
    //    Host Side
    .o_Hori(o_Hori),
    .o_Verti(o_Verti),
    .i_Red(i_Red),
    .i_Green(i_Green),
    .i_Blue(i_Blue),
    //    VGA Side
    .o_VGA_R(o_VGA_R),
    .o_VGA_G(o_VGA_G),
    .o_VGA_B(o_VGA_B),
    .o_VGA_H_SYNC(o_VGA_H_SYNC),
    .o_VGA_V_SYNC(o_VGA_V_SYNC),
    .o_VGA_SYNC(o_VGA_SYNC),
    .o_VGA_BLANK(o_VGA_BLANK),
    .o_VGA_CLOCK(o_VGA_CLOCK),
    //    Control Signal
    .i_clk(clk_27mhz)
);



    always @(posedge clk_i) begin
        if (rst_i) begin
            wb_ack_o <= 1'b0;
            
        end 
        else begin
            if(wb_cyc_i) begin
                wb_ack_o <= wb_stb_i & !wb_ack_o;
                
                if(wb_stb_i & wb_we_i & !wb_ack_o & wb_sel_i[0]) begin
                    mem[wb_adr_i[18:9]][wb_adr_i[8:0]] <= wb_dat_i[0];
                end
       
            end
        end
    end
endmodule
