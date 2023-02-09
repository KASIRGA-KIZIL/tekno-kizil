// uart_denetleyici.v
`timescale 1ns / 1ps

`include "tanimlamalar.vh"

module uart_denetleyici(
    input           clk_i,
    input           rst_i,
    
    input [31:0]    wb_adres_i,
    input [31:0]    wb_veri_i,
    input           wb_gecerli_i,
    input           wb_yaz_gecerli_i,
    output reg[31:0]wb_oku_veri_o,
    output reg      wb_oku_gecerli_o,
    output          uart_mesgul_o,

    input           uart_rx_i,
    output          uart_tx_o
);

    reg [4:0] tx_bufIdx_head_r, tx_bufIdx_tail_r; // 0 bos, 32 tamami dolu
    reg [4:0] tx_bufIdx_head_ns, tx_bufIdx_tail_ns;
    reg [4:0] rx_bufIdx_head_r, rx_bufIdx_tail_r;
    reg [4:0] rx_bufIdx_head_ns, rx_bufIdx_tail_ns;
   // ---------------******************-------------- //
   reg [7:0] rx_buffer_ns[31:0];
   reg [7:0] rx_buffer_r [31:0];
   reg [7:0] tx_buffer_ns[31:0];
   reg [7:0] tx_buffer_r [31:0];
   // ---------------******************-------------- //
   reg [31:0] wb_oku_veri_o_ns, wb_oku_veri_o_r;
   reg wb_oku_gecerli_o_ns, wb_oku_gecerli_o_r; 
   reg tx_gecerli_ns,tx_gecerli_r;
    // Sartnamede verilen yazmaclar ve parametreler. 
    // ------------*******************--------------- //
    reg tx_en_ns,tx_en_r ; // Okuma ve yazma yapilir.
    reg rx_en_ns,rx_en_r ; // Okuma ve yazma yapilir.
    reg [15:0] baud_div_ns,baud_div_r; // Okuma ve yazma yapilir.
    wire tx_full  = (tx_bufIdx_head_r - tx_bufIdx_tail_r) == 5'd31 ;
    wire rx_full  = (rx_bufIdx_head_r - rx_bufIdx_tail_r) == 5'd31 ;
    wire tx_empty = (tx_bufIdx_head_r - tx_bufIdx_tail_r) == 5'd0 ;
    wire rx_empty = (rx_bufIdx_head_r - rx_bufIdx_tail_r) == 5'd0 ;
    wire [7:0] uart_wdata;
    reg [7:0] tx_yolla_r, tx_yolla_ns_r;
    // ---------------******************-------------- //
    wire [7:0] rx_al;
    wire tx_hazir;
    integer i;
    // ---------------******************-------------- //
    assign uart_wdata = wb_veri_i[7:0];
    //assign tx_yolla = tx_buffer_r[tx_bufIdx_tail_r];
    assign wb_oku_veri_o = wb_oku_veri_o_r;
    assign wb_oku_gecerli_o = wb_oku_gecerli_o_r;

    always@*begin
        tx_bufIdx_head_ns = tx_bufIdx_head_r;
        rx_bufIdx_head_ns = rx_bufIdx_head_r;
        tx_bufIdx_tail_ns = tx_bufIdx_tail_r;
        rx_bufIdx_tail_ns = rx_bufIdx_tail_r;
        tx_gecerli_ns = 0;
        tx_en_ns = tx_en_r;
        rx_en_ns = rx_en_r;
        baud_div_ns = baud_div_r;
        wb_oku_veri_o_ns = wb_oku_veri_o_r;
        wb_oku_gecerli_o_ns = 0;
        tx_yolla_ns_r = 0;

        for(i = 0; i<32; i=i+1)begin
            tx_buffer_ns[i]  = tx_buffer_r[i];
            rx_buffer_ns[i]  = rx_buffer_r[i];
        end

        if(tx_en_r && !tx_empty) begin
            tx_gecerli_ns = 1;
            tx_yolla_ns_r = tx_buffer_r[tx_bufIdx_tail_r];
        end

        if (tx_gecerli_r && tx_hazir && ~tx_empty) begin
            tx_bufIdx_tail_ns = tx_bufIdx_tail_r + 5'd1; // else idx = idx+1
        end

        if(rx_en_r) begin   // Receiver read
            if(al_veri_gecerli_o && ~rx_full) begin  // Receiver buffer , // Buffer doluysa yeni gelen veriler onemsenmez
                rx_buffer_ns[rx_bufIdx_head_r] = rx_al;
                rx_bufIdx_head_ns = rx_bufIdx_head_r + 5'd1;
            end
        end
        if(wb_gecerli_i)begin
            case({wb_yaz_gecerli_i,wb_adres_i[3:0]})
                5'h10:begin //yaz gecerli
                  baud_div_ns = wb_veri_i[31:16];
                  rx_en_ns    = wb_veri_i[1];
                  tx_en_ns    = wb_veri_i[0];
                end
                5'h00:begin
                  wb_oku_gecerli_o_ns = 1'b1;
                  wb_oku_veri_o_ns = {baud_div_r,14'd0,rx_en_r,tx_en_r};
                end
                5'h04:begin
                    wb_oku_gecerli_o_ns = 1'b1;
                    wb_oku_veri_o_ns = {28'b0,rx_empty,tx_empty,rx_full,tx_full};
                end
                5'h08:begin
                    if(~rx_empty) begin
                        rx_bufIdx_tail_ns = rx_bufIdx_tail_r + 5'd1;
                        wb_oku_veri_o_ns = {24'b0, rx_buffer_r[rx_bufIdx_tail_r]};
                        wb_oku_gecerli_o_ns = 1'b1;
                    end else begin
                        wb_oku_gecerli_o_ns = 1'b0;
                    end
                end
                5'h1C:begin
                    if( ~tx_full)begin // Transmitter buffer
                        tx_buffer_ns[tx_bufIdx_head_r] = uart_wdata;
                        tx_bufIdx_head_ns = tx_bufIdx_head_r + 5'd1;
                    end
                end
            endcase
        end
    end

    always @(posedge clk_i) begin

      if(rst_i) begin
         tx_bufIdx_head_r <= 5'd0;
         rx_bufIdx_head_r <= 5'd0;
         tx_bufIdx_tail_r <= 5'd0;
         rx_bufIdx_tail_r <= 5'd0;
         tx_gecerli_r <= 0;
         tx_en_r <= 0;
         rx_en_r <= 0;
         baud_div_r <= 0;
         wb_oku_veri_o_r <= 0;
         wb_oku_gecerli_o_r <= 0;
         tx_yolla_r         <= 0;
         for(i = 0; i<32; i=i+1)begin
            tx_buffer_r[i]  <= 8'd0;
            rx_buffer_r[i]  <= 8'd0;
         end
         
      end else begin
         tx_bufIdx_head_r <= tx_bufIdx_head_ns;
         rx_bufIdx_head_r <= rx_bufIdx_head_ns;
         tx_bufIdx_tail_r <= tx_bufIdx_tail_ns;
         rx_bufIdx_tail_r <= rx_bufIdx_tail_ns;
         tx_gecerli_r     <= tx_gecerli_ns;
         tx_en_r          <= tx_en_ns;  
         rx_en_r          <= rx_en_ns;   
         baud_div_r       <= baud_div_ns;
         wb_oku_veri_o_r  <= wb_oku_veri_o_ns;
         wb_oku_gecerli_o_r <= wb_oku_gecerli_o_ns;
         tx_yolla_r         <= tx_yolla_ns_r;
         for(i = 0; i<32; i=i+1)begin
            tx_buffer_r[i]  <= tx_buffer_ns[i];
            rx_buffer_r[i]  <= rx_buffer_ns[i];
         end
      end

   end

    uart_alici ua(
        .clk_i(clk_i),
        .rst_i(rst_i),
        .rx_i(uart_rx_i),
        .rx_en_i(rx_en_r),
        .baud_rate_i(baud_div_r),
        .hazir_o(),
        .bitti_o(al_veri_gecerli_o),
        .veri_o(rx_al)
    );

    uart_verici uv(
        .clk_i(clk_i),
        .rst_i(rst_i),
        .veri_i(tx_yolla_r),
        .tx_en_i(tx_gecerli_r && ~tx_empty),
        .baud_rate_i(baud_div_r),
        .hazir_o(tx_hazir),
        .tx_o(uart_tx_o)
    );
endmodule
