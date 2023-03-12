module RAM512 (
    input CLK,
    input EN0,
    input [8:0] A0,
    input [15:0] Di0,
    output [15:0] Do0,
    input [1:0] WE0
);

    reg [15:0] RAM[0:511];

    always @(posedge CLK) begin
        if(EN0) begin
            if(WE0[0]) RAM[A0][7:0]  <= Di0[7:0];
            if(WE0[1]) RAM[A0][15:8] <= Di0[15:8];
        end
    end

    assign Do0 = RAM[A0];

endmodule