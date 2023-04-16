// wishbone_master.v
`timescale 1ns / 1ps

`include "tanimlamalar.vh"
/*
0x20020000 = PWM  = 00100000000000100000000000000000
0x20010000 = SPI  = 00100000000000010000000000000000
0x20000000 = UART = 00100000000000000000000000000000

Yanlizca gerekli bitlere bakilmasi yeterli.
Wishbone master gerekli cevre birimlerine gore OPTIMIZE edildi.
*/
module wishbone_master(
   input [0:0] clk_i,
   input [0:0] rst_i,
   
   //veriyolu <-> wb interface
   input  [31:0] vy_adres_i,
   input  [31:0] vy_veri_i,
   input  [ 3:0] vy_veri_maske_i,
   input         vy_sec_i,
   output [31:0] vy_veri_o,
   output        vy_durdur_o,
   
   //wb master <-> wb slave interface
   output wire [ 7:0] adr_o ,
   output wire [31:0] dat_o ,
   output wire [0:0]  we_o  ,
   output reg  [0:0]  stb_o ,
   output wire [3:0]  sel_o , // byte select/mask
   // UART
   output     [0:0]  uart_cyc_o ,
   input      [0:0]  uart_ack_i ,
   input      [31:0] uart_dat_i ,
   // SPI
   output     [0:0]  spi_cyc_o ,
   input      [0:0]  spi_ack_i ,
   input      [31:0] spi_dat_i ,
   // PWM
   output     [0:0]  pwm_cyc_o ,
   input      [0:0]  pwm_ack_i ,
   input      [31:0] pwm_dat_i
);
   // ADRESLERE gore sinyallerin muxlanmasi
   reg  cyc;
   
   wire ack = (vy_adres_i[17:16] == 2'b00) ? uart_ack_i :
              (vy_adres_i[17:16] == 2'b01) ? spi_ack_i  :
              (vy_adres_i[17:16] == 2'b10) ? pwm_ack_i  :
                                             1'b0;
   
   assign vy_veri_o = (vy_adres_i[17:16] == 2'b00) ? uart_dat_i :
                      (vy_adres_i[17:16] == 2'b01) ? spi_dat_i  :
                      (vy_adres_i[17:16] == 2'b10) ? pwm_dat_i  :
                                                     32'b0;
   
   assign adr_o = vy_adres_i[7:0];
   assign dat_o = vy_veri_i;
   assign we_o  = |(vy_veri_maske_i);
   assign sel_o = vy_veri_maske_i;
   
   assign pwm_cyc_o  = (vy_adres_i[17:16] == 2'b10) ? cyc : 1'b0;
   assign spi_cyc_o  = (vy_adres_i[17:16] == 2'b01) ? cyc : 1'b0;
   assign uart_cyc_o = (vy_adres_i[17:16] == 2'b00) ? cyc : 1'b0;
   
   reg sec_r;
   reg durdur_r;
   assign vy_durdur_o = (~sec_r&vy_sec_i) | durdur_r;
   
   reg state;
   reg next;
   localparam  IDLE = 1'b0,
               BUS  = 1'b1;
   
   
   always @(posedge clk_i) begin
      if(rst_i) state <= IDLE;
      else      state <= next;
      
      sec_r <= vy_sec_i;
   end
   
   always @(*) begin
      case(state)
         IDLE: if(vy_sec_i) next = BUS;
               else         next = IDLE;
         BUS:  if(ack)      next = IDLE;
               else         next = BUS;
         default: next = IDLE;
      endcase
   end
   
   always @(*) begin
      case(state)
         IDLE: begin // Kimseyle konusma
            stb_o    = 1'b0;
            cyc      = 1'b0;
            durdur_r = 1'b0;
         end
         BUS: begin // Istek geldiyse bus moduna gec
            stb_o    = 1'b1;
            cyc      = 1'b1;
            durdur_r = (next==IDLE) ? 1'b0 : 1'b1;
         end
      endcase
   end
endmodule
