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

    output uart_tx_o,
    input  uart_rx_i,

    output spi_cs_o,
    output spi_sck_o,
    output spi_mosi_o,
    input spi_miso_i,

    output pwm0_o,
    output pwm1_o
);
    wire clk_i = clk;
    wire rst_i = ~resetn;

    wire [31:0] bib_yaz_veri;
    wire [31:0] bib_oku_veri;
    wire [31:0] bib_adr;
    wire [ 3:0] bib_mask;
    wire        bib_durdur;
    wire        bib_yaz_gecerli;
    wire        bib_sec;

    wire        l1b_bekle;
    wire [31:0] l1b_deger;
    wire [18:2] l1b_adres;

    wire [31:0] l1v_oku_veri;
    wire        l1v_sec;
    wire        l1v_durdur;

    wire [31:0] vy_oku_veri;
    wire        vy_sec;
    wire        vy_durdur;

    wire [31:0] tmr_oku_veri;
    wire        tmr_sec;
    wire        tmr_durdur;

    wire        l1v_iomem_valid;
    wire        l1v_iomem_ready;
    wire [ 3:0] l1v_iomem_wstrb;
    wire [18:2] l1v_iomem_addr;
    wire [31:0] l1v_iomem_wdata;
    wire [31:0] l1v_iomem_rdata;

    wire        l1b_iomem_valid;
    wire        l1b_iomem_ready;
    wire [18:2] l1b_iomem_addr;
    wire [31:0] l1b_iomem_rdata;

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

    buyruk_onbellegi buyruk_onbellegi_dut (
        .clk_i (clk_i ),
        .rst_i (rst_i ),

        .iomem_valid   (l1b_iomem_valid),
        .iomem_ready   (l1b_iomem_ready),
        .iomem_addr    (l1b_iomem_addr ),
        .iomem_rdata   (l1b_iomem_rdata),

        .l1b_bekle_o   (l1b_bekle),
        .l1b_deger_o   (l1b_deger),
        .l1b_adres_i   (l1b_adres)
    );

    assign l1v_sec = bib_adr[30]               ? bib_sec : 1'b0;
    assign vy_sec  = bib_adr[29]&&~bib_adr[28] ? bib_sec : 1'b0;
    assign tmr_sec = bib_adr[28]               ? bib_sec : 1'b0;

    assign bib_durdur = bib_adr[30] ? l1v_durdur :
                        bib_adr[28] ?   1'b0     :
                                      vy_durdur  ;

    assign bib_oku_veri  = bib_adr[30] ? l1v_oku_veri :
                           bib_adr[28] ? tmr_oku_veri :
                                         vy_oku_veri  ;

    veri_onbellegi veri_onbellegi_dut (
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
        .iomem_rdata_i (l1v_iomem_rdata )
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


    veriyolu  veriyolu_dut (
        .clk_i (clk_i ),
        .rst_i (rst_i ),
        .vy_veri_o        (vy_oku_veri    ),
        .vy_durdur_o      (vy_durdur      ),
        .vy_veri_i        (bib_yaz_veri   ),
        .vy_adres_i       (bib_adr        ),
        .vy_veri_maske_i  (bib_mask       ),
        .vy_yaz_gecerli_i (bib_yaz_gecerli),
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
