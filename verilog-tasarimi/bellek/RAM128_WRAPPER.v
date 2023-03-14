module RAM128_WRAPPER (
    input CLK,
    input WE0,
    input [8:0] A0,
    input [7:0] Di0,
    output [7:0] Do0
);
    wire [6:0] address;
    wire [1:0] select_byte;
    
    wire [31:0] data_in;
    wire [3:0] write_en;

    wire [31:0] data_out;

    assign address = A0[8:2];
    assign select_byte = A0[1:0];  

    assign data_in = Di0 << select_byte;
    assign write_en = WE0 << select_byte;

    assign Do0 = data_out >> select_byte;

    RAM128 ram(
        .CLK(CLK),
        .EN0(1'b1),
        .WE0(write_en),
        .A0(address),
        .Di0(data_in),
        .Do0(data_out)
    );

endmodule
