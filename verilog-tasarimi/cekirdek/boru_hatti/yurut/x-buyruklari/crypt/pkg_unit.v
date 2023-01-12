module pkg_unit(
    input [31:0] kaynak_yazmac1_degeri,
    input [31:0] kaynak_yazmac2_degeri,
    output [31:0] pkg_sonuc
);
    assign pkg_sonuc = {kaynak_yazmac2_degeri[15:0],kaynak_yazmac1_degeri[15:0]};
endmodule