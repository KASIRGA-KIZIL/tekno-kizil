`timescale 1ns / 1ps

`define TAG 18:10
`define ADR 9:2

module veri_onbellegi(
    input clk_i,
    input rst_i,
    // Bib <-> Buyruk Onbellegi Okuma
    output reg  [31:0] l1v_veri_o,
    output wire        l1v_durdur_o,
    input  wire [31:0] l1v_veri_i,
    input  wire [18:2] l1v_adr_i,
    input  wire [ 3:0] l1v_veri_maske_i,
    input  wire        l1v_sec_i,
    // Anabellek Denetleyici <-> buyruk onbellegi
    output wire [18:2] iomem_addr_o,
    output wire        iomem_valid_o,
    output wire [31:0] iomem_wdata_o,
    output wire [3:0]  iomem_wstrb_o,
    input       [31:0] iomem_rdata_i,
    input              iomem_ready_i
);
reg [31:0] bib_veri_next;
reg [1:0] dirty_r [255:0]; 
reg [1:0] dirty_next_r [255:0];
reg [1:0] valid_r [255:0];
reg [1:0] valid_next_r [255:0];
reg [255:0] lru_r, lru_next_r;

reg [ 7:0] yaz_adres_next_r;
reg [ 8:0] yaz_tag_next_r;
reg        cs_yaz0_next_r;
reg        cs_yaz1_next_r;
reg        yaz_en0_next_r;
reg        yaz_en1_next_r;
reg        cs_oku_next_r;

reg [18:2] iomem_addr_o_next_r;
reg [31:0] iomem_wdata_o_next_r;
reg [3:0]  iomem_wstrb_o_next_r;

reg [18:2] iomem_addr_o_r;
reg [31:0] iomem_wdata_o_r;
reg [3:0]  iomem_wstrb_o_r;

reg [2:0] durum_r, durum_next_r;

wire cache_dirty0_w, cache_dirty1_w;
wire cache_valid0_w, cache_valid1_w;

localparam BEKLE = 3'd0,
           CACHE_OKU = 3'd1,
           CACHE_YAZ = 3'd2,
           BELLEK_OKU = 3'd3,
           BELLEK_YAZ = 3'd4,
           BITTI      = 3'd5;


assign iomem_addr_o  = iomem_addr_o_r;
assign iomem_valid_o = (durum_r == BELLEK_OKU) || (durum_r == BELLEK_YAZ);
assign iomem_wdata_o   = iomem_wdata_o_r;
assign iomem_wstrb_o   = iomem_wstrb_o_r;


wire [7:0] c_oku_adres_w = l1v_adr_i[`ADR];

wire [8:0] c_oku_tag0_w;
wire [8:0] c_oku_tag1_w;

wire [31:0] data_out0_w;
wire [31:0] data_out1_w;

reg [7:0] yaz_adres_r;
reg [8:0] yaz_tag_r;
reg yaz_en0_r;
reg yaz_en1_r;
reg cs_oku_r;
wire [3:0] veri_maske_w = (durum_r==BELLEK_OKU) ? 4'b1111 : l1v_veri_maske_i;

reg [18:2] anabellek_adr_r, anabellek_adr_next_r;
reg [31:0] anabellek_veri_r, anabellek_veri_next_r;
reg anabellek_veri_kullan_r, anabellek_veri_kullan_next_r;

wire dummy;

wire [31:0] data_in_w = anabellek_veri_kullan_next_r ? anabellek_veri_next_r : l1v_veri_i;


