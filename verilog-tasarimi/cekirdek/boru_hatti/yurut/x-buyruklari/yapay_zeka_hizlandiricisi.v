// yapay_zeka_hizlandiricisi.v
`timescale 1ns / 1ps

`include "tanimlamalar.vh"

`define YAPAY_ZEKA_RUN_GECIKMESI 15

module yapay_zeka_hizlandiricisi(
    input wire clk_i,
    input wire rst_i,
    input  wire ddb_durdur_i,

    // Kontrol sinyalleri
    input  wire [2:0] kontrol_i,
    output reg  carpma_rst_o,
    input  wire       basla_i,
    output wire       bitti_o,
    input  wire       rs2_en_i,

    // Veri yolu
    input  wire [31:0] deger1_i,
    input  wire [31:0] deger2_i,
    output wire [31:0] carp_deger1_o,
    output wire [31:0] carp_deger2_o
);

    reg [3:0] sayac;

    assign bitti_o = (sayac == `YAPAY_ZEKA_RUN_GECIKMESI) || (kontrol_i != `YZH_RUN);

    reg rst_veri;
    reg yaz1_veri_en;
    reg yaz2_veri_en;
    reg rst_katsayi;
    reg yaz1_katsayi_en;
    reg yaz2_katsayi_en;
    reg oku_veri_en;
    reg oku_katsayi_en;

    always @(posedge clk_i) begin
        if (rst_i) begin
            sayac <= 4'b0;
        end else begin
            if(kontrol_i == `YZH_RUN && ~ddb_durdur_i)begin
                sayac <= sayac + 4'b1;
            end else begin
                sayac <= 4'b0;
            end
        end
    end


    always @(*) begin
        yaz1_veri_en    = 1'b0;
        yaz2_veri_en    = 1'b0;
        yaz1_katsayi_en = 1'b0;
        yaz2_katsayi_en = 1'b0;
        rst_katsayi     = 1'b0;
        rst_veri        = 1'b0;
        oku_katsayi_en  = 1'b0;
        oku_veri_en     = 1'b0;
        carpma_rst_o    = 1'b1;

        if(basla_i & ~ddb_durdur_i) begin
            case(kontrol_i)
                `YZH_LD_W:begin
                    yaz1_katsayi_en = 1'b1;
                    yaz2_katsayi_en = rs2_en_i;
                end
                `YZH_CLR_W:begin
                    rst_katsayi     = 1'b1;
                end
                `YZH_LD_X:begin
                    yaz1_veri_en    = 1'b1;
                    yaz2_veri_en    = rs2_en_i;
                end
                `YZH_CLR_X:begin
                    rst_veri        = 1'b1;
                end
                `YZH_RUN:begin
                    oku_katsayi_en  = 1'b1;
                    oku_veri_en     = 1'b1;
                    carpma_rst_o    = 1'b0;
                end
            endcase
        end
    end

    yapay_zeka_yazmac_obegi veri_yo(
        .clk_i        (clk_i),
        .rst_i        (rst_veri | rst_i),
        .oku_deger_o  (carp_deger1_o),
        .oku_en_i     (oku_veri_en),
        .yaz1_deger_i (deger1_i),
        .yaz2_deger_i (deger2_i),
        .yaz1_en_i    (yaz1_veri_en),
        .yaz2_en_i    (yaz2_veri_en)
    );

    yapay_zeka_yazmac_obegi katsayi_yo(
        .clk_i        (clk_i),
        .rst_i        (rst_katsayi | rst_i),
        .oku_deger_o  (carp_deger2_o),
        .oku_en_i     (oku_katsayi_en),
        .yaz1_deger_i (deger1_i),
        .yaz2_deger_i (deger2_i),
        .yaz1_en_i    (yaz1_katsayi_en),
        .yaz2_en_i    (yaz2_katsayi_en)
    );

endmodule

module yapay_zeka_yazmac_obegi(
    input  wire clk_i,
    input  wire rst_i,
    // okuma arayuzu
    output wire [31:0] oku_deger_o,
    input  wire        oku_en_i,
    // yazma arayuzu
    input  wire [31:0] yaz1_deger_i,
    input  wire [31:0] yaz2_deger_i,
    input  wire        yaz1_en_i,
    input  wire        yaz2_en_i
);
    reg [3:0] adr_oku;
    reg [3:0] adr_yaz;

    reg [31:0] yazmaclar[15:0];
    assign oku_deger_o = yazmaclar[adr_yaz];

    integer i = 0;
    always@(posedge clk_i) begin
        if (rst_i) begin
            adr_oku <= 4'd0;
            adr_yaz <= 4'd0;
            for(i = 0; i < 16; i = i + 1)
                yazmaclar[i] <= 32'd0;
        end
        else if(yaz1_en_i) begin
            yazmaclar[adr_oku] <= yaz1_deger_i;
            adr_oku            <= adr_oku + 4'd1;
            if(yaz2_en_i)begin
                yazmaclar[adr_oku+1] <= yaz2_deger_i;
                adr_oku <= adr_oku + 4'd2;
            end
        end
        if(oku_en_i)begin
            adr_yaz <= adr_yaz + 4'd1;
        end
    end

endmodule
