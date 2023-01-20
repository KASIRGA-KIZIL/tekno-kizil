module popcount(
    input [31:0] kaynak_yazmac_degeri,
    output reg [5:0] bir_sayisi
);
    always@*begin
        bir_sayisi = 0;
        for(integer i = 0;i<32;i++)begin
            if(kaynak_yazmac_degeri[i])begin
                bir_sayisi = bir_sayisi + 1;
            end
        end
    end
endmodule