// `ifdef COCOTB_SIM
//     sram_40b_512_1w_1r_sky130_verilator sram(
//         // write port
//         .clk0       (clk_i),
//         .csb0       (cs_yaz0_next_r),
//         .wmask0     ({1'b1, veri_maske_w}),
//         .spare_wen0 (yaz_en0_next_r),
//         // zaten islemci durmus olucagi icin kontrole gerek yok
//         .addr0      (yaz_adres_next_r),
//         .din0       ({1'bx, yaz_tag_next_r, data_in_w}),
//         // read port
//         .clk1  (clk_i),
//         .csb1  (cs_oku_next_r),
//         .addr1 (c_oku_adres_w),
//         .dout1 ({dummy, c_oku_tag0_w, data_out0_w})
//     );
// `else
    sram_41b_256_1w_1r_sky130 sram0(
        // write port
        .clk0       (clk_i),
        .csb0       (cs_yaz0_next_r),
        .wmask0     ({2'b1, veri_maske_w}),
        .spare_wen0 (yaz_en0_next_r),
        .addr0      (yaz_adres_next_r),
        .din0       ({1'bx, yaz_tag_next_r, data_in_w}),
        // read port
        .clk1  (clk_i),
        .csb1  (cs_oku_next_r),
        .addr1 (c_oku_adres_w),
        .dout1 ({dummy, c_oku_tag0_w, data_out0_w})
    );
    sram_41b_256_1w_1r_sky130 sram1(
        // write port
        .clk0       (clk_i),
        .csb0       (cs_yaz1_next_r),
        .wmask0     ({2'b1, veri_maske_w}),
        .spare_wen0 (yaz_en1_next_r),
        .addr0      (yaz_adres_next_r),
        .din0       ({1'bx, yaz_tag_next_r, data_in_w}),
        // read port
        .clk1  (clk_i),
        .csb1  (cs_oku_next_r),
        .addr1 (c_oku_adres_w),
        .dout1 ({dummy, c_oku_tag1_w, data_out1_w})
    );
      /*
    // word size: 40, 512 words, simple dp
    blk_mem_gen_0 blk0(
        // write port
        .clka(clk_i),
        .ena(!cs_yaz0_next_r),
        .wea({1'b1, veri_maske_w}),
        .addra(yaz_adres_next_r),
        .dina({yaz_tag_next_r, data_in_w}),
        // read port
        .clkb(clk_i),
        .enb(!cs_oku_next_r),
        .addrb(c_oku_adres_w),
        .doutb({c_oku_tag0_w, data_out0_w})
    );
      */

// `endif

// okumada hit varsa bile 1 cycle durmali -> CACHE_OKU
// not: fazladan durdur silinebilir
reg basladi;
assign l1v_durdur_o = (~basladi && l1v_sec_i) || ~(durum_r == BITTI);


assign cache_valid0_w = valid_r[l1v_adr_i[`ADR]][0];
assign cache_dirty0_w = dirty_r[l1v_adr_i[`ADR]][0];

assign cache_valid1_w = valid_r[l1v_adr_i[`ADR]][1];
assign cache_dirty1_w = dirty_r[l1v_adr_i[`ADR]][1];

always @* begin
    bib_veri_next = l1v_veri_o;
    durum_next_r = durum_r;
    valid_next_r[0] = valid_r[0];
    valid_next_r[1] = valid_r[1];
    dirty_next_r[0] = dirty_r[0];
    dirty_next_r[1] = dirty_r[1];
    anabellek_adr_next_r = anabellek_adr_r;
    anabellek_veri_next_r = anabellek_veri_r;
    anabellek_veri_kullan_next_r = 1'b0;
    lru_next_r = lru_r;
    case(durum_r)
        BEKLE: begin
            // Yazma istegi
            // Cache oku
            if(l1v_sec_i && (|(l1v_veri_maske_i)) && ((!cache_valid0_w && !cache_valid1_w) || ((cache_valid0_w && !cache_dirty0_w) && (cache_valid1_w && !cache_dirty1_w))) && (&l1v_veri_maske_i))
                durum_next_r = CACHE_YAZ;

            if(l1v_sec_i && (|(l1v_veri_maske_i)) && ((!cache_valid0_w && !cache_valid1_w) || ((cache_valid0_w && !cache_dirty0_w) && (cache_valid1_w && !cache_dirty1_w))) && ~(&l1v_veri_maske_i))
                durum_next_r = BELLEK_OKU;

            if(l1v_sec_i && (|(l1v_veri_maske_i)) && ((cache_valid0_w && cache_dirty0_w) || (cache_valid1_w && cache_dirty1_w)))
                durum_next_r = CACHE_OKU;

            // Okuma istegi
            // Bellek Oku
            if(l1v_sec_i && !(|(l1v_veri_maske_i)) && !cache_valid0_w && !cache_valid1_w)
                durum_next_r = BELLEK_OKU;

            // Cache oku
            if(l1v_sec_i && !(|(l1v_veri_maske_i)) && (cache_valid0_w || cache_valid1_w))
                durum_next_r = CACHE_OKU;
        end

        CACHE_OKU: begin
            // Okuma
            if(!(|(l1v_veri_maske_i))) begin
                if(c_oku_tag0_w==l1v_adr_i[`TAG] || c_oku_tag1_w==l1v_adr_i[`TAG]) begin
                    durum_next_r = BITTI;
                    lru_next_r[`ADR] = c_oku_tag1_w==l1v_adr_i[`TAG];
                end
                else begin
                    if(cache_dirty0_w && cache_dirty1_w) begin
                        durum_next_r = BELLEK_YAZ;
                        anabellek_adr_next_r = lru_r[`ADR] ? {c_oku_tag0_w,l1v_adr_i[`ADR]} : {c_oku_tag1_w,l1v_adr_i[`ADR]};
                        anabellek_veri_next_r = lru_r[`ADR] ? data_out0_w : data_out1_w;
                        anabellek_veri_kullan_next_r = 1'b1;
                    end
                    else
                        durum_next_r = BELLEK_OKU;
                end
            end
            // Yazma
            else begin
                if(c_oku_tag0_w==l1v_adr_i[`TAG] || c_oku_tag1_w==l1v_adr_i[`TAG])
                    durum_next_r = CACHE_YAZ;
                else begin
                    if(cache_dirty0_w && cache_dirty1_w) begin
                        durum_next_r = BELLEK_YAZ;
                        anabellek_adr_next_r = lru_r[`ADR] ? {c_oku_tag0_w,l1v_adr_i[`ADR]} : {c_oku_tag1_w,l1v_adr_i[`ADR]};
                        anabellek_veri_next_r = lru_r[`ADR] ? data_out0_w : data_out1_w;
                        anabellek_veri_kullan_next_r = 1'b1;
                    end
                end
            end
            bib_veri_next  = c_oku_tag0_w==l1v_adr_i[`TAG] ? data_out0_w : data_out1_w;
        end

        CACHE_YAZ: begin
            // Okuma
            if(!(|(l1v_veri_maske_i))) begin
                if(c_oku_tag0_w==l1v_adr_i[`TAG] || c_oku_tag1_w==l1v_adr_i[`TAG]) begin
                    durum_next_r = CACHE_OKU;
                    dirty_next_r[l1v_adr_i[`ADR]][(c_oku_tag1_w==l1v_adr_i[`TAG])] = 1'b0;
                    valid_next_r[l1v_adr_i[`ADR]][(c_oku_tag1_w==l1v_adr_i[`TAG])] = 1'b1;
                end
                else begin
                    durum_next_r = CACHE_OKU;
                    dirty_next_r[l1v_adr_i[`ADR]][lru_r[`ADR]] = 1'b0;
                    valid_next_r[l1v_adr_i[`ADR]][lru_r[`ADR]] = 1'b1;
                end
            end
            // Yazma
            else begin
                if(c_oku_tag0_w==l1v_adr_i[`TAG] || c_oku_tag1_w==l1v_adr_i[`TAG]) begin
                    lru_next_r[`ADR] = (c_oku_tag1_w==l1v_adr_i[`TAG]);
                    durum_next_r = BITTI;
                    dirty_next_r[l1v_adr_i[`ADR]][c_oku_tag1_w==l1v_adr_i[`TAG]] = 1'b1;
                    valid_next_r[l1v_adr_i[`ADR]][c_oku_tag1_w==l1v_adr_i[`TAG]] = 1'b1;
                end
                else begin
                    lru_next_r[`ADR] = ~lru_r[`ADR];
                    durum_next_r = BITTI;
                    dirty_next_r[l1v_adr_i[`ADR]][lru_r[`ADR]] = 1'b1;
                    valid_next_r[l1v_adr_i[`ADR]][lru_r[`ADR]] = 1'b1;
                end
            end
        end

        BELLEK_OKU: begin
            // Okuma
            if(!(|(l1v_veri_maske_i))) begin
                if(iomem_ready_i) begin
                    durum_next_r = CACHE_YAZ;
                    anabellek_adr_next_r = l1v_adr_i;
                    anabellek_veri_next_r = iomem_rdata_i;
                    anabellek_veri_kullan_next_r = 1'b1;
                end
            end
            // yazma
            else begin
                // TODO bunu kaldirabiliriz
                if(iomem_ready_i && ~(&l1v_veri_maske_i)) begin
                    durum_next_r = CACHE_YAZ;
                    anabellek_adr_next_r = l1v_adr_i;
                    case(l1v_veri_maske_i)
                        4'b0001: anabellek_veri_next_r = {iomem_rdata_i[31:24],iomem_rdata_i[23:16],iomem_rdata_i[15:8],l1v_veri_i   [7:0]};
                        4'b0010: anabellek_veri_next_r = {iomem_rdata_i[31:24],iomem_rdata_i[23:16],l1v_veri_i   [15:8],iomem_rdata_i[7:0]};
                        4'b0100: anabellek_veri_next_r = {iomem_rdata_i[31:24],l1v_veri_i   [23:16],iomem_rdata_i[15:8],iomem_rdata_i[7:0]};
                        4'b1000: anabellek_veri_next_r = {l1v_veri_i   [31:24],iomem_rdata_i[23:16],iomem_rdata_i[15:8],iomem_rdata_i[7:0]};
                        4'b0011: anabellek_veri_next_r = {iomem_rdata_i[31:24],iomem_rdata_i[23:16],l1v_veri_i   [15:8],l1v_veri_i   [7:0]};
                        4'b1100: anabellek_veri_next_r = {l1v_veri_i   [31:24],l1v_veri_i   [23:16],iomem_rdata_i[15:8],iomem_rdata_i[7:0]};
                        default: begin
                        end
                    endcase
                    anabellek_veri_kullan_next_r = 1'b1;
                end
            end
        end

        BELLEK_YAZ: begin
            // Okuma
            if(!(|(l1v_veri_maske_i))) begin
                if(iomem_ready_i)
                    durum_next_r = BELLEK_OKU;
            end
            // Yazma
            else begin
                if(iomem_ready_i)
                    durum_next_r = &l1v_veri_maske_i ? CACHE_YAZ : BELLEK_OKU;
            end
        end
        BITTI: begin
            durum_next_r = BEKLE;
        end
        default:begin
        end
    endcase
end

always @(posedge clk_i) begin
    l1v_veri_o <= bib_veri_next;
    if(rst_i) begin
        durum_r <= 0;
        valid_r[0] <= 0;
        valid_r[1] <= 0;
        dirty_r[0] <= 0;
        dirty_r[1] <= 0;
        anabellek_adr_r <= 0;
        anabellek_veri_r <= 0;
        anabellek_veri_kullan_r <= 0;
        basladi <= 1'b0;
        lru_r <= 0;
    end
    else begin
        durum_r <= durum_next_r;
        dirty_r[0] <= dirty_next_r[0];
        dirty_r[1] <= dirty_next_r[1];
        valid_r[0] <= valid_next_r[0];
        valid_r[1] <= valid_next_r[1];
        anabellek_adr_r <= anabellek_adr_next_r;
        anabellek_veri_r <= anabellek_veri_next_r;
        anabellek_veri_kullan_r <= anabellek_veri_kullan_next_r;
        basladi <= ~(durum_r == BEKLE);
        lru_r <= lru_next_r;
    end
end


always @(*) begin
    yaz_adres_next_r = yaz_adres_r;
    yaz_tag_next_r   = yaz_tag_r;
    cs_yaz0_next_r   = 1'b1;
    cs_yaz1_next_r   = 1'b1;
    yaz_en0_next_r   = yaz_en0_r;
    yaz_en1_next_r   = yaz_en1_r;
    cs_oku_next_r    = 1'b1;
    iomem_wdata_o_next_r    = iomem_wdata_o_r;
    iomem_addr_o_next_r   = iomem_addr_o_r;

    iomem_wstrb_o_next_r    = iomem_wstrb_o_r;

    case(durum_next_r)
        CACHE_YAZ: begin
            // Bellekten gelen veri yazilacak
            if(anabellek_veri_kullan_r) begin
                yaz_adres_next_r = anabellek_adr_r[`ADR];
                yaz_tag_next_r = anabellek_adr_r[`TAG];
            end
            // Bibden gelen veri yazilacak
            else begin
                yaz_adres_next_r = l1v_adr_i[`ADR];
                yaz_tag_next_r = l1v_adr_i[`TAG];
            end
            cs_oku_next_r = 1'b1;
            cs_yaz0_next_r = lru_r[`ADR] ? 1'b0 : 1'b1;
            yaz_en0_next_r = lru_r[`ADR] ? 1'b1 : 1'b0;
            cs_yaz1_next_r = ~lru_r[`ADR] ? 1'b0 : 1'b1;
            yaz_en1_next_r = ~lru_r[`ADR] ? 1'b1 : 1'b0;
        end

        CACHE_OKU: begin
            // Bellekten gelen veri okunacak
            if(anabellek_veri_kullan_r) begin
                yaz_adres_next_r = anabellek_adr_r[`ADR];
                yaz_tag_next_r = anabellek_adr_r[`TAG];
            end
            // Bibden gelen veri okunacak
            else begin
                yaz_adres_next_r = l1v_adr_i[`ADR];
                yaz_tag_next_r = l1v_adr_i[`TAG];
            end
            cs_oku_next_r = 1'b0;
            cs_yaz0_next_r = 1'b1;
            yaz_en0_next_r = 1'b0;
            cs_yaz1_next_r = 1'b1;
            yaz_en1_next_r = 1'b0;
        end

        BELLEK_OKU: begin
            iomem_addr_o_next_r  = l1v_adr_i;
            iomem_wdata_o_next_r   = 32'd0;
            iomem_wstrb_o_next_r   = 4'b0;
        end

        BELLEK_YAZ: begin
            iomem_addr_o_next_r  = anabellek_adr_r;
            iomem_wdata_o_next_r   = anabellek_veri_r;
            iomem_wstrb_o_next_r   = 4'b1111;
        end
        default:begin
        end
    endcase
end

always @(posedge clk_i) begin
    if(rst_i)begin
        yaz_adres_r <= 0;
        yaz_tag_r   <= 0;
        yaz_en0_r    <= 1'b0;
        yaz_en1_r    <= 1'b0;
        cs_oku_r    <= 1'b1;
        iomem_wstrb_o_r      <= 4'b0;
    end else begin
        yaz_adres_r <= yaz_adres_next_r;
        yaz_tag_r   <= yaz_tag_next_r;
        yaz_en0_r    <= yaz_en0_next_r;
        yaz_en1_r    <= yaz_en1_next_r;
        cs_oku_r    <= cs_oku_next_r;

        iomem_wstrb_o_r   <= iomem_wstrb_o_next_r;

        iomem_addr_o_r  <= iomem_addr_o_next_r;
        iomem_wdata_o_r   <= iomem_wdata_o_next_r ;

    end
end

endmodule
