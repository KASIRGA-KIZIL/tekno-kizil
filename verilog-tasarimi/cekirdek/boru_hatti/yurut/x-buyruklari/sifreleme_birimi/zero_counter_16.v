// zero_counter_16.v

// Kullanilan algoritma belirtilen makalede anlatilmaktadir.
// https://ieeexplore.ieee.org/abstract/document/4539802
// Low-Power Leading-Zero Counting and Anticipation Logic for High-Speed Floating Point Units

module zero_counter_16(
   input  wire [15:0] A,
   output reg [ 3:0] Z,
   output reg V
);

   integer i;
   reg [7:0] C0;
   reg [3:0] C1;
   reg [3:0] D0;
   reg t0;
   reg t1;
   reg t2;
   reg t3;
   reg e0;
   reg e1;
   always @(*) begin
      for(i=0;i<8;i=i+1)begin
         C0[i] = (A[(i*2)+1]|A[(i*2)]);
      end
      for(i=0;i<4;i=i+1)begin
         C1[i] = (C0[(i*2)+1]|C0[(i*2)]);
      end
      for(i=0;i<4;i=i+1)begin
         D0[i] = ((A[(i*4)+1]&~C0[(2*i)+1])|A[(i*4)+3]);
      end
      
      t0 = ((C0[1]&~C1[1])|C0[3]);
      t1 = ((D0[0]&~C1[1])|D0[1]);
      
      t2 = ((C0[5]&~C1[3])|C0[7]);
      t3 = ((D0[2]&~C1[3])|D0[3]);
      
      e0 = C1[1]|C1[0];
      e1 = C1[3]|C1[2];
      
      V = ~(e0|e1);
      
      Z[3] = ~e1;
      Z[2] = ~((C1[1]&~e1)|C1[3]);
      Z[1] = ~((t0   &~e1)|t2   );
      Z[0] = ~((t1   &~e1)|t3   );
   end

endmodule
