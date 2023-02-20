BUILD_DIR = ./build

.PHONY: all
all: clean
	./riscv_dv.py

.PHONY: clean
clean:
		@echo "Ciktilar temizleniyor...";
		-rm -rf work
		-rm -rf $(BUILD_DIR)
		-rm -rf *.dump
