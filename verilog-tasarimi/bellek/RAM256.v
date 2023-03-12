module RAM256 (
    input CLK,
    input EN0,
    input WE0,
    input [7:0] A0,
    input [7:0] Di0,
    output [7:0] Do0
);

    reg [7:0] RAM[0:255];

    always @(posedge CLK) begin
        if(EN0) begin
            if(WE0) RAM[A0] <= Di0;
        end
    end

    assign Do0 = RAM[A0];

endmodule
