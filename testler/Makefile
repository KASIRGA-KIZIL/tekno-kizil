SUBMAKE := $(MAKE) --no-print-directory -C

.PHONY: clean
clean:
		@echo "Testler temizleniyor...";
		-rm -f riscv-tests/Makefile
		-rm -f riscv-tests/configure~
		-rm -f riscv-tests/autom4te.cache/*
		-rm -f riscv-tests/config.log
		-rm -f riscv-tests/config.status
		-rm -f riscv-tests/debug/__pycache__/*
		-rm -f riscv-tests/debug/targets/RISC-V/__pycache__/*
		+@$(SUBMAKE) aapg/ clean
		+@$(SUBMAKE) coremark/ clean
		+@$(SUBMAKE) el-yapimi-testler/ clean
		+@$(SUBMAKE) riscv-arch-test/ clean
		+@$(SUBMAKE) riscv-tests/ clean
		+@$(SUBMAKE) uart-demo/ clean
		+@$(SUBMAKE) pwm-demo/ clean
		+@$(SUBMAKE) uart-demo-pikachu/ clean
		+@$(SUBMAKE) uart-timer-demo/ clean
