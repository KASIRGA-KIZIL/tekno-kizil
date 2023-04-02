module RAM256x1_rst (
    input  CLK,
    input  RST,
    input  EN0,
    input  WE0,
    input  [7:0] A0,
    input  [0:0] Di0,
    output [0:0] Do0
);

    reg [255:0] RAM;

    always @(posedge CLK) begin
        if(RST) begin
            RAM <= 0;
        end else begin
            if(EN0 & WE0) begin
                RAM[A0] <= Di0;
            end
        end
    end

    assign Do0 = RAM[A0];

endmodule
