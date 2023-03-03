## basys3.xdc

# CLOCK
set_property PACKAGE_PIN W5 [get_ports clk]
	set_property IOSTANDARD LVCMOS33 [get_ports clk]
	create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]

# RESET
set_property PACKAGE_PIN V17 [get_ports rst_ni]
	set_property IOSTANDARD LVCMOS33 [get_ports rst_ni]

# PROGRAMMING LED
set_property PACKAGE_PIN U16 [get_ports prog_mode_led_o]
	set_property IOSTANDARD LVCMOS33 [get_ports prog_mode_led_o]

# PROGRAMMING UART
set_property PACKAGE_PIN K17 [get_ports program_rx_i]
	set_property IOSTANDARD LVCMOS33 [get_ports program_rx_i]

# UART
set_property PACKAGE_PIN B18 [get_ports uart_rx_i]
	set_property IOSTANDARD LVCMOS33 [get_ports uart_rx_i]
set_property PACKAGE_PIN A18 [get_ports uart_tx_o]
	set_property IOSTANDARD LVCMOS33 [get_ports uart_tx_o]

# PWM
set_property PACKAGE_PIN M18 [get_ports pwm0_o]
	set_property IOSTANDARD LVCMOS33 [get_ports pwm0_o]
set_property PACKAGE_PIN N17 [get_ports pwm1_o]
	set_property IOSTANDARD LVCMOS33 [get_ports pwm1_o]

# VGA
set_property PACKAGE_PIN G19 [get_ports {o_VGA_R[0]}]				
    set_property IOSTANDARD LVCMOS33 [get_ports {o_VGA_R[0]}]
set_property PACKAGE_PIN H19 [get_ports {o_VGA_R[1]}]				
    set_property IOSTANDARD LVCMOS33 [get_ports {o_VGA_R[1]}]
set_property PACKAGE_PIN J19 [get_ports {o_VGA_R[2]}]				
    set_property IOSTANDARD LVCMOS33 [get_ports {o_VGA_R[2]}]
set_property PACKAGE_PIN N19 [get_ports {o_VGA_R[3]}]				
    set_property IOSTANDARD LVCMOS33 [get_ports {o_VGA_R[3]}]
set_property PACKAGE_PIN N18 [get_ports {o_VGA_B[0]}]				
    set_property IOSTANDARD LVCMOS33 [get_ports {o_VGA_B[0]}]
set_property PACKAGE_PIN L18 [get_ports {o_VGA_B[1]}]				
    set_property IOSTANDARD LVCMOS33 [get_ports {o_VGA_B[1]}]
set_property PACKAGE_PIN K18 [get_ports {o_VGA_B[2]}]				
    set_property IOSTANDARD LVCMOS33 [get_ports {o_VGA_B[2]}]
set_property PACKAGE_PIN J18 [get_ports {o_VGA_B[3]}]				
    set_property IOSTANDARD LVCMOS33 [get_ports {o_VGA_B[3]}]
set_property PACKAGE_PIN J17 [get_ports {o_VGA_G[0]}]				
    set_property IOSTANDARD LVCMOS33 [get_ports {o_VGA_G[0]}]
set_property PACKAGE_PIN H17 [get_ports {o_VGA_G[1]}]				
    set_property IOSTANDARD LVCMOS33 [get_ports {o_VGA_G[1]}]
set_property PACKAGE_PIN G17 [get_ports {o_VGA_G[2]}]				
    set_property IOSTANDARD LVCMOS33 [get_ports {o_VGA_G[2]}]
set_property PACKAGE_PIN D17 [get_ports {o_VGA_G[3]}]				
    set_property IOSTANDARD LVCMOS33 [get_ports {o_VGA_G[3]}]
set_property PACKAGE_PIN P19 [get_ports o_VGA_H_SYNC]						
    set_property IOSTANDARD LVCMOS33 [get_ports o_VGA_H_SYNC]
set_property PACKAGE_PIN R19 [get_ports o_VGA_V_SYNC]						
    set_property IOSTANDARD LVCMOS33 [get_ports o_VGA_V_SYNC]

