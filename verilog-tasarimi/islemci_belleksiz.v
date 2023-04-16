// user_processor.v (islemci)
`timescale 1ns / 1ps


// CEKIRDEK+VERIYOLU
module islemci_belleksiz(
   input clk,
   input resetn,
   
   // Ana bellek Arayuzu
   output wire        iomem_valid,
   input  wire        iomem_ready,
   output wire [ 3:0] iomem_wstrb,
   output wire [31:0] iomem_addr,
   output wire [31:0] iomem_wdata,
   input  wire [31:0] iomem_rdata,
   
   output wire [7:0] l1b_tag_adr_o,
   
   // Veri onbellegi Arayuzu
   output wire        yol0_EN0,
   output wire        yol1_EN0,
   output wire [ 7:0] yol_A0 ,
   output wire [40:0] yol_Di0,
   input  wire [40:0] yol0_Do0,
   input  wire [40:0] yol1_Do0,
   output wire [ 3:0] yol_WE0,
   
   // dirty+lru+valid arayuzu
   input  wire lru_i,
   output wire lru_o,
   input  wire yol0_valid_i,
   output wire yol0_valid_o,
   input  wire yol0_dirty_i,
   output wire yol0_dirty_o,
   input  wire yol1_valid_i,
   output wire yol1_valid_o,
   input  wire yol1_dirty_i,
   output wire yol1_dirty_o,
   
   // RAM256_T0
   output wire       we0_o,
   output wire [7:0] adr0_o,
   input  wire [7:0] datao0_i,
   // RAM256_T1
   output wire       we1_o,
   output wire [7:0] adr1_o,
   input  wire [7:0] datao1_i,
   // RAM512_D0
   output wire        ram512d0_we0_o,
   output wire [ 8:0] ram512d0_adr0_o,
   input  wire [15:0] ram512d0_datao0_i,
   // RAM512_D1
   output wire        ram512d1_we0_o,
   output wire [ 8:0] ram512d1_adr0_o,
   input  wire [15:0] ram512d1_datao0_i,
   
   
   // Cevre birimi sinyalleri
   output wire uart_tx_o,
   input  wire uart_rx_i,
   
   output wire spi_cs_o,
   output wire spi_sck_o,
   output wire spi_mosi_o,
   input  wire spi_miso_i,
   
   output wire pwm0_o,
   output wire pwm1_o
);
   wire clk_i = clk;
   wire rst_i = ~resetn;
   
   // Bellek Islem Birimi sinyalleri
   wire [31:0] bib_yaz_veri;
   wire [31:0] bib_oku_veri;
   wire [31:0] bib_adr;
   wire [ 3:0] bib_mask;
   wire        bib_durdur;
   wire        bib_sec;
   
   // L1 BUyruk onbellegi sinyalleri
   wire        l1b_bekle;
   wire [31:0] l1b_deger;
   wire [18:1] l1b_adres;
   
   assign l1b_tag_adr_o = l1b_adres[18:11];
   
   // L1 Veri onbellegi sinyalleri
   wire [31:0] l1v_oku_veri;
   wire        l1v_sec;
   wire        l1v_durdur;
   
   // Veriyolu sinyalleri
   wire [31:0] vy_oku_veri;
   wire        vy_sec;
   wire        vy_durdur;
   
   // Timer sinyalleri
   wire [31:0] tmr_oku_veri;
   wire        tmr_sec;
   
   // L1 veri onbellegi <-> anabellek denetleyici
   wire        l1v_iomem_valid;
   wire        l1v_iomem_ready;
   wire [ 3:0] l1v_iomem_wstrb;
   wire [18:2] l1v_iomem_addr;
   wire [31:0] l1v_iomem_wdata;
   wire [31:0] l1v_iomem_rdata;
   
   // L1 buyruk onbellegi <-> anabellek denetleyici
   wire        l1b_iomem_valid;
   wire        l1b_iomem_ready;
   wire [18:2] l1b_iomem_addr;
   wire [31:0] l1b_iomem_rdata;
   
   // ISLEMCI+VERIYOLU
   cekirdek cek (
      .clk_i (clk_i),
      .rst_i (rst_i),
      //
      .l1b_bekle_i        (l1b_bekle          ),
      .l1b_deger_i        (l1b_deger          ),
      .l1b_adres_o        (l1b_adres          ),
      //
      .bib_veri_i       (bib_oku_veri     ),
      .bib_durdur_i     (bib_durdur       ),
      .bib_veri_o       (bib_yaz_veri     ),
      .bib_adr_o        (bib_adr          ),
      .bib_veri_maske_o (bib_mask         ),
      .bib_sec_o        (bib_sec          )
   );
   
   buyruk_onbellegi_denetleyici buyruk_onbellegi_denetleyici_dut (
      .clk_i (clk_i ),
      .rst_i (rst_i ),
      
      .iomem_valid   (l1b_iomem_valid),
      .iomem_ready   (l1b_iomem_ready),
      .iomem_addr    (l1b_iomem_addr ),
      
      .l1b_bekle_o   (l1b_bekle),
      .l1b_deger_o   (l1b_deger),
      .l1b_adres_i   (l1b_adres),
      
      .we0_o    (we0_o    ),
      .adr0_o   (adr0_o   ),
      .datao0_i (datao0_i ),
      
      .we1_o    (we1_o    ),
      .adr1_o   (adr1_o   ),
      .datao1_i (datao1_i ),
      
      .ram512d0_we0_o    (ram512d0_we0_o    ),
      .ram512d0_adr0_o   (ram512d0_adr0_o   ),
      .ram512d0_datao0_i (ram512d0_datao0_i ),
      
      .ram512d1_we0_o    (ram512d1_we0_o    ),
      .ram512d1_adr0_o   (ram512d1_adr0_o   ),
      .ram512d1_datao0_i (ram512d1_datao0_i )
   );
   
   // ADDRESS Araligina gore secme sinyalleri
   assign l1v_sec = bib_adr[30]               ? bib_sec : 1'b0;
   assign vy_sec  = bib_adr[29]&&~bib_adr[28] ? bib_sec : 1'b0;
   assign tmr_sec = bib_adr[28]               ? bib_sec : 1'b0;
   
   // Durdur sinyalinin nereden cekirdege iletilecegi adres araligina gore secilir
   assign bib_durdur = bib_adr[30] ? l1v_durdur :
                       bib_adr[28] ?   1'b0     :
                                     vy_durdur  ;
   // Okunan verinin nereden cekirdege iletilecegi adres araligina gore secilir
   assign bib_oku_veri  = bib_adr[30] ? l1v_oku_veri :
                          bib_adr[28] ? tmr_oku_veri :
                                        vy_oku_veri  ;
   
   veri_onbellegi_denetleyici veri_onbellegi_denetleyici_dut (
      .clk_i (clk_i ),
      .rst_i (rst_i ),
      
      .l1v_veri_o        (l1v_oku_veri   ),
      .l1v_durdur_o      (l1v_durdur     ),
      .l1v_veri_i        (bib_yaz_veri   ),
      .l1v_adr_i         (bib_adr[18:2]  ),
      .l1v_veri_maske_i  (bib_mask       ),
      .l1v_sec_i         (l1v_sec        ),
      
      .iomem_ready_i (l1v_iomem_ready ),
      .iomem_valid_o (l1v_iomem_valid ),
      .iomem_wstrb_o (l1v_iomem_wstrb ),
      .iomem_addr_o  (l1v_iomem_addr  ),
      .iomem_wdata_o (l1v_iomem_wdata ),
      .iomem_rdata_i (l1v_iomem_rdata ),
      
      .yol0_EN0 (yol0_EN0 ),
      .yol1_EN0 (yol1_EN0 ),
      .yol_A0   (yol_A0   ),
      .yol_Di0  (yol_Di0  ),
      .yol0_Do0 (yol0_Do0 ),
      .yol1_Do0 (yol1_Do0 ),
      .yol_WE0  (yol_WE0  ),
      
      .lru_i (lru_i ),
      .lru_o (lru_o ),
      .yol0_valid_i (yol0_valid_i ),
      .yol0_valid_o (yol0_valid_o ),
      .yol0_dirty_i (yol0_dirty_i ),
      .yol0_dirty_o (yol0_dirty_o ),
      .yol1_valid_i (yol1_valid_i ),
      .yol1_valid_o (yol1_valid_o ),
      .yol1_dirty_i (yol1_dirty_i ),
      .yol1_dirty_o  ( yol1_dirty_o)
   );
   
   // TIMER, L1B, L1V <-> Anabellek konusmasini kontrol eder
   anabellek_denetleyici abdd (
      .clk_i (clk_i ),
      .rst_i (rst_i ),
      
      .iomem_valid (iomem_valid ),
      .iomem_ready (iomem_ready ),
      .iomem_wstrb (iomem_wstrb ),
      .iomem_addr  (iomem_addr  ),
      .iomem_wdata (iomem_wdata ),
      .iomem_rdata (iomem_rdata ),
      
      .timer_iomem_valid (tmr_sec     ),
      .timer_iomem_addr  (bib_adr     ),
      .timer_iomem_rdata (tmr_oku_veri),
      
      .l1b_iomem_valid (l1b_iomem_valid ),
      .l1b_iomem_ready (l1b_iomem_ready ),
      .l1b_iomem_addr  (l1b_iomem_addr  ),
      .l1b_iomem_rdata (l1b_iomem_rdata ),
      
      .l1v_iomem_valid (l1v_iomem_valid ),
      .l1v_iomem_ready (l1v_iomem_ready ),
      .l1v_iomem_wstrb (l1v_iomem_wstrb ),
      .l1v_iomem_addr  (l1v_iomem_addr  ),
      .l1v_iomem_wdata (l1v_iomem_wdata ),
      .l1v_iomem_rdata (l1v_iomem_rdata )
   );
   
   // Wishbone master <-> UART, PWM, SPI
   veriyolu  veriyolu_dut (
      .clk_i (clk_i ),
      .rst_i (rst_i ),
      .vy_veri_o        (vy_oku_veri    ),
      .vy_durdur_o      (vy_durdur      ),
      .vy_veri_i        (bib_yaz_veri   ),
      .vy_adres_i       (bib_adr        ),
      .vy_veri_maske_i  (bib_mask       ),
      .vy_sec_i         (vy_sec         ),
      .uart_tx_o (uart_tx_o ),
      .uart_rx_i (uart_rx_i ),
      .spi_cs_o   (spi_cs_o   ),
      .spi_sck_o  (spi_sck_o  ),
      .spi_mosi_o (spi_mosi_o ),
      .spi_miso_i (spi_miso_i ),
      .pwm0_o (pwm0_o ),
      .pwm1_o (pwm1_o )
   );

endmodule
