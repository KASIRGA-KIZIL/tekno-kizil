// yurut.v
`timescale 1ns / 1ps

`include "tanimlamalar.vh"

// denetim durum birimi ile iliskisinin kurulmasi gerek

module yurut(
    input wire clk_i,
    input wire rst_i,

    // Veri yolu icin
    input  wire [`MI_BIT-1:0] mikroislem_i,
    input  wire        yaz_yazmac_i,             // Rd'ye sonuc yazilacak mi
    input  wire [ 4:0] rd_adres_i,               // Rd'nin adresi
    input  wire [31:0] program_sayaci_artmis_i,  // Rd=PC+4/2 islemi icin gerekli
    input  wire [31:0] deger1_i,                 // Islem birimi girdileri. Yonlendirme ve Immediate secilmis son degerler.
    input  wire [31:0] deger2_i,
    input  wire [ 1:0] yz_en_i,                  // yapay zeka buyruklari rs1 ve rs2 enable bitleri

    // Branch ve Jump buyruklari icin. Hepsi ayni cevrimde gidecek
    input  wire [ 2:0] lt_ltu_eq_i,             // Degerler arasindaki iliski. lt_ltu_eq_i: {lessthan,lt_unsigned, equal}
    input  wire [ 1:0] buyruk_tipi_i,           // J veya B veya digertip. Eger J tipiyse direkt atlanilacak. B tipiyse kosula bakilcak.
    output wire [31:0] yeni_program_sayaci_o,   // Atlanilan yeni program sayaci, pc+imm veya rs1+imm degerini tasiyor.
    output wire program_sayaci_gecerli_o        // Yeni program sayacinin gecerli olup olmadiginin sinyali. J tipinde hep gecerli

    // Dallanma Ongorucu icin. Hepsi ayni cevrimde gidecek
    input  wire [31:0] program_sayaci_i,        // Suanki buyrugun PC'si. Branch Target Buffer icin gerekli.
    input  wire [31:0] coz_program_sayaci_i,    // Tahmin dogru mu bakmak icin. COZ'un PC'si. Cozdeki buyruga ait.
    output wire [31:0] yurut_program_sayac_o,   // Atlamayi isteyen buyrugun PC'si. Yurutteki buyruga ait.
    output wire        tahmin_dogru_o,          // COZ'deki PC yuruttekine esit mi? Esitse dogru tahmin
    output wire [ 1:0] buyruk_tipi_o,           // Jtipi mi B tipi mi.
    output wire [31:0] program_sayaci_o,        // Suanki buyrugun PC'si. Branch Target Buffer icin gerekli.

    // GERIYAZ icin
    output reg [ 4:0] rd_adres_o,              // Rd'nin adresi
    output reg [31:0] program_sayaci_artmis_o, // Rd=PC+4/2 islemi icin gerekli
    output reg [31:0] rd_deger_o,              // islem birimlerinden cikan sonuc
    output reg [ 2:0] mikroislem_o             // Rd secimi ve write enable sinyalleri
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
                                                                  1'b0; // x veya ? yerine 0 cunku dallanma_kosulu surekli okunuyor. Kazayla 1 verirsek gecmis olsun.

    assign program_sayaci_gecerli_o = (buyruk_tipi_i == `JTIP) || ((buyruk_tipi_i == `BTIP) && dallanma_kosulu_w);

    assign tahmin_dogru_o = (program_sayaci_gecerli_o == coz_program_sayaci_artmis_i);

    assign yeni_program_sayaci_o = amb_sonuc_w;
    assign buyruk_tipi_o = buyruk_tipi_i;
    assign program_sayaci_o = program_sayaci_i;

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
