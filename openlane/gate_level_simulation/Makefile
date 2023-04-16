PATTERN = user_processor.nl

PDK_ROOT ?= ../pdks
PDK ?= sky130A
SCL ?= sky130_fd_sc_hd
export PDK_ROOT


lint: ${PATTERN}.v
	iverilog -o tb_wrapper.vvp -DFUNCTIONAL -I ../platforms/sky130A/sky130_fd_sc_hd sky130_fd_sc_hd.v model.v ${PATTERN}.v teknofest_ram.v simpleuart.v primitives.v block_definitions.v tanimlamalar.vh tb_wrapper.v

.PHONY: wave
wave:
	gtkwave tb_wrapper.vcd
	
.PHONY: run
run:
	vvp tb_wrapper.vvp

.PHONY: clean
clean:
	rm -f *.vvp *.vcd
