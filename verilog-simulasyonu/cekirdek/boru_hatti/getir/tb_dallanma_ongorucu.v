// tb_dallanma_ongorucu.v
`timescale 1ns / 1ps

`define ATLAMAMALIYDI 2'd0
`define ATLAMALIYDI   2'd1
`define SORUN_YOK     2'd2
module tb_dallanma_ongorucu;

    localparam OUTPUT_VCD_FILE = "./build/out.vcd";

    // Ports
    reg  rst_i = 0;
    reg  clk_i = 0;
    //
    reg [31:1] ps_i = 0;
    reg  buyruk_ctipi_i = 0;
    reg  tahmin_et_i = 0;
    wire [31:1] ongorulen_ps_o;
    wire  ongorulen_ps_gecerli_o;
    // Kalibrasyon sinyalleri
    reg [31:1] atlanan_ps_i;
    reg  atlanan_ps_gecerli_i = 0;
    // hata duzeltme
    wire [ 1:0] hata_duzelt_o;
    wire [31:1] yrt_ps_o;
    wire  yrt_buyruk_ctipi_o;

    dallanma_ongorucu dot (
        .rst_i (rst_i ),
        .clk_i (clk_i ),
        .ddb_durdur_i (1'b0),
        //
        .ps_i (ps_i ),
        .buyruk_ctipi_i (buyruk_ctipi_i ),
        .tahmin_et_i (tahmin_et_i ),
        .ongorulen_ps_o (ongorulen_ps_o ),
        .ongorulen_ps_gecerli_o (ongorulen_ps_gecerli_o ),
        // Kalibrasyon sinyalleri
        .atlanan_ps_i (atlanan_ps_i ),
        .atlanan_ps_gecerli_i (atlanan_ps_gecerli_i ),
        // hata duzeltme
        .hata_duzelt_o (hata_duzelt_o ),
        .yrt_ps_o (yrt_ps_o ),
        .yrt_buyruk_ctipi_o  ( yrt_buyruk_ctipi_o)
    );

    reg [31:1] ps_next;

    always @(*) begin
        case(hata_duzelt_o)
            `ATLAMALIYDI: begin
                ps_next = atlanan_ps_i;
            end
            `ATLAMAMALIYDI: begin
                if(yrt_buyruk_ctipi_o) begin
                    ps_next = yrt_ps_o + 1;
                end else begin
                    ps_next = yrt_ps_o + 2;
                end
            end
            default: begin
                if(tahmin_et_i && ongorulen_ps_gecerli_o) begin
                    ps_next = ongorulen_ps_o;
                end else begin
                    ps_next = ps_i + 2;
                end
            end
        endcase
    end

    always@(posedge clk_i) ps_i <= ps_next[31:1];

    initial begin
        $dumpfile(OUTPUT_VCD_FILE);
        $dumpvars(0, tb_dallanma_ongorucu);
        rst_i = 1;
        clk_delay(1);
        rst_i = 0;
        atlanan_ps_gecerli_i = 0;

        tahmin_et_i          = 0;
        clk_delay(1);

        tahmin_et_i          = 0;
        clk_delay(1);

        tahmin_et_i          = 1;
        clk_delay(1);
        tahmin_et_i          = 0;
        clk_delay(1);

        atlanan_ps_gecerli_i = 0;
        atlanan_ps_i         = 32'h11;
        clk_delay(1);
        clk_delay(1);
        clk_delay(1);

        $display("[BASARILI]");
        $stop;
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
    end endtask
    wire [31:0] mike = {ps_i,1'b0};
endmodule
