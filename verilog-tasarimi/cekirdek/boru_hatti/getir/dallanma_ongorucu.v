`timescale 1ns / 1ps

`define JAL     7'b1101111
`define JALR    7'b1100111
`define BRANCH  7'b1100011
`define C_JALR  4'b1001
`define BUYRUK_BIT 32'd32

//`include "sabitler.vh"

module dallanma_ongorucu(
input rst_g,
input clk_g,
input [`BUYRUK_BIT-1:0] i_buyruk_adresi,
input [`BUYRUK_BIT-1:0] i_buyruk,
// getir 2 asamasindan gelen oncoz sinyalleri
input is_jr,
input is_branch,
input is_jalr,
input is_j,
input is_jal,
input is_comp,

output [`BUYRUK_BIT-1:0] o_atlanan_adres,
output o_buyruk_ongoru,

// dallanma ongorucuyu guncellemek icin kullanilan bitler
input guncelle_gecerli_g,
input [`BUYRUK_BIT-1:0] i_eski_buyruk,
input [`BUYRUK_BIT-1:0] i_eski_buyruk_adresi,
input i_buyruk_atladi,
input [`BUYRUK_BIT-1:0] i_atlanan_adres,
input i_ongoru_yanlis
    );

    ////////////////////////////////////////////////////
    //                  Tanimlamalar
    ////////////////////////////////////////////////////

    // Branch Target Buffer: 33:32 ghsare table, rest is addr
    reg [33:0] btb       [31:0];
    reg [33:0] btb_next  [31:0];
    // BHT
    reg [7:0] bht, bht_next;
    reg [2:0] bht_pointer, bht_pointer_next;

    // Kontrol sinyalleri
    wire eski_uncond_buyruk;
    wire yeni_dallanma_buyrugu;
    wire eski_dallanma_buyrugu;
    wire [4:0] yeni_ongoru_adresi;
    wire [4:0] eski_ongoru_adresi;

    ////////////////////////////////////////////////////
    //                  Atamalar
    ////////////////////////////////////////////////////

    // BTB kontrol sinyalleri
    assign yeni_dallanma_buyrugu = is_branch;
    assign eski_dallanma_buyrugu = i_eski_buyruk[6:0] == `BRANCH;
    assign yeni_ongoru_adresi = ((yeni_dallanma_buyrugu && guncelle_gecerli_g) ? ({bht[4:1], i_buyruk_atladi}) : (bht[4:0])) ^ i_buyruk_adresi[6:2]; // once tahmin iceren bht elemanini guncelle
    assign eski_ongoru_adresi = bht_next[(bht_pointer)+:4] ^ i_eski_buyruk_adresi; // kontrol et*************
    assign eski_uncond_buyruk = (i_eski_buyruk[6:0] == `JALR) || (is_comp &&  (i_eski_buyruk[15:12] == `C_JALR ));  // BTB'ye erisecek jump buyruklari
    // Modul Cikislari
    assign o_atlanan_adres = btb[yeni_ongoru_adresi][31:0];
    assign o_buyruk_ongoru = btb[yeni_ongoru_adresi][33];

    integer loop_counter;
    always@* begin
        for(loop_counter=0; loop_counter<32; loop_counter=loop_counter+1) begin
            btb_next[loop_counter] = btb[loop_counter] ;
        end
        bht_next = bht;
        bht_pointer_next = bht_pointer;

        if(is_branch) begin
            bht_next = {bht[6:0], btb[yeni_ongoru_adresi][33]}; // spekulatif guncelleme
            bht_pointer_next = bht_pointer + 3'd1;

            r_atlanan_adres_next = btb[yeni_ongoru_adresi][31:0];
        end

        if(eski_dallanma_buyrugu && guncelle_gecerli_g) begin
            bht_pointer_next = (bht_pointer != 3'd0) ?  ((is_branch) ? (bht_pointer) : (bht_pointer - 3'd1)) : (3'd0);

            btb_next[eski_ongoru_adresi][31:0] = i_eski_buyruk_adresi;
            if(i_ongoru_yanlis) begin
                case({i_buyruk_atladi, btb[eski_ongoru_adresi][33:32]})
                3'b111:  btb_next[eski_ongoru_adresi][33:32] = 2'b11;
                3'b110:  btb_next[eski_ongoru_adresi][33:32] = 2'b11;
                3'b101:  btb_next[eski_ongoru_adresi][33:32] = 2'b10;
                3'b100:  btb_next[eski_ongoru_adresi][33:32] = 2'b01;
                3'b011:  btb_next[eski_ongoru_adresi][33:32] = 2'b10;
                3'b010:  btb_next[eski_ongoru_adresi][33:32] = 2'b01;
                3'b001:  btb_next[eski_ongoru_adresi][33:32] = 2'b00;
                3'b000:  btb_next[eski_ongoru_adresi][33:32] = 2'b00;
                endcase

                btb_next[eski_ongoru_adresi][31:0] = i_atlanan_adres;

                for(loop_counter=1 ;loop_counter<5; loop_counter=loop_counter+1) begin
                    bht_next[loop_counter] = bht[loop_counter+bht_pointer]; // iki yonlu shift register, araya yanlis branchler aldiysak geri sarilmali
                end

                bht_next[0] = i_buyruk_atladi;

            end
        end

        if (is_jr || is_jalr) begin
            r_atlanan_adres_next = btb[yeni_ongoru_adresi][31:0];
        end

        if (is_jal) begin // compressed jal varsa degismeli
            r_atlanan_adres_next = i_buyruk_adresi + {{13{i_buyruk[31]}}, i_buyruk[19:12], i_buyruk[20], i_buyruk[30:21]};
        end

        if (is_j) begin
            r_atlanan_adres_next = i_buyruk_adresi + {{21{i_buyruk[11]}}, i_buyruk[4], i_buyruk[9:8], i_buyruk[10],i_buyruk[6], i_buyruk[7], i_buyruk[3:1], i_buyruk[5]};
        end

        if(eski_uncond_buyruk && i_ongoru_yanlis) begin
            btb_next[eski_ongoru_adresi][31:0] = i_atlanan_adres;
        end
    end

    always@(posedge clk_g) begin
        if(rst_g) begin
            for(loop_counter=0; loop_counter<32; loop_counter=loop_counter+1) begin
                btb[loop_counter] <= 34'b11_00000000000000000000000000000000;
            end
            bht <= 8'd0;
            bht_pointer <= 3'd0;
        end
        else begin
            for(loop_counter=0; loop_counter<32; loop_counter=loop_counter+1) begin
                btb[loop_counter] <= btb_next[loop_counter] ;
            end
            bht <= bht_next;
            bht_pointer <= bht_pointer_next;
        end
    end

endmodule
