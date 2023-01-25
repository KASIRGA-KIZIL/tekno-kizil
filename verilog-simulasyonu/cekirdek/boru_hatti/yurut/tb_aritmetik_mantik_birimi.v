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

    aritmetik_mantik_birimi amb_dut (
        .kontrol(kontrol),
        .deger1_i(deger1_i),
        .deger2_i(deger2_i),
        .lt_ltu_i(2'b0),
        .sonuc_o(sonuc_o)
    );

    wire [31:0] golden_ans;
    behave_adder golden_adder(
        .in0(deger1_i),
        .in1((kontrol == `AMB_CIKARMA) ? ~deger2_i : deger2_i),
        .cin((kontrol == `AMB_CIKARMA)),
        .out(golden_ans),
        .cout( )
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

    task automatic Test(
        input [31:0] deger1,
        input [31:0] deger2,
        input [31:0] sonuc,
        input [31:0] beklenen,
        input [ 3:0] kontrol
    );begin : hata_raporu
        if(((beklenen != sonuc)))begin
            $display("----------------------------------------");
            $display("Zaman: %t", $time);
            $display("Elemanlar: %d , %d",$signed(deger1),$signed(deger2));
            $display("Sonuc:     %d",$signed(sonuc));
            $display("Beklenen:  %d",$signed(beklenen));
            $display("Operasyon: %s", (kontrol == `AMB_CIKARMA)? "AMB_CIKARMA":
                                      (kontrol == `AMB_CIKARMA)? "AMB_CIKARMA":
                                      (kontrol == `AMB_XOR    )? "AMB_XOR    ":
                                      (kontrol == `AMB_OR     )? "AMB_OR     ":
                                      (kontrol == `AMB_AND    )? "AMB_AND    ":
                                      (kontrol == `AMB_SLL    )? "AMB_SLL    ":
                                      (kontrol == `AMB_SRL    )? "AMB_SRL    ":
                                      (kontrol == `AMB_SRA    )? "AMB_SRA    ":
                                      (kontrol == `AMB_SLT    )? "AMB_SLT    ":
                                      (kontrol == `AMB_SLTU   )? "AMB_SLTU   ":
                                                                  "AMB_YOK");
            $display("[ERROR]");
            $finish;
        end
    end endtask

    // tests
    task automatic test_toplama_cikarma(
    );begin : toplama_cikarma_testi
        integer i;
        reg [110:0] operasyon;

        // Bariz testler, 0+0, 0-0 gibi.
        deger1_i = 32'b0;
        deger2_i = 32'b0;
        kontrol  = `AMB_TOPLAMA;
        clk_delay(1);
        Test(deger1_i, deger2_i, sonuc_o, golden_ans, kontrol);

        deger1_i = 32'b0;
        deger2_i = 32'b0;
        kontrol  = `AMB_CIKARMA;
        clk_delay(1);
        Test(deger1_i, deger2_i, sonuc_o, golden_ans, kontrol);

        // rastgele testler
        for (i=0; i<10000;i=i+1)begin
            deger1_i = $random;
            deger2_i = $random;
            kontrol  = $random % 2 ? `AMB_TOPLAMA : `AMB_CIKARMA;
            clk_delay(1);
            Test(deger1_i, deger2_i, sonuc_o, golden_ans, kontrol);
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
