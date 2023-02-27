
module buyruk_tagvram #(
    parameter DATA_WIDTH = 9,
    parameter COLS_N = 512
)(
    input wire clk_i,
    // Port 0: W
    input wire        wen_i,
    input wire [DATA_WIDTH-1:0] data_i,
    input wire [ 8:0] wadr_i,
    // Port 0: R
    output wire [DATA_WIDTH-1:0] data0_o,
    input  wire [ 8:0] radr0_i,
    // Port 1: R
    output wire [DATA_WIDTH-1:0] data1_o,
    input  wire [ 8:0] radr1_i
);
    reg [DATA_WIDTH-1:0] RAM[0:COLS_N-1];

    always @(posedge clk_i) begin
        if(wen_i) RAM[wadr_i] <= data_i;
    end

    assign data0_o = RAM[radr0_i];
    assign data1_o = RAM[radr1_i];

endmodule
