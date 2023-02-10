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
    output     [0:0]  cmd_busy_o ,
    output reg [31:0] cmd_rdata_o,
    output reg [0:0]  cmd_rdata_valid_o,

    //wb master <-> wb slave interface
    output reg [31:0] addr_o ,
    input      [31:0] data_i ,
    output reg [31:0] data_o ,
    output reg [0:0]  we_o   ,

    output reg [0:0]  cyc_o  ,
    output reg [0:0]  stb_o  ,

    output reg [1:0]  sel_o  ,
    input      [0:0]  ack_i

    // output reg [0:0]  tgd_i  ,
    // output reg [0:0]  tgd_o  ,
);

    //latches
    reg [31:0]    addr_o_n;
    reg [31:0]    data_o_n;
    reg [0:0]     we_o_n  ;

    reg [0:0]     cyc_o_n ;
    reg [0:0]     stb_o_n ;

    reg [31:0]    cmd_rdata_o_n;
    reg [0:0]     cmd_rdata_valid_o_n;
    reg [0:0]     okuma_istegi_r,okuma_istegi_n;

    wire read_request_w = cmd_word_i[32];
    wire write_request_w = cmd_word_i[33];

    assign cmd_busy_o = cyc_o || stb_o;

    reg [1:0] sel_o_n;

    always@*begin
        sel_o_n = (read_request_w | write_request_w) ? (cmd_addr_i[29] ? cmd_addr_i[17:16]   //Cihazlar
                                    : 2'b11)    // Veri bellegi
                                    : 2'b00;    // Inaktif

        cmd_rdata_valid_o_n = 1'b0;
        //
        addr_o_n       = 32'b0;
        cyc_o_n        = 1'b0;
        stb_o_n        = 1'b0;
        okuma_istegi_n = 1'b0;
        data_o_n       = 32'b0;
        we_o_n         = 1'b0;
        cmd_rdata_o_n  = 32'b0;
        // IDLE
        if(!cyc_o && !stb_o)begin
            if(read_request_w)begin//read request
                addr_o_n = cmd_addr_i;
                cyc_o_n = 1'b1;
                stb_o_n = 1'b1;
                okuma_istegi_n = 1'b1;
            end else if(write_request_w)begin//write request
                addr_o_n = cmd_addr_i;
                data_o_n = cmd_word_i[31:0];
                cyc_o_n = 1'b1;
                stb_o_n = 1'b1;
                we_o_n  = 1'b1;
            end else begin//idle
                cyc_o_n = cyc_o;
                stb_o_n = stb_o;
            end
        end

        if(cyc_o && stb_o)begin
            stb_o_n = 1'b0;
            addr_o_n = 32'b0;
            data_o_n = 32'b0;
            we_o_n  = 1'b0;
        end

        if(cyc_o && ~stb_o && ack_i)begin
            cmd_rdata_o_n = data_i;
            cyc_o_n = 1'b0;
            stb_o_n = 1'b0;
            we_o_n  = 1'b0;
            if(okuma_istegi_r)begin
                cmd_rdata_valid_o_n = 1'b1;
                okuma_istegi_n = 1'b0;
            end
        end

    end

    always@(posedge clk_i)begin
        if(~rst_i)begin
            cmd_rdata_o <= cmd_rdata_o_n;
            cmd_rdata_valid_o <= cmd_rdata_valid_o_n;
            okuma_istegi_r <= okuma_istegi_n;

            addr_o <= addr_o_n ;
            data_o <= data_o_n ;
            we_o   <= we_o_n   ;

            cyc_o  <= cyc_o_n  ;
            stb_o  <= stb_o_n  ;

            sel_o  <= sel_o_n  ;
        end else begin
            //reset
            cmd_rdata_o <= 32'b0;
            cmd_rdata_valid_o <= 1'b0;
            okuma_istegi_r <= 1'b0;

            addr_o <= 32'b0;
            data_o <= 32'b0;
            we_o   <= 1'b0 ;

            cyc_o  <= 1'b0 ;
            stb_o  <= 1'b0 ;

            sel_o  <= 2'b0 ;
        end
    end

endmodule