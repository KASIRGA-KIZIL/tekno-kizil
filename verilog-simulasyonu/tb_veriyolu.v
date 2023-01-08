// tb_veriyolu.v
`timescale 1ns / 1ps

`include "tanimlamalar.vh"

module tb_veriyolu();

    reg clk_i = 0;
    reg rst_i = 0;

    veriyolu vy(
        .clk_i(clk_i),
        .rst_i(rst_i)


    );

    always begin
        #5;
        clk_i = ~clk_i;
    end

    initial begin
        rst_i = 1'b1;
        #100;
        rst_i = 0;


        $finish;
    end

endmodule
