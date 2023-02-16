// denetim_durum_birimi.v
`timescale 1ns / 1ps

`include "tanimlamalar.vh"

`define ASAMA_GETIR   0
`define ASAMA_COZ     1
`define ASAMA_YURUT   2
`define ASAMA_GERIYAZ 3


module denetim_durum_birimi(
    input wire clk_i,
    input wire rst_i,
    // GETIR sinyalleri
    input  wire gtr_yanlis_tahmin_i,       // Dallanma ongorucu, ongoremedi
    input  wire gtr_hazir_i,               // Getir hazir degil. L1 miss oldu vs. Buyruk gecersiz
    output wire gtr_durdur_o,
    output wire gtr_bosalt_o,

    // COZ sinyalleri
    input  wire [4:0] cyo_rs1_adres_i,          // RS1 adresi
    input  wire [4:0] cyo_rs2_adres_i,          // RS2 adresi
    output wire [1:0] cyo_yonlendir_kontrol1_o, // Yonlendirme(Forwarding) deger1 icin kontrol sinyali
    output wire [1:0] cyo_yonlendir_kontrol2_o, // Yonlendirme(Forwarding) deger2 icin kontrol sinyali
    output wire       cyo_durdur_o,
    output wire       cyo_bosalt_o,

    // YURUT sinyalleri
    output wire      yrt_durdur_o,
    input wire       yrt_yaz_yazmac_i,         // Rd geri yaziliyor ise 1
    input wire       yrt_hazir_i,              // Birden fazla cevrim suren bolme vs. icin
    input wire [4:0] yrt_rd_adres_i,           // Rd nin adresi
    input wire       yrt_yonlendir_gecerli_i,  //

    // GERIYAZ sinyalleri
    input       gy_yaz_yazmac_i,   // Rd geri yaziliyor ise 1
    input [4:0] gy_rd_adres_i      // Rd nin adresi
);

    reg [3:0] gecersiz;
    reg bos_basla;

    wire yurut_yonlendir1   = (((cyo_rs1_adres_i == yrt_rd_adres_i) && yrt_yaz_yazmac_i) && (cyo_rs1_adres_i != 0)) && (~gecersiz[`ASAMA_YURUT  ]||yrt_yonlendir_gecerli_i);
    wire geriyaz_yonlendir1 = (((cyo_rs1_adres_i == gy_rd_adres_i ) && gy_yaz_yazmac_i ) && (cyo_rs1_adres_i != 0)) && (~gecersiz[`ASAMA_GERIYAZ]);
    assign  cyo_yonlendir_kontrol1_o = yurut_yonlendir1   ? `YON_YURUT :
                                       geriyaz_yonlendir1 ? `YON_GERIYAZ :
                                                            `YON_HICBISEY;

    wire yurut_yonlendir2   = (((cyo_rs2_adres_i == yrt_rd_adres_i) && yrt_yaz_yazmac_i) && (cyo_rs2_adres_i != 0)) && (~gecersiz[`ASAMA_YURUT  ]||yrt_yonlendir_gecerli_i);
    wire geriyaz_yonlendir2 = (((cyo_rs2_adres_i == gy_rd_adres_i ) && gy_yaz_yazmac_i ) && (cyo_rs2_adres_i != 0)) && (~gecersiz[`ASAMA_GERIYAZ]);
    assign  cyo_yonlendir_kontrol2_o =  yurut_yonlendir2   ? `YON_YURUT :
                                        geriyaz_yonlendir2 ? `YON_GERIYAZ :
                                                             `YON_HICBISEY;

    assign gtr_durdur_o = ~yrt_hazir_i || ~gtr_hazir_i || (~yrt_yonlendir_gecerli_i && (yurut_yonlendir2 || yurut_yonlendir1));
    assign cyo_durdur_o = ~yrt_hazir_i || ~gtr_hazir_i || (~yrt_yonlendir_gecerli_i && (yurut_yonlendir2 || yurut_yonlendir1));
    assign yrt_durdur_o = ~gtr_hazir_i;

    assign gtr_bosalt_o = bos_basla || gtr_yanlis_tahmin_i ;
    assign cyo_bosalt_o = bos_basla || gtr_yanlis_tahmin_i ;

    always @(posedge clk_i) begin
        if(rst_i)begin
            gecersiz   <= 4'b1111;
            bos_basla  <= 1'b1;
        end else begin
            gecersiz[`ASAMA_GETIR]   <= 1'b0;
            gecersiz[`ASAMA_COZ]     <= 1'b0;
            gecersiz[`ASAMA_YURUT]   <= (gtr_yanlis_tahmin_i) ? 1'b1 : ~yrt_yonlendir_gecerli_i;
            gecersiz[`ASAMA_GERIYAZ] <= gecersiz[`ASAMA_YURUT];

            bos_basla  <= 1'b0;
        end
    end
endmodule
