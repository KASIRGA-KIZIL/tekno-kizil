
module RAM256_buyruk (
    input wire clk_i,

    input  wire        we_i,
    input  wire [ 7:0] wadr_i,
    input  wire [41:0] data_i,
    input  wire [ 7:0] radr0_i,
    output wire [41:0] data0_o,
    input  wire [ 7:0] radr1_i,
    output wire [41:0] data1_o
);
    reg [41:0] RAM [0:255];

    assign data0_o = RAM[radr0_i];
    assign data1_o = RAM[radr1_i];

    always @(posedge clk_i) begin
        if(we_i)
            RAM[wadr_i] <= data_i;
    end

endmodule
