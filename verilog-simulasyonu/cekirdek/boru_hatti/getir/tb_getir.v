// tb_getir.v
`timescale 1ns / 1ps


// RV32IMCX Buyruklari
`define ADD        32'b00000000000000000000000000110011
`define ADDI       32'b00000000000000000000000000010011
`define AND        32'b00000000000000000111000000110011
`define ANDI       32'b00000000000000000111000000010011
`define AUIPC      32'b00000000000000000000000000010111
`define BEQ        32'b00000000000000000000000001100011
`define BGE        32'b00000000000000000101000001100011
`define BGEU       32'b00000000000000000111000001100011
`define BLT        32'b00000000000000000100000001100011
`define BLTU       32'b00000000000000000110000001100011
`define BNE        32'b00000000000000000001000001100011


`define C_ADD      32'b0000000000000000_1001111111111110
`define C_ADDI     32'b0000000000000000_0001111111111101
`define C_ADDI16SP 32'b0000000000000000_0111000101111101
`define C_ADDI4SPN 32'b0000000000000000_0001111111111100
`define C_AND      32'b0000000000000000_1000111111111101
`define C_ANDI     32'b0000000000000000_1001101111111101
`define C_BEQZ     32'b0000000000000000_1101111111111101
`define C_BNEZ     32'b0000000000000000_1111111111111101
`define C_EBREAK   32'b0000000000000000_1001000000000010
`define C_J        32'b0000000000000000_1011111111111101
`define C_JAL      32'b0000000000000000_0011111111111101
`define C_JALR     32'b0000000000000000_1001111110000010
`define C_JR       32'b0000000000000000_1000111110000010
`define C_LI       32'b0000000000000000_0101111111111101
`define C_LUI      32'b0000000000000000_0111111111111101
`define C_LW       32'b0000000000000000_0101111111111100
`define C_LWSP     32'b0000000000000000_0101111111111110
`define C_MV       32'b0000000000000000_1000111111111110
`define C_NOP      32'b0000000000000000_0001000001111101
`define C_OR       32'b0000000000000000_1000111111011101
`define C_SLLI     32'b0000000000000000_0000111111111110
`define C_SRAI     32'b0000000000000000_1000011111111101
`define C_SRLI     32'b0000000000000000_1000001111111101
`define C_SUB      32'b0000000000000000_1000111110011101
`define C_SW       32'b0000000000000000_1101111111111100
`define C_SWSP     32'b0000000000000000_1101111111111110
`define C_XOR      32'b0000000000000000_1000111110111101

`define DIV        32'b00000010000000000100000000110011
`define DIVU       32'b00000010000000000101000000110011
`define EBREAK     32'b00000000000100000000000001110011
`define ECALL      32'b00000000000000000000000001110011
`define FENCE      32'b00000000000000000000000000001111
`define FENCE_I    32'b00000000000000000001000000001111
`define JAL        32'b00000000000000000000000001101111
`define JALR       32'b00000000000000000000000001100111
`define LB         32'b00000000000000000000000000000011
`define LBU        32'b00000000000000000100000000000011
`define LH         32'b00000000000000000001000000000011
`define LHU        32'b00000000000000000101000000000011
`define LUI        32'b00000000000000000000000000110111
`define LW         32'b00000000000000000010000000000011
`define MUL        32'b00000010000000000000000000110011
`define MULH       32'b00000010000000000001000000110011
`define MULHSU     32'b00000010000000000010000000110011
`define MULHU      32'b00000010000000000011000000110011
`define OR         32'b00000000000000000110000000110011
`define ORI        32'b00000000000000000110000000010011
`define REM        32'b00000010000000000110000000110011
`define REMU       32'b00000010000000000111000000110011
`define SB         32'b00000000000000000000000000100011
`define SH         32'b00000000000000000001000000100011
`define SLL        32'b00000000000000000001000000110011
`define SLLI       32'b00000000000000000001000000010011
`define SLT        32'b00000000000000000010000000110011
`define SLTI       32'b00000000000000000010000000010011
`define SLTIU      32'b00000000000000000011000000010011
`define SLTU       32'b00000000000000000011000000110011
`define SRA        32'b01000000000000000101000000110011
`define SRAI       32'b01000000000000000101000000010011
`define SRL        32'b00000000000000000101000000110011
`define SRLI       32'b00000000000000000101000000010011
`define SUB        32'b01000000000000000000000000110011
`define SW         32'b00000000000000000010000000100011
`define XOR        32'b00000000000000000100000000110011
`define XORI       32'b00000000000000000100000000010011

`define HMDST      32'b0000101_00000_00000_001_00000_0110011
`define PKG        32'b0000100_00000_00000_100_00000_0110011
`define RVRS       32'b011010111000_00000_101_00000_0010011
`define SLADD      32'b0010000_00000_00000_010_00000_0110011
`define CNTZ       32'b0110000_00001_00000_001_00000_0010011
`define CNTP       32'b0110000_00010_00000_001_00000_0010011

`define CONV_LD_W  32'b0_000000_00000_00000_010_00000_0001011
`define CONV_CLR_W 32'b0000000_00000_00000_011_00000_0001011
`define CONV_LD_X  32'b0_000000_00000_00000_000_00000_0001011
`define CONV_CLR_X 32'b0000000_00000_00000_001_00000_0001011
`define CONV_RUN   32'b0000000_00000_00000_100_00000_0001011

