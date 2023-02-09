
module buyruk_ffram(
    input wire clk_i,
    // Port 0: W
    input wire [ 4:0] wen_i,
    input wire [40:0] data_i,
    input wire [ 8:0] wadr_i,
    // Port 1: R
    output wire [40:0] data_o,
    input  wire [ 8:0] radr_i
);
    localparam COLS_N = 512;
    reg [40:0] RAM[0:COLS_N-1];

    always @(posedge clk_i) begin
        if(wen_i[0]) RAM[wadr_i][ 7: 0] <= data_i[ 7: 0];
        if(wen_i[1]) RAM[wadr_i][15: 8] <= data_i[15: 8];
        if(wen_i[2]) RAM[wadr_i][23:16] <= data_i[23:16];
        if(wen_i[3]) RAM[wadr_i][31:24] <= data_i[31:24];
        if(wen_i[4]) RAM[wadr_i][39:32] <= data_i[39:32];
        if(wen_i[4]) RAM[wadr_i][   40] <= data_i[   40];
    end

    assign   data_o = RAM[radr_i];

endmodule
