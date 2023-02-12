create_clock -name clk_i -period 10.0 -waveform {0 5.0}

set_false_path -from [get_ports *] -to [get_ports clk_i]
