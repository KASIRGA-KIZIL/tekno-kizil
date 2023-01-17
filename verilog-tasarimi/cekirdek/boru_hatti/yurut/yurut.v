// yurut.v
`timescale 1ns / 1ps

`include "tanimlamalar.vh"

// denetim durum birimi ile iliskisinin kurulmasi gerek

module yurut(
    input clk_i,
    input rst_i,

    input buyruk_compressed_i,

    input [`MI_BIT-1:0] mikroislem_i, // 0 olursa gecersiz

    input [4:0] rd_adres_i, // geri yaza kadar gitmesi lazim

    input [31:0] rs1_deger_i, // ayni zamanda uimm icin kullan
    input [31:0] rs2_deger_i, // ayni zamanda shamt icin kullan

    input [31:0] i_imm_i, // fencete ve csrlarda kullan
    input [31:0] s_imm_i,
    input [31:0] b_imm_i,
    input [31:0] u_imm_i,
    input [31:0] j_imm_i,

    input wire [1:0] ddb_kontrol_yonlendir_deger1_i,
    input wire [1:0] ddb_kontrol_yonlendir_deger2_i,
    input wire [31:0] yonlendir_geri_yaz_i,


    output [4:0] rd_adres_o, // geri yaza kadar gitmesi lazim
    output [31:0] rd_deger_o, // islem birimlerinden gelen sonuclar
    output yaz_yazmac_o


);

    // hepsinde sonuc olmayacak duzenlemek lazim
    wire [31:0] amb_sonuc_w;
    wire [31:0] cla_sonuc_w;
    wire [31:0] bdc_sonuc_w;
    wire [31:0] div_sonuc_w;
    wire [31:0] bib_sonuc_w;
    wire [31:0] dal_sonuc_w;
    wire [31:0] sif_sonuc_w;
    wire [31:0] yap_sonuc_w;
    wire [31:0] sis_sonuc_w;

    // anlik ya da rs degerlerinin secilmesi lazim
    wire [31:0] deger1_w;
    wire [31:0] deger2_w;

    aritmetik_mantik_birimi amb (
        .miniislem_i(mikroislem_i[`MI_BIT-1:11]),
        .deger1_i(deger1_w),
        .deger2_i(deger2_w),

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
        else if(mikroislem_i[`DIV]) begin
            rd_deger_sonraki_r = div_sonuc_w;
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
