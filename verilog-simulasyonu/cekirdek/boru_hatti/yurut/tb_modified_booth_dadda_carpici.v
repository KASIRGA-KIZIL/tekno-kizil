// tb_modified_booth_dadda_carpici.v
`timescale 1ns / 1ps

`include "tanimlamalar.vh"

module tb_modified_booth_dadda_carpici();
    reg [31:0] a_r;
    reg [31:0] b_r;
    wire [63:0] s_w;
  
    modified_booth_dadda_carpici mbdc(a_r,b_r,s_w);

    initial begin
         // Test case 1: 7*4=18
         a_r = 32'd4;
         b_r = 32'd7;
         
         #10;
  
          // Test case 2: 4000*11=44 000
          a_r = 32'd4000;
          b_r = 32'd11;
          
          #10;
 
         // Test case 3: negatif pozitif carpimi(3000*(-4)=-12 000)
         a_r = 32'd30000;
         b_r = 32'hffff_fffc;
        
         #10;
 
        // Test case 4: iki negatif carpimi((-11)*(-16)=176)
        a_r = 32'hffff_fff5;
        b_r = 32'hffff_fff0;;
        
        #10;
        $finish;
    end

endmodule

