// tb_modified_booth_dadda_carpici.v
`timescale 1ns / 1ps

`include "tanimlamalar.vh"

`define WLEN       33

module tb_modified_booth_dadda_carpici();
    reg [`WLEN-1:0] a_r;
    reg [`WLEN-1:0] b_r;
    wire [(`WLEN*2)-1:0] s_w;
    localparam OUTPUT_VCD_FILE = "./build/out.vcd";

    wire [31:0] mulhsu     = s_w[63:32];
    wire [31:0] alt_sonuc = s_w[63:0];
    modified_booth_dadda_carpici mbdc(
        .carpilan_i(a_r),
        .carpan_i(b_r),
        .sonuc_o(s_w),
        .isaretli(1'b1),
        .bitti()
    );

    initial begin
        $dumpfile(OUTPUT_VCD_FILE);
        $dumpvars(0, tb_modified_booth_dadda_carpici);
        a_r = 0;
        b_r = 0;
        #1;
        $display("gher");
        // Test case 1: 7*4=18
        a_r = 4;
        b_r = 7;
        $display("other");
        #10;
        a_r = -7;
        b_r =  3;
        $display("other");
        #10;
        a_r = 4;
        b_r = 11;


        #10;
        $finish;
    end

endmodule

