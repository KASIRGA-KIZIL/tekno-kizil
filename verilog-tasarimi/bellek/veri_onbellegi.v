`timescale 1ns / 1ps

`define TAG 18:11
`define ADR 10:2

module veri_onbellegi(
  input clk_i,
  input rst_i,
  // DDB <-> Onbellek Denetleyici
  output ddb_durdur,
  // Bib <-> Buyruk Onbellegi Okuma
  output  wire [31:0] bib_veri_o,
  output  wire        bib_durdur_o,
  input wire [31:0] bib_veri_i,
  input wire [31:0] bib_adr_o,
  input wire [ 3:0] bib_veri_maske_o,
  input wire        bib_yaz_gecerli_o,
  input wire        bib_sec_n_o, // active low
  // Anabellek Denetleyici <-> buyruk onbellegi
  output reg [31:0] ab_addr,
  output reg        ab_valid,
  output reg [31:0] ab_din,
  output reg [3:0]  ab_web,
  input      [31:0] ab_dot,
  input             ab_ready
);

reg [511:0] dirty_r, dirty_next_r;
reg [511:0] valid_r, valid_next_r;

wire cache_dirty_w;
wire cache_valid_w;

localparam BEKLE = 3'd0,
           CACHE_OKU = 3'd1,
           CACHE_YAZ = 3'd2,
           BELLEK_OKU = 3'd3,
           BELLEK_YAZ = 3'd4;

reg [2:0] durum_r, durum_next_r;


wire [8:0] c_oku_adres_w;

wire [7:0] c_oku_tag_w;

wire [31:0] data_out_w;
wire oku_valid_w;

reg [8:0] yaz_adres_r;
reg [7:0] yaz_tag_r;
reg [31:0] data_in_r;
reg cs_yaz_r;
reg yaz_en_r;
reg cs_oku_r;

reg [8:0] anabellek_adr_r, anabellek_adr_next_r;
reg [31:0] anabellek_veri_r, anabellek_veri_next_r;
reg anabellek_veri_kullan_r, anabellek_veri_kullan_next_r;

// assign cs_yaz_r =

sram_40b_512_1w_1r_sky130 veri_onbellegi(
    // write port
    .clk0       (clk_i),
    .csb0       (cs_yaz_r),
    .wmask0     ({1'b1, bib_veri_maske_o}),
    .spare_wen0 (yaz_en_r),
    // zaten islemci durmus olucagi icin kontrole gerek yok
    .addr0      (yaz_adres_r),
    .din0       ({1'bx, yaz_tag_r, data_in_r}),
    // read port
    .clk1  (clk_i),
    .csb1  (cs_oku_r),
    .addr1 (c_oku_adres_w),
    .dout1 ({dummy, c_oku_tag_w, data_out_w})
);

// okumada hit varsa bile 1 cycle durmali -> CACHE_OKU
// not: fazladan durdur silinebilir
assign ddb_durdur   = (durum_r!=BEKLE);
assign bib_durdur_o = (durum_r!=BEKLE); // || (durum_r==BEKLE&&!bib_sec_n_o);

assign cache_valid_w = valid_r[bib_adr_o[`ADR]];
assign cache_dirty_w = dirty_r[bib_adr_o[`ADR]];

assign bib_veri_o = data_out_w;

always @* begin
    durum_next_r = durum_r;
    valid_next_r = valid_r;
    dirty_next_r = dirty_r;
    anabellek_adr_next_r = anabellek_adr_r;
    anabellek_veri_next_r = anabellek_veri_r;
    anabellek_veri_kullan_next_r = 1'b0;
    case(durum_r)
        BEKLE: begin
            // Yazma istegi
            // Cache oku
            if(!bib_sec_n_o && bib_yaz_gecerli_o && (!cache_valid_w && (cache_valid_w && !cache_dirty_w)))
                durum_next_r = CACHE_YAZ;

            if(!bib_sec_n_o && bib_yaz_gecerli_o && (cache_valid_w && cache_dirty_w))
                durum_next_r = CACHE_OKU;

            // Okuma istegi
            // Bellek Oku
            if(!bib_sec_n_o && !bib_yaz_gecerli_o && !cache_valid_w)
                durum_next_r = BELLEK_OKU;

            // Cache oku
            if(!bib_sec_n_o && !bib_yaz_gecerli_o && cache_valid_w)
                durum_next_r = CACHE_OKU;
        end

        CACHE_OKU: begin
            // Okuma
            if(!bib_yaz_gecerli_o) begin
                if(c_oku_tag_w==bib_adr_o[`TAG])
                    durum_next_r = BEKLE;
                else begin
                    if(cache_dirty_w) begin
                        durum_next_r = BELLEK_YAZ;
                        anabellek_adr_next_r = c_oku_adres_w;
                        anabellek_veri_next_r = data_out_w;
                        anabellek_veri_kullan_next_r = 1'b1;
                    end
                    else
                        durum_next_r = BELLEK_OKU;
                end
            end
            // Yazma
            else begin
                if(c_oku_tag_w==bib_adr_o[`TAG])
                    durum_next_r = CACHE_YAZ;
                else begin
                    durum_next_r = BELLEK_YAZ;
                    anabellek_adr_next_r = c_oku_adres_w;
                    anabellek_veri_next_r = data_out_w;
                    anabellek_veri_kullan_next_r = 1'b1;
                end
            end
        end

        CACHE_YAZ: begin
            // Okuma
            if(!bib_yaz_gecerli_o)
                durum_next_r = CACHE_OKU;
            // Yazma
            else
                durum_next_r = BEKLE;
        end

        BELLEK_OKU: begin
            // Okuma
            if(!bib_yaz_gecerli_o) begin
                if(ab_ready) begin
                    durum_next_r = CACHE_YAZ;
                    anabellek_adr_next_r = bib_adr_o;
                    anabellek_veri_next_r = ab_dot;
                    anabellek_veri_kullan_next_r = 1'b1;
                end
            end
        end

        BELLEK_YAZ: begin
            // Okuma
            if(!bib_yaz_gecerli_o) begin
                if(ab_ready)
                    durum_next_r = BELLEK_OKU;
            end
            // Yazma
            else begin
                if(ab_ready)
                    durum_next_r = CACHE_YAZ;
            end
        end

    endcase
end

always @(posedge clk_i) begin
    if(rst_i) begin
        durum_r <= 0;
        valid_r <= 0;
        dirty_r <= 0;
        anabellek_adr_r <= 0;
        anabellek_veri_r <= 0;
        anabellek_veri_kullan_r <= 0;
        yaz_adres_r <= 0;
        yaz_tag_r <= 0;
        data_in_r <= 0;
        cs_yaz_r <= 1'b1;
        yaz_en_r <= 0;
        cs_oku_r <= 1'b1;
        ab_addr <= 0;
        ab_valid <= 1'b1;
        ab_din <= 0;
        ab_web <= 4'b0;
    end
    else begin
        durum_r <= durum_next_r;
        valid_r <= valid_next_r;
        valid_r <= valid_next_r;
        anabellek_adr_r <= anabellek_adr_next_r;
        anabellek_veri_r <= anabellek_veri_next_r;
        anabellek_veri_kullan_r <= anabellek_veri_kullan_next_r;
    end
end

always @(*) begin
    case(durum_next_r)
        CACHE_YAZ: begin
            // Bellekten gelen veri yazilacak
            if(anabellek_veri_kullan_r) begin
                yaz_adres_r = anabellek_adr_r[`ADR];
                yaz_tag_r = anabellek_adr_r[`TAG];
                data_in_r = anabellek_veri_r;
                cs_yaz_r = 1'b0;
                yaz_en_r = 1'b1;
                cs_oku_r = 1'b1;

                ab_addr = 0;
                ab_valid = 1'b1;
                ab_din = 0;
                ab_web = 4'b0;
            end
            // Bibden gelen veri yazilacak
            else begin
                yaz_adres_r = bib_adr_o[`ADR];
                yaz_tag_r = bib_adr_o[`TAG];
                data_in_r = bib_veri_i;
                cs_yaz_r = 1'b0;
                yaz_en_r = 1'b1;
                cs_oku_r = 1'b1;

                ab_addr = 0;
                ab_valid = 1'b1;
                ab_din = 0;
                ab_web = 4'b0;
            end
        end

        CACHE_OKU: begin
            // Bellekten gelen veri okunacak
            if(anabellek_veri_kullan_r) begin
                yaz_adres_r = anabellek_adr_r[`ADR];
                yaz_tag_r = anabellek_adr_r[`TAG];
                data_in_r = 0;
                cs_yaz_r = 1'b1;
                yaz_en_r = 1'b0;
                cs_oku_r = 1'b0;

                ab_addr = 0;
                ab_valid = 1'b1;
                ab_din = 0;
                ab_web = 4'b0;
            end
            // Bibden gelen veri okunacak
            else begin
                yaz_adres_r = bib_adr_o[`ADR];
                yaz_tag_r = bib_adr_o[`TAG];
                data_in_r = 0;
                cs_yaz_r = 1'b1;
                yaz_en_r = 1'b0;
                cs_oku_r = 1'b0;

                ab_addr = 0;
                ab_valid = 1'b1;
                ab_din = 0;
                ab_web = 4'b0;
            end
        end

        BELLEK_OKU: begin
            ab_addr = bib_adr_o;
            ab_valid = 1'b0;
            ab_din = 32'd0;
            ab_web = 4'b0;

            yaz_adres_r = 0;
            yaz_tag_r = 0;
            data_in_r = 0;
            cs_yaz_r = 1'b1;
            yaz_en_r = 1'b0;
            cs_oku_r = 1'b0;
        end

        BELLEK_YAZ: begin
            ab_addr = anabellek_adr_r;
            ab_valid = 1'b0;
            ab_din = anabellek_veri_r;
            ab_web = 4'b1111;

            yaz_adres_r = 0;
            yaz_tag_r = 0;
            data_in_r = 0;
            cs_yaz_r = 1'b1;
            yaz_en_r = 1'b0;
            cs_oku_r = 1'b0;
        end

        default: begin
            yaz_adres_r = 0;
            yaz_tag_r = 0;
            data_in_r = 0;
            cs_yaz_r = 1'b1;
            yaz_en_r = 1'b0;
            cs_oku_r = 1'b1;

            ab_addr = 0;
            ab_valid = 1'b1;
            ab_din = 0;
            ab_web = 4'b0;
        end
    endcase
end
endmodule
