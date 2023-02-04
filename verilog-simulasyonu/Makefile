######################################################
## Simulasyonlar icin make dosyasi.
######################################################

# sim
TOPLEVEL_LANG = verilog
SIM           = icarus

MODULE              := test_teknofest_wrapper
VERILOG_INCLUDE_DIRS = ../verilog-tasarimi
KAYNAKLAR            = ../verilog-tasarimi
SIM_BUILD            = ./build


ifeq ($(MODULE), test_cekirdek)
	TOPLEVEL        := cekirdek
    VERILOG_SOURCES +=  $(KAYNAKLAR)/cekirdek/*.v \
						$(KAYNAKLAR)/cekirdek/boru_hatti/yurut/*.v \
						$(KAYNAKLAR)/cekirdek/boru_hatti/yurut/x-buyruklari/*.v \
						$(KAYNAKLAR)/cekirdek/boru_hatti/yurut/x-buyruklari/sifreleme_birimi/*.v \
						$(KAYNAKLAR)/cekirdek/boru_hatti/getir/*.v \
						$(KAYNAKLAR)/cekirdek/boru_hatti/coz_yazmacoku/*.v \
						$(KAYNAKLAR)/cekirdek/boru_hatti/geri_yaz/*.v
else ifeq ($(MODULE),test_amb)
	TOPLEVEL        := aritmetik_mantik_birimi
    VERILOG_SOURCES +=  $(KAYNAKLAR)/cekirdek/*.v \
						$(KAYNAKLAR)/cekirdek/boru_hatti/yurut/*.v \
						$(KAYNAKLAR)/cekirdek/boru_hatti/yurut/x-buyruklari/*.v \
						$(KAYNAKLAR)/cekirdek/boru_hatti/yurut/x-buyruklari/sifreleme_birimi/*.v \
						$(KAYNAKLAR)/cekirdek/boru_hatti/getir/*.v \
						$(KAYNAKLAR)/cekirdek/boru_hatti/coz_yazmacoku/*.v \
						$(KAYNAKLAR)/cekirdek/boru_hatti/geri_yaz/*.v
else ifeq ($(MODULE),test_carpma_birimi)
	TOPLEVEL        := carpma_birimi
    VERILOG_SOURCES +=  $(KAYNAKLAR)/cekirdek/*.v \
						$(KAYNAKLAR)/cekirdek/boru_hatti/yurut/*.v \
						$(KAYNAKLAR)/cekirdek/boru_hatti/yurut/x-buyruklari/*.v \
						$(KAYNAKLAR)/cekirdek/boru_hatti/yurut/x-buyruklari/sifreleme_birimi/*.v \
						$(KAYNAKLAR)/cekirdek/boru_hatti/getir/*.v \
						$(KAYNAKLAR)/cekirdek/boru_hatti/coz_yazmacoku/*.v \
						$(KAYNAKLAR)/cekirdek/boru_hatti/geri_yaz/*.v
else ifeq ($(MODULE),test_bolme_birimi)
	TOPLEVEL        := bolme_birimi
    VERILOG_SOURCES +=  $(KAYNAKLAR)/cekirdek/*.v \
						$(KAYNAKLAR)/cekirdek/boru_hatti/yurut/*.v \
						$(KAYNAKLAR)/cekirdek/boru_hatti/yurut/x-buyruklari/*.v \
						$(KAYNAKLAR)/cekirdek/boru_hatti/yurut/x-buyruklari/sifreleme_birimi/*.v \
						$(KAYNAKLAR)/cekirdek/boru_hatti/getir/*.v \
						$(KAYNAKLAR)/cekirdek/boru_hatti/coz_yazmacoku/*.v \
						$(KAYNAKLAR)/cekirdek/boru_hatti/geri_yaz/*.v
else ifeq ($(MODULE),test_teknofest_wrapper)
	TOPLEVEL        := teknofest_wrapper
    VERILOG_SOURCES +=  ../cevreleyici/*.v \
						$(KAYNAKLAR)/*.v \
						$(KAYNAKLAR)/cekirdek/*.v \
						$(KAYNAKLAR)/bellek/*.v \
						$(KAYNAKLAR)/cekirdek/boru_hatti/yurut/*.v \
						$(KAYNAKLAR)/cekirdek/boru_hatti/yurut/x-buyruklari/*.v \
						$(KAYNAKLAR)/cekirdek/boru_hatti/yurut/x-buyruklari/sifreleme_birimi/*.v \
						$(KAYNAKLAR)/cekirdek/boru_hatti/getir/*.v \
						$(KAYNAKLAR)/cekirdek/boru_hatti/coz_yazmacoku/*.v \
						$(KAYNAKLAR)/cekirdek/boru_hatti/geri_yaz/*.v
else
    $(error A module was not provided)
endif

# Set module parameters
# [TODO] DOESN'T WORK -> define SIMULATION
ifeq ($(SIM),icarus)
    COMPILE_ARGS += -DSIMULATION
else ifeq ($(SIM),modelsim)
    SIM_ARGS += +define+SIMULATION
	WAVES     = 1
else ifeq ($(SIM),verilator)
    COMPILE_ARGS += -DSIMULATION
	EXTRA_ARGS += --trace-fst --trace-structs
else
    $(error A valid simulator (verilator,icarus,questa,modelsim) was not provided)
endif

# Python variables and cocotb make files
export RANDOM_SEED := 123456789
include $(shell cocotb-config --makefiles)/Makefile.sim

# Extend existing clean target
.PHONY: clean
clean::
		-rm -f results.xml
		-rm -f transcript
		-rm -f *.vcd
		-rm -f *.wlf
		-rm -f *.fst
		-rm -f modelsim.ini
		-rm -f *.vstf
