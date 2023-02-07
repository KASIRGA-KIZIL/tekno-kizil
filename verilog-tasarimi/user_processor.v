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

    wire [31:0] l1v_veri_i;
    wire [31:0] l1v_veri_o;
    wire [31:0] l1v_adr_o;
    wire [ 3:0] l1v_veri_maske_o;
    wire        l1v_durdur_i;
    wire        l1v_yaz_gecerli_o;
    wire        l1v_sec_n_o;

    wire        l1b_bekle;
    wire [31:0] l1b_deger;
    wire [31:0] l1b_adres;
    wire        l1b_chip_select_n_o;

    cekirdek cek (
        .clk_i (clk_i),
        .rst_i (rst_i),
        //
        .l1b_bekle_i        (l1b_bekle          ),
        .l1b_deger_i        (l1b_deger          ),
        .l1b_adres_o        (l1b_adres          ),
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

    assign iomem_wstrb = 4'b0000;

    buyruk_onbellegi buyruk_onbellegi_dut (
        .clk_i (clk_i ),
        .rst_i (rst_i ),
        .iomem_valid (iomem_valid ),
        .iomem_ready (iomem_ready ),
        .iomem_addr  (iomem_addr  ),
        .iomem_rdata (iomem_rdata ),
        .l1b_bekle_o (l1b_bekle   ),
        .l1b_deger_o (l1b_deger   ),
        .l1b_adres_i (l1b_adres   )
    );

    veriyolu wb(
        .clk_i(clk_i),
        .rst_i(rst_i),

        .cekirdek_wb_adres_i(l1v_adr_o),
        .cekirdek_wb_veri_i(l1v_veri_o),
        .cekirdek_wb_veri_maske_i(l1v_veri_maske_o),
        .cekirdek_wb_yaz_gecerli_i(l1v_yaz_gecerli_o),
        .cekirdek_wb_sec_n_i(l1v_sec_n_o),
        .wb_cekirdek_veri_o(l1v_veri_i),

        .uart_wb_oku_veri_i(),
        .uart_wb_oku_veri_gecerli_i(),
        .uart_wb_mesgul_i(),
        .wb_uart_adres_i(),
        .wb_uart_veri_i(),
        .wb_uart_gecerli_i(),
        .wb_uart_yaz_gecerli_i()

    );
    // TODO bu isimli wirelar olusturulup uart'a baglanacak
    .uart_wb_oku_veri_i(),
    .uart_wb_oku_veri_gecerli_i(),
    .uart_wb_mesgul_i(),
    .wb_uart_adres_i(),
    .wb_uart_veri_i(),
    .wb_uart_gecerli_i(),
    .wb_uart_yaz_gecerli_i()

    uart_denetleyici ud(
        .clk_i(clk_i),
        .rst_i(rst_i),
        .wb_adres_i(),
        .wb_veri_i(),
        .wb_gecerli_i(),
        .wb_yaz_gecerli_i(),
        .wb_oku_veri_o(),
        .wb_oku_gecerli_o(),
        .uart_mesgul_o()
    )

endmodule