module getir_tb;

    // Parameters
    localparam OUTPUT_VCD_FILE = "./build/out.vcd";

    // Ports
    reg  clk_i = 0;
    reg  rst_i = 0;
    reg  ddb_durdur_i = 0;
    reg  ddb_bosalt_i = 0;
    wire ddb_hazir_o;
    // L1 Buyruk Onbellegi
    reg  l1b_bekle_i = 0;
    wire [31:0] l1b_deger_i;
    wire  l1b_bosalt_o;
    wire  l1b_chip_select_n_o;
    // Yurut
    reg  yrt_atlanan_ps_gecerli_i = 0;
    reg [31:1] yrt_atlanan_ps_i;
    // Coz Yazmacoku
    wire [31:1] cyo_l1b_ps_o;
    wire [31:0] cyo_buyruk_o;

    getir getir_dut (
        .clk_i (clk_i ),
        .rst_i (rst_i ),
        //  Denetim Durum Birimi
        .ddb_durdur_i (1'b0),
        .ddb_bosalt_i (1'b0),
        .ddb_hazir_o  (ddb_hazir_o ),
        //  L1 Buyruk Onbellegi
        .l1b_bekle_i  (1'b0),
        .l1b_deger_i  (l1b_deger_i  ),
        .l1b_bosalt_o (l1b_bosalt_o ),
        .l1b_chip_select_n_o (l1b_chip_select_n_o ),
        // Yurut
        .yrt_atlanan_ps_gecerli_i (yrt_atlanan_ps_gecerli_i ),
        .yrt_atlanan_ps_i (yrt_atlanan_ps_i ),
        // Coz Yazmacoku
        .cyo_l1b_ps_o (cyo_l1b_ps_o ),
        .cyo_buyruk_o  ( cyo_buyruk_o)
    );

    reg [32:0] kod [15:0];
    assign l1b_deger_i = kod[cyo_l1b_ps_o>>1];
    initial begin
        $dumpfile(OUTPUT_VCD_FILE);
        $dumpvars(0, getir_tb);
        rst_i = 1'b1;
        clk_delay(1);
        rst_i = 1'b0;

        clk_delay(20);

        $display("finished");
        $finish;
    end

    reg [31:0] tmp = `ADD;
    reg [31:0] tmp1 = `C_ADD;

    initial begin
        kod[0]  = `ADD;
        kod[1]  = `ADD;
        kod[2]  = `ADD;
        kod[3]  = `ADD;
        kod[4]  = {tmp [15:0],tmp1[15:0]};
        kod[5]  = {tmp1[15:0],tmp [31:16]};
        kod[6]  = `ADD;
        kod[7]  = `ADD;
        kod[8]  = {tmp [15:0],tmp1[15:0]};
        kod[9]  = {tmp [15:0],tmp [31:16]};
        kod[10] = {tmp1[15:0],tmp [31:16]};
        kod[11] = `XORI;
        kod[12] = `DIV;

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
