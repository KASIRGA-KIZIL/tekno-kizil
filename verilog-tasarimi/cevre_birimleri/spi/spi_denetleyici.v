// spi_denetleyici.v
`timescale 1ns / 1ps

`include "tanimlamalar.vh"

module spi_denetleyici (
   input clk_i,
   input rst_i,

   input  [31:0] wb_adr_i,
   input  [31:0] wb_dat_i,
   input         wb_we_i,
   input         wb_stb_i,
   input  [ 3:0] wb_sel_i,
   input         wb_cyc_i,
   output        wb_ack_o,
   output [31:0] wb_dat_o,

   // spi i/o
   input  spi_miso_i,
   output spi_mosi_o,
   output spi_cs_o,
   output spi_sck_o
   );
`ifdef COCOTB_SIM
initial begin
  $dumpfile ("spi_denetleyici.vcd");
  $dumpvars (0, spi_denetleyici);
  #1;
end
`endif
    // Yazmac adresleri
    localparam [4:0]
    SPI_CTRL = 5'h00,
    SPI_STAT = 5'h04,
    SPI_RDAT = 5'h08,
    SPI_WDAT = 5'h0c,
    SPI_CMD  = 5'h10;

    // Durum makinesi parametreleri
    localparam [2:0]
    IDLE  = 3'b001,
    WRITE = 3'b010,
    READ  = 3'b100;

    // SPI donanim yazmaclari
    reg [2:0] state, state_next;
    reg [31:0] mosi_buffer[7:0],mosi_buffer_next[7:0],miso_buffer[7:0],miso_buffer_next[7:0]; 
    reg [ 3:0] mosi_tail, mosi_tail_next, miso_tail, miso_tail_next;
    reg [31:0] wb_dat_o_r, wb_dat_o_r_next;
    assign wb_dat_o = wb_dat_o_r;
    reg [31:0]  spi_rdata, spi_rdata_next; // fifo in
    reg [32:0]    spi_wdata, spi_wdata_next; // fifo out
    reg spi_cs_o_r, spi_cs_o_r_next;
    assign spi_cs_o = spi_cs_o_r;
    reg spi_sck_o_r, spi_sck_o_r_next;
    assign spi_sck_o = spi_sck_o_r;
    assign spi_mosi_o = spi_wdata[32];

    // Sayaclar
    reg [15:0] clock_ctr, clock_ctr_next;
    reg [ 8:0] bit_ctr, bit_ctr_next;
    reg [ 8:0] flow_ctr, flow_ctr_next;

    // CTRL yazmaci
    reg  [31:0] spi_ctrl, spi_ctrl_next; // 20 bit yeterli?
    wire        spi_en  = spi_ctrl[0];
    wire        spi_rst = spi_ctrl[1];
    wire        cpha    = spi_ctrl[2];
    wire        cpol    = spi_ctrl[3];
    wire [15:0] sck_div = spi_ctrl[31:16];


    // STAT yazmaci
    wire mosi_full  = (mosi_tail == 4'd8);
    wire mosi_empty = (mosi_tail == 4'd0);
    wire miso_full  = (miso_tail == 4'd8);
    wire miso_empty = (miso_tail == 4'd0);
    // TODO
    wire cmd_full   = 1'b0; // CMD buffer'da neler tutuluyor?
    wire cmd_empty  = 1'b0; // CMD buffer'da neler tutuluyor?

    // CMD yazmaci
    reg [31:0]  spi_cmd, spi_cmd_next;
    wire[ 8:0]  length      = spi_cmd[8:0];
    wire        cs_active   = spi_cmd[9];
    wire        miso_en     = spi_cmd[12];
    wire        mosi_en     = spi_cmd[13];

    integer loop_counter;
    always@*begin
        for(loop_counter=0; loop_counter<8; loop_counter=loop_counter+1) begin
            miso_buffer_next[loop_counter] = miso_buffer[loop_counter];
            mosi_buffer_next[loop_counter] = mosi_buffer[loop_counter];
        end
        miso_tail_next = miso_tail;
        mosi_tail_next = mosi_tail;
        spi_ctrl_next = spi_ctrl;
        spi_rdata_next = spi_rdata;
        spi_wdata_next = spi_wdata;
        spi_cmd_next = spi_cmd;
        spi_cs_o_r_next = spi_cs_o_r;
        spi_sck_o_r_next = spi_sck_o_r;
        state_next = state;
        clock_ctr_next = clock_ctr;
        bit_ctr_next = bit_ctr;
        flow_ctr_next = flow_ctr;

        if(spi_en)begin
            if(clock_ctr == 0)begin
                case(state)
                    IDLE :begin
                            if(mosi_en & ~miso_en)begin
                                clock_ctr_next = sck_div;
                                bit_ctr_next = 9'd32;
                                flow_ctr_next = length;
                                spi_sck_o_r_next = cpol;
                                spi_cs_o_r_next = 1'b0;
                                state_next = WRITE;
                                spi_wdata_next = {1'b0, mosi_buffer[0]};
                            end else if(miso_en & ~mosi_en)begin
                                clock_ctr_next = sck_div;
                                bit_ctr_next = 9'd32;
                                flow_ctr_next = length;
                                spi_sck_o_r_next = cpol;
                                spi_cs_o_r_next = 1'b0;
                                state_next = READ;
                            end else begin
                                clock_ctr_next = 16'd0;
                                state_next = IDLE;
                                spi_cs_o_r_next = 1'b1;
                                spi_sck_o_r_next = cpol;
                            end
                    end
                    WRITE:begin
                        clock_ctr_next  = sck_div;
                        if(bit_ctr == 16'd0) begin // Byte tamamlandi
                            mosi_buffer_next[0] = mosi_buffer[1];
                            mosi_buffer_next[1] = mosi_buffer[2];
                            mosi_buffer_next[2] = mosi_buffer[3];
                            mosi_buffer_next[3] = mosi_buffer[4];
                            mosi_buffer_next[4] = mosi_buffer[5];
                            mosi_buffer_next[5] = mosi_buffer[6];
                            mosi_buffer_next[6] = mosi_buffer[7];
                            mosi_buffer_next[7] = 32'd0;
                            mosi_tail_next = mosi_tail - 4'd1;
                            if(flow_ctr > 9'd0) begin // Sonraki byte
                                clock_ctr_next = sck_div;
                                bit_ctr_next = 9'd32;
                                flow_ctr_next = flow_ctr - 9'd1;
                                state_next = WRITE;
                                spi_wdata_next = {1'b0, mosi_buffer[0]};
                            end else begin // Tum veri aktarildi
                                state_next       = IDLE;
                                clock_ctr_next   = 16'd0;
                                spi_ctrl_next[0] = 1'b0;
                                spi_cmd_next[13] = 1'b0; // burda olmali?
                                spi_cs_o_r_next  = ~cs_active;
                                spi_sck_o_r_next = 1'b0;
                            end
                        end else begin
                            spi_sck_o_r_next  = ~spi_sck_o_r_next;
                            state_next = WRITE;
                            if(spi_sck_o_r == ~(cpol^cpha)) begin
                                bit_ctr_next = bit_ctr - 16'd1;
                                spi_wdata_next = {spi_wdata[31:0], 1'b0};
                            end
                        end
                    end
                    READ :begin
                        clock_ctr_next  = sck_div;
                        if(bit_ctr == 16'd0) begin
                            miso_buffer_next[miso_tail-1] = spi_rdata;
                            miso_tail_next = miso_tail + 4'd1;
                            if(flow_ctr > 9'd0) begin // Sonraki byte
                                clock_ctr_next = sck_div;
                                bit_ctr_next = 9'd32;
                                flow_ctr_next = flow_ctr - 9'd1;
                                state_next = READ;
                            end else begin // Tum bytelar okundu
                                state_next       = IDLE;
                                clock_ctr_next   = 16'd0;
                                spi_ctrl_next[0] = 1'b0;
                                spi_cmd_next[12] = 1'b0; // burda olmali?
                                spi_cs_o_r_next  = ~cs_active;
                                spi_sck_o_r_next = 1'b0;
                            end
                        end else begin
                            spi_sck_o_r_next  = ~spi_sck_o_r_next;
                            state_next = READ;
                            if(spi_sck_o_r == (cpol^cpha)) begin
                                bit_ctr_next    = bit_ctr - 16'd1;
                                spi_rdata_next  = {spi_rdata[30:0], spi_miso_i};
                            end
                        end
                    end
                endcase
            end else begin
                clock_ctr_next = clock_ctr - 16'b1;
            end
        end

        case(wb_adr_i[4:0])
            SPI_CTRL:begin
                if(wb_we_i)begin
                    spi_ctrl_next = wb_dat_i;//{wb_dat_i[31:16],wb_dat_i[3:0]};
                end else begin
                    wb_dat_o_r_next = spi_ctrl;
                end
            end
            SPI_STAT:begin
                if(~wb_we_i)begin
                    wb_dat_o_r_next = {26'b0,cmd_empty,cmd_full,miso_empty, miso_full, mosi_empty, mosi_full};
                end
            end
            SPI_RDAT:begin
                if(~wb_we_i & ~miso_empty)begin
                    wb_dat_o_r_next = miso_buffer[0];
                    miso_buffer_next[0] = miso_buffer[1];
                    miso_buffer_next[1] = miso_buffer[2];
                    miso_buffer_next[2] = miso_buffer[3];
                    miso_buffer_next[3] = miso_buffer[4];
                    miso_buffer_next[4] = miso_buffer[5];
                    miso_buffer_next[5] = miso_buffer[6];
                    miso_buffer_next[6] = miso_buffer[7];
                    miso_buffer_next[7] = 32'd0;
                    miso_tail_next = miso_tail - 4'd1;
                end
            end
            SPI_WDAT:begin
                if(wb_we_i & ~mosi_full)begin
                    mosi_buffer_next[(mosi_empty?mosi_tail:(mosi_tail-1))] = wb_dat_i;
                    mosi_tail_next = mosi_tail + 4'b1;
                end
            end
            SPI_CMD :begin
                if(wb_we_i)begin
                    spi_cmd_next = wb_dat_i;
                end else begin
                    wb_dat_o_r_next = spi_cmd;
                end
            end
        endcase
    end

    always@(posedge clk_i)begin
        if(rst_i | spi_rst)begin
            for(loop_counter=0; loop_counter<8; loop_counter=loop_counter+1) begin
                miso_buffer[loop_counter] = 0;
                mosi_buffer[loop_counter] = 0;
            end
            miso_tail = 0;
            mosi_tail = 0;
            spi_ctrl = 0;
            spi_rdata = 0;
            spi_wdata = 0;
            spi_cmd = 0;
            spi_cs_o_r = 1;
            spi_sck_o_r = 0;
            state = IDLE;
            clock_ctr = 0;
            bit_ctr = 0;
            flow_ctr = 0;
        end else begin
            for(loop_counter=0; loop_counter<8; loop_counter=loop_counter+1) begin
                miso_buffer[loop_counter] = miso_buffer_next[loop_counter];
                mosi_buffer[loop_counter] = mosi_buffer_next[loop_counter];
            end
            miso_tail = miso_tail_next;
            mosi_tail = mosi_tail_next;
            spi_ctrl = spi_ctrl_next;
            spi_rdata = spi_rdata_next;
            spi_wdata = spi_wdata_next;
            spi_cmd = spi_cmd_next;
            spi_cs_o_r = spi_cs_o_r_next;
            spi_sck_o_r = spi_sck_o_r_next;
            state = state_next;
            clock_ctr = clock_ctr_next;
            bit_ctr = bit_ctr_next;
            flow_ctr = flow_ctr_next;
        end
    end
endmodule