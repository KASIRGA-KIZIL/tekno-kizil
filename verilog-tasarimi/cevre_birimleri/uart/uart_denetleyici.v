// uart_denetleyici.v
`timescale 1ns / 1ps

`include "tanimlamalar.vh"


module uart_denetleyici (
    input wire clk_i,
    input wire rst_i,
    input  wire [ 3:0] wb_adr_i,
    input  wire [31:0] wb_dat_i,
    input  wire        wb_we_i ,
    input  wire        wb_stb_i,
    input  wire [ 3:0] wb_sel_i,
    input  wire        wb_cyc_i,
    output reg         wb_ack_o,
    output reg  [31:0] wb_dat_o,

    output wire uart_rx_i,
    output wire uart_tx_o
);


    reg tx_en;
    reg rx_en;
    reg tx_we;
    reg [15:0] baud_div;
    wire tx_full;
    wire tx_empty;

    reg uart_clk_pulse;

    uart_tx uart_tx_dut (
      .clk_i (clk_i ),
      .rst_i (rst_i ),
      .uart_clk_pulse_i (uart_clk_pulse),
      .we_i    (tx_we        ),
      .stall_i (~tx_en       ),
      .data_i  (wb_dat_i[7:0]),
      .full_o  (tx_full      ),
      .empty_o (tx_empty     ),
      .tx_o    (uart_tx_o    )
    );


    always @(posedge clk_i) begin
        if (rst_i) begin
            wb_ack_o <= 1'b0;
        end else begin
            tx_we <= 1'b0;
            if(wb_cyc_i) begin
                wb_ack_o <= wb_stb_i & !wb_ack_o;
                case(wb_adr_i)
                    4'h0: begin
                        if(wb_stb_i & wb_we_i & !wb_ack_o) begin
                            tx_en    <=   wb_sel_i[0]    ? wb_dat_i[0]     : tx_en;
                            rx_en    <=   wb_sel_i[0]    ? wb_dat_i[1]     : rx_en;
                            baud_div <= (&wb_sel_i[3:2]) ? wb_dat_i[31:16] : baud_div;
                        end
                        wb_dat_o <= {baud_div, 13'b0, rx_en, tx_en};
                    end
                    4'h4: begin
                        wb_dat_o <= {30'b0,tx_empty,tx_full}; // [TODO] RX REGS
                    end
                    4'h8: begin

                    end
                    4'hc: begin
                        if(wb_stb_i & wb_we_i & !wb_ack_o) begin
                            tx_we <= 1'b1;
                        end
                    end
                endcase
            end
        end
    end

    reg [20:0] counter;
    always @(posedge clk_i) begin
        if (rst_i) begin
            baud_div <= 0;
            counter  <= 0;
            uart_clk_pulse <= 1'b0;
        end else if(counter == baud_div) begin
            counter <= 0;
            uart_clk_pulse <= 1'b1;
        end else begin
            counter <= counter + 1;
            uart_clk_pulse <= 1'b0;
        end
    end
endmodule
