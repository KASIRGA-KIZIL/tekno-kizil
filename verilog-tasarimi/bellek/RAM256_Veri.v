module RAM256_Veri (
    input CLK,
    input RST,
    input EN0,
    input [3:0] WE0,
    input [7:0] A0,
    input [40:0] Di0,
    output [40:0] Do0
);

    reg [40:0] RAM[0:255];
    integer i;
    always @(posedge CLK) begin
        if(RST) begin
            for(i=0; i<256; i=i+1) begin
                RAM[i] <= 0;
            end 
        end
        else begin    
        if(EN0) begin
            if(WE0[0]) RAM[A0][7:0] <= Di0[7:0];
            if(WE0[1]) RAM[A0][15:8] <= Di0[15:8];
            if(WE0[2]) RAM[A0][23:16] <= Di0[23:16];
            if(WE0[3]) RAM[A0][31:24] <= Di0[31:24];
            RAM[A0][40:32] <= Di0[40:32];
        end
        end
    end

    assign Do0 = RAM[A0];

endmodule