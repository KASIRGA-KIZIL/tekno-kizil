// wishbone_master.v
`timescale 1ns / 1ps

`include "tanimlamalar.vh"

module wishbone_master(
    //syscon
    input [0:0] clk_i,
    input [0:0] rst_i,

    //control interface  ---> zipcpu
    // input      [0:0]  cmd_rst  ,
    // input      [0:0]  cmd_stb  ,
    // input      [33:0] cmd_word ,
    // output reg [0:0]  cmd_busy ,
    
    output reg [31:0] addr_o ,
    input      [31:0] data_i ,
    output reg [31:0] data_o ,
    output reg [0:0]  we_o   ,

    output reg [0:0]  cyc_o  ,
    output reg [0:0]  stb_o  ,

    output reg [1:0]  sel_o  ,
    input      [0:0]  ack_i  ,
    //olmali mi??
    output reg [:0]  tga_o  ,
    output reg [:0]  tgc_o  ,
    output reg [:0]  tgd_o  ,
    input      [:0]  tgd_i
);

    //buffers
    reg [31:0] b_addr;
    reg [31:0] b_data;

    //latches
    reg [31:0]    addr_o_n;
    reg [31:0]    data_o_n;
    reg [0:0]     we_o_n  ;
     
    reg [0:0]     cyc_o_n ;
    reg [0:0]     stb_o_n ;
 
    reg [1:0]     sel_o_n ;
    //     bunlar olmali mi??
    reg [0:0]     tga_o_n  ;
    reg [0:0]     tgc_o_n  ;
    reg [0:0]     tgd_o_n  ;

    

    always@*begin
        // IDLE
        if(!cyc_o && !stb_o)begin
            if()begin//read request
                addr_o_n = b_addr;
                sel_o_n = ;//chip select
                cyc_o_n = 1'b1;
                stb_o_n = 1'b1;
                tga_o_n = ;//olmali mi
                tgc_o_n = ;//olmali mi
                //busy = 1'b1;
            end else if()begin//write request
                addr_o_n = b_addr;
                data_o_n = b_data;
                sel_o_n = ;//chip select
                cyc_o_n = 1'b1;
                stb_o_n = 1'b1;
                we_o_n  = 1'b1;
                tga_o_n = ;//olmali mi
                tgd_o_n = ;//olmali mi
                tgc_o_n = ;//olmali mi
            end else begin//idle
                cyc_o_n = cyc_o;
                stb_o_n = stb_o;
            end
        end
        // BUS REQUEST
        if(cyc_o && stb_o)begin
            addr_o_n = 32'b0;
            stb_o_n = 1'b0;
            sel_o_n = 2'b0;
            if()begin//write request
                data_o = 32'b0;
                we_o_n  = 1'b0;
            end
        end
        // BUS WAIT
        if(cyc_o && !stb_o && ack_i)begin
            cyc_o_n = 1'b0;
            if()begin//read request
                b_data = data_i;
            end
        end
    end

    always@(posedge clk)begin
        if(~rst_i)begin
            addr_o <= addr_o_n ;    
            data_o <= data_o_n ;
            we_o   <= we_o_n   ;

            cyc_o  <= cyc_o_n  ;
            stb_o  <= stb_o_n  ;

            sel_o  <= sel_o_n  ;

            tga_o  <= tga_o_n  ;
            tgc_o  <= tgc_o_n  ;
            tgd_o  <= tgd_o_n  ;
        end else begin
            //reset
            addr_o <= 32'b1101; // ornek deger = 32'd13 = 32'h000D
            data_o <= 32'b0;
            we_o   <= 1'b0 ;

            cyc_o  <= 1'b0 ;
            stb_o  <= 1'b0 ;

            sel_o  <= 2'b0 ;

            tga_o  <= 1'b0 ;
            tgc_o  <= 1'b0 ;
            tgd_o  <= 1'b0 ;
        end
    end

endmodule