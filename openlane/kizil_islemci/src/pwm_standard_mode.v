// pwm_standard_mode.v
`timescale 1ns / 1ps

// Bu modul acik kaynakli https://github.com/SerdarUnal132/pwm_openmpw reposundan alinmistir

module pwm_standard_mode #(
   parameter Resolution = 32
) (
   input                   clk_i,
   input                   rst_ni,
   input  [Resolution-1:0] threshold_counter,
   input  [Resolution-1:0] period_counter,
   input  [Resolution-1:0] step,
   output                  pwm_signal
);

   reg                    output_reg;
   reg   [Resolution-1:0] counter;
   
   assign pwm_signal = output_reg;
   
   always @(posedge clk_i) begin
      if (rst_ni == 0  | threshold_counter == 0) begin
         counter      <= 0;
         output_reg   <= 0;
      end else begin
         if (counter < threshold_counter) begin
            output_reg <= 1;
            counter    <= counter + step;
         end else if (counter >= threshold_counter && counter < period_counter) begin
            output_reg <= 0;
            if (counter >= period_counter - step) begin
               counter <= 0;
            end else begin
               counter <= counter + step;
            end
         end else begin
            output_reg <= 0;
            counter    <= 0;
         end
      end
   end
endmodule
