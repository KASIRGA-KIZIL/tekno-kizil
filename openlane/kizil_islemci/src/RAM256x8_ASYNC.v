module RAM256x8_ASYNC (
   input CLK,
   input WE0,
   input [7:0] A0,
   input [7:0] Di0,
   output [7:0] Do0
);

   reg [7:0] RAM[0:255];

   always @(posedge CLK) begin
      if(WE0) RAM[A0] <= Di0;
   end

   assign Do0 = RAM[A0];

endmodule
