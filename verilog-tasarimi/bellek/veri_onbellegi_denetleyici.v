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
   input              iomem_ready_i,
   
   // veri+tag Arayuzu
   output wire        yol0_EN0,
   output wire        yol1_EN0,
   output wire [ 7:0] yol_A0 ,
   output wire [40:0] yol_Di0,
   input  wire [40:0] yol0_Do0,
   input  wire [40:0] yol1_Do0,
   output wire [ 3:0] yol_WE0,
   
   // dirty+lru+valid arayuzu
   input  wire lru_i,
   output reg  lru_o,
   input  wire yol0_valid_i,
   output reg  yol0_valid_o,
   input  wire yol0_dirty_i,
   output reg  yol0_dirty_o,
   input  wire yol1_valid_i,
   output reg  yol1_valid_o,
   input  wire yol1_dirty_i,
   output reg  yol1_dirty_o
);

   localparam  RESET      = 2'b00, // Onbellekleri Resetle
               BOY        = 2'b01, // Bekle, Cache Oku, Cache Yaz
               BELLEK_OKU = 2'b10, // Bellek Oku
               BELLEK_YAZ = 2'b11; // BelleK Yaz
   
   reg [1:0] durum_r;
   reg [1:0] durum_next_r;
   
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
   
   // Sifirlama sayaci
   reg [7:0] counter;
   
   wire [7:0] ADRES = l1v_adr_i[`ADRV];
   
   wire cache_valid_yol0_w = yol0_valid_i;
   wire cache_valid_yol1_w = yol1_valid_i;
   
   wire tag_hit_yol0_w = (l1v_adr_i[`TAGV]==oku_tag_yol0_w) && cache_valid_yol0_w;
   wire tag_hit_yol1_w = (l1v_adr_i[`TAGV]==oku_tag_yol1_w) && cache_valid_yol1_w;
   
   wire cache_dirty_yol0_w = yol0_dirty_i;
   wire cache_dirty_yol1_w = yol1_dirty_i;
   
   wire lru_sec0_w = lru_i;
   
   wire hit_yol0 = (cache_valid_yol0_w && tag_hit_yol0_w);
   wire hit_yol1 = (cache_valid_yol1_w && tag_hit_yol1_w);
   
   assign yol0_EN0 = yaz_en_yol0_next_r;
   assign yol1_EN0 = yaz_en_yol1_next_r;
   assign yol_WE0  = wmask_yaz_next_r;
   assign yol_A0   = (durum_r == RESET) ? counter : l1v_adr_i[`ADRV];
   assign yol_Di0  = {l1v_adr_i[`TAGV], yaz_cache_veri_next_r};
   assign {oku_tag_yol0_w, data_out_yol0_w} =  yol0_Do0;
   assign {oku_tag_yol1_w, data_out_yol1_w} =  yol1_Do0;
   
   assign iomem_valid_o = (durum_r == BELLEK_OKU) || (durum_r == BELLEK_YAZ);
   assign iomem_wstrb_o = (durum_r == BELLEK_YAZ) ? 4'b1111 : 4'b0;
   
   assign l1v_veri_o = bib_veri_next_r;
   assign l1v_durdur_o = (durum_next_r != BOY) || (durum_r != BOY);
   
   assign iomem_addr_o = iomem_addr_r;
   assign iomem_wdata_o = iomem_wdata_r;
   
   always@* begin
      durum_next_r = durum_r;
      
      yaz_en_yol0_next_r = 1'b0;
      yaz_en_yol1_next_r = 1'b0;
      yaz_cache_veri_next_r = yaz_cache_veri_r;
      
      wmask_yaz_next_r = 4'd0;
      
      bib_veri_next_r = bib_veri_r;
      
      iomem_addr_next_r = iomem_addr_r;
      iomem_wdata_next_r = iomem_wdata_r;
      
      yol0_valid_o = 1'b0;
      yol1_valid_o = 1'b0;
      yol0_dirty_o = 1'b0;
      yol1_dirty_o = 1'b0;
      lru_o        = 1'b0;
      case(durum_r)
         RESET: begin
            yol0_valid_o = 1'b0;
            yol1_valid_o = 1'b0;
            yol0_dirty_o = 1'b0;
            yol1_dirty_o = 1'b0;
            lru_o        = 1'b0;
            
            yaz_en_yol0_next_r = 1'b1;
            yaz_en_yol1_next_r = 1'b1;
            durum_next_r = (counter == 8'hff) ? BOY : RESET;
         end
         BOY: begin
            // Yazma (Store) istegi
            if(l1v_sec_i && (|l1v_veri_maske_i)) begin
               if(hit_yol0) begin
                  yaz_cache_veri_next_r = l1v_veri_i;
                  yaz_en_yol0_next_r = 1'b1;
                  wmask_yaz_next_r = l1v_veri_maske_i;
                  yol0_valid_o = 1'b1;
                  yol0_dirty_o = 1'b1;
                  lru_o = 1'b0;
               end
               
               if(hit_yol1) begin
                  yaz_cache_veri_next_r = l1v_veri_i;
                  yaz_en_yol1_next_r = 1'b1;
                  wmask_yaz_next_r = l1v_veri_maske_i;
                  yol1_valid_o = 1'b1;
                  yol1_dirty_o = 1'b1;
                  lru_o = 1'b1;
               end
               
               // Hit yoksa lruya gore yaz
               if(~hit_yol0 & ~hit_yol1) begin
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
                     yol0_valid_o = lru_sec0_w ? 1'b1 : yol0_valid_i;
                     yol0_dirty_o = lru_sec0_w ? 1'b1 : yol0_valid_i;
                     yol1_valid_o = ~lru_sec0_w ? 1'b1 : yol1_valid_i;
                     yol1_dirty_o = ~lru_sec0_w ? 1'b1 : yol1_valid_i;
                     lru_o = ~lru_i;
                  end
                  
                  // LRU olmayan temiz ama word yazilmayacak, geri kalan bytelarin bellekten okunmasi gerek
                  if(((lru_sec0_w && !cache_dirty_yol0_w) || (!lru_sec0_w && !cache_dirty_yol1_w)) && ~(&l1v_veri_maske_i)) begin
                     durum_next_r = BELLEK_OKU;
                     iomem_addr_next_r = l1v_adr_i;
                  end
               end
            end
            
            // Okuma (Load) istegi
            if(l1v_sec_i && ~(|l1v_veri_maske_i)) begin
               if(hit_yol0) begin
                  bib_veri_next_r = data_out_yol0_w;
                  lru_o = 1'b0;
               end
               
               if(hit_yol1) begin
                  bib_veri_next_r = data_out_yol1_w;
                  lru_o = 1'b1;
               end
               
               if(~hit_yol0 & ~hit_yol1) begin
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
            // Okuma (Load) istegi
            if(!(|l1v_veri_maske_i)) begin
               if(iomem_ready_i) begin
                  durum_next_r = BOY;
                  // Okunan veriyi cache'e yaz
                  yaz_cache_veri_next_r = iomem_rdata_i;
                  yaz_en_yol0_next_r = lru_sec0_w;
                  yaz_en_yol1_next_r = !lru_sec0_w;
                  wmask_yaz_next_r = 4'b1111;
                  yol0_valid_o = lru_sec0_w ? 1'b1 : yol0_valid_i;
                  yol0_dirty_o = lru_sec0_w ? 1'b0 : yol0_valid_i;
                  yol1_valid_o = ~lru_sec0_w ? 1'b1 : yol1_valid_i;
                  yol1_dirty_o = ~lru_sec0_w ? 1'b0 : yol1_valid_i;
                  lru_o = ~lru_i;
                  // veriyi cikisa ver
                  bib_veri_next_r = iomem_rdata_i;
               end
            end
            // Yazma (Store) istegi
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
                  yol0_valid_o =  lru_sec0_w ? 1'b1 : yol0_valid_i;
                  yol0_dirty_o =  lru_sec0_w ? 1'b0 : yol0_valid_i;
                  yol1_valid_o = ~lru_sec0_w ? 1'b1 : yol1_valid_i;
                  yol1_dirty_o = ~lru_sec0_w ? 1'b0 : yol1_valid_i;
                  lru_o = ~lru_i;
               end
            end
         end
         
         BELLEK_YAZ: begin
            // Okuma (Load) istegi
            if(!(|(l1v_veri_maske_i))) begin
               if(iomem_ready_i) begin
                  durum_next_r = BELLEK_OKU;
                  iomem_addr_next_r = l1v_adr_i;
               end
            end
            // Yazma (Store) istegi
            else begin
               if(iomem_ready_i) begin
                  if(&l1v_veri_maske_i) begin
                     durum_next_r = BOY;
                     // Bib'in verisini cache'e yaz
                     yaz_en_yol0_next_r =  lru_sec0_w;
                     yaz_en_yol1_next_r = !lru_sec0_w;
                     yaz_cache_veri_next_r = l1v_veri_i;
                     yol0_valid_o =  lru_sec0_w ? 1'b1 : yol0_valid_i;
                     yol0_dirty_o =  lru_sec0_w ? 1'b1 : yol0_valid_i;
                     yol1_valid_o = ~lru_sec0_w ? 1'b1 : yol1_valid_i;
                     yol1_dirty_o = ~lru_sec0_w ? 1'b1 : yol1_valid_i;
                     lru_o = ~lru_i;
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
         durum_r <= RESET;
         yaz_en_yol0_r <= 1'b0;
         yaz_en_yol1_r <= 1'b0;
         wmask_yaz_r <= 4'b0;
         counter     <= 8'b0;
      end
      else begin
         counter <= (counter != 8'hff) ? (counter + 8'b1) : counter;
         durum_r <= durum_next_r;
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
