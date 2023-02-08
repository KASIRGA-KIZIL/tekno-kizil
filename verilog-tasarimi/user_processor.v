// user_processor.v (islemci)
`timescale 1ns / 1ps


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
    wire clk_i = clk;
    wire rst_i = ~resetn;

    wire [31:0] l1v_yaz_veri;
    wire [31:0] l1v_oku_veri;
    wire [31:0] l1v_adr;
    wire [ 3:0] l1v_mask;
    wire        l1v_durdur;
    wire        l1v_yaz_gecerli;
    wire        l1v_sec;

    wire        l1b_bekle;
    wire [31:0] l1b_deger;
    wire [31:0] l1b_adres;


    wire        l1v_iomem_valid;
    wire        l1v_iomem_ready;
    wire [ 3:0] l1v_iomem_wstrb;
    wire [31:0] l1v_iomem_addr;
    wire [31:0] l1v_iomem_wdata;
    wire [31:0] l1v_iomem_rdata;

    wire [31:0] l1v_adr_o;
    wire [31:0] l1b_iomem_addr;
    wire [31:0] l1b_iomem_rdata;

    cekirdek cek (
        .clk_i (clk_i),
        .rst_i (rst_i),
        //
        .l1b_bekle_i        (l1b_bekle          ),
        .l1b_deger_i        (l1b_deger          ),
        .l1b_adres_o        (l1b_adres          ),
        .l1b_chip_select_n_o( ),
        //
        .l1v_veri_i       (l1v_yaz_veri     ),
        .l1v_durdur_i     (l1v_durdur       ),
        .l1v_veri_o       (l1v_oku_veri     ),
        .l1v_adr_o        (l1v_adr_o        ),
        .l1v_veri_maske_o (l1v_mask         ),
        .l1v_yaz_gecerli_o(l1v_yaz_gecerli  ),
        .l1v_sec_n_o      (l1v_sec          )
    );

    buyruk_onbellegi buyruk_onbellegi_dut (
        .clk_i (clk_i ),
        .rst_i (rst_i ),

        .iomem_valid   (l1b_iomem_valid),
        .iomem_ready   (l1b_iomem_ready),
        .iomem_addr    (l1b_iomem_addr ),
        .iomem_rdata   (l1b_iomem_rdata),

        .l1b_bekle_o   (l1b_bekle   ),
        .l1b_deger_o   (l1b_deger   ),
        .l1b_adres_i   (l1b_adres   )
    );

    veri_onbellegi veri_onbellegi_dut (
        .clk_i (clk_i ),
        .rst_i (rst_i ),

        .ddb_durdur         (ddb_durdur       ),

        .bib_veri_o         (l1v_yaz_veri     ),
        .bib_durdur_o       (l1v_durdur       ),
        .bib_veri_i         (l1v_oku_veri     ),
        .bib_adr_o          (l1v_adr_o        ),
        .bib_veri_maske_o   (l1v_mask         ),
        .bib_yaz_gecerli_o  (l1v_yaz_gecerli  ),
        .bib_sec_n_o        (l1v_sec          ),

        .ab_ready (l1v_iomem_ready ),
        .ab_valid (l1v_iomem_valid ),
        .ab_web   (l1v_iomem_wstrb ),
        .ab_addr  (l1v_iomem_addr  ),
        .ab_din   (l1v_iomem_wdata ),
        .ab_dot   (l1v_iomem_rdata )
    );

    anabellek_denetleyici abdd (
        .clk_i (clk_i ),
        .rst_i (rst_i ),

        .iomem_valid (iomem_valid ),
        .iomem_ready (iomem_ready ),
        .iomem_wstrb (iomem_wstrb ),
        .iomem_addr  (iomem_addr  ),
        .iomem_wdata (iomem_wdata ),
        .iomem_rdata (iomem_rdata ),

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


endmodule
