######################################################
## all: Runs analysis and synthesis step of quartus
##      The aim is to see warnings and errors.
##
######################################################

TOP_MODULE = top
RTL      := ../verilog-tasarimi

.PHONY: sentez
Sentez:
		cd ./build && quartus_map $(TOP_MODULE) -l ../$(RTL)

.PHONY: show
show:
		cd ./build && quartus_npp $(TOP_MODULE) --netlist_type=sgate
		cd ./build && qnui $(TOP_MODULE)

.PHONY: clean
clean:
		-rm -rf build/*

