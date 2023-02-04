// user_processor.v (islemci)
`timescale 1ns / 1ps

//`include "tanimlamalar.vh"

module user_processor(
    input clk,
    input resetn,

    output        iomem_valid,
    input         iomem_ready,
    output [ 3:0] iomem_wstrb,
    output [31:0] iomem_addr,
    output [31:0] iomem_wdata,
    input  [31:0] iomem_rdata,

    output spi_cs_o,
    output spi_sck_o,
    output spi_mosi_o,
    output spi_miso_i,

    output uart_tx_o,
    input  uart_rx_i,

    output pwm0_o,
    output pwm1_o
);
    wire rst_i = ~resetn;

    wire [31:0] l1v_veri_i;
    wire [31:0] l1v_veri_o;
    wire [31:0] l1v_adr_o;
    wire [ 3:0] l1v_veri_maske_o;
    wire        l1v_durdur_i;
    wire        l1v_yaz_gecerli_o;
    wire        l1v_sec_n_o;

    wire        l1b_bekle_i;
    wire [31:0] l1b_deger_i;
    wire [31:0] l1b_adres_o;
    wire        l1b_chip_select_n_o;

    cekirdek cek (
        .clk_i (clk_i),
        .rst_i (rst_i),
        //
        .l1b_bekle_i        (l1b_bekle_i        ),
        .l1b_deger_i        (l1b_deger_i        ),
        .l1b_adres_o        (l1b_adres_o        ),
        .l1b_chip_select_n_o(l1b_chip_select_n_o),
        //
        .l1v_veri_i       (l1v_veri_i       ),
        .l1v_durdur_i     (l1v_durdur_i     ),
        .l1v_veri_o       (l1v_veri_o       ),
        .l1v_adr_o        (l1v_adr_o        ),
        .l1v_veri_maske_o (l1v_veri_maske_o ),
        .l1v_yaz_gecerli_o(l1v_yaz_gecerli_o),
        .l1v_sec_n_o      (l1v_sec_n_o      )
    );


    wire [10:0] main_l1v_addr;
    wire [31:0] main_l1v_din;
    wire [31:0] main_l1v_dout;
    wire        main_l1v_csb;
    wire        main_l1v_stall;
    wire        main_l1v_web;
    // [TODO] l1v <-> cpu olmamali. l1b <-> veriyolu <-> cpu olmali. Gecici olarak direkt cach'e baglandi.
    // Wishbone master <-> veriyolu kodu yazilmali vs.
    wire [31:0] real_adr = {2'b0,l1v_adr_o[29:0]};
    veri_onbellegi vo (
        .clk  (clk_i ),
        .rst  (rst_i ),
        .addr   (real_adr         ),
        .csb    (l1v_sec_n_o      ),
        .din    (l1v_veri_o       ),
        .dout   (l1v_veri_i       ),
        .stall  (l1v_durdur_i     ),
        .web    (l1v_yaz_gecerli_o),
        .wmask  (l1v_veri_maske_o ),
        .main_addr  (main_l1v_addr ),
        .main_csb   (main_l1v_csb  ),
        .main_din   (main_l1v_din  ),
        .main_dout  (main_l1v_dout ),
        .main_stall (main_l1v_stall),
        .main_web   (main_l1v_web  )
    );

    wire [10:0] main_l1b_addr;
    wire [31:0] main_l1b_dout;
    wire        main_l1b_csb;
    wire        main_l1b_stall;

    buyruk_onbellegi bo (
        .clk (clk_i ),
        .rst (rst_i ),
        //
        .addr   (l1b_adres_o        ),
        .csb    (l1b_chip_select_n_o),
        .dout   (l1b_deger_i        ),
        .stall  (l1b_bekle_i        ),
        //
        .main_addr  (main_l1b_addr ),
        .main_csb   (main_l1b_csb  ),
        .main_dout  (main_l1b_dout ),
        .main_stall (main_l1b_stall),
    );

    anabellek_denetleyici abd (
        .clk_i (clk ),
        .rst_i (rst_i ),
        //
        .iomem_valid (iomem_valid),
        .iomem_ready (iomem_ready),
        .iomem_wstrb (iomem_wstrb),
        .iomem_addr  (iomem_addr ),
        .iomem_wdata (iomem_wdata),
        .iomem_rdata (iomem_rdata),
        //
        .l1b_addr  (main_l1b_addr ),
        .l1b_dot   (main_l1b_dout ),
        .l1b_csb   (main_l1b_csb  ),
        .l1b_stall (main_l1b_stall),
        //
        .l1v_addr      (main_l1v_addr ),
        .l1v_csb       (main_l1v_csb  ),
        .l1v_din       (main_l1v_din  ),
        .l1v_dot       (main_l1v_dout ),
        .l1v_stall     (main_l1v_stall),
        .l1v_web       (main_l1v_web  )
    );

endmodule

