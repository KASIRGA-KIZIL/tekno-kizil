// tb_cekirdek.v
`timescale 1ns / 1ps

`include "tanimlamalar.vh"


module tb_cekirdek;

    // Parameters
    localparam INPUT_FILE  = "./build/blinky.hex";
    localparam OUTPUT_VCD_FILE = "./build/out.vcd";
    localparam DEPTH = 2048;

    reg [31:0] mem [DEPTH-1:0];
    initial begin
        $readmemh(INPUT_FILE,   mem,   0, DEPTH-1);
    end

    // Ports
    reg   clk_i = 0;
    reg   rst_i = 0;

    reg   l1b_bekle_i = 0;
    wire  l1b_chip_select_n_o;
    reg  [31:0] l1b_deger_i;
    wire [31:0] l1b_adres_o;

    cekirdek cekirdek_dut (
        .clk_i (clk_i ),
        .rst_i (rst_i ),
        .l1b_bekle_i (l1b_bekle_i ),
        .l1b_deger_i (mem[l1b_adres_o>>2]),
        .l1b_chip_select_n_o (l1b_chip_select_n_o ),
        .l1b_adres_o  ( l1b_adres_o)
    );

    initial begin
        $dumpfile(OUTPUT_VCD_FILE);
        $dumpvars(0, tb_cekirdek);
        rst_i = 1'b1;
        clk_delay(1);
        rst_i = 1'b0;


        clk_delay(25);

        $display("finished");
        $finish;

    end

    always #5  clk_i = ! clk_i ;


    // Helper tasks
    task automatic clk_delay(
        input [31:0] nmbr
    );begin : Clock_Delay_Task
        integer i;
        for (i=0; i<nmbr;i=i+1)begin
            @(posedge clk_i);
        end
        #1;
    end endtask

endmodule
