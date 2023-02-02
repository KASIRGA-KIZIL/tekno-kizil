// zero_counter.v


`timescale 1ns / 1ps


module zero_counter(
    input [31:0] deger_i,
    output reg [4:0] sifir_sayisi,
    output [0:0] hepsi_sifir
);
    assign hepsi_sifir = !(|deger_i);
    always@*begin
        casex(deger_i)
            32'bxxxxxxxx_xxxxxxxx_xxxxxxxx_xxxxxxx1:
                sifir_sayisi = 5'd0;
            32'bxxxxxxxx_xxxxxxxx_xxxxxxxx_xxxxxx10:
                sifir_sayisi = 5'd1;
            32'bxxxxxxxx_xxxxxxxx_xxxxxxxx_xxxxx100:
                sifir_sayisi = 5'd2;
            32'bxxxxxxxx_xxxxxxxx_xxxxxxxx_xxxx1000:
                sifir_sayisi = 5'd3;
            32'bxxxxxxxx_xxxxxxxx_xxxxxxxx_xxx10000:
                sifir_sayisi = 5'd4;
            32'bxxxxxxxx_xxxxxxxx_xxxxxxxx_xx100000:
                sifir_sayisi = 5'd5;
            32'b00000000_xxxxxxxx_xxxxxxxx_x1000000:
                sifir_sayisi = 5'd6;
            32'bxxxxxxxx_xxxxxxxx_xxxxxxxx_10000000:
                sifir_sayisi = 5'd7;
            32'bxxxxxxxx_xxxxxxxx_xxxxxxx1_00000000:
                sifir_sayisi = 5'd8;
            32'bxxxxxxxx_xxxxxxxx_xxxxxx10_00000000:
                sifir_sayisi = 5'd9;
            32'bxxxxxxxx_xxxxxxxx_xxxxx100_00000000:
                sifir_sayisi = 5'd10;
            32'bxxxxxxxx_xxxxxxxx_xxxx1000_00000000:
                sifir_sayisi = 5'd11;
            32'bxxxxxxxx_xxxxxxxx_xxx10000_00000000:
                sifir_sayisi = 5'd12;
            32'bxxxxxxxx_xxxxxxxx_xx100000_00000000:
                sifir_sayisi = 5'd13;
            32'bxxxxxxxx_xxxxxxxx_x1000000_00000000:
                sifir_sayisi = 5'd14;
            32'bxxxxxxxx_xxxxxxxx_10000000_00000000:
                sifir_sayisi = 5'd15;
            32'bxxxxxxxx_xxxxxxx1_00000000_00000000:
                sifir_sayisi = 5'd16;
            32'bxxxxxxxx_xxxxxx10_00000000_00000000:
                sifir_sayisi = 5'd17;
            32'bxxxxxxxx_xxxxx100_00000000_00000000:
                sifir_sayisi = 5'd18;
            32'bxxxxxxxx_xxxx1000_00000000_00000000:
                sifir_sayisi = 5'd19;
            32'bxxxxxxxx_xxx10000_00000000_00000000:
                sifir_sayisi = 5'd20;
            32'bxxxxxxxx_xx100000_00000000_00000000:
                sifir_sayisi = 5'd21;
            32'bxxxxxxxx_x1000000_00000000_00000000:
                sifir_sayisi = 5'd22;
            32'bxxxxxxxx_10000000_00000000_00000000:
                sifir_sayisi = 5'd23;
            32'bxxxxxxx1_00000000_00000000_00000000:
                sifir_sayisi = 5'd24;
            32'bxxxxxx10_00000000_00000000_00000000:
                sifir_sayisi = 5'd25;
            32'bxxxxx100_00000000_00000000_00000000:
                sifir_sayisi = 5'd26;
            32'bxxxx1000_00000000_00000000_00000000:
                sifir_sayisi = 5'd27;
            32'bxxx10000_00000000_00000000_00000000:
                sifir_sayisi = 5'd28;
            32'bxx100000_00000000_00000000_00000000:
                sifir_sayisi = 5'd29;
            32'bx1000000_00000000_00000000_00000000:
                sifir_sayisi = 5'd30;
            32'b10000000_00000000_00000000_00000000:
                sifir_sayisi = 5'd31;
        endcase
    end
endmodule
