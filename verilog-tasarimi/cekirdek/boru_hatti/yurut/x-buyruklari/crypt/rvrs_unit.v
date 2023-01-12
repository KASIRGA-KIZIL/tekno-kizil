module rvrs_unit(
    input [31:0] kaynak_yazmac_degeri,
    output [31:0] rvrs_sonuc
);
    assign rvrs_sonuc = {kaynak_yazmac_degeri[7:0],kaynak_yazmac_degeri[15:8],kaynak_yazmac_degeri[23:16],kaynak_yazmac_degeri[31:24]}
endmodule