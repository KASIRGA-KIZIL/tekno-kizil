`timescale 1ns / 1ps

module uart_verici(
input [7:0]veri_i,
input tx_en_i,
input baud_rate_i,
input clk_i,
input rst_i,
output hazir_o,
output reg tx_o
    );
localparam HAZIR=  2'b00;
localparam BASLA=  2'b01;
localparam GONDER= 2'b10;
localparam DUR=    2'b11;  


reg [1:0] durum_r= HAZIR, durum_sonraki_r;
reg hazir_r=1, hazir_sonraki_r;
wire bit_period_w=baud_rate_i;// degisecek
reg [9:0] pSayac_r=0,pSayac_sonraki_r=0;
reg [2:0]bitSirasi_r=3'b000,bitSirasi_sonraki_r=3'b000;
assign hazir_o=hazir_r;

always @(*)begin
hazir_sonraki_r=hazir_r;
durum_sonraki_r=durum_r;
pSayac_sonraki_r=pSayac_r;
bitSirasi_sonraki_r=bitSirasi_r;


case(durum_r)
HAZIR:begin
    tx_o=1;
    if(tx_en_i && hazir_r)begin
        durum_sonraki_r=BASLA;
        hazir_sonraki_r=0;
    end
end
BASLA:begin
    tx_o=0;
    if(pSayac_r==bit_period_w)begin
        durum_sonraki_r=GONDER;
        pSayac_sonraki_r=0;
    end
    else begin
        pSayac_sonraki_r=pSayac_r+1;
    end
end
GONDER:begin
    tx_o=veri_i[bitSirasi_r];
    if(pSayac_r==bit_period_w)begin
        pSayac_sonraki_r=0;
        if(bitSirasi_r==3'b111)begin
            durum_sonraki_r=DUR;
            bitSirasi_sonraki_r=3'b000;
        end
        else begin
            bitSirasi_sonraki_r=bitSirasi_r+1;
        end
    end

    else begin
        pSayac_sonraki_r=pSayac_r+1;
    end
end
DUR:begin
    tx_o=1;
    if(pSayac_r==bit_period_w)begin
        durum_sonraki_r=BASLA;
        hazir_sonraki_r=1;
        pSayac_sonraki_r=0;
    end
    else begin
        pSayac_sonraki_r=pSayac_r+1;
    end
end

endcase

end


always @(posedge clk_i)begin
    if(rst_i)begin
        hazir_r<=1'b1;
        durum_r<=HAZIR;
        pSayac_r<=0;
        bitSirasi_r<=0;
    end
    else begin
        hazir_r<=hazir_sonraki_r;
        durum_r<=durum_sonraki_r;
        pSayac_r<=pSayac_sonraki_r;
        bitSirasi_r<=bitSirasi_sonraki_r;
    end

end

endmodule
