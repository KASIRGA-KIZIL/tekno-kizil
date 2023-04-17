`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: TUBITAK TUTEL
// Engineer:
//
// Create Date: 27.04.2022 10:41:19
// Design Name: TEKNOFEST
// Module Name: teknofest_ram
// Project Name: TEKNOFEST
// Target Devices: Nexys A7
// Tool Versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////


module teknofest_ram_basys3 #(
  parameter NB_COL = 4,
  parameter COL_WIDTH = 8,
  parameter RAM_DEPTH = 131072,
  parameter INIT_FILE = "C:/Users/TUTEL/Desktop/TEKNOFEST/tekno_sw/outputs/hex/uart_test.hex"
)
(
  input clk_i,
  input rst_ni,

  input [clogb2(RAM_DEPTH-1)-1:0] wr_addr,
  input [clogb2(RAM_DEPTH-1)-1:0] rd_addr,
  input [(NB_COL*COL_WIDTH)-1:0]  wr_data,
  input [NB_COL-1:0]              wr_strb,
  output [(NB_COL*COL_WIDTH)-1:0] rd_data,

  input  rd_en,
  input  ram_prog_rx_i,
  output system_reset_o,
  output prog_mode_led_o
    );

localparam CPU_CLK   = 60_000_000;   //Default CPU frequency on FPGA
localparam BAUD_RATE = 9600;          //Default Baud rate for programming on the run via UART

reg [(NB_COL*COL_WIDTH)-1:0] ram [RAM_DEPTH-1:0];
reg [(NB_COL*COL_WIDTH)-1:0] ram_data;

wire [31:0] ram_prog_data;
wire        ram_prog_data_valid;

reg  [clogb2(RAM_DEPTH-1)-1:0] prog_addr;
wire [clogb2(RAM_DEPTH-1)-1:0] wr_addr_ram;
wire [(NB_COL*COL_WIDTH)-1:0]  wr_data_ram;

assign wr_addr_ram = (prog_mode_led_o && ram_prog_data_valid) ? prog_addr : wr_addr;
assign wr_data_ram = (prog_mode_led_o && ram_prog_data_valid) ? ram_prog_data : wr_data;

generate
  if (INIT_FILE != "") begin: use_init_file
    initial
      $readmemh(INIT_FILE, ram, 0, RAM_DEPTH-1);
  end else begin: init_bram_to_zero
    integer ram_index;
    initial
      for (ram_index = 0; ram_index < RAM_DEPTH; ram_index = ram_index + 1)
        ram[ram_index] = {(NB_COL*COL_WIDTH){1'b0}};
  end
endgenerate

always @(posedge clk_i)
  if (rd_en)
    ram_data <= ram[rd_addr];

generate
genvar i;
   for (i = 0; i < NB_COL; i = i+1) begin: byte_write
     always @(posedge clk_i)
       if (wr_strb[i] || (prog_mode_led_o && ram_prog_data_valid))
         ram[wr_addr_ram][(i+1)*COL_WIDTH-1:i*COL_WIDTH] <= wr_data_ram[(i+1)*COL_WIDTH-1:i*COL_WIDTH];
   end
endgenerate

always @(posedge clk_i) begin
  if (!(rst_ni && system_reset_o)) begin
    prog_addr <= 'h0;
  end else begin
    if (prog_mode_led_o && ram_prog_data_valid) begin
      prog_addr <= prog_addr + 1'b1;
    end
  end
end

assign rd_data = ram_data;

//  The following function calculates the address width based on specified RAM depth
function integer clogb2;
  input integer depth;
    for (clogb2=0; depth>0; clogb2=clogb2+1)
      depth = depth >> 1;
endfunction

//  programmer program_ram(
//    .clock(clk_i),
//    .reset(rst_ni),
//    .rx(ram_prog_rx_i),
//    .ReceivedInstruction(ram_prog_data),
//    .ReceivedInstructionValid(ram_prog_data_valid),
//    .SystemReset(system_reset_o),
//    .ProbRx(ProbRx),
//    .ProgMode(prog_mode_led_o)
//  );

localparam PROGRAM_SEQUENCE    = "TEKNOFEST";
localparam PROG_SEQ_LENGTH     = 9 ;
localparam SEQ_BREAK_THRESHOLD = 32'd1000000;

reg [PROG_SEQ_LENGTH*8-1:0] received_sequence;
reg [3:0] rcv_seq_ctr;

reg  [31:0] sequence_break_ctr;
wire        sequence_break;
wire [31:0] prog_uart_do;

localparam SequenceWait       = 3'b000;
localparam SequenceReceive    = 3'b001;
localparam SequenceCheck      = 3'b011;
localparam SequenceLengthCalc = 3'b010;
localparam SequenceProgram    = 3'b110;
localparam SequenceFinish     = 3'b100;

reg [2:0]  state_prog;
reg [2:0]  state_prog_next;
reg [1:0]  instruction_byte_ctr;
reg [31:0] prog_instruction;
reg [31:0] prog_intr_number;
reg [31:0] prog_intr_ctr;

reg  prog_inst_valid;
reg  prog_sys_rst_n;
wire ram_prog_rd_en;

assign ram_prog_data       = prog_instruction;
assign ram_prog_data_valid = prog_inst_valid;
assign system_reset_o      = prog_sys_rst_n;
assign ram_prog_rd_en      = (state_prog != SequenceFinish);
assign prog_mode_led_o     = (state_prog == SequenceProgram);
assign sequence_break      = sequence_break_ctr == SEQ_BREAK_THRESHOLD;

always @(posedge clk_i) begin
  if (!rst_ni) begin
    state_prog <= SequenceWait;
  end else begin
    state_prog <= state_prog_next;
  end
end

always @(*) begin
  state_prog_next = state_prog;
  case (state_prog)
    SequenceWait: begin
      if (prog_uart_do != ~0) begin
        state_prog_next = SequenceReceive;
      end
    end
    SequenceReceive: begin
      if (prog_uart_do != ~0) begin
        if (rcv_seq_ctr == PROG_SEQ_LENGTH-1) begin
          state_prog_next = SequenceCheck;
        end
      end else if (sequence_break) begin
        state_prog_next = SequenceWait;
      end
    end
    SequenceCheck: begin
      if (received_sequence == PROGRAM_SEQUENCE) begin
        state_prog_next = SequenceLengthCalc;
      end else begin
        state_prog_next = SequenceWait;
      end
    end
    SequenceLengthCalc: begin
      if ((prog_uart_do != ~0) && &instruction_byte_ctr) begin
        state_prog_next = SequenceProgram;
      end
    end
    SequenceProgram: begin
      if (prog_intr_ctr == prog_intr_number) begin
        state_prog_next = SequenceFinish;
      end
    end
    SequenceFinish: begin
      state_prog_next = SequenceWait;
    end
    default:begin
    end
  endcase
end

always @(posedge clk_i) begin
  if (!rst_ni) begin
    instruction_byte_ctr <= 2'b0;
    prog_instruction     <= 32'h0;
    prog_intr_number     <= 32'h0;
    prog_intr_ctr        <= 32'h0;
    sequence_break_ctr   <= 32'h0;
    received_sequence    <= 72'h0;
    rcv_seq_ctr          <= 4'h0;
    prog_inst_valid      <= 1'b0;
    prog_sys_rst_n       <= 1'b1;
  end else begin
    case (state_prog)
      SequenceWait: begin
        instruction_byte_ctr <= 2'b0;
        prog_instruction     <= 32'h0;
        prog_intr_number     <= 32'h0;
        prog_intr_ctr        <= 32'h0;
        sequence_break_ctr   <= 32'h0;
        received_sequence    <= 72'h0;
        rcv_seq_ctr          <= 4'h0;
        prog_inst_valid      <= 1'b0;
        prog_sys_rst_n       <= 1'b1;
        if (prog_uart_do != ~0) begin
          rcv_seq_ctr <= rcv_seq_ctr + 4'h1;
          received_sequence <= {received_sequence[PROG_SEQ_LENGTH*8-9:0],prog_uart_do[7:0]};
        end
      end
      SequenceReceive: begin
        if (prog_uart_do != ~0) begin
          received_sequence <= {received_sequence[PROG_SEQ_LENGTH*8-9:0],prog_uart_do[7:0]};
          if (rcv_seq_ctr == PROG_SEQ_LENGTH-1) begin
            rcv_seq_ctr <= 4'h0;
          end else begin
            rcv_seq_ctr <= rcv_seq_ctr + 4'h1;
          end
        end else begin
          if (sequence_break) begin
            sequence_break_ctr <= 32'h0;
            rcv_seq_ctr        <= 4'h0;
          end else begin
            sequence_break_ctr <= sequence_break_ctr + 32'h1;
          end
        end
      end
      SequenceCheck: begin
        instruction_byte_ctr <= 2'b0;
      end
      SequenceLengthCalc: begin
        prog_intr_ctr <= 32'h0;
        if (prog_uart_do != ~0) begin
          prog_intr_number <= {prog_intr_number[3*8-1:0],prog_uart_do[7:0]};
          if (&instruction_byte_ctr) begin
            instruction_byte_ctr <= 2'b0;
          end else begin
            instruction_byte_ctr <= instruction_byte_ctr + 2'b1;
          end
        end
      end
      SequenceProgram: begin
        if (prog_uart_do != ~0) begin
          prog_instruction <= {prog_instruction[3*8-1:0],prog_uart_do[7:0]};
          if (&instruction_byte_ctr) begin
            instruction_byte_ctr <= 2'b0;
            prog_inst_valid      <= 1'b1;
            prog_intr_ctr        <= prog_intr_ctr + 32'h1;
          end else begin
            instruction_byte_ctr <= instruction_byte_ctr + 2'b1;
            prog_inst_valid      <= 1'b0;
          end
        end else begin
          prog_inst_valid      <= 1'b0;
        end
      end
      SequenceFinish: begin
        prog_sys_rst_n <= 1'b0;
      end
      default: begin
      end
    endcase
  end
end

simpleuart #(
    .DEFAULT_DIV(CPU_CLK/BAUD_RATE)
  )
  simpleuart (
		.clk         (clk_i),
		.resetn      (rst_ni),

		.ser_tx      (),
		.ser_rx      (ram_prog_rx_i),

		.reg_div_we  (4'h0),
		.reg_div_di  (32'h0),
		.reg_div_do  (),

		.reg_dat_we  (1'b0),
		.reg_dat_re  (ram_prog_rd_en),
		.reg_dat_di  (32'h0),
		.reg_dat_do  (prog_uart_do)
	);

endmodule

