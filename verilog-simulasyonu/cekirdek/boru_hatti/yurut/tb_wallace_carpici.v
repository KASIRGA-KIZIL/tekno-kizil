// tb_wallace_carpici.v
`timescale 1ns / 1ps

`include "tanimlamalar.vh"


module tb_wallace_carpici();

    // TB PARAMS
    localparam OUTPUT_VCD_FILE = "./build/out.vcd";
    localparam  WLEN = 32;
    // DUT Variables
    reg  clk_i = 0;

    // Ports
    reg [WLEN-1:0] carpilan_i;
    reg [WLEN-1:0] carpan_i;
    wire [(WLEN*2)-1:0] sonuc_o;

    wallace wallace_dut (
        .x (carpilan_i ),
        .y (carpan_i ),
        .p (sonuc_o)
    );


    wire [(WLEN*2)-1:0] bmis_ans;
    wire [(WLEN*2)-1:0] bmi_ans;
    behave_multiplier #(
        .WLEN(WLEN)
    )behave_multiplier_dut(
        .in0(carpilan_i),
        .in1(carpan_i  ),
        .out(bmis_ans)
    );


    always    #5  clk_i = !clk_i;

    initial begin
        $dumpfile(OUTPUT_VCD_FILE);
        $dumpvars(0, tb_modified_booth_dadda_carpici);

        test_carpma();
        $display("[BASARILI]");
        $finish;
    end

    // Helper tasks
    task automatic clk_delay(
        input [31:0] nmbr
    );begin : Clock_Delay_Task
        integer i;
        for (i=0; i<nmbr;i=i+1)begin
            @(posedge clk_i);
        end
    end endtask

    task automatic Test(
        input [WLEN-1:0] carpilan_i,
        input [WLEN-1:0] carpan_i,
        input [(WLEN*2)-1:0] sonuc
    );begin : hata_raporu
        if((((bmis_ans) != sonuc)))begin
            $display("----------------------------------------");
            $display("Zaman: %t", $time);
            $display("Elemanlar: %d , %d",$signed(carpilan_i),$signed(carpan_i));
            $display("Sonuc:     %d",$signed(sonuc));
            $display("Beklenen:  %d",$signed((bmis_ans)));
            $display("[ERROR]");
            $finish;
        end
    end endtask

    // tests
    task automatic test_carpma(
    );begin : carpma_testi
        integer i;

        // Bariz testler, 0*0, 1*1 gibi.
        carpilan_i = 0;
        carpan_i   = 0;
        clk_delay(1);
        Test(carpilan_i, carpan_i, sonuc_o);

        carpilan_i = -1>>1;
        carpan_i   = -1>>1;
        clk_delay(1);
        Test(carpilan_i, carpan_i, sonuc_o);

        carpilan_i = 1;
        carpan_i   = 1;
        clk_delay(1);
        Test(carpilan_i, carpan_i, sonuc_o);

        carpilan_i  = 17;
        carpan_i    = 3;
        clk_delay(1);
        Test(carpilan_i, carpan_i, sonuc_o);

        // rastgele testler
        for (i=0; i<400;i=i+1)begin
            carpilan_i  = $random;
            carpan_i    = $random;
            clk_delay(1);
            Test(carpilan_i, carpan_i, sonuc_o);
        end
        $display("[GECTI] CARPMA Testi");
    end endtask

endmodule


module behave_multiplier#(
    parameter WLEN = 32
)(
    input  wire signed [WLEN-1:0] in0,
    input  wire signed [WLEN-1:0] in1,
    output wire signed [(WLEN*2)-1:0] out
);
    assign out = in1*in0;
endmodule
