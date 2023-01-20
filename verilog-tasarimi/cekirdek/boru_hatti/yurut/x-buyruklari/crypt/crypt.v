`timescale 1ns/1ps

module crypt(
    input [2:0] islem,
    input [31:0] kaynak_yazmac1_degeri,
    input [31:0] kaynak_yazmac2_degeri,
    output reg[31:0] hedef_yazmac_degeri
);
    localparam
    HMDST = 0,
    PKG = 1,
    RVRS = 2,
    SLADD = 3,
    CNTZ = 4,
    CNTP = 5;


    wire [5:0] hamming_uzakligi;
    hamming_distance hd_inst(
        .kaynak_yazmac1_degeri(kaynak_yazmac1_degeri),
        .kaynak_yazmac2_degeri(kaynak_yazmac2_degeri),
        .hamming_uzakligi(hamming_uzakligi)
    );

    wire [31:0] pkg_sonuc;
    pkg_unit pu_inst(
        .kaynak_yazmac1_degeri(kaynak_yazmac1_degeri),
        .kaynak_yazmac2_degeri(kaynak_yazmac2_degeri),
        .pkg_sonuc(pkg_sonuc)
    );

    wire [31:0] rvrs_sonuc;
    rvrs_unit ru_inst(
        .kaynak_yazmac_degeri(kaynak_yazmac1_degeri),
        .rvrs_sonuc(rvrs_sonuc)
    );

    wire [31:0] sladd_sonuc;
    sladd_unit su_inst(
        .kaynak_yazmac1_degeri(kaynak_yazmac1_degeri),
        .kaynak_yazmac2_degeri(kaynak_yazmac1_degeri),
        .sladd_sonuc(sladd_sonuc)
    );

    wire [4:0] sifir_sayisi;
    wire [0:0] hepsi_sifir;
    zero_counter zc_inst(
        .kaynak_yazmac_degeri(kaynak_yazmac1_degeri),
        .sifir_sayisi(sifir_sayisi),
        .hepsi_sifir(hepsi_sifir)
    );

    wire [5:0] bir_sayisi;
    popcount pc_inst(
        .kaynak_yazmac_degeri(kaynak_yazmac1_degeri),
        .bir_sayisi(bir_sayisi)
    );


    always@*begin
        case(islem)
            HMDST:
                hedef_yazmac_degeri = {26'b0,hamming_uzakligi};
            PKG:
                hedef_yazmac_degeri = pkg_sonuc;
            RVRS:
                hedef_yazmac_degeri = rvrs_sonuc;
            SLADD:
                hedef_yazmac_degeri = sladd_sonuc;
            CNTZ:
                hedef_yazmac_degeri = {27'b0,sifir_sayisi};
            CNTP:
                hedef_yazmac_degeri = {26'b0,bir_sayisi};

        endcase
    end


endmodule