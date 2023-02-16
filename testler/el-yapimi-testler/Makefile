######################################################
## Simulasyonlar icin make dosyasi.
######################################################

TEST_DOSYASI_KLASOR= .
TEST_DOSYASI_ADI= bol_carp_bol_carp

.PHONY: all
all: builddir


		riscv32-unknown-elf-gcc $(TEST_DOSYASI_KLASOR)/$(TEST_DOSYASI_ADI).S -nostartfiles -nostdlib -march=rv32im -mabi=ilp32 -T$(TEST_DOSYASI_KLASOR)/link.ld -o ./build/$(TEST_DOSYASI_ADI).elf
		riscv32-unknown-elf-objcopy ./build/$(TEST_DOSYASI_ADI).elf -O binary ./build/$(TEST_DOSYASI_ADI).bin
		riscv32-unknown-elf-objdump -D ./build/$(TEST_DOSYASI_ADI).elf > ./build/$(TEST_DOSYASI_ADI).txt
		python3 ./makehex.py ./build/$(TEST_DOSYASI_ADI).bin > ./build/$(TEST_DOSYASI_ADI).hex


.PHONY: builddir
builddir:
	mkdir -p "./build"

.PHONY: clean
clean:
		-rm -rf FAILED
		-rm -rf PASSED
		-rm -rf UNKNOWN
		-rm -rf build
