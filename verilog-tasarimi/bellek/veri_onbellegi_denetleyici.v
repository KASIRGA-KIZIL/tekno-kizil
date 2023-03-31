`timescale 1ns / 1ps

`define TAGV 18:10
`define ADRV 9:2

module veri_onbellegi_denetleyici(
    input clk_i,
    input rst_i,
    // Bib <-> Buyruk Onbellegi Okuma
    output wire  [31:0] l1v_veri_o,
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
localparam  BOY = 2'b00, // Bekle, Cache Oku, Cache Yaz
            BELLEK_OKU = 2'b01,
            BELLEK_YAZ = 2'b10;

reg [1:0] durum_r;
reg [1:0] durum_next_r;

reg [255:0] valid_yol0_r, valid_yol0_next_r;
reg [255:0] valid_yol1_r, valid_yol1_next_r;

reg [255:0] dirty_yol0_r, dirty_yol0_next_r; 
reg [255:0] dirty_yol1_r, dirty_yol1_next_r; 

reg [255:0] lru_r, lru_next_r; 

// cache cikis sinyalleri
wire [31:0] data_out_yol0_w; 
wire [31:0] data_out_yol1_w;
wire [8:0] oku_tag_yol0_w;
wire [8:0] oku_tag_yol1_w;

// cache kontrol sinyalleri
reg yaz_en_yol0_r, yaz_en_yol0_next_r;
reg yaz_en_yol1_r, yaz_en_yol1_next_r;
reg [31:0] yaz_cache_veri_r, yaz_cache_veri_next_r;
reg [3:0] wmask_yaz_r, wmask_yaz_next_r;

// Bib output registerlari
reg [31:0] bib_veri_r, bib_veri_next_r;

// bellek output registerlari
reg [18:2] iomem_addr_r, iomem_addr_next_r; 
reg [31:0] iomem_wdata_r, iomem_wdata_next_r;

// Önbellek 1. yol
RAM256_Veri vo1(
    .CLK(clk_i),
    .RST(rst_i),
    .EN0(yaz_en_yol0_next_r),
    .WE0(wmask_yaz_next_r),
    .A0(l1v_adr_i[`ADRV]),
    .Di0({l1v_adr_i[`TAGV], yaz_cache_veri_next_r}),
    .Do0({oku_tag_yol0_w, data_out_yol0_w})
);

// Önbellek 2. yol
RAM256_Veri vo2(
    .CLK(clk_i),
    .RST(rst_i),
    .EN0(yaz_en_yol1_next_r),
    .WE0(wmask_yaz_next_r),
    .A0(l1v_adr_i[`ADRV]),
    .Di0({l1v_adr_i[`TAGV], yaz_cache_veri_next_r}),
    .Do0({oku_tag_yol1_w, data_out_yol1_w})
);

wire [7:0] ADRES = l1v_adr_i[`ADRV];

wire cache_valid_yol0_w = valid_yol0_r[ADRES]; 
wire cache_valid_yol1_w = valid_yol1_r[ADRES];

wire tag_hit_yol0_w = (l1v_adr_i[`TAGV]==oku_tag_yol0_w) && cache_valid_yol0_w; 
wire tag_hit_yol1_w = (l1v_adr_i[`TAGV]==oku_tag_yol1_w) && cache_valid_yol1_w;

wire cache_dirty_yol0_w = dirty_yol0_r[ADRES];
wire cache_dirty_yol1_w = dirty_yol1_r[ADRES];

wire lru_sec0_w = lru_r[ADRES];

assign iomem_valid_o = (durum_r == BELLEK_OKU) || (durum_r == BELLEK_YAZ);
assign iomem_wstrb_o = (durum_r == BELLEK_YAZ) ? 4'b1111 : 4'b0; 

assign l1v_veri_o = bib_veri_next_r;
assign l1v_durdur_o = (durum_next_r != BOY) || (durum_r != BOY);

assign iomem_addr_o = iomem_addr_r;
assign iomem_wdata_o = iomem_wdata_r;


always@* begin
    durum_next_r = durum_r;

    valid_yol0_next_r = valid_yol0_r;
    valid_yol1_next_r = valid_yol1_r;

    dirty_yol0_next_r = dirty_yol0_r;
    dirty_yol1_next_r = dirty_yol1_r;

    lru_next_r = lru_r;

    yaz_en_yol0_next_r = 1'b0;
    yaz_en_yol1_next_r = 1'b0;
    yaz_cache_veri_next_r = yaz_cache_veri_r;

    wmask_yaz_next_r = 4'd0;

    bib_veri_next_r = bib_veri_r;

    iomem_addr_next_r = iomem_addr_r;
    iomem_wdata_next_r = iomem_wdata_r;

    case(durum_r)
        BOY: begin
            // Yazma istegi
            if(l1v_sec_i && (|l1v_veri_maske_i)) begin
                if(cache_valid_yol0_w && tag_hit_yol0_w) begin
                    yaz_cache_veri_next_r = l1v_veri_i;
                    yaz_en_yol0_next_r = 1'b1;
                    wmask_yaz_next_r = l1v_veri_maske_i;
                    valid_yol0_next_r[ADRES] = 1'b1;
                    dirty_yol0_next_r[ADRES] = 1'b1;
                    lru_next_r[ADRES] = 1'b0;
                end

                if(cache_valid_yol1_w && tag_hit_yol1_w) begin
                    yaz_cache_veri_next_r = l1v_veri_i;
                    yaz_en_yol1_next_r = 1'b1;
                    wmask_yaz_next_r = l1v_veri_maske_i;
                    valid_yol1_next_r[ADRES] = 1'b1;
                    dirty_yol1_next_r[ADRES] = 1'b1;
                    lru_next_r[ADRES] = 1'b1;
                end

                // Hit yoksa lruya gore yaz
                if((((!tag_hit_yol0_w) && cache_valid_yol0_w) && ((!tag_hit_yol1_w) && cache_valid_yol1_w)) || (!cache_valid_yol1_w || !cache_valid_yol0_w)) begin
                    // LRU olmayan Kirli
                    if((lru_sec0_w && cache_dirty_yol0_w) || (!lru_sec0_w && cache_dirty_yol1_w)) begin
                        durum_next_r = BELLEK_YAZ;
                        iomem_wdata_next_r = lru_sec0_w ? data_out_yol0_w : data_out_yol1_w;
                        iomem_addr_next_r = lru_sec0_w ? {oku_tag_yol0_w,l1v_adr_i[`ADRV]} 
                                                            : {oku_tag_yol1_w,l1v_adr_i[`ADRV]};
                    end

                    // LRU olmayan temiz ve word yazilacak
                    if(((lru_sec0_w && !cache_dirty_yol0_w) || (!lru_sec0_w && !cache_dirty_yol1_w)) && (&l1v_veri_maske_i)) begin
                        yaz_cache_veri_next_r = l1v_veri_i;
                        yaz_en_yol0_next_r = lru_sec0_w;
                        yaz_en_yol1_next_r = !lru_sec0_w;
                        wmask_yaz_next_r = 4'b1111;
                        valid_yol0_next_r[ADRES] = lru_sec0_w ? 1'b1 : valid_yol0_r[ADRES];
                        dirty_yol0_next_r[ADRES] = lru_sec0_w ? 1'b1 : valid_yol0_r[ADRES];
                        valid_yol1_next_r[ADRES] = ~lru_sec0_w ? 1'b1 : valid_yol1_r[ADRES];
                        dirty_yol1_next_r[ADRES] = ~lru_sec0_w ? 1'b1 : valid_yol1_r[ADRES];
                        lru_next_r[ADRES] = ~lru_r[ADRES];
                    end

                    // LRU olmayan temiz ama word yazilmayacak, geri kalan bytelarin bellekten okunmasi gerek
                    if(((lru_sec0_w && !cache_dirty_yol0_w) || (!lru_sec0_w && !cache_dirty_yol1_w)) && ~(&l1v_veri_maske_i)) begin
                        durum_next_r = BELLEK_OKU;
                        iomem_addr_next_r = l1v_adr_i;
                    end
                end            
            end

            // Okuma istegi
            if(l1v_sec_i && ~(|l1v_veri_maske_i)) begin
                if(cache_valid_yol0_w && tag_hit_yol0_w) begin
                    bib_veri_next_r = data_out_yol0_w;
                    lru_next_r[ADRES] = 1'b0;
                end

                if(cache_valid_yol1_w && tag_hit_yol1_w) begin
                    bib_veri_next_r = data_out_yol1_w;
                    lru_next_r[ADRES] = 1'b1;
                end

                if((((!tag_hit_yol0_w) && cache_valid_yol0_w) && ((!tag_hit_yol1_w) && cache_valid_yol1_w)) || (!cache_valid_yol1_w || !cache_valid_yol0_w)) begin
                    // LRU olmayan Kirli
                    if((lru_sec0_w && cache_dirty_yol0_w) || (!lru_sec0_w && cache_dirty_yol1_w)) begin
                        durum_next_r = BELLEK_YAZ;
                        iomem_wdata_next_r = lru_sec0_w ? data_out_yol0_w : data_out_yol1_w;
                        iomem_addr_next_r = lru_sec0_w ? {oku_tag_yol0_w,l1v_adr_i[`ADRV]} 
                                                            : {oku_tag_yol1_w,l1v_adr_i[`ADRV]};
                    end

                    // LRU olmayan temiz 
                    if(((lru_sec0_w && !cache_dirty_yol0_w) || (!lru_sec0_w && !cache_dirty_yol1_w))) begin
                        durum_next_r = BELLEK_OKU;
                        iomem_addr_next_r = l1v_adr_i;
                    end
                end

            end
        end

        BELLEK_OKU: begin
            // okuma
            if(!(|l1v_veri_maske_i)) begin
                if(iomem_ready_i) begin
                    durum_next_r = BOY;
                    // Okunan veriyi cache'e yaz
                    yaz_cache_veri_next_r = iomem_rdata_i;
                    yaz_en_yol0_next_r = lru_sec0_w;
                    yaz_en_yol1_next_r = !lru_sec0_w;
                    wmask_yaz_next_r = 4'b1111;
                    valid_yol0_next_r[ADRES] = lru_sec0_w ? 1'b1 : valid_yol0_r[ADRES];
                    dirty_yol0_next_r[ADRES] = lru_sec0_w ? 1'b0 : valid_yol0_r[ADRES];
                    valid_yol1_next_r[ADRES] = ~lru_sec0_w ? 1'b1 : valid_yol1_r[ADRES];
                    dirty_yol1_next_r[ADRES] = ~lru_sec0_w ? 1'b0 : valid_yol1_r[ADRES];
                    lru_next_r[ADRES] = ~lru_r[ADRES];
                    // veriyi cikisa ver
                    bib_veri_next_r = iomem_rdata_i;
                end
            end
            // yazma
            else begin
                if(iomem_ready_i && ~(&l1v_veri_maske_i)) begin
                    durum_next_r = BOY;
                    // Okunan veriyi cache'e yaz
                    yaz_en_yol0_next_r = lru_sec0_w;
                    yaz_en_yol1_next_r = !lru_sec0_w;
                    wmask_yaz_next_r = 4'b1111;
                    case(l1v_veri_maske_i)
                        4'b0001: yaz_cache_veri_next_r = {iomem_rdata_i[31:24],iomem_rdata_i[23:16],iomem_rdata_i[15:8],l1v_veri_i   [7:0]};
                        4'b0010: yaz_cache_veri_next_r = {iomem_rdata_i[31:24],iomem_rdata_i[23:16],l1v_veri_i   [15:8],iomem_rdata_i[7:0]};
                        4'b0100: yaz_cache_veri_next_r = {iomem_rdata_i[31:24],l1v_veri_i   [23:16],iomem_rdata_i[15:8],iomem_rdata_i[7:0]};
                        4'b1000: yaz_cache_veri_next_r = {l1v_veri_i   [31:24],iomem_rdata_i[23:16],iomem_rdata_i[15:8],iomem_rdata_i[7:0]};
                        4'b0011: yaz_cache_veri_next_r = {iomem_rdata_i[31:24],iomem_rdata_i[23:16],l1v_veri_i   [15:8],l1v_veri_i   [7:0]};
                        4'b1100: yaz_cache_veri_next_r = {l1v_veri_i   [31:24],l1v_veri_i   [23:16],iomem_rdata_i[15:8],iomem_rdata_i[7:0]};
                        default: begin
                        end
                    endcase
                    valid_yol0_next_r[ADRES] = lru_sec0_w ? 1'b1 : valid_yol0_r[ADRES];
                    dirty_yol0_next_r[ADRES] = lru_sec0_w ? 1'b0 : valid_yol0_r[ADRES];
                    valid_yol1_next_r[ADRES] = ~lru_sec0_w ? 1'b1 : valid_yol1_r[ADRES];
                    dirty_yol1_next_r[ADRES] = ~lru_sec0_w ? 1'b0 : valid_yol1_r[ADRES];
                    lru_next_r[ADRES] = ~lru_r[ADRES];
                end
            end
        end

        BELLEK_YAZ: begin
            // okuma
            if(!(|(l1v_veri_maske_i))) begin
                if(iomem_ready_i) begin
                    durum_next_r = BELLEK_OKU;
                    iomem_addr_next_r = l1v_adr_i;
                end
            end
            // Yazma
            else begin
                if(iomem_ready_i) begin
                    if(&l1v_veri_maske_i) begin
                        durum_next_r = BOY;
                        // Bib'in verisini cache'e yaz
                        yaz_en_yol0_next_r = lru_sec0_w;
                        yaz_en_yol1_next_r = !lru_sec0_w;
                        yaz_cache_veri_next_r = l1v_veri_i;
                        valid_yol0_next_r[ADRES] = lru_sec0_w ? 1'b1 : valid_yol0_r[ADRES];
                        dirty_yol0_next_r[ADRES] = lru_sec0_w ? 1'b1 : valid_yol0_r[ADRES];
                        valid_yol1_next_r[ADRES] = ~lru_sec0_w ? 1'b1 : valid_yol1_r[ADRES];
                        dirty_yol1_next_r[ADRES] = ~lru_sec0_w ? 1'b1 : valid_yol1_r[ADRES];
                        lru_next_r[ADRES] = ~lru_r[ADRES];
                    end 
                    
                    if(~(&l1v_veri_maske_i)) begin
                        durum_next_r = BELLEK_OKU;
                        // Byte okuma istegini bellekten oku
                        iomem_addr_next_r = l1v_adr_i;
                    end
                end
            end
        end

    endcase
end

always@(posedge clk_i) begin
    if(rst_i) begin
        durum_r <= BOY;
        valid_yol0_r <= 256'd0;
        valid_yol1_r <= 256'd0;
        dirty_yol0_r <= 256'd0;
        dirty_yol1_r <= 256'd0;
        lru_r <= 256'd0;
        yaz_en_yol0_r <= 1'b0;
        yaz_en_yol1_r <= 1'b0;
        yaz_cache_veri_r <= 32'd0;
        wmask_yaz_r <= 4'b0;
        bib_veri_r <= 32'd0;
        iomem_addr_r <= 17'd0;
        iomem_wdata_r <= 32'd0;
    end
    else begin
        durum_r <= durum_next_r;
        valid_yol0_r <= valid_yol0_next_r;
        valid_yol1_r <= valid_yol1_next_r;
        dirty_yol0_r <= dirty_yol0_next_r;
        dirty_yol1_r <= dirty_yol1_next_r;
        lru_r <= lru_next_r;
        yaz_en_yol0_r <= yaz_en_yol0_next_r;
        yaz_en_yol1_r <= yaz_en_yol1_next_r;
        yaz_cache_veri_r <= yaz_cache_veri_next_r;
        wmask_yaz_r <= wmask_yaz_next_r;
        bib_veri_r <= bib_veri_next_r;
        iomem_addr_r <= iomem_addr_next_r;
        iomem_wdata_r <= iomem_wdata_next_r;
    end
    
end

endmodule
