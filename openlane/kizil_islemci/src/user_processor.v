// user_processor.v (islemci)
`timescale 1ns / 1ps

`include "tanimlamalar.vh"

module user_processor(
   input wire clk,
   input wire resetn,
   
   output wire        iomem_valid,
   input  wire        iomem_ready,
   output wire [ 3:0] iomem_wstrb,
   output wire [31:0] iomem_addr,
   output wire [31:0] iomem_wdata,
   input  wire [31:0] iomem_rdata,
   
   output wire uart_tx_o,
   input  wire uart_rx_i,
   
   output wire spi_cs_o,
   output wire spi_sck_o,
   output wire spi_mosi_o,
   input  wire spi_miso_i,
   
   output wire pwm0_o,
   output wire pwm1_o
);

   wire        yol0_EN0;
   wire        yol1_EN0;
   wire [ 7:0] yol_A0 ;
   wire [40:0] yol_Di0;
   wire [40:0] yol0_Do0;
   wire [40:0] yol1_Do0;
   wire [ 3:0] yol_WE0;
   
   wire lru_din;
   wire lru_ddo;
   wire yol0_valid_din;
   wire yol0_valid_ddo;
   wire yol0_dirty_din;
   wire yol0_dirty_ddo;
   wire yol1_valid_din;
   wire yol1_valid_ddo;
   wire yol1_dirty_din;
   wire yol1_dirty_ddo;
   
   wire  we0;
   wire [7:0] adr0;
   wire [7:0] datai0;
   wire [7:0] datao0;
   
   wire  we1;
   wire [7:0] adr1;
   wire [7:0] datai1;
   wire [7:0] datao1;
   
   wire        ram512d0_we0;
   wire [ 8:0] ram512d0_adr0;
   wire [15:0] ram512d0_datai0;
   wire [15:0] ram512d0_datao0;
   
   wire        ram512d1_we0;
   wire [ 8:0] ram512d1_adr0;
   wire [15:0] ram512d1_datai0;
   wire [15:0] ram512d1_datao0;
   
   wire [7:0] l1b_tag_adr;
   
   // CEKIRDEK+VERIYOLU
   islemci_belleksiz isl_blksiz (
      .clk (clk ),
      .resetn (resetn ),
      
      .iomem_valid (iomem_valid ),
      .iomem_ready (iomem_ready ),
      .iomem_wstrb (iomem_wstrb ),
      .iomem_addr  (iomem_addr  ),
      .iomem_wdata (iomem_wdata ),
      .iomem_rdata (iomem_rdata ),
      
      .l1b_tag_adr_o(l1b_tag_adr),
      
      .yol0_EN0 (yol0_EN0 ),
      .yol1_EN0 (yol1_EN0 ),
      .yol_A0   (yol_A0   ),
      .yol_Di0  (yol_Di0  ),
      .yol0_Do0 (yol0_Do0 ),
      .yol1_Do0 (yol1_Do0 ),
      .yol_WE0  (yol_WE0  ),
      
      .lru_i (lru_din ),
      .lru_o (lru_ddo ),
      .yol0_valid_i (yol0_valid_din ),
      .yol0_valid_o (yol0_valid_ddo ),
      .yol0_dirty_i (yol0_dirty_din ),
      .yol0_dirty_o (yol0_dirty_ddo ),
      .yol1_valid_i (yol1_valid_din ),
      .yol1_valid_o (yol1_valid_ddo ),
      .yol1_dirty_i (yol1_dirty_din ),
      .yol1_dirty_o (yol1_dirty_ddo ),
      
      .we0_o    (we0    ),
      .adr0_o   (adr0   ),
      .datao0_i (datao0 ),
      
      .we1_o    (we1    ),
      .adr1_o   (adr1   ),
      .datao1_i (datao1 ),
      
      .ram512d0_we0_o    (ram512d0_we0    ),
      .ram512d0_adr0_o   (ram512d0_adr0   ),
      .ram512d0_datao0_i (ram512d0_datao0 ),
      .ram512d1_we0_o    (ram512d1_we0    ),
      .ram512d1_adr0_o   (ram512d1_adr0   ),
      .ram512d1_datao0_i (ram512d1_datao0 ),
      
      .uart_tx_o (uart_tx_o ),
      .uart_rx_i (uart_rx_i ),
      
      .spi_cs_o   (spi_cs_o   ),
      .spi_sck_o  (spi_sck_o  ),
      .spi_mosi_o (spi_mosi_o ),
      .spi_miso_i (spi_miso_i ),
      
      .pwm0_o  (pwm0_o ),
      .pwm1_o  (pwm1_o )
   );
   
   // RAM isimleri:
   //    d0   -> data bellegi 0 inci bank
   //    t0   -> tag  bellegi 0 inci bank
   //    t0_1 -> tag  bellegi 0 inci bank 1 inci parca
   
   RAM512x16_ASYNC`GATE RAM512_d0 (
      .CLK(clk),
      .A0(ram512d0_adr0),
      .Di0(iomem_rdata[15:0]),
      .Do0(ram512d0_datao0),
      .WE0({ram512d0_we0,ram512d0_we0})
   );
   
   RAM512x16_ASYNC`GATE RAM512_d1 (
      .CLK(clk),
      .A0(ram512d1_adr0),
      .Di0(iomem_rdata[31:16]),
      .Do0(ram512d1_datao0),
      .WE0({ram512d1_we0,ram512d1_we0})
   );
   
   RAM256x8_ASYNC`GATE bffram_t0( // even
      .CLK(clk),
      .A0(adr0),
      .Di0(l1b_tag_adr),
      .Do0(datao0),
      .WE0(we0)
   );
   
   RAM256x8_ASYNC`GATE bffram_t1( // odd
      .CLK(clk),
      .A0(adr1),
      .Di0(l1b_tag_adr),
      .Do0(datao1),
      .WE0(we1)
   );
   
   RAM256x8_ASYNC`GATE vffram_t0_0(
      .CLK(clk),
      .A0 (yol_A0  ),
      .Di0(yol_Di0 [39:32]),
      .Do0(yol0_Do0[39:32]),
      .WE0(yol0_EN0)
   );
   
   RAM256x8_ASYNC`GATE vffram_t1_0(
      .CLK(clk),
      .A0 (yol_A0  ),
      .Di0(yol_Di0 [39:32]),
      .Do0(yol1_Do0[39:32]),
      .WE0(yol1_EN0)
   );
   
   
   RAM256x16_ASYNC`GATE vffram_d0_0(
      .CLK(clk),
      .A0 (yol_A0  ),
      .Di0(yol_Di0 [15:0]),
      .Do0(yol0_Do0[15:0]),
      .WE0(yol_WE0[1:0] & {yol0_EN0,yol0_EN0})
   );
   
   RAM256x16_ASYNC`GATE vffram_d0_1(
      .CLK(clk),
      .A0 (yol_A0  ),
      .Di0(yol_Di0 [31:16]),
      .Do0(yol0_Do0[31:16]),
      .WE0(yol_WE0[3:2] & {yol0_EN0,yol0_EN0})
   );
   
   RAM256x16_ASYNC`GATE vffram_d1_0(
      .CLK(clk),
      .A0 (yol_A0  ),
      .Di0(yol_Di0 [15:0]),
      .Do0(yol1_Do0[15:0]),
      .WE0(yol_WE0[1:0] & {yol1_EN0,yol1_EN0})
   );
   
   RAM256x16_ASYNC`GATE vffram_d1_1(
      .CLK(clk),
      .A0 (yol_A0  ),
      .Di0(yol_Di0 [31:16]),
      .Do0(yol1_Do0[31:16]),
      .WE0(yol_WE0[3:2] & {yol1_EN0,yol1_EN0})
   );
   
   // 8 bitlik RAM'e yol1_tag0, yol1_diry, yol1_valid, x, lru_bit, yol0_tag0, yol0_diry, yol0_valid
   // Bu sayede yine RAM256x8 modulu kullanilabilmistir.
   // t1_d1_v1_x_lru_t0_d0_v0
   wire [7:0] combined_data_yeni;
   wire [7:0] combined_data_okunan;
   // Her yol kendi we sinyaline ihtiyac duyar. Bundan dolayi we sinyalleri ortaklanmistir.
   assign combined_data_yeni[0] =  yol0_EN0             ? yol0_valid_ddo : combined_data_okunan[0];
   assign combined_data_yeni[1] =  yol0_EN0             ? yol0_dirty_ddo : combined_data_okunan[1];
   assign combined_data_yeni[2] =  yol0_EN0             ? yol_Di0 [40]   : combined_data_okunan[2];
   assign combined_data_yeni[3] = (yol0_EN0 | yol1_EN0) ? lru_ddo        : combined_data_okunan[3];
   assign combined_data_yeni[4] = 1'bx;
   assign combined_data_yeni[5] =  yol1_EN0             ? yol1_valid_ddo : combined_data_okunan[5];
   assign combined_data_yeni[6] =  yol1_EN0             ? yol1_dirty_ddo : combined_data_okunan[6];
   assign combined_data_yeni[7] =  yol1_EN0             ? yol_Di0 [40]   : combined_data_okunan[7];
   
   assign yol0_valid_din = combined_data_okunan[0];
   assign yol0_dirty_din = combined_data_okunan[1];
   assign yol0_Do0[40]   = combined_data_okunan[2];
   assign lru_din        = combined_data_okunan[3];
   
   assign yol1_valid_din = combined_data_okunan[5];
   assign yol1_dirty_din = combined_data_okunan[6];
   assign yol1_Do0[40]   = combined_data_okunan[7];
   
   
   RAM256x8_ASYNC`GATE vffram_combined(
      .CLK(clk),
      .A0 (yol_A0  ),
      .Di0(combined_data_yeni),
      .Do0(combined_data_okunan),
      .WE0(yol0_EN0 | yol1_EN0)
   );

endmodule
