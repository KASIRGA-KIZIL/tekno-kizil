module sladd_unit(
    input [31:0] kaynak_yazmac1_degeri,
    input [31:0] kaynak_yazmac2_degeri,
    output [31:0] sladd_sonuc
);
    assign sladd_sonuc = kaynak_yazmac2_degeri + (kaynak_yazmac1_degeri << 1);
endmodule