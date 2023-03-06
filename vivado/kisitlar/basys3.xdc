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

# SPI
set_property PACKAGE_PIN L17 [get_ports spi_cs_o]
	set_property IOSTANDARD LVCMOS33 [get_ports spi_cs_o]
set_property PACKAGE_PIN M19 [get_ports spi_sck_o]
	set_property IOSTANDARD LVCMOS33 [get_ports spi_sck_o]
set_property PACKAGE_PIN P17 [get_ports spi_mosi_o]
	set_property IOSTANDARD LVCMOS33 [get_ports spi_mosi_o]
set_property PACKAGE_PIN R18 [get_ports spi_miso_i]
	set_property IOSTANDARD LVCMOS33 [get_ports spi_miso_i]
