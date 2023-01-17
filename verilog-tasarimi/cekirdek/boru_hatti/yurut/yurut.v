// yurut.v
`timescale 1ns / 1ps

`include "tanimlamalar.vh"

// denetim durum birimi ile iliskisinin kurulmasi gerek

module yurut(
    input clk_i,
    input rst_i,

    input [`MI_BIT-1:0] mikroislem_i, // 0 olursa gecersiz

    input [4:0] rd_adres_i, // geri yaza kadar gitmesi lazim

    input [31:0] deger1_i, // anlik/yazmac secilmis son ALU girdileri
    input [31:0] deger2_i,

    input [31:0] imm_i, // Branch buyruklari icin gerekli (pc+imm)

    input yz_en_i, // yapay zeka icin enable biti

    output [4:0] rd_adres_o, // geri yaza kadar gitmesi lazim
    output [31:0] rd_deger_o, // islem birimlerinden gelen sonuclar
    output yaz_yazmac_o
);

    // hepsinde sonuc olmayacak duzenlemek lazim
    wire [31:0] amb_sonuc_w;
    wire [31:0] cla_sonuc_w;
    wire [31:0] bdc_sonuc_w;
    wire [31:0] bol_sonuc_w;
    wire [31:0] bib_sonuc_w;
    wire [31:0] dal_sonuc_w;
    wire [31:0] sif_sonuc_w;
    wire [31:0] yap_sonuc_w;
    wire [31:0] sis_sonuc_w;


    aritmetik_mantik_birimi amb (
        .miniislem_i(mikroislem_i[`MI_BIT-1:11]),
        .deger1_i(deger1_i),
        .deger2_i(deger2_i),

        .sonuc_o(amb_sonuc_w)
    );


    assign rd_adres_o = rd_adres_i;

    reg [31:0] rd_deger_sonraki_r = 0;
    reg [31:0] rd_deger_r = 0;
    assign rd_deger_o = rd_deger_r;

    reg yaz_yazmac_sonraki_r = 0;
    reg yaz_yazmac_r = 0;
    assign yaz_yazmac_o = yaz_yazmac_r;

    always @* begin
        // burayi if else yerine kaydirarak yapsak?
        if(mikroislem_i[`AMB]) begin
            rd_deger_sonraki_r = amb_sonuc_w;
        end
        else if(mikroislem_i[`CLA]) begin
            rd_deger_sonraki_r = cla_sonuc_w;
        end
        else if(mikroislem_i[`BDC]) begin
            rd_deger_sonraki_r = bdc_sonuc_w;
        end
        else if(mikroislem_i[`BOL]) begin
            rd_deger_sonraki_r = bol_sonuc_w;
        end
        else if(mikroislem_i[`BIB]) begin
            rd_deger_sonraki_r = bib_sonuc_w;
        end
        else if(mikroislem_i[`DAL]) begin
            rd_deger_sonraki_r = dal_sonuc_w;
        end
        else if(mikroislem_i[`SIF]) begin
            rd_deger_sonraki_r = sif_sonuc_w;
        end
        else if(mikroislem_i[`YAP]) begin
            rd_deger_sonraki_r = yap_sonuc_w;
        end
        else if(mikroislem_i[`SIS]) begin
            rd_deger_sonraki_r = sis_sonuc_w;
        end
    end

    always @(posedge clk_i) begin
        if(rst_i) begin
            rd_deger_r <= 0;
        end
        else begin
            rd_deger_r <= rd_deger_sonraki_r;
        end
    end
endmodule
