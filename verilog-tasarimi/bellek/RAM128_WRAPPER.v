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

    reg [6:0] address_r;
    reg [1:0] select_byte_r;
    reg [31:0] data_in_r;
    reg [3:0] wen_r;

    always@(posedge CLK) begin
        address_r <= address;
        select_byte_r <= select_byte;
        data_in_r <= data_in;
        wen_r <= write_en;
    end

    RAM128 ram(
        .CLK(CLK),
        .EN0(1'b1),
        .WE0(wen_r),
        .A0(address_r),
        .Di0(data_in_r),
        .Do0(data_out)
    );

endmodule
