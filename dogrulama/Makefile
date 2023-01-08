######################################################
## all: Runs prove for all valid targets.
##
## <my_target>:   Runs prove for <my_target>
##				`make my_target`
##
## cover: Runs cover tests for a given TARGET
##		`make cover TARGET=read_decoder`
##
## bmc:   Runs bmc tests for a given TARGET
##		`make bmc TARGET=read_decoder`
##
######################################################

TESTS := islemci #top2 top3 top4
RTL   := ../verilog-tasarimi

FILE_0  := islemci
#FILE_1  := top2


.PHONY: $(TESTS)
all: $(TESTS)

.PHONY: $(FILE_0)
$(FILE_0): $(FILE_0)_prove/PASS
$(FILE_0)_prove/PASS: $(FILE_0).sby $(RTL)/$(FILE_0).v
		sby -f $(FILE_0).sby prove

.PHONY: cover
cover:
		test -n "$(TARGET)"
		sby  -f  $(TARGET).sby cover

.PHONY: bmc
bmc:
		test -n "$(TARGET)"
		sby  -f  $(TARGET).sby bmc

.PHONY: clean
clean:
		-rm -rf *_prove/
		-rm -rf *_cover/
		-rm -rf *_bmc/

