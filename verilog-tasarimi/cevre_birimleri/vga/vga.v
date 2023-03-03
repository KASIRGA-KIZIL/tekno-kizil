`timescale 1ns/1ps

module    vga #(
    //    Horizontal Parameter    ( Pixel )
    parameter H_SYNC_CYC   = 95,
    parameter H_SYNC_BACK  = 47,
    parameter H_SYNC_ACT   = 640,
    parameter H_SYNC_FRONT = 15,
    parameter H_SYNC_TOTAL = 797,
    //    Virtical Parameter ( Line )
    parameter V_SYNC_CYC   = 2,
    parameter V_SYNC_BACK  = 33,
    parameter V_SYNC_ACT   = 480,
    parameter V_SYNC_FRONT = 10,
    parameter V_SYNC_TOTAL = 525

)(
    //    Host Side
    output wire [ 9:0] o_Hori,
    output wire [ 9:0] o_Verti,
    input       [ 9:0] i_Red,
    input       [ 9:0] i_Green,
    input       [ 9:0] i_Blue,
    //    VGA Side
    output wire [ 9:0] o_VGA_R,
    output wire [ 9:0] o_VGA_G,
    output wire [ 9:0] o_VGA_B,
    output wire        o_VGA_H_SYNC,
    output wire        o_VGA_V_SYNC,
    output wire        o_VGA_SYNC,
    output wire        o_VGA_BLANK,
    output wire        o_VGA_CLOCK,
    //    Control Signal
    input wire i_clk
);
localparam H_OFFSET = -11;
localparam X_START = H_SYNC_CYC+H_SYNC_BACK+H_OFFSET;
localparam Y_START = V_SYNC_CYC+V_SYNC_BACK;

//    Internal Registers and Wires
reg [ 9:0] H_Cont = 0;
reg [ 9:0] V_Cont = 0;
reg [ 9:0] o_coord_X = 0;
reg [ 9:0] o_coord_Y = 0;
reg        H_SYNC = 0;
reg        V_SYNC = 0;
reg        clk25 = 0;

assign o_VGA_CLOCK = clk25;
assign o_VGA_H_SYNC = H_SYNC;
assign o_VGA_V_SYNC = V_SYNC;
assign o_Hori = o_coord_X;
assign o_Verti = o_coord_Y;

assign o_VGA_BLANK = o_VGA_H_SYNC & o_VGA_V_SYNC;
assign o_VGA_SYNC  = 1'b0;

assign o_VGA_R = (H_Cont>=X_START && H_Cont<X_START+H_SYNC_ACT && V_Cont>=Y_START && V_Cont<Y_START+V_SYNC_ACT) ? (  i_Red) : 0;
assign o_VGA_G = (H_Cont>=X_START && H_Cont<X_START+H_SYNC_ACT && V_Cont>=Y_START && V_Cont<Y_START+V_SYNC_ACT) ? (i_Green) : 0;
assign o_VGA_B = (H_Cont>=X_START && H_Cont<X_START+H_SYNC_ACT && V_Cont>=Y_START && V_Cont<Y_START+V_SYNC_ACT) ? ( i_Blue) : 0;


//always@(posedge i_clk) begin
//    clk25 <= !clk25;
//end

//    Pixel LUT Address Generator
always@(posedge i_clk) begin
    if(H_Cont>=X_START && H_Cont<X_START+H_SYNC_ACT && V_Cont>=Y_START && V_Cont<Y_START+V_SYNC_ACT) begin
        o_coord_X <= H_Cont-X_START;
        o_coord_Y <= V_Cont-Y_START;
    end
end

//    H_Sync Generator, Ref. 25.175 MHz Clock
always@(posedge i_clk) begin
    //    H_Sync Counter
    if(H_Cont < H_SYNC_TOTAL)
        H_Cont <= H_Cont+1;
    else
        H_Cont <= 0;
    //    H_Sync Generator
    if( H_Cont < H_SYNC_CYC )
        H_SYNC <= 0;
    else
        H_SYNC <= 1;
end

//    V_Sync Generator, Ref. H_Sync
always@(posedge i_clk) begin
    //    When H_Sync Re-start
    if(H_Cont==0) begin
    //    V_Sync Counter
        if( V_Cont < V_SYNC_TOTAL )
            V_Cont    <=    V_Cont+1;
        else
            V_Cont    <=    0;
            //    V_Sync Generator
        if(    V_Cont < V_SYNC_CYC )
            V_SYNC    <=    0;
        else
            V_SYNC    <=    1;
    end
end

endmodule
