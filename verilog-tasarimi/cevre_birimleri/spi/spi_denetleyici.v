// spi_denetleyici.v
`timescale 1ns / 1ps

`include "tanimlamalar.vh"

module spi_denetleyici (
   input clk_i,
   input rst_i,
   // Wishbone arayüzü
   input  [ 4:0] wb_adr_i,
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
   READ  = 3'b100,
   DUMMY = 3'b111;
   
   // SPI donanim yazmaclari
   reg  [ 2:0] state, state_next;
   reg  [31:0] mosi_buffer[7:0],mosi_buffer_next[7:0],miso_buffer[7:0],miso_buffer_next[7:0]; 
   reg  [ 3:0] mosi_tail, mosi_tail_next, miso_tail, miso_tail_next;
   reg  [31:0] wb_dat_o_r, wb_dat_o_r_next;
   reg         wb_ack_o_r,wb_ack_o_r_next;
   reg [31:0]  spi_rdata, spi_rdata_next; // fifo in
   reg [31:0]  spi_wdata, spi_wdata_next; // fifo out
   reg         spi_cs_o_r, spi_cs_o_r_next;
   reg         spi_sck_o_r, spi_sck_o_r_next;
   assign      wb_dat_o    = wb_dat_o_r;
   assign      wb_ack_o    = wb_ack_o_r;
   assign      spi_cs_o    = spi_cs_o_r;
   assign      spi_sck_o   = spi_sck_o_r;
   assign      spi_mosi_o  = spi_wdata[31];
   
   // Sayaclar
   reg [15:0] clock_ctr, clock_ctr_next;
   reg [ 3:0] bit_ctr, bit_ctr_next;
   reg [ 8:0] flow_ctr, flow_ctr_next;
   reg [ 2:0] byte_ctr, byte_ctr_next;
   
   // CTRL yazmaci
   reg  [31:0] spi_ctrl, spi_ctrl_next; // 20 bit yeterli?
   wire        spi_en  = spi_ctrl[0];
   wire        spi_rst = spi_ctrl[1];
   wire        cpha    = spi_ctrl[2];
   wire        cpol    = spi_ctrl[3];
   wire [15:0] sck_div = spi_ctrl[31:16];
   
   // CMD yazmaci
   reg  [31:0]  cmd_buffer[7:0], cmd_buffer_next[7:0];
   reg  [ 3:0]  cmd_tail,cmd_tail_next;
   wire [31:0]  cmd = cmd_buffer[0];
   wire [ 8:0]  length      = cmd[8:0];
   wire         cs_active   = cmd[9];
   wire         miso_en     = cmd[12];
   wire         mosi_en     = cmd[13];
   
   // STAT yazmaci
   wire mosi_full  = (mosi_tail == 4'd8);
   wire mosi_empty = (mosi_tail == 4'd0);
   wire miso_full  = (miso_tail == 4'd8);
   wire miso_empty = (miso_tail == 4'd0);
   wire cmd_full   = (cmd_tail == 4'd8);
   wire cmd_empty  = (cmd_tail == 4'd0);
   
   
   integer loop_counter;
   always@*begin
      // varsayilan degerleri ata
      for(loop_counter=0; loop_counter<8; loop_counter=loop_counter+1) begin
         miso_buffer_next[loop_counter] = miso_buffer[loop_counter];
         mosi_buffer_next[loop_counter] = mosi_buffer[loop_counter];
         cmd_buffer_next[loop_counter]  = cmd_buffer[loop_counter];
      end
      miso_tail_next = miso_tail;
      mosi_tail_next = mosi_tail;
      cmd_tail_next = cmd_tail;
      spi_ctrl_next = spi_ctrl;
      spi_rdata_next = spi_rdata;
      spi_wdata_next = spi_wdata;
      spi_cs_o_r_next = spi_cs_o_r;
      spi_sck_o_r_next = spi_sck_o_r;
      state_next = state;
      clock_ctr_next = clock_ctr;
      bit_ctr_next = bit_ctr;
      byte_ctr_next = byte_ctr;
      flow_ctr_next = flow_ctr;
      wb_dat_o_r_next = wb_dat_o_r;
      wb_ack_o_r_next = wb_ack_o_r;
      
      if(spi_en)begin
         if(clock_ctr == 0)begin
            case(state)
               // hazirda bekle
               IDLE :begin
                  // yazma komutu basla
                  if(mosi_en & ~miso_en & ~mosi_empty)begin
                     clock_ctr_next = sck_div;
                     bit_ctr_next = 4'd8 + cpha;
                     byte_ctr_next = (length>9'd3)? 3'd3 : {1'b0,length[1:0]};
                     flow_ctr_next = length;
                     spi_sck_o_r_next = cpol;
                     spi_cs_o_r_next = 1'b0;
                     state_next = WRITE;
                     spi_wdata_next = mosi_buffer[0];
                  end else if(miso_en & ~mosi_en & ~miso_full)begin
                     // okuma komutu basla
                     clock_ctr_next = sck_div;
                                bit_ctr_next = 4'd8 + cpha;
                     byte_ctr_next = (length>9'd3)? 3'd3 : {1'b0,length[1:0]};
                     flow_ctr_next = length;
                     spi_sck_o_r_next = cpol;
                     spi_cs_o_r_next = 1'b0;
                     state_next = READ;
                  end else if(~miso_en & ~mosi_en & (|cmd_tail))begin
                     // bos dongu
                     clock_ctr_next = sck_div;
                     bit_ctr_next = 4'd8 + cpha;
                     byte_ctr_next = (length>9'd3)? 3'd3 : {1'b0,length[1:0]};
                     flow_ctr_next = length;
                     spi_sck_o_r_next = cpol;
                     spi_cs_o_r_next = 1'b0;
                     state_next = DUMMY;
                  end else begin
                     clock_ctr_next = 16'b0;
                     bit_ctr_next = 4'd0;
                     byte_ctr_next = 3'd0;
                     flow_ctr_next = 9'd0;
                     state_next = IDLE;
                     spi_cs_o_r_next = spi_cs_o_r;
                     spi_sck_o_r_next = cpol;
                  end
               end
               // yazma
               WRITE:begin
                  clock_ctr_next  = sck_div;
                  if(bit_ctr == 4'b0) begin // Byte tamamlandi
                     byte_ctr_next = byte_ctr - 3'b1;
                     if(byte_ctr == 3'b0)begin
                        mosi_buffer_next[0] = mosi_buffer[1];
                        mosi_buffer_next[1] = mosi_buffer[2];
                        mosi_buffer_next[2] = mosi_buffer[3];
                        mosi_buffer_next[3] = mosi_buffer[4];
                        mosi_buffer_next[4] = mosi_buffer[5];
                        mosi_buffer_next[5] = mosi_buffer[6];
                        mosi_buffer_next[6] = mosi_buffer[7];
                        mosi_buffer_next[7] = 32'd0;
                        mosi_tail_next = mosi_tail - 4'd1;
                        spi_wdata_next = mosi_buffer[1];
                        byte_ctr_next = (flow_ctr>9'd3)? 3'd3 : {1'b0,(flow_ctr[1:0] - 2'd1)};
                     end
                     if(flow_ctr > 9'd0) begin // Sonraki byte
                        clock_ctr_next = sck_div;
                        bit_ctr_next = 4'd8;
                        flow_ctr_next = flow_ctr - 9'd1;
                        state_next = WRITE;
                     end else begin // Tum veri aktarildi
                        state_next       = IDLE;
                        clock_ctr_next   = 16'b0;
                        // flow bitince de tail azalmali mi?
                        mosi_buffer_next[0] = mosi_buffer[1];
                        mosi_buffer_next[1] = mosi_buffer[2];
                        mosi_buffer_next[2] = mosi_buffer[3];
                        mosi_buffer_next[3] = mosi_buffer[4];
                        mosi_buffer_next[4] = mosi_buffer[5];
                        mosi_buffer_next[5] = mosi_buffer[6];
                        mosi_buffer_next[6] = mosi_buffer[7];
                        mosi_buffer_next[7] = 32'd0;
                        mosi_tail_next = mosi_tail - 4'd1;
                        // istenen command tamamlandi cmd buffer kaydir
                        cmd_buffer_next [0] = cmd_buffer[1];
                        cmd_buffer_next [1] = cmd_buffer[2];
                        cmd_buffer_next [2] = cmd_buffer[3];
                        cmd_buffer_next [3] = cmd_buffer[4];
                        cmd_buffer_next [4] = cmd_buffer[5];
                        cmd_buffer_next [5] = cmd_buffer[6];
                        cmd_buffer_next [6] = cmd_buffer[7];
                        cmd_buffer_next [7] = 32'd0;
                        cmd_tail_next = cmd_tail - 4'b1;
                        
                        spi_cs_o_r_next  = ~cs_active;
                        spi_sck_o_r_next = spi_sck_o_r;
                     end
                  end else begin
                     spi_sck_o_r_next  = ~spi_sck_o_r_next;
                     state_next = WRITE;
                     if(spi_sck_o_r == ~(cpol^cpha))begin
                        bit_ctr_next = bit_ctr - 4'b1;
                        if(~cpha || bit_ctr != 9)begin
                           spi_wdata_next = {spi_wdata[30:0],1'b0};
                        end
                     end
                  end
               end
               // okuma
               READ :begin
                  clock_ctr_next  = sck_div;
                  if(bit_ctr == 4'b0) begin // Byte tamamlandi
                     byte_ctr_next = byte_ctr - 3'b1;
                     if(byte_ctr == 3'b0)begin // Buffer indexi doldu
                        miso_buffer_next[miso_tail] = ({spi_rdata[7:0],spi_rdata[15:8],spi_rdata[23:16],spi_rdata[31:24]})>>({(2'd3-length[1:0]),3'b0});
                        miso_tail_next = miso_tail + 4'd1;
                        byte_ctr_next = 3'd3;
                        spi_rdata_next = 32'd0;
                     end
                     if(flow_ctr > 9'd0) begin // Sonraki byte
                        clock_ctr_next = sck_div;
                        bit_ctr_next = 4'd8;
                        flow_ctr_next = flow_ctr - 9'd1;
                        state_next = READ;
                     end else begin // Tum bytelar okundu
                        state_next       = IDLE;
                        clock_ctr_next   = 16'b0;
                        // flow bitti ne olursa olsun tail kaydir
                        miso_buffer_next[miso_tail] = ({spi_rdata[7:0],spi_rdata[15:8],spi_rdata[23:16],spi_rdata[31:24]})>>({(2'd3-length[1:0]),3'b0});// Buraya daha iyi bi cozum?
                        miso_tail_next = miso_tail + 4'd1;
                        // islem tamamlandi cmd buffer kaydir
                        cmd_buffer_next [0] = cmd_buffer[1];
                        cmd_buffer_next [1] = cmd_buffer[2];
                        cmd_buffer_next [2] = cmd_buffer[3];
                        cmd_buffer_next [3] = cmd_buffer[4];
                        cmd_buffer_next [4] = cmd_buffer[5];
                        cmd_buffer_next [5] = cmd_buffer[6];
                        cmd_buffer_next [6] = cmd_buffer[7];
                        cmd_buffer_next [7] = 32'd0;
                        cmd_tail_next = cmd_tail - 4'b1;
                        spi_rdata_next = 32'd0;
                        spi_cs_o_r_next  = ~cs_active;
                        spi_sck_o_r_next = cpol;
                     end
                  end else begin
                     spi_sck_o_r_next  = ~spi_sck_o_r;
                     state_next = READ;
                     if(spi_sck_o_r == (cpol^cpha)) begin
                        bit_ctr_next    = bit_ctr - 4'b1;
                        if(~cpha || bit_ctr != 9)begin
                           spi_rdata_next  = {spi_rdata[30:0],spi_miso_i};
                        end
                     end
                  end
               end
               // bos dongu
               DUMMY:begin
                  clock_ctr_next  = sck_div;
                  if(bit_ctr == 4'b0) begin // Byte tamamlandi
                     if(byte_ctr == 3'b0)begin
                        byte_ctr_next = 3'd3;
                     end
                     if(flow_ctr > 9'd0) begin // Sonraki byte
                        clock_ctr_next = sck_div;
                        bit_ctr_next = 4'd8;
                        flow_ctr_next = flow_ctr - 9'd1;
                        state_next = DUMMY;
                     end else begin // Tum bytelar okundu
                        state_next       = IDLE;
                        clock_ctr_next   = 16'b0;
                        cmd_tail_next = cmd_tail - 4'b1;
                        spi_cs_o_r_next  = ~cs_active;
                        spi_sck_o_r_next = cpol;
                     end
                  end else begin
                     spi_sck_o_r_next  = ~spi_sck_o_r;
                     state_next = DUMMY;
                     if(spi_sck_o_r == (cpol^cpha)) begin
                        bit_ctr_next    = bit_ctr - 4'b1;
                     end
                  end
               end
               default:begin
                  wb_dat_o_r_next = wb_dat_o_r; //nop
               end
            endcase
         end else begin
            clock_ctr_next = clock_ctr - 16'b1;
         end
      end
      // veriyolundan spi'a erisildi
      if(wb_cyc_i & wb_stb_i & ~wb_ack_o_r)begin
         wb_ack_o_r_next = 1'b1;
         case(wb_adr_i[4:0])
            SPI_CTRL:begin
               if(wb_we_i)begin
                  spi_ctrl_next[ 7: 0] = wb_sel_i[0] ? wb_dat_i[ 7: 0] : 8'b0;
                  spi_ctrl_next[15: 8] = wb_sel_i[1] ? wb_dat_i[15: 8] : 8'b0;
                  spi_ctrl_next[23:16] = wb_sel_i[2] ? wb_dat_i[23:16] : 8'b0;
                  spi_ctrl_next[31:24] = wb_sel_i[3] ? wb_dat_i[31:24] : 8'b0;
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
                  // bufferdan veriyoluna veri aktar
                  wb_dat_o_r_next = miso_buffer[0];
                  // fifo'yu kaydir
                  miso_buffer_next[0] = miso_buffer[1];
                  miso_buffer_next[1] = miso_buffer[2];
                  miso_buffer_next[2] = miso_buffer[3];
                  miso_buffer_next[3] = miso_buffer[4];
                  miso_buffer_next[4] = miso_buffer[5];
                  miso_buffer_next[5] = miso_buffer[6];
                  miso_buffer_next[6] = miso_buffer[7];
                  miso_buffer_next[7] = 32'd0;
                  // fifo kuyrugunu azalt
                  miso_tail_next = miso_tail - 4'd1;
               end
            end
            SPI_WDAT:begin
               if(wb_we_i & ~mosi_full)begin
                  // fifo kuyruguna yazma verisi sakla
                  mosi_buffer_next[mosi_tail[2:0]][ 7: 0] = wb_sel_i[0] ? wb_dat_i[31:24] : mosi_buffer[mosi_tail[2:0]];
                  mosi_buffer_next[mosi_tail[2:0]][15: 8] = wb_sel_i[1] ? wb_dat_i[23:16] : mosi_buffer[mosi_tail[2:0]];
                  mosi_buffer_next[mosi_tail[2:0]][23:16] = wb_sel_i[2] ? wb_dat_i[15: 8] : mosi_buffer[mosi_tail[2:0]];
                  mosi_buffer_next[mosi_tail[2:0]][31:24] = wb_sel_i[3] ? wb_dat_i[ 7: 0] : mosi_buffer[mosi_tail[2:0]];
                  // fifo kuyrugunu artir
                  mosi_tail_next = mosi_tail + 4'b1;
               end
            end
            SPI_CMD :begin
               if(wb_we_i & ~cmd_full)begin
                  // komut fifosuna sakla
                  cmd_buffer_next[cmd_tail[2:0]][ 7: 0] = wb_sel_i[0] ? wb_dat_i[ 7: 0] : 8'b0;
                  cmd_buffer_next[cmd_tail[2:0]][15: 8] = wb_sel_i[1] ? wb_dat_i[15: 8] : 8'b0;
                  cmd_buffer_next[cmd_tail[2:0]][23:16] = wb_sel_i[2] ? wb_dat_i[23:16] : 8'b0;
                  cmd_buffer_next[cmd_tail[2:0]][31:24] = wb_sel_i[3] ? wb_dat_i[31:24] : 8'b0;
                  // fifo kuyrugunu artir
                  cmd_tail_next = cmd_tail + 4'b1;
               end else begin
                  wb_dat_o_r_next = cmd;
               end
            end
            default:begin
               wb_dat_o_r_next = wb_dat_o_r; //nop
            end
         endcase
      end
      // yalnizca 1 cevrimlik ack sinyali icin
      if(wb_ack_o_r)begin
         wb_ack_o_r_next = 1'b0;
      end
   end
   
   always@(posedge clk_i)begin
      if(rst_i | spi_rst)begin
         for(loop_counter=0; loop_counter<8; loop_counter=loop_counter+1) begin
             miso_buffer[loop_counter] = 0;
             mosi_buffer[loop_counter] = 0;
             cmd_buffer[loop_counter]  = 0;
         end
         miso_tail       = 0;
         mosi_tail       = 0;
         cmd_tail        = 0;
         spi_ctrl        = 0;
         spi_rdata       = 0;
         spi_wdata       = 0;
         spi_cs_o_r      = 1;
         spi_sck_o_r     = 0;
         state           = IDLE;
         clock_ctr       = 0;
         bit_ctr         = 0;
         byte_ctr        = 0;
         flow_ctr        = 0;
         wb_dat_o_r      = 0;
         wb_ack_o_r      = 0;
      end else begin
         for(loop_counter=0; loop_counter<8; loop_counter=loop_counter+1) begin
            miso_buffer[loop_counter] = miso_buffer_next[loop_counter];
            mosi_buffer[loop_counter] = mosi_buffer_next[loop_counter];
            cmd_buffer[loop_counter]  = cmd_buffer_next[loop_counter];
         end
         miso_tail       = miso_tail_next;
         mosi_tail       = mosi_tail_next;
         cmd_tail        = cmd_tail_next;
         spi_ctrl        = spi_ctrl_next;
         spi_rdata       = spi_rdata_next;
         spi_wdata       = spi_wdata_next;
         spi_cs_o_r      = spi_cs_o_r_next;
         spi_sck_o_r     = spi_sck_o_r_next;
         state           = state_next;
         clock_ctr       = clock_ctr_next;
         bit_ctr         = bit_ctr_next;
         byte_ctr        = byte_ctr_next;
         flow_ctr        = flow_ctr_next;
         wb_dat_o_r      = wb_dat_o_r_next;
         wb_ack_o_r      = wb_ack_o_r_next;
      end
   end
endmodule
