// uart_verici.v
`timescale 1ns / 1ps

`include "tanimlamalar.vh"

// RX paketleri circuilar bir queue ya konulur.
module uart_rx (
   input  wire         clk_i,
   input  wire         rst_i,
   input  wire [15: 0] baud_div_i,
   input  wire         re_i,
   input  wire         stall_i,
   output wire [ 7: 0] data_o,
   output wire         full_o,
   output wire         empty_o,
   input  wire         rx_i
);

   localparam DATA_SIZE = 4'd8;
   
   reg [3:0] state;
   reg [3:0] next;
   
   localparam IDLE      = 4'd0,
              START_BIT = 4'd1,
              DATA_0    = 4'd2,
              DATA_1    = 4'd3,
              DATA_2    = 4'd4,
              DATA_3    = 4'd5,
              DATA_4    = 4'd6,
              DATA_5    = 4'd7,
              DATA_6    = 4'd8,
              DATA_7    = 4'd9,
              STOP_BIT  = 4'd10;
   
   reg [7:0]  queue [31:0];
   reg [4:0]  read_ptr;
   reg [4:0]  write_ptr;
   reg [15:0] counter;
   reg        uart_clk_pulse;
   
   wire [4:0] limit = read_ptr-1;
   assign full_o  = (limit    == write_ptr);
   assign empty_o = (read_ptr == write_ptr);
   assign data_o  = queue[read_ptr];
   
   reg [3:0] start_pattern;
   reg       start_r;
   
   always @(posedge clk_i) begin
      if(rst_i)                state <= IDLE;
      else if(uart_clk_pulse)  state <= next;
      
      if (rst_i) begin
         read_ptr       <= 0;
         write_ptr      <= 0;
         counter        <= 0;
         uart_clk_pulse <= 0;
         start_pattern  <= 0;
         start_r        <= 0;
      end else begin
         if(re_i) begin
            read_ptr         <= read_ptr + 1;
         end
         if(uart_clk_pulse)begin
            if((state == STOP_BIT) && (next == IDLE)) begin
               write_ptr <= write_ptr + 1;
               start_r  <= 1'b0;
            end
         end
         if(counter == baud_div_i) begin
            counter        <= 0;
            uart_clk_pulse <= 1'b1;
         end else begin
            if(start_r) counter <= counter + 1;
            uart_clk_pulse <= 1'b0;
         end
         start_pattern <= {start_pattern[2:0],rx_i};
      end
      if(start_pattern == 4'b1100) begin
         start_r <= 1'b1;
         if(~start_r) begin
            uart_clk_pulse <= 1'b1;
            counter <= baud_div_i;
         end
      end
   end
   
   always @(*) begin
      case(state)
         IDLE:  if(start_r && ~stall_i) next = START_BIT;
                else                     next = IDLE;
         START_BIT: next = DATA_0;
         DATA_0:    next = DATA_1;
         DATA_1:    next = DATA_2;
         DATA_2:    next = DATA_3;
         DATA_3:    next = DATA_4;
         DATA_4:    next = DATA_5;
         DATA_5:    next = DATA_6;
         DATA_6:    next = DATA_7;
         DATA_7:    next = STOP_BIT;
         STOP_BIT:  next = IDLE;
         default:   next = IDLE;
      endcase
   end
   always @(posedge clk_i) begin
      if(uart_clk_pulse)begin
         case(state)
            DATA_0: queue[write_ptr][0] <= rx_i;
            DATA_1: queue[write_ptr][1] <= rx_i;
            DATA_2: queue[write_ptr][2] <= rx_i;
            DATA_3: queue[write_ptr][3] <= rx_i;
            DATA_4: queue[write_ptr][4] <= rx_i;
            DATA_5: queue[write_ptr][5] <= rx_i;
            DATA_6: queue[write_ptr][6] <= rx_i;
            DATA_7: queue[write_ptr][7] <= rx_i;
            default: begin
            end
         endcase
      end
   end
endmodule
