// wishbone_master.v
`timescale 1ns / 1ps

`include "tanimlamalar.vh"

module wishbone_master(
    //syscon
    input [0:0] clk_i,
    input [0:0] rst_i,

    //cpu <-> wb interface
    input      [31:0] cmd_addr_i ,
    input      [33:0] cmd_word_i , //33. bit write, 32. bit read request
    output     [0:0]  cmd_busy_i ,
    output reg [31:0] cmd_rdata_i,
    
    //wb master <-> wb slave interface
    output reg [31:0] addr_o ,
    input      [31:0] data_i ,
    output reg [31:0] data_o ,
    output reg [0:0]  we_o   ,

    output reg [0:0]  cyc_o  ,
    output reg [0:0]  stb_o  ,

    output reg [1:0]  sel_o  ,
    input      [0:0]  ack_i
);


    //latches
    reg [31:0]    addr_o_n;
    reg [31:0]    data_o_n;
    reg [0:0]     we_o_n  ;
     
    reg [0:0]     cyc_o_n ;
    reg [0:0]     stb_o_n ;
 
    reg [1:0]     sel_o_n ;

    assign cmd_busy_i = cyc_o || stb_o;
    

    always@*begin
        // IDLE
        if(!cyc_o && !stb_o)begin
            if(cmd_word_i[32])begin//read request
                addr_o_n = cmd_addr_i;
                sel_o_n = ;//chip select
                cyc_o_n = 1'b1;
                stb_o_n = 1'b1;
            end else if(cmd_word_i[33])begin//write request
                addr_o_n = cmd_addr_i;
                data_o_n = cmd_word_i[31:0];
                sel_o_n = ;//chip select
                cyc_o_n = 1'b1;
                stb_o_n = 1'b1;
                we_o_n  = 1'b1;
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
            if(cmd_word_i[33])begin//write request
                data_o = 32'b0;
                we_o_n  = 1'b0;
            end
        end
        // BUS WAIT
        if(cyc_o && !stb_o && ack_i)begin
            cyc_o_n = 1'b0;
            if(cmd_word_i[32])begin//read request
                cmd_rdata_i = data_i;
            end
        end
    end

    always@(posedge clk_i)begin
        if(~rst_i)begin
            addr_o <= addr_o_n ;    
            data_o <= data_o_n ;
            we_o   <= we_o_n   ;

            cyc_o  <= cyc_o_n  ;
            stb_o  <= stb_o_n  ;

            sel_o  <= sel_o_n  ;
        end else begin
            //reset
            addr_o <= 32'b1101; // ornek deger = 32'd13 = 32'h000D
            data_o <= 32'b0;
            we_o   <= 1'b0 ;

            cyc_o  <= 1'b0 ;
            stb_o  <= 1'b0 ;

            sel_o  <= 2'b0 ;
        end
    end

endmodule