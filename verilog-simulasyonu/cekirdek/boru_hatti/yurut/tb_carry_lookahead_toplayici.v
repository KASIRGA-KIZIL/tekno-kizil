// tb_carry_lookahead_toplayici.v
`timescale 1ns / 1ps

`include "tanimlamalar.vh"

module tb_carry_lookahead_toplayici();
reg [31:0] a_r;
reg [31:0] b_r;
reg islem_r;
wire [31:0] s_w;

carry_lookahead_toplayici clat(a_r,b_r,islem_r,s_w);

initial begin
    // Test case 1: taşma olmayan durum
    a_r = 32'h0000_0011;
    b_r = 32'h0000_0001;
    islem_r = 1'b0; //topla
    #10;
         
    a_r = 32'h0000_0011;
    b_r = 32'h0000_0001;
    islem_r = 1'b1; //cikar
    #10;
        
        
    // Test case 2: taşma olan durum
    a_r = 32'h7fff_ffff;
    b_r = 32'h0001_0000;
    islem_r = 1'b0; //topla
    #10;
         
    a_r = 32'h7fff_ffff;
    b_r = 32'h0001_0000;
    islem_r = 1'b1; //cikar
    #10;
        
        
    // Test case 3: iki negatif giris
    a_r = 32'hffff_fff0;
    b_r = 32'hffff_ffff;
    islem_r = 1'b0; //topla
    #10;
         
    a_r = 32'hffff_fff0;
    b_r = 32'hffff_ffff;
    islem_r = 1'b1; //cikar
    #10;

    // Test case 4: pozitif, negatif giris
    a_r = 32'hffff_fff5;
    b_r = 32'h0000_0015;
    islem_r = 1'b0; //topla
    #10;
        
    a_r = 32'hffff_fff5;
    b_r = 32'h0000_0015;
    islem_r = 1'b1; //cikar
    #10;
    
    $finish;
end

endmodule
