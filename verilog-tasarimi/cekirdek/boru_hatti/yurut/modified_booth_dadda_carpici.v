// modified_booth_dadda_carpici.v
// modified booth carpici eklendi, dadda tree eklenecek
// en son toplam "+" lar ile yapıldı. Dadda tree eklenince buna gerek kalmayacak
`timescale 1ns / 1ps

/*
Modified Booth Dadda algoritmasi

Sinyal isimleri
    ara_carpim       -> ac
    isaret_duzeltici -> id
    ac_id         -> ara carpim isaret duzeltici
*/

`define WLEN       33
`define SIFIR      3'b000
`define BIR        3'b001,3'b010
`define IKI        3'b011
`define IKI_EKSI   3'b100
`define BIR_EKSI   3'b101,3'b110
`define SIFIR_EKSI 3'b111

module modified_booth_dadda_carpici(
    input  wire [`WLEN-1:0] carpilan_i,
    input  wire [`WLEN-1:0] carpan_i,
    input  wire isaretli,
    output wire bitti,
    output reg [(`WLEN * 2)-1:0] sonuc_o
);

    reg  [`WLEN:0] ac[(`WLEN/2):0];
    reg  [(`WLEN+4):0] ac_genis[(`WLEN/2):0];
    reg  [(`WLEN/2)-1:0] ac_isaret;
    wire [`WLEN+2:0] carpan_genis = isaretli ? {{2{carpan_i[`WLEN-1]}},carpan_i,1'b0} : {2'b0,carpan_i,1'b0};

    wire  [`WLEN:0] carpilan_bir = isaretli ? {carpilan_i[`WLEN-1],carpilan_i} : {1'b0,carpilan_i};
    wire  [`WLEN:0] carpilan_iki = {carpilan_i,1'b0};
    wire  [`WLEN:0] carpilan_bir_eksi = ~carpilan_bir;
    wire  [`WLEN:0] carpilan_iki_eksi = ~carpilan_iki;

    reg  [(`WLEN/2)-1:0] ac_id;

    wire id_eksi = 1'b1;
    wire id_arti = 1'b0;

    integer i;
    always @(*) begin
        $display("%d",carpilan_i);
        for(i=0; i<(`WLEN/2)+1;i=i+1) begin
            case(carpan_genis[(2*i)+:3])
                `SIFIR: begin
                    ac[i] = {`WLEN{1'b0}};;
                    ac_isaret[i] = id_arti;
                end
                `BIR: begin
                    ac[i] = carpilan_bir;
                    ac_isaret[i] = id_arti;
                end
                `IKI: begin
                    ac[i] = carpilan_iki;
                    ac_isaret[i] = id_arti;
                end
                `IKI_EKSI: begin
                    ac[i] = carpilan_iki_eksi;
                    ac_isaret[i] = id_eksi;
                end
                `BIR_EKSI: begin
                    ac[i] = carpilan_bir_eksi;
                    ac_isaret[i] = id_eksi;
                end
                `SIFIR_EKSI: begin
                    ac[i] = {`WLEN{1'b1}};
                    ac_isaret[i] = id_eksi;
                end
            endcase
        end
        for(i=0;i<(`WLEN/2);i=i+1)begin
            ac_id[i] = isaretli ? (ac_isaret[i]^carpilan_i[`WLEN-1]) : ac_isaret[i];
        end

        ac_genis[0] = {1'b0,~ac_id[0],ac_id[0],ac_id[0],ac[0]};

        for(i=1;i<(`WLEN/2)-1;i=i+1)begin
            ac_genis[i] = {1'b1,~ac_id[i],ac[i],1'b0,ac_isaret[i-1]};
        end

        ac_genis[(`WLEN/2)-1] = {~ac_id[(`WLEN/2)-1],ac[(`WLEN/2)-1],1'b0,ac_isaret[(`WLEN/2)-2]};

        ac_genis[(`WLEN/2)] = {ac[(`WLEN/2)],1'b0,ac_isaret[(`WLEN/2)-1]};

        sonuc_o =  ac_genis[0];
        for(i=1;i<(`WLEN/2)+1;i=i+1)begin
            sonuc_o = $signed(sonuc_o) + $signed((ac_genis[i] << (i-1)*2));
        end
        $display("%b",sonuc_o);
    end

endmodule
