######################################################
## Simulasyonlar icin make dosyasi.
######################################################
rwildcard=$(foreach d,$(wildcard $(1:=/*)),$(call rwildcard,$d,$2) $(filter $(subst *,%,$2),$d))

TEST_DOSYASI_KLASOR = .
TESTLER             = $(call rwildcard,$(TEST_DOSYASI_KLASOR),*.S)

.PHONY: all
all: builddir $(TESTLER)

.PHONY: $(TESTLER)
$(TESTLER):
		riscv32-unknown-elf-gcc $@ -nostartfiles -nostdlib -march=rv32im -mabi=ilp32 -T$(TEST_DOSYASI_KLASOR)/link.ld -o ./build/$@.elf
		riscv32-unknown-elf-objcopy ./build/$@.elf -O binary ./build/$@.bin
		riscv32-unknown-elf-objdump -M numeric,no-aliases -D ./build/$@.elf > ./build/$@.txt
		python3 ../../araclar/makehex.py ./build/$@.bin > ./build/$@.hex



.PHONY: builddir
builddir:
	mkdir -p "./build"

.PHONY: clean
clean:
		-rm -rf FAILED
		-rm -rf PASSED
		-rm -rf UNKNOWN
		-rm -rf build
