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
    output spi_miso_i,

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
    wire [31:0] l1b_adres;

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
    wire [31:0] l1v_iomem_addr;
    wire [31:0] l1v_iomem_wdata;
    wire [31:0] l1v_iomem_rdata;

    wire        l1b_iomem_valid;
    wire        l1b_iomem_ready;
    wire [31:0] l1b_iomem_addr;
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
        .bib_yaz_gecerli_o(bib_yaz_gecerli  ),
        .bib_sec_o        (bib_sec          )
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

    assign l1v_sec = bib_adr[30] ? bib_sec : 1'b0;
    assign vy_sec  = bib_adr[29] ? bib_sec : 1'b0;
    assign tmr_sec = bib_adr[28] ? bib_sec : 1'b0;

    assign bib_durdur = bib_adr[30] ? l1v_durdur :
                        bib_adr[29] ? vy_durdur  :
                                        1'b0     ;

    assign bib_oku_veri  = bib_adr[30] ? l1v_oku_veri :
                           bib_adr[29] ? vy_oku_veri  :
                                         tmr_oku_veri ;

    veri_onbellegi veri_onbellegi_dut (
        .clk_i (clk_i ),
        .rst_i (rst_i ),

        .bib_veri_o        (l1v_oku_veri   ),
        .bib_durdur_o      (l1v_durdur     ),
        .bib_veri_i        (bib_yaz_veri   ),
        .bib_adr_o         (bib_adr        ),
        .bib_veri_maske_o  (bib_mask       ),
        .bib_yaz_gecerli_o (bib_yaz_gecerli),
        .bib_sec_o         (l1v_sec        ),

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

    wire [31:0] wb_uart_adres_w;
    wire [31:0] wb_uart_veri_w;
    wire        wb_uart_hazir_w;
    wire        wb_uart_yaz_etkin_w;
    wire [31:0] uart_wb_oku_veri_w;
    wire        uart_wb_oku_hazir_w;
    wire        uart_wb_mesgul_w;
    wire        uart_wb_oku_veri_hazir_w;
    wire        wb_uart_etkin_w;

    wire [31:0] wb_spi_adres_w;
    wire [31:0] wb_spi_veri_w;
    wire        wb_spi_hazir_w;
    wire        wb_spi_yaz_etkin_w;
    wire [31:0] spi_wb_oku_veri_w;
    wire        spi_wb_oku_hazir_w;
    wire        spi_wb_mesgul_w;
    wire        spi_wb_oku_veri_hazir_w;
    wire        wb_spi_etkin_w;

    wire [31:0] wb_pwm_adres_w;
    wire [31:0] wb_pwm_veri_w;
    wire        wb_pwm_hazir_w;
    wire        wb_pwm_yaz_etkin_w;
    wire [31:0] pwm_wb_oku_veri_w;
    wire        pwm_wb_oku_hazir_w;
    wire        pwm_wb_mesgul_w;
    wire        pwm_wb_oku_veri_hazir_w;
    wire        wb_pwm_etkin_w;

    veriyolu vy(
        .clk_i(clk_i),
        .rst_i(rst_i),

        .wb_vyd_veri_o      (vy_oku_veri    ),
        .wb_vyd_mesgul_o    (vy_durdur      ),
        .vyd_wb_veri_i      (bib_yaz_veri   ),
        .vyd_wb_adres_i     (bib_adr        ),
        .vyd_wb_yaz_etkin_i (bib_yaz_gecerli),
        .vyd_wb_sec_i       (vy_sec         ),

        .uart_wb_oku_veri_i      (uart_wb_oku_veri_w      ),
        .uart_wb_oku_veri_hazir_i(uart_wb_oku_veri_hazir_w),
        .uart_wb_mesgul_i        (uart_wb_mesgul_w        ),
        .wb_uart_adres_o         (wb_uart_adres_w         ),
        .wb_uart_veri_o          (wb_uart_veri_w          ),
        .wb_uart_etkin_o         (wb_uart_etkin_w         ),
        .wb_uart_yaz_etkin_o     (wb_uart_yaz_etkin_w     ),

        .spi_wb_mesgul_i         (spi_wb_mesgul_w        ),
        .spi_wb_oku_veri_i       (spi_wb_oku_veri_w      ),
        .spi_wb_oku_veri_hazir_i (spi_wb_oku_veri_hazir_w),
        .wb_spi_adres_o          (wb_spi_adres_w         ),
        .wb_spi_veri_o           (wb_spi_veri_w          ),
        .wb_spi_etkin_o          (wb_spi_etkin_w         ),
        .wb_spi_yaz_etkin_o      (wb_spi_yaz_etkin_w     ),

        .pwm_wb_mesgul_i         (pwm_wb_mesgul_w        ),
        .pwm_wb_oku_veri_i       (pwm_wb_oku_veri_w      ),
        .pwm_wb_oku_veri_hazir_i (pwm_wb_oku_veri_hazir_w),
        .wb_pwm_adres_o          (wb_pwm_adres_w         ),
        .wb_pwm_veri_o           (wb_pwm_veri_w          ),
        .wb_pwm_yaz_etkin_o      (wb_pwm_yaz_etkin_w     )
    );

    uart_denetleyici ud(
        .clk_i(clk_i),
        .rst_i(rst_i),
        .wb_adres_i        (wb_uart_adres_w         ),
        .wb_veri_i         (wb_uart_veri_w          ),
        .wb_etkin_i        (wb_uart_etkin_w         ),
        .wb_yaz_gecerli_i  (wb_uart_yaz_etkin_w     ),
        .wb_oku_veri_o     (uart_wb_oku_veri_w      ),
        .wb_oku_gecerli_o  (uart_wb_oku_veri_hazir_w),
        .wb_mesgul_o       (uart_wb_mesgul_w        ),

        .uart_rx_i(uart_rx_i),
        .uart_tx_o(uart_tx_o)
    );


    spi_denetleyici sd(
        .clk_i(clk_i),
        .rst_i(rst_i),
        .wb_mesgul_o    (spi_wb_mesgul_w        ),
        .wb_oku_veri_o  (spi_wb_oku_veri_w      ),
        .wb_oku_hazir_o (spi_wb_oku_veri_hazir_w),
        .wb_adres_i     (wb_spi_adres_w         ),
        .wb_yaz_veri_i  (wb_spi_veri_w          ),
        .wb_etkin_i     (wb_spi_etkin_w         ),
        .wb_yaz_etkin_i (wb_spi_yaz_etkin_w     ),

        .spi_cs_o  (spi_cs_o  ),
        .spi_sck_o (spi_sck_o ),
        .spi_mosi_o(spi_mosi_o),
        .spi_miso_i(spi_miso_i)
    );

    pwm_denetleyici pd(
        .clk_i(clk_i),
        .rst_i(rst_i),

        .wb_pwm_adres_i(wb_pwm_adres_w),
        .wb_veri_i(wb_pwm_veri_w),
        .wb_etkin_i(wb_pwm_etkin_w),
        .wb_yaz_etkin_i(wb_pwm_yaz_etkin_w),
        .wb_oku_veri_o(pwm_wb_oku_veri_w),
        .wb_oku_hazir_o(pwm_wb_oku_hazir_w),
        .wb_mesgul_o(pwm_wb_mesgul_w),

        .pwm0_o(pwm0_o),
        .pwm1_o(pwm1_o)
    );


endmodule
