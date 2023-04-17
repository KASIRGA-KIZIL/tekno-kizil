// pwm_denetleyici.v
`timescale 1ns / 1ps

// Alt pwm modulleri acik kaynakli https://github.com/SerdarUnal132/pwm_openmpw reposundan alinmistir

`include "tanimlamalar.vh"

// Cozunurluk 32 bit
`define RESOLUTION 32

// PWM Durumlari
`define BOSTA 2'b00
`define STANDART 2'b01
`define KALP_ATISI 2'b10

// Varsayilan PWM adim sayisi 1
`define STEP 32'd1

// Bu modul https://github.com/SerdarUnal132/pwm_openmpw reposundan alinan 
// standart ve kalp atisi modundaki alt PWM modullerini kullanarak PWM yazmaclari ile denetler
module pwm_denetleyici(
   input clk_i,
   input rst_i,

   // wishbone <-> pwm_denetleyici
   input  [5:0]  wb_adr_i, // 32 bit adres gelmesine gerek yok, sadece son 6 bitine bakmak yeterli
   input  [31:0] wb_dat_i,
   input         wb_we_i,
   input         wb_cyc_i,
   output [31:0] wb_dat_o, // daha az bit sayisi olan yazmaclarin on bitleri 0
   output        wb_ack_o,
   input         wb_stb_i, //
   input  [ 3:0] wb_sel_i, //

   // pwm_denetleyici <-> user_processor
   output pwm0_o, // 0x20020028
   output pwm1_o  // 0x2002002c adresten okunabilmesi lazim
);

   wire [7:0] wb_yaz_w = {wb_cyc_i, wb_stb_i & wb_we_i & !wb_ack_o, wb_adr_i};
   wire [7:0] wb_oku_w = {wb_cyc_i, ~wb_we_i, wb_adr_i};

   reg [31:0] wb_oku_veri_r = 0;
   reg [31:0] wb_oku_veri_next_r = 0;
   assign wb_dat_o = wb_oku_veri_r;

   reg wb_ack_r = 0;
   reg wb_ack_next_r = 0;
   assign wb_ack_o = wb_ack_r;

   // PWM0
   wire [1:0]  wb_pwm_control_1_w = wb_dat_i[1:0];
   wire [31:0] wb_pwm_period_1_w = wb_dat_i[31:0];
   wire [31:0] wb_pwm_threshold_1_1_w = wb_dat_i[31:0];
   wire [31:0] wb_pwm_threshold_1_2_w = wb_dat_i[31:0];
   wire [11:0] wb_pwm_step_1_w = wb_dat_i[11:0];

   // PWM1
   wire [1:0]  wb_pwm_control_2_w = wb_dat_i[1:0];
   wire [31:0] wb_pwm_period_2_w = wb_dat_i[31:0];
   wire [31:0] wb_pwm_threshold_2_1_w = wb_dat_i[31:0];
   wire [31:0] wb_pwm_threshold_2_2_w = wb_dat_i[31:0];
   wire [11:0] wb_pwm_step_2_w = wb_dat_i[11:0];

   // PWM yazmaclari
   reg [1:0] pwm_control_1_r = 0;
   reg [1:0] pwm_control_2_r = 0;

   reg [31:0] pwm_period_1_r = 0;
   reg [31:0] pwm_period_2_r = 0;

   reg [31:0] pwm_threshold_1_1_r = 0;
   reg [31:0] pwm_threshold_1_2_r = 0;

   reg [31:0] pwm_threshold_2_1_r = 0;
   reg [31:0] pwm_threshold_2_2_r = 0;

   reg [11:0] pwm_step_1_r = 0;
   reg [11:0] pwm_step_2_r = 0;

   reg pwm_output_1_r = 0;
   reg pwm_output_2_r = 0;

   assign pwm0_o = pwm_output_1_r;
   assign pwm1_o = pwm_output_2_r;

   wire pwm0_standart_w;
   wire pwm0_kalp_atisi_w;
   wire pwm1_standart_w;
   wire pwm1_kalp_atisi_w;

   wire resetn_w = ~rst_i;
   wire standart_aktif1_w   = pwm_control_1_r[0];
   wire kalp_atisi_aktif1_w = pwm_control_1_r[1];
   wire standart_aktif2_w   = pwm_control_2_r[0];
   wire kalp_atisi_aktif2_w = pwm_control_2_r[1];

   // Yazmac sonraki degerleri
   reg [1:0] pwm_control_1_next_r = 0;
   reg [1:0] pwm_control_2_next_r = 0;

   reg [31:0] pwm_period_1_next_r = 0;
   reg [31:0] pwm_period_2_next_r = 0;

   reg [31:0] pwm_threshold_1_1_next_r = 0;
   reg [31:0] pwm_threshold_1_2_next_r = 0;

   reg [31:0] pwm_threshold_2_1_next_r = 0;
   reg [31:0] pwm_threshold_2_2_next_r = 0;

   reg [11:0] pwm_step_1_next_r = 0;
   reg [11:0] pwm_step_2_next_r = 0;

   reg pwm_output_1_next_r = 0;
   reg pwm_output_2_next_r = 0;

   always @* begin
      pwm_control_1_next_r     = pwm_control_1_r;
      pwm_period_1_next_r      = pwm_period_1_r;
      pwm_threshold_1_1_next_r = pwm_threshold_1_1_r;
      pwm_threshold_1_2_next_r = pwm_threshold_1_2_r;
      pwm_step_1_next_r        = pwm_step_1_r;

      pwm_control_2_next_r     = pwm_control_2_r;
      pwm_period_2_next_r      = pwm_period_2_r;
      pwm_threshold_2_1_next_r = pwm_threshold_2_1_r;
      pwm_threshold_2_2_next_r = pwm_threshold_2_2_r;
      pwm_step_2_next_r        = pwm_step_2_r;

      wb_oku_veri_next_r = wb_oku_veri_r;
      wb_ack_next_r = 0;

      // PWM yazmaclarina yazma islemleri
      if(wb_cyc_i) begin
         case(wb_yaz_w)
            // 0x20020000 --> pwm_control_1
            8'hc0: begin //8'b11_00_0000: begin
               pwm_control_1_next_r = wb_sel_i[0] ? wb_pwm_control_1_w[1:0] : pwm_control_1_r;
               wb_ack_next_r  = 1'b1;
            end
            // 0x20020004 --> pwm_control_2
            8'hc4: begin //8'b11_00_0100: begin
               pwm_control_2_next_r = wb_sel_i[0] ? wb_pwm_control_2_w[1:0] : pwm_control_2_r;
               wb_ack_next_r  = 1'b1;
            end
            // 0x20020008 --> pwm_period_1
            8'hc8: begin //8'b11_00_1000: begin
               pwm_period_1_next_r[ 7: 0] = wb_sel_i[0] ? wb_pwm_period_1_w[ 7: 0] : pwm_period_1_r[ 7: 0];
               pwm_period_1_next_r[15: 8] = wb_sel_i[1] ? wb_pwm_period_1_w[15: 8] : pwm_period_1_r[15: 8];
               pwm_period_1_next_r[23:16] = wb_sel_i[2] ? wb_pwm_period_1_w[23:16] : pwm_period_1_r[23:16];
               pwm_period_1_next_r[31:24] = wb_sel_i[3] ? wb_pwm_period_1_w[31:24] : pwm_period_1_r[31:24];
               wb_ack_next_r  = 1'b1;
            end
            // 0x2002000c --> pwm_period_2
            8'hcc: begin //8'b11_00_1100: begin
               pwm_period_2_next_r[ 7: 0] = wb_sel_i[0] ? wb_pwm_period_2_w[ 7: 0] : pwm_period_2_r[ 7: 0];
               pwm_period_2_next_r[15: 8] = wb_sel_i[1] ? wb_pwm_period_2_w[15: 8] : pwm_period_2_r[15: 8];
               pwm_period_2_next_r[23:16] = wb_sel_i[2] ? wb_pwm_period_2_w[23:16] : pwm_period_2_r[23:16];
               pwm_period_2_next_r[31:24] = wb_sel_i[3] ? wb_pwm_period_2_w[31:24] : pwm_period_2_r[31:24];
               wb_ack_next_r  = 1'b1;
            end
            // 0x20020010 --> pwm_threshold_1_1
            8'hd0: begin //8'b11_01_0000: begin
               pwm_threshold_1_1_next_r[ 7: 0] = wb_sel_i[0] ? wb_pwm_threshold_1_1_w[ 7: 0] : pwm_threshold_1_1_r[ 7: 0];
               pwm_threshold_1_1_next_r[15: 8] = wb_sel_i[1] ? wb_pwm_threshold_1_1_w[15: 8] : pwm_threshold_1_1_r[15: 8];
               pwm_threshold_1_1_next_r[23:16] = wb_sel_i[2] ? wb_pwm_threshold_1_1_w[23:16] : pwm_threshold_1_1_r[23:16];
               pwm_threshold_1_1_next_r[31:24] = wb_sel_i[3] ? wb_pwm_threshold_1_1_w[31:24] : pwm_threshold_1_1_r[31:24];
               wb_ack_next_r  = 1'b1;
            end
            // 0x20020014 --> pwm_threshold_1_2
            8'hd4: begin //8'b11_01_0100: begin
               pwm_threshold_1_2_next_r[ 7: 0] = wb_sel_i[0] ? wb_pwm_threshold_1_2_w[ 7: 0] : pwm_threshold_1_2_r[ 7: 0];
               pwm_threshold_1_2_next_r[15: 8] = wb_sel_i[1] ? wb_pwm_threshold_1_2_w[15: 8] : pwm_threshold_1_2_r[15: 8];
               pwm_threshold_1_2_next_r[23:16] = wb_sel_i[2] ? wb_pwm_threshold_1_2_w[23:16] : pwm_threshold_1_2_r[23:16];
               pwm_threshold_1_2_next_r[31:24] = wb_sel_i[3] ? wb_pwm_threshold_1_2_w[31:24] : pwm_threshold_1_2_r[31:24];
               wb_ack_next_r  = 1'b1;
            end
            // 0x20020018 --> pwm_threshold_2_1
            8'hd8: begin //8'b11_01_1000: begin
               pwm_threshold_2_1_next_r[ 7: 0] = wb_sel_i[0] ? wb_pwm_threshold_2_1_w[ 7: 0] : pwm_threshold_2_1_r[ 7: 0];
               pwm_threshold_2_1_next_r[15: 8] = wb_sel_i[1] ? wb_pwm_threshold_2_1_w[15: 8] : pwm_threshold_2_1_r[15: 8];
               pwm_threshold_2_1_next_r[23:16] = wb_sel_i[2] ? wb_pwm_threshold_2_1_w[23:16] : pwm_threshold_2_1_r[23:16];
               pwm_threshold_2_1_next_r[31:24] = wb_sel_i[3] ? wb_pwm_threshold_2_1_w[31:24] : pwm_threshold_2_1_r[31:24];
               wb_ack_next_r  = 1'b1;
            end
            // 0x2002001c --> pwm_threshold_2_2
            8'hdc: begin //8'b11_01_1100: begin
               pwm_threshold_2_2_next_r[ 7: 0] = wb_sel_i[0] ? wb_pwm_threshold_2_2_w[ 7: 0] : pwm_threshold_2_2_r[ 7: 0];
               pwm_threshold_2_2_next_r[15: 8] = wb_sel_i[1] ? wb_pwm_threshold_2_2_w[15: 8] : pwm_threshold_2_2_r[15: 8];
               pwm_threshold_2_2_next_r[23:16] = wb_sel_i[2] ? wb_pwm_threshold_2_2_w[23:16] : pwm_threshold_2_2_r[23:16];
               pwm_threshold_2_2_next_r[31:24] = wb_sel_i[3] ? wb_pwm_threshold_2_2_w[31:24] : pwm_threshold_2_2_r[31:24];
               wb_ack_next_r  = 1'b1;
            end
            // 0x20020020 --> pwm_step_1
            8'he0: begin //8'b11_10_0000: begin
               pwm_step_1_next_r[ 7: 0] = wb_sel_i[0] ? wb_pwm_step_1_w[ 7: 0] : pwm_step_1_r[ 7: 0];
               pwm_step_1_next_r[11: 8] = wb_sel_i[1] ? wb_pwm_step_1_w[11: 8] : pwm_step_1_r[11: 8];
               wb_ack_next_r  = 1'b1;
            end
            // 0x20020024 --> pwm_step_2
            8'he4: begin //8'b11_10_0100: begin
               pwm_step_2_next_r[ 7: 0] = wb_sel_i[0] ? wb_pwm_step_2_w[ 7: 0] : pwm_step_2_r[ 7: 0];
               pwm_step_2_next_r[11: 8] = wb_sel_i[1] ? wb_pwm_step_2_w[11: 8] : pwm_step_2_r[11: 8];
               wb_ack_next_r  = 1'b1;
            end
            // Ciktilar sadece okunabilir
            // Digerleri hem yazilip hem okunabilir
            /*
            // 0x20020028 --> pwm_output_1
            8'he8: begin //8'b11_10_1000: begin

            end
            // 0x2002002c --> pwm_output_2
            8'hec: begin //8'b11_10_1100: begin

            end
            */
         endcase

         // PWM yazmaclarindan okuma islemleri
         case(wb_oku_w)
            // 0x20020000 --> pwm_control_1
            8'hc0: begin //8'b11_00_0000: begin
               wb_oku_veri_next_r = {30'd0, pwm_control_1_r};
               wb_ack_next_r  = 1'b1;
            end
            // 0x20020004 --> pwm_control_2
            8'hc4: begin //8'b11_00_0100: begin
               wb_oku_veri_next_r = {30'd0, pwm_control_2_r};
               wb_ack_next_r  = 1'b1;
            end
            // 0x20020008 --> pwm_period_1
            8'hc8: begin //8'b11_00_1000: begin
               wb_oku_veri_next_r = pwm_period_1_r;
               wb_ack_next_r  = 1'b1;
            end
            // 0x2002000c --> pwm_period_2
            8'hcc: begin //8'b11_00_1100: begin
               wb_oku_veri_next_r = pwm_period_2_r;
               wb_ack_next_r  = 1'b1;
            end
            // 0x20020010 --> pwm_threshold_1_1
            8'hd0: begin //8'b11_01_0000: begin
               wb_oku_veri_next_r = pwm_threshold_1_1_r;
               wb_ack_next_r  = 1'b1;
            end
            // 0x20020014 --> pwm_threshold_1_2
            8'hd4: begin //8'b11_01_0100: begin
               wb_oku_veri_next_r = pwm_threshold_1_2_r;
               wb_ack_next_r  = 1'b1;
            end
            // 0x20020018 --> pwm_threshold_2_1
            8'hd8: begin //8'b11_01_1000: begin
               wb_oku_veri_next_r = pwm_threshold_2_1_r;
               wb_ack_next_r  = 1'b1;
            end
            // 0x2002001c --> pwm_threshold_2_2
            8'hdc: begin //8'b11_01_1100: begin
               wb_oku_veri_next_r = pwm_threshold_2_2_r;
               wb_ack_next_r  = 1'b1;
            end
            // 0x20020020 --> pwm_step_1
            8'he0: begin //8'b11_10_0000: begin
               wb_oku_veri_next_r = {20'd0, pwm_step_1_r};
               wb_ack_next_r  = 1'b1;
            end
            // 0x20020024 --> pwm_step_2
            8'he4: begin //8'b11_10_0100: begin
               wb_oku_veri_next_r = {20'd0, pwm_step_2_r};
               wb_ack_next_r  = 1'b1;
            end
            // 0x20020028 --> pwm_output_1
            8'he8: begin //8'b11_10_1000: begin
               wb_oku_veri_next_r = {31'd0, pwm_output_1_r};
               wb_ack_next_r  = 1'b1;
            end
            // 0x2002002c --> pwm_output_2
            8'hec: begin //8'b11_10_1100: begin
               wb_oku_veri_next_r = {31'd0, pwm_output_2_r};
               wb_ack_next_r  = 1'b1;
            end
         endcase
      end

      // PWM0 durumlari
      case(pwm_control_1_r)
         `BOSTA: begin // default varken bosta durumu olmasina gerek yok aslinda
            pwm_output_1_next_r = 0;
         end
         `STANDART: begin
            pwm_output_1_next_r = pwm0_standart_w;
         end
         `KALP_ATISI: begin
            pwm_output_1_next_r = pwm0_kalp_atisi_w;
         end
         default: begin
            pwm_output_1_next_r = 0;
         end
      endcase

      // PWM1 durumlari
      case(pwm_control_2_r)
         `BOSTA: begin
            pwm_output_2_next_r = 0;
         end
         `STANDART: begin
            pwm_output_2_next_r = pwm1_standart_w;
         end
         `KALP_ATISI: begin
            pwm_output_2_next_r = pwm1_kalp_atisi_w;
         end
         default: begin
            pwm_output_2_next_r = 0;
         end
      endcase
   end

   always @(posedge clk_i) begin
      if(rst_i) begin
         pwm_output_1_r      <= 0;
         pwm_output_2_r      <= 0;

         pwm_control_1_r     <= 0;
         pwm_period_1_r      <= 0;
         pwm_threshold_1_1_r <= 0;
         pwm_threshold_1_2_r <= 0;
         pwm_step_1_r        <= 0;

         pwm_control_2_r     <= 0;
         pwm_period_2_r      <= 0;
         pwm_threshold_2_1_r <= 0;
         pwm_threshold_2_2_r <= 0;
         pwm_step_2_r        <= 0;

         wb_oku_veri_r       <= 0;
         wb_ack_r            <= 0;
      end
      else begin
         pwm_output_1_r      <= pwm_output_1_next_r;
         pwm_output_2_r      <= pwm_output_2_next_r;

         pwm_control_1_r     <= pwm_control_1_next_r;
         pwm_period_1_r      <= pwm_period_1_next_r;
         pwm_threshold_1_1_r <= pwm_threshold_1_1_next_r;
         pwm_threshold_1_2_r <= pwm_threshold_1_2_next_r;
         pwm_step_1_r        <= pwm_step_1_next_r;

         pwm_control_2_r     <= pwm_control_2_next_r;
         pwm_period_2_r      <= pwm_period_2_next_r;
         pwm_threshold_2_1_r <= pwm_threshold_2_1_next_r;
         pwm_threshold_2_2_r <= pwm_threshold_2_2_next_r;
         pwm_step_2_r        <= pwm_step_2_next_r;

         wb_oku_veri_r       <= wb_oku_veri_next_r;
         wb_ack_r            <= wb_ack_next_r;
      end
   end

   // PWM0 ICIN
   pwm_standard_mode #(
      .Resolution          (`RESOLUTION)
   ) psm0 (
      .clk_i               (clk_i),
      .rst_ni              (resetn_w & standart_aktif1_w),
      .threshold_counter   (pwm_threshold_1_1_r),
      .period_counter      (pwm_period_1_r),
      .step                (`STEP),
      .pwm_signal          (pwm0_standart_w)
   );

   pwm_heartbeat_mode #(
      .Resolution          (`RESOLUTION)
   ) phm0 (
      .clk_i               (clk_i),
      .rst_ni              (resetn_w & kalp_atisi_aktif1_w),
      .threshold_counter_1 (pwm_threshold_1_1_r),
      .threshold_counter_2 (pwm_threshold_1_2_r),
      .period_counter      (pwm_period_1_r),
      .step                (`STEP),
      .increment_step      ({{20{1'b0}}, pwm_step_1_r}),
      .pwm_signal          (pwm0_kalp_atisi_w)
   );


   // PWM1 ICIN
   pwm_standard_mode #(
      .Resolution          (`RESOLUTION)
   ) psm1 (
      .clk_i               (clk_i),
      .rst_ni              (resetn_w & standart_aktif2_w),
      .threshold_counter   (pwm_threshold_2_1_r),
      .period_counter      (pwm_period_2_r),
      .step                (`STEP),
      .pwm_signal          (pwm1_standart_w)
   );

   pwm_heartbeat_mode #(
      .Resolution          (`RESOLUTION)
   ) phm1 (
      .clk_i               (clk_i),
      .rst_ni              (resetn_w & kalp_atisi_aktif2_w),
      .threshold_counter_1 (pwm_threshold_2_1_r),
      .threshold_counter_2 (pwm_threshold_2_2_r),
      .period_counter      (pwm_period_2_r),
      .step                (`STEP),
      .increment_step      ({{20{1'b0}}, pwm_step_2_r}),
      .pwm_signal          (pwm1_kalp_atisi_w)
   );

endmodule
