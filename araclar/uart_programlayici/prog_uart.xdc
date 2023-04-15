## BASYS3 PROGRAMLAYICI UART XDC

##USB-RS232 Interface
set_property PACKAGE_PIN B18 [get_ports uart_rx_i]
	set_property IOSTANDARD LVCMOS33 [get_ports uart_rx_i]
	
set_property PACKAGE_PIN K17 [get_ports program_tx1_o]
	set_property IOSTANDARD LVCMOS33 [get_ports program_tx1_o]
	
set_property PACKAGE_PIN L17 [get_ports program_tx2_o]
	set_property IOSTANDARD LVCMOS33 [get_ports program_tx2_o]

set_property PACKAGE_PIN M18 [get_ports program_tx3_o]
	set_property IOSTANDARD LVCMOS33 [get_ports program_tx3_o]

set_property PACKAGE_PIN M19 [get_ports program_tx4_o]
	set_property IOSTANDARD LVCMOS33 [get_ports program_tx4_o]

set_property PACKAGE_PIN N17 [get_ports program_tx5_o]
	set_property IOSTANDARD LVCMOS33 [get_ports program_tx5_o]

set_property PACKAGE_PIN P17 [get_ports program_tx6_o]
	set_property IOSTANDARD LVCMOS33 [get_ports program_tx6_o]

set_property PACKAGE_PIN P18 [get_ports program_tx7_o]
	set_property IOSTANDARD LVCMOS33 [get_ports program_tx7_o]

set_property PACKAGE_PIN R18 [get_ports program_tx8_o]
	set_property IOSTANDARD LVCMOS33 [get_ports program_tx8_o]
	
set_property PACKAGE_PIN U16 [get_ports led_tx_o]
	set_property IOSTANDARD LVCMOS33 [get_ports led_tx_o]
