// user_processor.v (islemci)
`timescale 1ns / 1ps


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

    wire        yol0_we;
    wire [ 7:0] yol0_wadr;
    wire [41:0] yol0_data;
    wire [ 7:0] yol0_radr0;
    wire [41:0] yol0_data0;
    wire [ 7:0] yol0_radr1;
    wire [41:0] yol0_data1;

    wire        yol1_we;
    wire [ 7:0] yol1_wadr;
    wire [41:0] yol1_data;
    wire [ 7:0] yol1_radr0;
    wire [41:0] yol1_data0;
    wire [ 7:0] yol1_radr1;
    wire [41:0] yol1_data1;

    wire [7:0] l1b_tag_adr;

    cekirdek_ramsiz cek_ramsiz (
        .clk (clk ),
        .resetn (resetn ),

        .iomem_valid (iomem_valid ),
        .iomem_ready (iomem_ready ),
        .iomem_wstrb (iomem_wstrb ),
        .iomem_addr  (iomem_addr  ),
        .iomem_wdata (iomem_wdata ),
        .iomem_rdata (iomem_rdata ),

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

        .yol0_we_o   (yol0_we ),
        .yol0_wadr_o (yol0_wadr ),
        .yol0_data_o (yol0_data ),
        .yol0_radr0_o (yol0_radr0 ),
        .yol0_data0_i (yol0_data0 ),
        .yol0_radr1_o (yol0_radr1 ),
        .yol0_data1_i (yol0_data1 ),

        .yol1_we_o   (yol1_we ),
        .yol1_wadr_o (yol1_wadr ),
        .yol1_data_o (yol1_data ),
        .yol1_radr0_o (yol1_radr0 ),
        .yol1_data0_i (yol1_data0 ),
        .yol1_radr1_o (yol1_radr1 ),
        .yol1_data1_i (yol1_data1),

        .uart_tx_o (uart_tx_o ),
        .uart_rx_i (uart_rx_i ),

        .spi_cs_o   (spi_cs_o   ),
        .spi_sck_o  (spi_sck_o  ),
        .spi_mosi_o (spi_mosi_o ),
        .spi_miso_i (spi_miso_i ),

        .pwm0_o  (pwm0_o ),
        .pwm1_o  (pwm1_o )
    );

    RAM256_buyruk RAM256_buyruk_yol0 (
      .clk_i (clk ),
      .we_i    (yol0_we ),
      .wadr_i  (yol0_wadr ),
      .data_i  (yol0_data ),
      .radr0_i (yol0_radr0 ),
      .data0_o (yol0_data0 ),
      .radr1_i (yol0_radr1 ),
      .data1_o (yol0_data1 )
    );
    RAM256_buyruk RAM256_buyruk_yol1 (
      .clk_i (clk ),
      .we_i    (yol1_we ),
      .wadr_i  (yol1_wadr ),
      .data_i  (yol1_data ),
      .radr0_i (yol1_radr0 ),
      .data0_o (yol1_data0 ),
      .radr1_i (yol1_radr1 ),
      .data1_o (yol1_data1 )
    );

    RAM256x8 vffram_t0_0(
        .CLK(clk),
        .EN0(yol0_EN0),
        .A0 (yol_A0  ),
        .Di0(yol_Di0 [39:32]),
        .Do0(yol0_Do0[39:32]),
        .WE0(yol0_EN0)
    );

    RAM256x8 vffram_t1_0(
        .CLK(clk),
        .EN0(yol1_EN0),
        .A0 (yol_A0  ),
        .Di0(yol_Di0 [39:32]),
        .Do0(yol1_Do0[39:32]),
        .WE0(yol1_EN0)
    );


    RAM256x16 vffram_d0_0(
        .CLK(clk),
        .EN0(yol0_EN0),
        .A0 (yol_A0  ),
        .Di0(yol_Di0 [15:0]),
        .Do0(yol0_Do0[15:0]),
        .WE0(yol_WE0[1:0])
    );

    RAM256x16 vffram_d0_1(
        .CLK(clk),
        .EN0(yol0_EN0),
        .A0 (yol_A0  ),
        .Di0(yol_Di0 [31:16]),
        .Do0(yol0_Do0[31:16]),
        .WE0(yol_WE0[3:2])
    );

    RAM256x16 vffram_d1_0(
        .CLK(clk),
        .EN0(yol1_EN0),
        .A0 (yol_A0  ),
        .Di0(yol_Di0 [15:0]),
        .Do0(yol1_Do0[15:0]),
        .WE0(yol_WE0[1:0])
    );

    RAM256x16 vffram_d1_1(
        .CLK(clk),
        .EN0(yol1_EN0),
        .A0 (yol_A0  ),
        .Di0(yol_Di0 [31:16]),
        .Do0(yol1_Do0[31:16]),
        .WE0(yol_WE0[3:2])
    );


    // t1_d1_v1_x_lru_t0_d0_v0
    wire [7:0] combined_data_yeni;
    wire [7:0] combined_data_okunan;
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


    RAM256x8 vffram_combined(
        .CLK(clk),
        .EN0(yol0_EN0 | yol1_EN0),
        .A0 (yol_A0  ),
        .Di0(combined_data_yeni),
        .Do0(combined_data_okunan),
        .WE0(yol0_EN0 | yol1_EN0)
    );

endmodule
