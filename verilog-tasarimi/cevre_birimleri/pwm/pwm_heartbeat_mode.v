// pwm_heartbeat_mode.v
`timescale 1ns / 1ps

// Bu modul acik kaynakli https://github.com/SerdarUnal132/pwm_openmpw reposundan alinmistir

module pwm_heartbeat_mode #(
   parameter Resolution = 32
) (
   input                   clk_i,
   input                   rst_ni,
   input  [Resolution-1:0] threshold_counter_1,
   input  [Resolution-1:0] threshold_counter_2,
   input  [Resolution-1:0] period_counter,
   input  [Resolution-1:0] step,
   input  [Resolution-1:0] increment_step,
   output                  pwm_signal
);

   reg                      direction;
   reg   [Resolution-1:0]   counter;
   reg   [Resolution-1:0]   counter_temp;
   reg   [Resolution-1:0]   smaller_number_reg;
   reg   [Resolution-1:0]   larger_number_reg;
   wire  [Resolution-1:0]   smaller_number;
   wire  [Resolution-1:0]   larger_number;

   pwm_standard_mode #(
      .Resolution (Resolution)
   ) standard_mode_pwm (
      .clk_i             (clk_i),
      .rst_ni            (rst_ni),
      .threshold_counter (counter),
      .period_counter    (period_counter),
      .step              (step),
      .pwm_signal        (pwm_signal)
   );
   
   function [Resolution-1:0] find_smaller;
      input [Resolution-1:0] number_1;
      input [Resolution-1:0] number_2;
         begin
            find_smaller = (number_1 <= number_2) ? number_1 : number_2;
         end
   endfunction
   
   function [Resolution-1:0] find_larger;
      input [Resolution-1:0] number_1;
      input [Resolution-1:0] number_2;
         begin
            find_larger  = (number_1 > number_2)  ? number_1 : number_2;
         end
   endfunction
   
   assign smaller_number = find_smaller(threshold_counter_1, threshold_counter_2);
   assign larger_number = find_larger(threshold_counter_1, threshold_counter_2);
   
   always @(posedge clk_i) begin
      if (rst_ni == 0) begin
         smaller_number_reg <= 0;
         larger_number_reg  <= 0;
      end else begin
         smaller_number_reg <= smaller_number;
         larger_number_reg  <= larger_number;
      end
   end
   
   always @(posedge clk_i) begin
      if (rst_ni == 0) begin
         counter_temp <= 0;
         counter      <= 0;
         direction    <= 0;
      end else begin
         if (counter_temp < period_counter) begin
            counter_temp <= counter_temp + 1;
            counter      <= counter;
            direction    <= direction;
         end else begin
            counter_temp <= 0;
            if (counter == 0 || smaller_number_reg != smaller_number || larger_number_reg != larger_number) begin
               counter   <= smaller_number;
               direction <= 0;
            end else begin
               if (counter > (larger_number_reg-increment_step) && direction == 0) begin
                  counter <= counter - increment_step;
                  direction <= 1;
               end else if (counter < (smaller_number_reg+increment_step) && direction == 1) begin
                  counter <= counter + increment_step;
                  direction <= 0;
               end else begin
                  if (direction == 0) begin
                     counter <= counter + increment_step;
                  end else begin
                     counter <= counter - increment_step;
                  end
               end
            end
         end
      end
   end
endmodule
