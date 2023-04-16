// uart_verici.v
`timescale 1ns / 1ps

`include "tanimlamalar.vh"

// 1 bit start bit 8 veri bit no parity ve 1 stop bit
// gonderme circular queue araciligi ile yapilir.
module uart_tx (
   input  wire         clk_i,
   input  wire         rst_i,
   input  wire [15: 0] baud_div_i,
   input  wire         we_i,
   input  wire         stall_i,
   input  wire [ 7: 0] data_i,
   output wire         full_o,
   output wire         empty_o,
   output reg          tx_o
);

   reg [4:0] state;
   reg [4:0] next;
   
   localparam IDLE       = 5'd0,
              START_BIT  = 5'd1,
              DATA_0     = 5'd2,
              DATA_1     = 5'd3,
              DATA_2     = 5'd4,
              DATA_3     = 5'd5,
              DATA_4     = 5'd6,
              DATA_5     = 5'd7,
              DATA_6     = 5'd8,
              DATA_7     = 5'd9,
              STOP_BIT0  = 5'd10;
   
   reg [7:0]  queue [31:0];
   
   reg  [4:0] read_ptr;
   reg  [4:0] write_ptr;
   wire [4:0] limit = read_ptr-1;
   
   reg [15:0] counter;
   reg        uart_clk_pulse;
   
   assign full_o  = (limit    == write_ptr);
   assign empty_o = (read_ptr == write_ptr);
   
   always @(posedge clk_i) begin
      if(rst_i)                state <= IDLE;
      else if(uart_clk_pulse)  state <= next;
      
      if (rst_i) begin
         read_ptr       <= 0;
         write_ptr      <= 0;
         counter        <= 0;
         uart_clk_pulse <= 0;
      end else begin
         if(we_i) begin
            write_ptr        <= write_ptr + 1;
            queue[write_ptr] <= data_i;
         end
         if(uart_clk_pulse)begin
            if((state == STOP_BIT0) && (next == IDLE))
               read_ptr <= read_ptr + 1;
         end
         if(counter == baud_div_i) begin
            counter        <= 0;
            uart_clk_pulse <= 1'b1;
         end else begin
            counter <= counter + 1;
            uart_clk_pulse <= 1'b0;
         end
      end
   end
   
   always @(*) begin
      case(state)
         IDLE:  if(~empty_o && ~stall_i) next = START_BIT;
                else                     next = IDLE;
         START_BIT: next = DATA_0;
         DATA_0:    next = DATA_1;
         DATA_1:    next = DATA_2;
         DATA_2:    next = DATA_3;
         DATA_3:    next = DATA_4;
         DATA_4:    next = DATA_5;
         DATA_5:    next = DATA_6;
         DATA_6:    next = DATA_7;
         DATA_7:    next = STOP_BIT0;
         STOP_BIT0: next = IDLE;
         default:   next = IDLE;
      endcase
   end
   always @(*) begin
      case(state)
         IDLE:      tx_o = 1'b1;
         START_BIT: tx_o = 1'b0;
         DATA_0:    tx_o = queue[read_ptr][0];
         DATA_1:    tx_o = queue[read_ptr][1];
         DATA_2:    tx_o = queue[read_ptr][2];
         DATA_3:    tx_o = queue[read_ptr][3];
         DATA_4:    tx_o = queue[read_ptr][4];
         DATA_5:    tx_o = queue[read_ptr][5];
         DATA_6:    tx_o = queue[read_ptr][6];
         DATA_7:    tx_o = queue[read_ptr][7];
         STOP_BIT0: tx_o = 1'b1;
         default:   tx_o = 1'b1;
      endcase
   end
endmodule
