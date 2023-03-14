module RAM128 (
    input CLK,
    input EN0,
    input [3:0] WE0,
    input [6:0] A0,
    input [31:0] Di0,
    output [31:0] Do0
);

    reg [31:0] RAM[0:127];

    always @(posedge CLK) begin
        if(EN0) begin
            if(WE0[0]) RAM[A0] <= Di0[7:0];
            if(WE0[1]) RAM[A0] <= Di0[15:8];
            if(WE0[2]) RAM[A0] <= Di0[23:16];
            if(WE0[3]) RAM[A0] <= Di0[31:24];
        end
    end

    assign Do0 = RAM[A0];

endmodule
