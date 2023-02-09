######################################################
## all: Runs analysis and synthesis step of quartus
##      The aim is to see warnings and errors.
##
######################################################
rwildcard=$(foreach d,$(wildcard $(1:=/*)),$(call rwildcard,$d,$2) $(filter $(subst *,%,$2),$d))

TOP_MODULE = user_processor
KAYNAKLAR    = ../verilog-tasarimi
CEVRELEYICI  = ../cevreleyici
OUTPUT_DIR = ./build

KAYNAKLAR_FOREACH   = $(foreach item,$(call rwildcard,$(KAYNAKLAR),*.v),--source=$(item))
CEVRELEYICI_FOREACH = $(foreach item,$(call rwildcard,$(CEVRELEYICI),*.v),--source=$(item))

.PHONY: sentez
Sentez: builddir
		quartus_map $(TOP_MODULE) $(KAYNAKLAR_FOREACH) $(CEVRELEYICI_FOREACH)  -l $(KAYNAKLAR)

.PHONY: show
show:
		cd $(OUTPUT_DIR) && quartus_npp $(TOP_MODULE) --netlist_type=sgate
		cd $(OUTPUT_DIR) && qnui $(TOP_MODULE)

.PHONY: builddir
builddir:
	mkdir -p $(OUTPUT_DIR)


.PHONY: clean
clean:
	cd ..; \
	mkdir ./tmp000; \
	mv ./sentez/Makefile ./tmp000/; \
	rm -rf sentez/*; \
	mv ./tmp000/Makefile ./sentez/; \
	rm -rf ./tmp000
