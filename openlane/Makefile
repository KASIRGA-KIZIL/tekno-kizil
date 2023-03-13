BUILD_DIR = ./build

.PHONY: all
all: clean cekirdek
	@echo "Generating required folders";
	@echo "You should run them in this order:";
	@echo "    1-  ./flow.tcl -design cekirdek         -tag v1 -overwrite ";
	@echo "    2-  ./flow.tcl -design buyruk_onbellegi -tag v1 -overwrite ";
	@echo "    3-  ./flow.tcl -design veri_onbellegi   -tag v1 -overwrite ";
	@echo "    4-  ./flow.tcl -design user_processor   -tag v1 -overwrite ";

.PHONY: cekirdek
cekirdek:
	@./cekirdek/gen.py

.PHONY: clean
clean:
	@echo "";
