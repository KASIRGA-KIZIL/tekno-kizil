// uart_verici.v
`timescale 1ns / 1ps

`include "tanimlamalar.vh"

module uart_verici(
    input           clk_i,
    input           rst_i,
    input [7:0]     veri_i,
    input           tx_en_i,
    input [15:0]    baud_rate_i,

    output          hazir_o,
    output reg      tx_o
    );
    localparam HAZIR=  2'b00;
    localparam BASLA=  2'b01;
    localparam GONDER= 2'b10;
    localparam DUR=    2'b11;  

    reg [15:0] baud_sayac_r,baud_sayac_sonraki_r = 0;
    reg [1:0] durum_r= HAZIR, durum_sonraki_r;
    wire [15:0]bit_period_w=baud_rate_i;// degisecek
    reg [2:0]bitSirasi_r=3'b000,bitSirasi_sonraki_r=3'b000;
    assign hazir_o= durum_sonraki_r == HAZIR;
    
    wire baud_saat_w = baud_rate_i == baud_sayac_r;

    always @(*)begin
        durum_sonraki_r=durum_r;
        bitSirasi_sonraki_r=bitSirasi_r;

        case(durum_r)
            HAZIR:begin
                tx_o=1;
                if(tx_en_i && hazir_o)begin
                    durum_sonraki_r=BASLA;
                    baud_sayac_sonraki_r=0;
                end
            end
            BASLA:begin
                tx_o=0;
                if(baud_saat_w)begin
                    durum_sonraki_r=GONDER;
                    baud_sayac_sonraki_r=0;
                end else begin
                    baud_sayac_sonraki_r = baud_sayac_r + 16'b1;
                end
            end
            GONDER:begin
                tx_o=veri_i[bitSirasi_r];
                if(baud_saat_w)begin
                    baud_sayac_sonraki_r=0;
                    if(bitSirasi_r==3'b111)begin
                        durum_sonraki_r=DUR;
                        bitSirasi_sonraki_r=3'b000;
                    end
                    else begin
                        bitSirasi_sonraki_r=bitSirasi_r+1;
                    end
                end else begin
                    baud_sayac_sonraki_r = baud_sayac_r + 16'b1;
                end
            end
            DUR:begin
                tx_o=1;
                if(baud_saat_w)begin
                    //if(tx_en_i) durum_sonraki_r = BASLA;
                    //else
                    durum_sonraki_r = HAZIR;
                    baud_sayac_sonraki_r=0;
                end else begin
                    baud_sayac_sonraki_r = baud_sayac_r + 16'b1;
                end
            end
        endcase
    end


    always @(posedge clk_i)begin
        if(rst_i)begin
            durum_r<=HAZIR;
            baud_sayac_r <= 0;
            bitSirasi_r<=0;
        end else begin
            durum_r<=durum_sonraki_r;
            baud_sayac_r <= baud_sayac_sonraki_r;
            bitSirasi_r<=bitSirasi_sonraki_r;
        end
    end
endmodule
