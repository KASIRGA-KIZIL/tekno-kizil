SUBMAKE := $(MAKE) --no-print-directory -C

TEST_FILE = work/asm/out_config_00000.S
BUILD_DIR = ./build

.PHONY: all
all: clean generate
		@echo "Duck";

.PHONY: generate
generate: builddir
		unzip base_work.zip
		aapg setup
		cp base_work/config.yaml work
		aapg gen --arch rv32
		cp -r base_work/common work
		cp    base_work/out_config_00000_template.S work/asm/
		cp    base_work/out_config_00000.ld         work/asm/
		cp    base_work/Makefile                    work
		grep -v "csr" $(TEST_FILE) > temp; mv temp $(TEST_FILE)
		-+@$(SUBMAKE) work/
		python3 log_parser.py -i work/log/out_config_00000.log > $(BUILD_DIR)/tmp.log
		cp    work/bin/tmp.hex $(BUILD_DIR)/
		mv    work/objdump/out_config_00000.objdump work/objdump/tmp.dump
		cp    work/objdump/tmp.dump $(BUILD_DIR)/


.PHONY: dogrulama
dogrulama:
		+@$(SUBMAKE) dogrulama/

.PHONY: builddir
builddir:
	mkdir -p $(BUILD_DIR)

.PHONY: clean
clean:
		@echo "Ciktilar temizleniyor...";
		-rm -rf base_work
		-rm -rf work
		-rm -rf $(BUILD_DIR)
		-rm -rf *.dump
