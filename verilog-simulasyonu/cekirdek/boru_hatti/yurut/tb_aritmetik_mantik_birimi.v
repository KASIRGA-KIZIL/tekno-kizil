// tb_aritmetik_mantik_birimi.v
`timescale 1ns / 1ps

`include "tanimlamalar.vh"


module tb_aritmetik_mantik_birimi();

    // TB PARAMS
    localparam OUTPUT_VCD_FILE = "./build/out.vcd";

    // DUT Variables
    reg  rst_i = 0;
    reg  clk_i = 0;

    // Ports
    reg  [3:0] kontrol;
    reg  [31:0] deger1_i;
    reg  [31:0] deger2_i;
    wire [31:0] sonuc_o;
    wire sifir;

    aritmetik_mantik_birimi amb_dut (
        .kontrol(kontrol),
        .deger1_i(deger1_i),
        .deger2_i(deger2_i),
        .lt_ltu_i(3'b0),

        .sonuc_o(sonuc_o)
    );

    wire [31:0] golden_ans;
    wire golden_carry_o;
    wire golden_carry_i         = (kontrol == `AMB_CIKARMA) ? 1'b1 : 1'b0;
    wire [31:0] golden_deger2_i = (kontrol == `AMB_CIKARMA) ? ~deger2_i : deger2_i;
    behave_adder golden_adder(
        .in0(deger1_i),
        .in1(golden_deger2_i),
        .cin(golden_carry_i),
        .out(golden_ans),
        .cout(golden_carry_o)
    );

    always    #5  clk_i = !clk_i;

    initial begin
        $dumpfile(OUTPUT_VCD_FILE);
        $dumpvars(0, tb_aritmetik_mantik_birimi);

        test_toplama_cikarma();
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

    // tests
    task test_toplama_cikarma(
    );begin : toplama_cikarma_testi
        integer i;
        for (i=0; i<10000;i=i+1)begin
            deger1_i = $random;
            deger2_i = $random;
            kontrol  = $random%2 ? `AMB_TOPLAMA : `AMB_CIKARMA;
            clk_delay(1);
            if(((golden_ans != sonuc_o)))begin
                $display("----------------------------------------");
                $display("Zaman: %t",$time);
                $display("Elemanlar: %d , %d",$signed(deger1_i),$signed(deger2_i));
                $display("Sonuc:     %d",$signed(sonuc_o));
                $display("Beklenen:  %d",$signed(golden_ans));
                $display("Operasyon: %s",(kontrol == `AMB_CIKARMA) ? "cikarma": "toplama");
                $display("[ERROR]");
                #11;
                $finish;
            end
        end
        $display("[GECTI] Toplama Cikarma Testi");
    end endtask
endmodule

module behave_adder(
    input  wire [31:0] in0,
    input  wire [31:0] in1,
    input  wire cin,
    output wire [31:0] out,
    output wire cout
);
    wire [32:0]temp;
    assign temp=in0+in1+cin;
    assign out=temp[31:0];
    assign cout=temp[32];
endmodule
