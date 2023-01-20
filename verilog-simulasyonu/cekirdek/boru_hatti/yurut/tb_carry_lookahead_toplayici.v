// tb_carry_lookahead_toplayici.v
`timescale 1ns / 1ps

`include "tanimlamalar.vh"

module tb_carry_lookahead_toplayici();
    reg [2:0] a_r;
    reg [2:0] b_r;
    reg c_in_r;
    wire [2:0] s_w;
    carry_lookahead_toplayici clat(a_r,b_r,c_in_r,s_w);

    initial begin
         // Test case 1: taşma olmayan durum
         a_r = 32'h0000_0011;
         b_r = 32'h0000_0001;
         c_in_r = 1'b0;
         #10;

          // Test case 2: taşma olan durum
          a_r = 32'h7fff_ffff;
          b_r = 32'h0001_0000;
          c_in_r = 1'b0;
          #10;

         // Test case 3: negatif sayi toplami
         a_r = 32'hffff_fff0;
         b_r = 32'hffff_ffff;
         c_in_r = 1'b0;
         #10;

        // Test case 4: pozitif negatif toplami
        a_r = 32'hffff_fff5;
        b_r = 32'h0000_0015;
        c_in_r = 1'b0;
        #10;
        $finish;
    end

endmodule
