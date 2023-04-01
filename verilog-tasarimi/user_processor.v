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

    cekirdek_ramsiz cek_ramsiz (
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

    RAM512 RAM512_d0 (
        .CLK(clk),
        .EN0(1'b1),
        .A0(ram512d0_adr0),
        .Di0(iomem_rdata[15:0]),
        .Do0(ram512d0_datao0),
        .WE0({ram512d0_we0,ram512d0_we0})
    );

    RAM512 RAM512_d1 (
        .CLK(clk),
        .EN0(1'b1),
        .A0(ram512d1_adr0),
        .Di0(iomem_rdata[31:16]),
        .Do0(ram512d1_datao0),
        .WE0({ram512d1_we0,ram512d1_we0})
    );

    RAM256x8 bffram_t0( // even
        .CLK(clk),
        .EN0(1'b1),
        .A0(adr0),
        .Di0(l1b_tag_adr),
        .Do0(datao0),
        .WE0(we0)
    );

    RAM256x8 bffram_t1( // odd
        .CLK(clk),
        .EN0(1'b1),
        .A0(adr1),
        .Di0(l1b_tag_adr),
        .Do0(datao1),
        .WE0(we1)
    );


    RAM256x8 vffram_t0_0(
        .CLK(clk),
        .EN0(yol0_EN0),
        .A0 (yol_A0  ),
        .Di0(yol_Di0 [39:32]),
        .Do0(yol0_Do0[39:32]),
        .WE0(yol0_EN0)
    );

    RAM256x1 vffram_t0_1(
        .CLK(clk),
        .EN0(yol0_EN0),
        .A0 (yol_A0  ),
        .Di0(yol_Di0 [40]),
        .Do0(yol0_Do0[40]),
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

    RAM256x1 vffram_t1_1(
        .CLK(clk),
        .EN0(yol1_EN0),
        .A0 (yol_A0  ),
        .Di0(yol_Di0 [40]),
        .Do0(yol1_Do0[40]),
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
endmodule
