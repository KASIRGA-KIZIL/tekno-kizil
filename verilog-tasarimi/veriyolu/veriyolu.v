// veriyolu.v
`timescale 1ns / 1ps

`include "tanimlamalar.vh"
// TODO: TAGLERI EKLE

module veriyolu(
    input clk_i,
    input rst_i,

    // Cekirdek --- WB
    input  [31:0]       cekirdek_wb_adres_i,
    input  [31:0]       cekirdek_wb_veri_i,
    input  [ 3:0]       cekirdek_wb_veri_maske_i,
    input               cekirdek_wb_yaz_gecerli_i,
    input               cekirdek_wb_sec_n_i,
    output [31:0]       wb_cekirdek_veri_o,
    output              wb_cekirdek_veri_gecerli_o,
    output              wb_cekirdek_mesgul_o,

    // WB --- UART
    input               uart_wb_mesgul_i,
    input  [31:0]       uart_wb_oku_veri_i,
    input               uart_wb_oku_veri_gecerli_i,
    output wire[31:0]    wb_uart_adres_o,
    output wire[31:0]    wb_uart_veri_o,
    output wire         wb_uart_gecerli_o,
    output wire          wb_uart_yaz_gecerli_o,

    // WB --- PWM
    input           pwm_wb_mesgul_i,
    input  [31:0]   pwm_wb_oku_veri_i,
    input           pwm_wb_oku_veri_gecerli_i,
    output [31:0]   wb_pwm_adres_o,
    output [31:0]   wb_pwm_veri_o,
    output          wb_pwm_yaz_gecerli_o
    // diger cihazlar icin devami eklenecek

);

    wire [31:0] master_slave_addr_w;
    wire [31:0] master_slave_data_w;
    wire        master_slave_we_w;

    wire        master_slave_cyc_w;
    wire        master_slave_stb_w;

    wire [1:0]  master_sel_w;
    wire        slave_sel_w [3:0]; // 0: UART 1:SPI 2:PWM 3:V$

    genvar i;
    generate
        for(i = 0; i < 4; i = i + 1)begin : ms_decoder
            assign slave_sel_w[i] = master_sel_w == i;
        end
    endgenerate

    wire        uart_master_ack_w;
    wire        spi_master_ack_w;
    wire        pwm_master_ack_w;
    wire        veri_master_ack_w;
    wire        master_ack_in_w =   (master_sel_w == 0) ? uart_master_ack_w  :
                                    (master_sel_w == 1) ? spi_master_ack_w   :
                                    (master_sel_w == 2) ? pwm_master_ack_w   :
                                    (master_sel_w == 3) ? veri_master_ack_w  :
                                                            1'b0;

    wire [31:0] uart_master_data_w;
    wire [31:0] spi_master_data_w;
    wire [31:0] pwm_master_data_w;
    wire [31:0] veri_master_data_w;
    wire [31:0] master_data_in_w =  (master_sel_w == 0) ? uart_master_data_w :
                                    (master_sel_w == 1) ? spi_master_data_w  :
                                    (master_sel_w == 2) ? pwm_master_data_w  :
                                    (master_sel_w == 3) ? veri_master_data_w :
                                                            32'dx;

    wishbone_master wm(
        .clk_i(clk_i),
        .rst_i(rst_i),

        .cmd_addr_i(cekirdek_wb_adres_i),
        .cmd_word_i({cekirdek_wb_yaz_gecerli_i,cekirdek_wb_sec_n_i,cekirdek_wb_veri_i}),
        .cmd_busy_o(wb_cekirdek_mesgul_o),
        .cmd_rdata_o(wb_cekirdek_veri_o),
        .cmd_rdata_valid_o(wb_cekirdek_veri_gecerli_o),

        .addr_o(master_slave_addr_w),
        .data_i(uart_master_data_w),
        .data_o(master_slave_data_w),
        .we_o(master_slave_we_w),

        .cyc_o(master_slave_cyc_w),
        .stb_o(master_slave_stb_w),
        .sel_o(master_sel_w),
        .ack_i(master_ack_w)
    );

    wire wb_uart_oku_gecerli_w;
    wishbone_slave ws_uart(
        .clk_i(clk_i),
        .rst_i(rst_i),

        .addr_i(master_slave_addr_w),
        .data_i(master_slave_data_w),
        .data_o(uart_master_data_w),
        .we_i(master_slave_we_w),

        .cyc_i(master_slave_cyc_w),
        .stb_i(master_slave_stb_w),
        .sel_i(slave_sel_w[0]),
        .ack_o(uart_master_ack_w),

        .device_ready_i(~uart_wb_mesgul_i),
        .device_rdata_i(uart_wb_oku_veri_i),
        .device_rdata_valid_i(uart_wb_oku_veri_gecerli_i),
        .device_addr_o(wb_uart_adres_o),
        .device_wdata_o(wb_uart_veri_o),
        .device_we_o(wb_uart_yaz_gecerli_o),
        .device_re_o(wb_uart_oku_gecerli_w)
    );
    assign wb_uart_gecerli_o = slave_sel_w[0] & (wb_uart_yaz_gecerli_o || wb_uart_oku_gecerli_w) ;

    wire wb_pwm_oku_gecerli_w;
    wishbone_slave ws_pwm(
        .clk_i(clk_i),
        .rst_i(rst_i),

        .addr_i(master_slave_addr_w),
        .data_i(master_slave_data_w),
        .data_o(pwm_master_data_w),
        .we_i(master_slave_we_w),

        .cyc_i(master_slave_cyc_w),
        .stb_i(master_slave_stb_w),
        .sel_i(slave_sel_w[0]),
        .ack_o(pwm_master_ack_w),

        .device_ready_i(~pwm_wb_mesgul_i),
        .device_rdata_i(pwm_wb_oku_veri_i),
        .device_rdata_valid_i(pwm_wb_oku_veri_gecerli_i),
        .device_addr_o(wb_pwm_adres_o),
        .device_wdata_o(wb_pwm_veri_o),
        .device_we_o(wb_pwm_yaz_gecerli_o),
        .device_re_o(wb_pwm_oku_gecerli_w)
    );
    assign wb_pwm_oku_gecerli_w = slave_sel_w[2] & (wb_pwm_yaz_gecerli_o || wb_pwm_oku_gecerli_w) ;
endmodule
