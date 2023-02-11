// veriyolu.v
`timescale 1ns / 1ps

`include "tanimlamalar.vh"
// TODO: TAGLERI EKLE

module veriyolu(
    input clk_i,
    input rst_i,

    // VYD --- WB
    input  [31:0]       vyd_wb_adres_i,
    input  [31:0]       vyd_wb_veri_i,
    input               vyd_wb_yaz_etkin_i,
    input               vyd_wb_sec_i,
    output [31:0]       wb_vyd_veri_o,
    output              wb_vyd_veri_hazir_o,
    output              wb_vyd_mesgul_o,

    // WB --- UART
    input               uart_wb_mesgul_i,
    input  [31:0]       uart_wb_oku_veri_i,
    input               uart_wb_oku_veri_hazir_i,
    output [31:0]       wb_uart_adres_o,
    output [31:0]       wb_uart_veri_o,
    output              wb_uart_etkin_o,
    output              wb_uart_yaz_etkin_o,

    // WB --- SPI
    input               spi_wb_mesgul_i,
    input  [31:0]       spi_wb_oku_veri_i,
    input               spi_wb_oku_veri_hazir_i,
    output [31:0]       wb_spi_adres_o,
    output [31:0]       wb_spi_veri_o,
    output              wb_spi_etkin_o,
    output              wb_spi_yaz_etkin_o,

    // WB --- PWM
    input               pwm_wb_mesgul_i,
    input  [31:0]       pwm_wb_oku_veri_i,
    input               pwm_wb_oku_veri_hazir_i,
    output [31:0]       wb_pwm_adres_o,
    output [31:0]       wb_pwm_veri_o,
    output              wb_pwm_etkin_o,
    output              wb_pwm_yaz_etkin_o

);

    wire [31:0] master_slave_addr_w;
    wire [31:0] master_slave_data_w;
    wire        master_slave_we_w;

    wire        master_slave_cyc_w;
    wire        master_slave_stb_w;

    wire [1:0]  master_sel_w;
    wire uart_sel_w = master_sel_w == 2'b00;
    wire spi_sel_w  = master_sel_w == 2'b01;
    wire pwm_sel_w  = master_sel_w == 2'b10;   

    wire [31:0] uart_master_data_w;
    wire [31:0] spi_master_data_w;
    wire [31:0] pwm_master_data_w;
    wire [31:0] slave_master_data_w =   (master_sel_w == 0) ? uart_master_data_w :
                                        (master_sel_w == 1) ? spi_master_data_w  :
                                        (master_sel_w == 2) ? pwm_master_data_w  :
                                                              32'bX              ;

    wire uart_master_ack_w;
    wire spi_master_ack_w;
    wire pwm_master_ack_w;    
    wire master_ack_in_w =              (master_sel_w == 0) ? uart_master_ack_w  :
                                        (master_sel_w == 1) ? spi_master_ack_w   :
                                        (master_sel_w == 2) ? pwm_master_ack_w   :
                                                              1'b0               ;
    wire uart_master_tgd_w;
    wire spi_master_tgd_w;
    wire pwm_master_tgd_w;
    wire slave_master_tgd_w =           (master_sel_w == 0) ? uart_master_data_w :
                                        (master_sel_w == 1) ? spi_master_data_w  :
                                        (master_sel_w == 2) ? pwm_master_data_w  :
                                                              1'b0               ;

    wire master_slave_tgd_w;

    wishbone_master wm(
        .clk_i(clk_i),
        .rst_i(rst_i),

        .cmd_addr_i(vyd_wb_adres_i),
        .cmd_word_i({vyd_wb_yaz_etkin_i,vyd_wb_sec_i,vyd_wb_veri_i}),
        .cmd_busy_o(wb_vyd_mesgul_o),
        .cmd_rdata_o(wb_vyd_veri_o),
        .cmd_rdata_valid_o(wb_vyd_veri_hazir_o),

        .addr_o(master_slave_addr_w),
        .data_i(slave_master_data_w),
        .data_o(master_slave_data_w),
        .we_o(master_slave_we_w),

        .cyc_o(master_slave_cyc_w),
        .stb_o(master_slave_stb_w),
        .sel_o(master_sel_w),
        .ack_i(master_ack_w),
        .tgd_o(master_slave_tgd_w),
        .tgd_i(slave_master_tgd_w)
    );

    wire wb_uart_oku_etkin_w;
    wishbone_slave ws_uart(
        .clk_i(clk_i),
        .rst_i(rst_i),

        .addr_i(master_slave_addr_w),
        .data_i(master_slave_data_w),
        .data_o(uart_master_data_w),
        .we_i(master_slave_we_w),

        .cyc_i(master_slave_cyc_w),
        .stb_i(master_slave_stb_w),
        .sel_i(uart_sel_w),
        .ack_o(uart_master_ack_w),
        .tgd_i(master_slave_tgd_w),
        .tgd_o(uart_master_tgd_w),

        .device_ready_i(~uart_wb_mesgul_i),
        .device_rdata_i(uart_wb_oku_veri_i),
        .device_rdata_valid_i(uart_wb_oku_veri_hazir_i),
        .device_addr_o(wb_uart_adres_o),
        .device_wdata_o(wb_uart_veri_o),
        .device_we_o(wb_uart_yaz_etkin_o),
        .device_re_o(wb_uart_oku_etkin_w)
    );
    assign wb_uart_etkin_o = uart_sel_w & (wb_uart_yaz_etkin_o || wb_uart_oku_etkin_w) ;

    wire wb_spi_oku_etkin_w;
    wishbone_slave ws_spi(
        .clk_i(clk_i),
        .rst_i(rst_i),

        .addr_i(master_slave_addr_w),
        .data_i(master_slave_data_w),
        .data_o(spi_master_data_w),
        .we_i(master_slave_we_w),

        .cyc_i(master_slave_cyc_w),
        .stb_i(master_slave_stb_w),
        .sel_i(spi_sel_w),
        .ack_o(spi_master_ack_w),
        .tgd_i(master_slave_tgd_w),
        .tgd_o(spi_master_tgd_w),

        .device_ready_i(~spi_wb_mesgul_i),
        .device_rdata_i(spi_wb_oku_veri_i),
        .device_rdata_valid_i(spi_wb_oku_veri_hazir_i),
        .device_addr_o(wb_spi_adres_o),
        .device_wdata_o(wb_spi_veri_o),
        .device_we_o(wb_spi_yaz_etkin_o),
        .device_re_o(wb_spi_oku_etkin_w)
    );
    assign wb_spi_etkin_o = spi_sel_w & (wb_spi_yaz_etkin_o || wb_spi_oku_etkin_w) ;

    wire wb_pwm_oku_etkin_w;
    wishbone_slave ws_pwm(
        .clk_i(clk_i),
        .rst_i(rst_i),

        .addr_i(master_slave_addr_w),
        .data_i(master_slave_data_w),
        .data_o(pwm_master_data_w),
        .we_i(master_slave_we_w),

        .cyc_i(master_slave_cyc_w),
        .stb_i(master_slave_stb_w),
        .sel_i(pwm_sel_w),
        .ack_o(pwm_master_ack_w),
        .tgd_i(master_slave_tgd_w),
        .tgd_o(pwm_master_tgd_w),

        .device_ready_i(~pwm_wb_mesgul_i),
        .device_rdata_i(pwm_wb_oku_veri_i),
        .device_rdata_valid_i(pwm_wb_oku_veri_hazir_i),
        .device_addr_o(wb_pwm_adres_o),
        .device_wdata_o(wb_pwm_veri_o),
        .device_we_o(wb_pwm_yaz_etkin_o),
        .device_re_o(wb_pwm_oku_etkin_w)
    );
    assign wb_pwm_etkin_o = pwm_sel_w & (wb_pwm_yaz_etkin_o || wb_pwm_oku_etkin_w) ;
    
endmodule
