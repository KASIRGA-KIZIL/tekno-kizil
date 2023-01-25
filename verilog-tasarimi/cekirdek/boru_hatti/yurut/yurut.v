// yurut.v
`timescale 1ns / 1ps

`include "tanimlamalar.vh"

// denetim durum birimi ile iliskisinin kurulmasi gerek

module yurut(
    input wire clk_i,
    input wire rst_i,

    // DDB sinyalleri
    output wire ddb_hazir_o,

    // Coz-Yazmacoku bolumu sinyallleri
    input  wire [`MI_BIT-1:0] cyo_mikroislem_i,
    input  wire [        4:0] cyo_rd_adres_i,               // Rd'nin adresi
    input  wire [       31:0] cyo_ps_artmis_i,              // Rd=PC+4/2 islemi icin gerekli
    input  wire [       31:0] cyo_deger1_i,                 // Islem birimi girdileri. Yonlendirme ve Immediate secilmis son degerler.
    input  wire [       31:0] cyo_deger2_i,
    input  wire               cyo_yapay_zeka_en_i,          // yapay zeka buyruklari rs2 enable biti

    // Branch ve Jump buyruklari icin. Hepsi ayni cevrimde gidecek
    input  wire [ 2:0] cyo_lt_ltu_eq_i,                // Degerler arasindaki iliski. cyo_lt_ltu_eq_i: {lessthan,lt_unsigned, equal}
    input  wire [ 1:0] cyo_buyruk_tipi_i,              // J veya B veya digertip. Eger J tipiyse direkt atlanilacak. B tipiyse kosula bakilcak.
    output wire [31:0] gtr_atlanan_ps_o,               // Atlanilan yeni program sayaci, pc+imm veya rs1+imm degerini tasiyor.
    output wire        gtr_atlanan_ps_gecerli_o,       // Yeni program sayacinin gecerli olup olmadiginin sinyali. J tipinde hep gecerli

    // GERIYAZ icin
    output reg [ 4:0] gy_rd_adres_o,              // Rd'nin adresi
    output reg [31:0] gy_ps_artmis_o,             // Rd=PC+4/2 islemi icin gerekli
    output reg [31:0] gy_rd_deger_o,              // islem birimlerinden cikan sonuc
    output reg [31:0] gy_bib_deger_o,             // Bellek Islem Biriminin ciktisi.
    output reg [ 2:0] gy_mikroislem_o,            // Rd secimi ve write enable sinyalleri

    // Yonlendirme icin
    output wire [31:0] cyo_yonlendir_deger_o
);

    // hepsinde sonuc olmayacak duzenlemek lazim
    wire [31:0] amb_sonuc_w      ;
    wire [31:0] carp_sonuc_w     ;
    wire [31:0] bol_sonuc_w      ;
    wire [31:0] sifreleme_sonuc_w;
    wire [31:0] yapayzeka_sonuc_w;
    wire [31:0] sistem_sonuc_w   ;

    aritmetik_mantik_birimi amb (
        .kontrol(cyo_mikroislem_i[`AMB]),
        .deger1_i(cyo_deger1_i),
        .deger2_i(cyo_deger2_i),
        .lt_ltu_i(cyo_lt_ltu_eq_i[2:1]),
        .sonuc_o(amb_sonuc_w)
    );

    wire [31:0] rd_deger_sonraki_w = (cyo_mikroislem_i[`BIRIM] == `BIRIM_AMB      ) ? amb_sonuc_w      :
                                     (cyo_mikroislem_i[`BIRIM] == `BIRIM_CARPMA   ) ? carp_sonuc_w     :
                                     (cyo_mikroislem_i[`BIRIM] == `BIRIM_BOLME    ) ? bol_sonuc_w      :
                                     (cyo_mikroislem_i[`BIRIM] == `BIRIM_SIFRELEME) ? sifreleme_sonuc_w:
                                     (cyo_mikroislem_i[`BIRIM] == `BIRIM_YAPAYZEKA) ? yapayzeka_sonuc_w:
                                     (cyo_mikroislem_i[`BIRIM] == `BIRIM_SISTEM   ) ? sistem_sonuc_w   :
                                                                                 32'hxxxx_xxxx;

    wire dallanma_kosulu_w = (cyo_mikroislem_i[`DAL] == `DAL_EQ ) ?  cyo_lt_ltu_eq_i[0]:
                             (cyo_mikroislem_i[`DAL] == `DAL_NE ) ? !cyo_lt_ltu_eq_i[0]:
                             (cyo_mikroislem_i[`DAL] == `DAL_LT ) ?  cyo_lt_ltu_eq_i[2]:
                             (cyo_mikroislem_i[`DAL] == `DAL_GE ) ? !cyo_lt_ltu_eq_i[2]:
                             (cyo_mikroislem_i[`DAL] == `DAL_LTU) ?  cyo_lt_ltu_eq_i[1]:
                             (cyo_mikroislem_i[`DAL] == `DAL_GEU) ? !cyo_lt_ltu_eq_i[1]:
                             (cyo_mikroislem_i[`DAL] == `DAL_YOK) ? 1'b0           :
                                                                    1'b0; // x veya ? yerine 0 cunku dallanma_kosulu surekli okunuyor. Kazayla 1 verirsek gecmis olsun.

    assign gtr_atlanan_ps_gecerli_o = (cyo_buyruk_tipi_i == `JTIP) || ((cyo_buyruk_tipi_i == `BTIP) && dallanma_kosulu_w);

    assign gtr_atlanan_ps_o = amb_sonuc_w;

    assign cyo_yonlendir_deger_o = rd_deger_sonraki_w;

    always @(posedge clk_i) begin
        if(rst_i) begin
            gy_mikroislem_o <= 0;
            gy_rd_deger_o   <= 0;
            gy_rd_adres_o   <= 0;
        end
        else begin
            gy_mikroislem_o <= cyo_mikroislem_i;
            gy_rd_deger_o   <= rd_deger_sonraki_w;
            gy_rd_adres_o  <= cyo_rd_adres_i;
            gy_ps_artmis_o <= cyo_ps_artmis_i;
        end
    end

    assign ddb_hazir_o = 1'b1; // [TODO] Bolme carpma vs. de Bitti sinyallerine baglanmali.
endmodule
