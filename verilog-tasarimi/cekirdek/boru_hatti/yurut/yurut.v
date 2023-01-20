// yurut.v
`timescale 1ns / 1ps

`include "tanimlamalar.vh"

// denetim durum birimi ile iliskisinin kurulmasi gerek

module yurut(
    input wire clk_i,
    input wire rst_i,

    input wire [`MI_BIT-1:0] mikroislem_i, // 0 olursa gecersiz
    input wire yaz_yazmac_i,

    input wire [4:0] rd_adres_i,               // geri yaza kadar gitmesi lazim
    input wire [31:0] program_sayaci_artmis_i, // geri yaza kadar gitmesi lazim

    input wire [31:0] deger1_i, // anlik/yazmac vs. secilmis son ALU girdileri
    input wire [31:0] deger2_i,

    // jump ve branch icin
    input wire [ 2:0] lt_ltu_eq_i        // degerler arasindaki iliski. lt_ltu_i[0]: lessthan r1<r2, lt_ltu_i[1]: lt_unsigned r1<r2 unsigned
    input wire [ 1:0] buyruk_tipi_i      // J veya B tipi veya digertip, branch/jump buyruklari icin

    output wire [31:0] program_sayaci_o,  // ayni cevrimde gitmeli
    output wire program_sayaci_guncelle_o // ayni cevrimde gitmeli

    input wire yz_en_i, // yapay zeka icin enable biti

    output reg [ 4:0] rd_adres_o,              // geri yaza kadar gitmesi lazim
    output reg [31:0] program_sayaci_artmis_o, // geri yaza kadar gitmesi lazim

    output reg [31:0] rd_deger_o, // islem birimlerinden cikan sonuc
    output reg yaz_yazmac_o
);

    // hepsinde sonuc olmayacak duzenlemek lazim
    wire [31:0] amb_sonuc_w      ;
    wire [31:0] carp_sonuc_w     ;
    wire [31:0] bol_sonuc_w      ;
    wire [31:0] sifreleme_sonuc_w;
    wire [31:0] yapayzeka_sonuc_w;
    wire [31:0] sistem_sonuc_w   ;


    aritmetik_mantik_birimi amb (
        .kontrol(mikroislem_i[`AMB]),
        .deger1_i(deger1_i),
        .deger2_i(deger2_i),
        .lt_ltu_i(lt_ltu_eq_i[2:1]),
        .sonuc_o(amb_sonuc_w)
    );

    assign program_sayaci_o = amb_sonuc_w;


    wire [31:0] rd_deger_sonraki_w = (mikroislem_i[`BIRIM] == `BIRIM_AMB      ) ? amb_sonuc_w      :
                                     (mikroislem_i[`BIRIM] == `BIRIM_CARPMA   ) ? carp_sonuc_w     :
                                     (mikroislem_i[`BIRIM] == `BIRIM_BOLME    ) ? bol_sonuc_w      :
                                     (mikroislem_i[`BIRIM] == `BIRIM_SIFRELEME) ? sifreleme_sonuc_w:
                                     (mikroislem_i[`BIRIM] == `BIRIM_YAPAYZEKA) ? yapayzeka_sonuc_w:
                                     (mikroislem_i[`BIRIM] == `BIRIM_SISTEM   ) ? sistem_sonuc_w   :
                                                                                 32'hxxxx_xxxx;

    assign dallanma_kosulu_w = (mikroislem_i[`DAL] == `DAL_EQ ) ?  lt_ltu_eq_i[0]:
                               (mikroislem_i[`DAL] == `DAL_NE ) ? !lt_ltu_eq_i[0]:
                               (mikroislem_i[`DAL] == `DAL_LT ) ?  lt_ltu_eq_i[2]:
                               (mikroislem_i[`DAL] == `DAL_GE ) ? !lt_ltu_eq_i[2]:
                               (mikroislem_i[`DAL] == `DAL_LTU) ?  lt_ltu_eq_i[1]:
                               (mikroislem_i[`DAL] == `DAL_GEU) ? !lt_ltu_eq_i[1]:
                               (mikroislem_i[`DAL] == `DAL_YOK) ? 1'b0           :
                                                                  1'b0; // x yerine 0 cunku surekli okunuyor.

    assign program_sayaci_guncelle_o = (buyruk_tipi_i == `JTIP) || ((buyruk_tipi_i == `BTIP) && dallanma_kosulu_w);

    always @(posedge clk_i) begin
        if(rst_i) begin
            rd_deger_o <= 0;
            yaz_yazmac_o <= 0;
            rd_adres_o <= 0;
        end
        else begin
            yaz_yazmac_o <= yaz_yazmac_i;
            rd_deger_o <= rd_deger_sonraki_w;
            rd_adres_o <= rd_adres_i;
        end
    end

endmodule
