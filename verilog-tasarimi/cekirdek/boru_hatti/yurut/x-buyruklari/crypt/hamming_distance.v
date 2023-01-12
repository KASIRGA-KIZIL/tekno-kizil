module hamming_distance(
    input [31:0] kaynak_yazmac1_degeri,
    input [31:0] kaynak_yazmac2_degeri,
    output [5:0] hamming_uzakligi
);
    wire [31:0]bit_farklari;
    assign bit_farklari = kaynak_yazmac1_degeri ^ kaynak_yazmac2_degeri;

    wire [5:0]fark_sayisi;
    popcount hd_pc_inst(
        .kaynak_yazmac_degeri(bit_farklari),
        .bir_sayisi(hamming_uzakligi)
    );
    
endmodule
