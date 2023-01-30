
`timescale 1ns / 1ps


module popcount(
    input [31:0] deger_i,
    output reg [5:0] bir_sayisi
);
    always@*begin
        bir_sayisi = 0;
        for(integer i = 0;i<32;i++)begin
            if(deger_i[i])begin
                bir_sayisi = bir_sayisi + 1;
            end
        end
    end
endmodule