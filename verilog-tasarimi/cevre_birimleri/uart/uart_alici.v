// uart_alici.v
`timescale 1ns / 1ps

`include "tanimlamalar.vh"

module uart_alici(
    input rx_i,
    input rx_en_i,
    input [15:0]baud_rate_i,
    input clk_i,
    input rst_i,
    output hazir_o,
    output reg bitti_o,
    output [7:0] veri_o
    );

localparam HAZIR=  2'b00;
localparam BASLA=  2'b01;
localparam AL=     2'b10;
localparam DUR=    2'b11;


reg [1:0] durum_r= HAZIR, durum_sonraki_r;
reg hazir_r=1, hazir_sonraki_r;
reg [15:0] pSayac_r=0,pSayac_sonraki_r=0;
reg [2:0] bitSirasi_r=3'b000,bitSirasi_sonraki_r=3'b000;
reg [7:0] veri_r, veri_sonraki_r;
wire [15:0]limit_w = baud_rate_i; //degisecek

assign veri_o= veri_r;
assign hazir_o=hazir_r;

always @(*)begin
    hazir_sonraki_r=hazir_r;
    durum_sonraki_r=durum_r;
    pSayac_sonraki_r=pSayac_r;
    bitSirasi_sonraki_r=bitSirasi_r;
    veri_sonraki_r=veri_r;
    bitti_o = 1;

    case(durum_r)
        HAZIR:begin
            bitti_o = 0;
            if(~rx_i && rx_en_i && hazir_r)begin
                durum_sonraki_r=BASLA;
                hazir_sonraki_r=1'b0;
            end
        end

        BASLA:begin
            if(pSayac_r==limit_w/2)begin
                durum_sonraki_r=AL;
                pSayac_sonraki_r=16'b0;
            end
            else begin
                pSayac_sonraki_r=pSayac_r+16'b1;
            end
        end

        AL:begin
            veri_sonraki_r[bitSirasi_r]=rx_i;
            if(pSayac_r==limit_w)begin
                pSayac_sonraki_r=16'b0;
                if(bitSirasi_r==3'b111)begin
                    durum_sonraki_r=DUR;
                    bitSirasi_sonraki_r=3'b000;
                end
                else begin
                    bitSirasi_sonraki_r=bitSirasi_r+3'b1;
                end
            end else begin
                pSayac_sonraki_r=pSayac_r+16'b1;
            end
        end

        DUR:begin
            if(pSayac_r==limit_w)begin
                durum_sonraki_r =   HAZIR;
                hazir_sonraki_r =   1;
                pSayac_sonraki_r=   0;
                bitti_o = 1;
            end else begin
                pSayac_sonraki_r=pSayac_r+16'b1;
            end
        end

    endcase

end


always @(posedge clk_i)begin
    if(rst_i)begin
        hazir_r         <=      1'b1    ;
        durum_r         <=      HAZIR   ;
        pSayac_r        <=      0       ;
        bitSirasi_r     <=      0       ;
        veri_r          <=      0       ;
    end else begin
        hazir_r         <=      hazir_sonraki_r     ;
        durum_r         <=      durum_sonraki_r     ;
        pSayac_r        <=      pSayac_sonraki_r    ;
        bitSirasi_r     <=      bitSirasi_sonraki_r ;
        veri_r          <=      veri_sonraki_r      ;
    end
end



endmodule
