SUBMAKE := $(MAKE) --no-print-directory -C

.PHONY: all
all: sentez verilog-simulasyonu doğrulama

.PHONY: sentez
sentez:
		@echo "Moduller sentezleniyor...";
		+@$(SUBMAKE) sentez/

.PHONY: verilog-simulasyonu
verilog-simulasyonu:
		@echo "Moduller simule ediliyor...";
		+@$(SUBMAKE) verilog-simulasyonu/

.PHONY: dogrulama
dogrulama:
		@echo "Moduller dogrulaniyor...";
		+@$(SUBMAKE) dogrulama/

.PHONY: clean
clean:
		@echo "Ciktilar temizleniyor...";
		-+@$(SUBMAKE) sentez/ clean
		-+@$(SUBMAKE) verilog-simulasyonu/ clean
		-+@$(SUBMAKE) dogrulama/ clean
		-+@$(SUBMAKE) sentez/ clean
		-+@$(SUBMAKE) testler/ clean
