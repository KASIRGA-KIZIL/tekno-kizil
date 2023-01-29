// bellek_islem_birimi.v
`timescale 1ns / 1ps


module bellek_islem_birimi(
    input clk_i,
    input rst_i,
    // denetim durum birimi sinyalleri 
    input ddb_duraklat_i,
    input ddb_bosalt_i,
    // yurut -> bib
    input yurut_buyruk_gecerli,
    input [3:0] yurut_buyruk_kontrol_i, // TODO: bu sinyali 9 bite cikar
    input [31:0] yurut_deger1_i, // reg1
    input [31:0] yurut_deger2_i, // reg2, imm
    input [31:0] yurut_address_i,
    // bib -> yurut
    output [31:0] yurut_deger_o, // islem birimlerinden gelen sonuclar
    output yurut_yaz_yazmac_o,
    // l1 cache controller -> bib
    input l1c_stall_i,
    input l1c_oku_gecerli,
    input [31:0] l1c_oku_veri_o, // dout
    // bib -> l1 cache controller
    output [3:0] l1c_veri_maske_o,
    output [31:0] l1c_yaz_veri_o, // din
    output [31:0] l1c_veri_addres_o, // boyut?? 
    output l1c_yaz_gecerli_o, // write enable
    );

    ////////////////////////////////////////////////////
    //                  Tanimlamalar
    ////////////////////////////////////////////////////

    // Buyruklar:
    // Yükle : lw 4'b0000, lh 4'b0001, lb 4'b0010, lhu 4'b0011, lbu 4'b0100
    // Sakla : sb 4'b0101, sh 4'b0110, sw 4'b0111
    // Fence 4'b1000
    localparam lw    = 4'b0000,
               lh    = 4'b0001,
               lb    = 4'b0010,
               lhu   = 4'b0011,
               lbu   = 4'b0100,
               sb    = 4'b0001,
               sh    = 4'b0110,
               sw    = 4'b0111,
               fence = 4'b1000;

    // Cikis reg
    reg [31:0] yurut_deger_r, yurut_deger_next_r;
    reg yurut_yaz_yazmac_r, yurut_yaz_yazmac_next_r;

    // Store buyruk turu
    wire sb_w;
    wire sh_w;
    wire sw_w;

    ////////////////////////////////////////////////////
    //                  Atamalar
    ////////////////////////////////////////////////////

    // L1'e ayni cevrimde erisilecek
    // burasi degisebilir, coz zaten hesapliyor
    assign sb_w = yurut_buyruk_kontrol_i==4'b0101;
    assign sh_w = yurut_buyruk_kontrol_i==4'b0110;
    assign sw_w = yurut_buyruk_kontrol_i==4'b0111;

    // L1c'ye ayni cevrim erisilecek
    assign l1c_veri_maske_o = sb_w ? (yurut_address_i[1:0]<<3)
        : (sh_w ? ({yurut_address_i[1], yurut_address_i[1], ~yurut_address_i[1], ~yurut_address_i[1]}) 
        : 4'b1111);
    // ONEMLI: cozden dogru verinin geldigini varsaydin
    assign l1c_yaz_veri_o = yaz_veri_r;
    assign l1c_veri_addres_o = yurut_address_i;
    assign l1c_yaz_gecerli_o = (durum_r==BOSTA) && (sb_w || sh_w || sw_w);

    // Cikis

    always @* begin
        yurut_yaz_yazmac_next_r = 1'b0;
        yurut_deger_next_r = yurut_deger_r;

        // l1c_oku_gecerli: load buyrugunun istedigi veri getirildi.
        // Onemli: ddb boru hattini duraklatirken l1c bu modulu duraklatmiyor
        if(!l1c_stall_i && l1c_oku_gecerli) begin
            yurut_yaz_yazmac_next_r = 1'b1;
            // Onemli: cache 32 bit adresliyor
            case(yurut_buyruk_kontrol_i)
            lw: yurut_deger_next_r = l1c_oku_veri_o;

            lh:  yurut_deger_next_r = {{16{l1c_oku_veri_o[{yurut_address_i[1]<<4} + 15]}}, l1c_oku_veri_o[(yurut_address_i[1]<<3)+:16]};

            lhu: yurut_deger_next_r = {{16{1'b0}}, l1c_oku_veri_o[(yurut_address_i[1]<<4)+:16]};

            lb:  yurut_deger_next_r = {{24{l1c_oku_veri_o[(yurut_address_i[1:0]<<3) + 7]}}, l1c_oku_veri_o[(yurut_address_i[1:0]<<3)+:8]};

            lbu: yurut_deger_next_r = {{24{1'b0}},l1c_oku_veri_o[(yurut_address_i[1:0]<<3)+:8]};
            endcase
        end    
    end

    always@(posedge clk_i) begin
        if (rst_i || ddb_bosalt_i) begin
            yurut_yaz_yazmac_r <= 1'b0;
            yurut_deger_r <= 32'b0;
        end
        else begin
            yurut_yaz_yazmac_r <= yurut_yaz_yazmac_next_r; 
            yurut_deger_r <= yurut_deger_next_r;
        end
    end


endmodule
