######################################################
## Simulasyonlar icin make dosyasi.
######################################################

# Icarus Verilog
SIMULATOR  = iverilog
FLAGS      = -Wall
KAYNAKLAR := ../verilog-tasarimi
SUBMAKE := $(MAKE) --no-print-directory -C
ARACLAR  = ../araclar
TEST_DOSYASI_KLASOR=../testler
TEST_DOSYASI_ADI= basit_dongu

.PHONY: tb_coz_yazmacoku
tb_coz_yazmacoku: builddir
		$(SIMULATOR) -Wall -o ./build/out.vvp ./cekirdek/boru_hatti/coz_yazmacoku/tb_coz_yazmacoku.v \
									$(KAYNAKLAR)/cekirdek/boru_hatti/coz_yazmacoku/coz_yazmacoku.v \
									$(KAYNAKLAR)/cekirdek/boru_hatti/coz_yazmacoku/yazmac_obegi.v \
									-I $(KAYNAKLAR) \
									-DSIMULATION
		vvp ./build/out.vvp

.PHONY: tb_aritmetik_mantik_birimi
tb_aritmetik_mantik_birimi: builddir
		$(SIMULATOR) -Wall -o ./build/out.vvp ./cekirdek/boru_hatti/yurut/tb_aritmetik_mantik_birimi.v \
									$(KAYNAKLAR)/cekirdek/boru_hatti/yurut/aritmetik_mantik_birimi.v \
									$(KAYNAKLAR)/cekirdek/boru_hatti/yurut/carry_lookahead_toplayici.v \
									-I $(KAYNAKLAR) \
									-DSIMULATION
		vvp ./build/out.vvp

.PHONY: tb_dallanma_ongorucu
tb_dallanma_ongorucu: builddir
		$(SIMULATOR) -Wall -o ./build/out.vvp ./cekirdek/boru_hatti/getir/tb_dallanma_ongorucu.v \
									$(KAYNAKLAR)/cekirdek/boru_hatti/getir/dallanma_ongorucu.v \
									-I $(KAYNAKLAR) \
									-DSIMULATION
		vvp ./build/out.vvp

.PHONY: tb_getir
tb_getir: builddir
		$(SIMULATOR) -Wall -o ./build/out.vvp ./cekirdek/boru_hatti/getir/tb_getir.v \
									$(KAYNAKLAR)/cekirdek/boru_hatti/getir/getir.v \
									$(KAYNAKLAR)/cekirdek/boru_hatti/getir/dallanma_ongorucu.v \
									-I $(KAYNAKLAR) \
									-DSIMULATION
		vvp ./build/out.vvp

.PHONY: tb_buyruk_onbellegi
tb_buyruk_onbellegi: builddir
		$(SIMULATOR) -Wall -o ./build/out.vvp ./bellek/tb_buyruk_onbellegi.v \
									$(KAYNAKLAR)/bellek/buyruk_onbellegi.v \
									$(KAYNAKLAR)/bellek/buyruk_onbellegi_tag_array.v \
									$(KAYNAKLAR)/bellek/buyruk_onbellegi_data_array.v \
									-I $(KAYNAKLAR) \
									-DSIMULATION
		vvp ./build/out.vvp


.PHONY: tb_yurut
tb_yurut: builddir
		$(SIMULATOR) -Wall -o ./build/out.vvp ./cekirdek/boru_hatti/yurut/tb_yurut.v \
									$(KAYNAKLAR)/cekirdek/boru_hatti/yurut/yurut.v \
									$(KAYNAKLAR)/cekirdek/boru_hatti/yurut/aritmetik_mantik_birimi.v \
									$(KAYNAKLAR)/cekirdek/boru_hatti/yurut/carry_lookahead_toplayici.v \
									-I $(KAYNAKLAR) \
									-DSIMULATION
		vvp ./build/out.vvp

.PHONY: tb_wallace_carpici
tb_wallace_carpici: builddir
		$(SIMULATOR) -Wall -o ./build/out.vvp ./cekirdek/boru_hatti/yurut/tb_wallace_carpici.v \
									$(KAYNAKLAR)/cekirdek/boru_hatti/yurut/wallace_carpici.v \
									-I $(KAYNAKLAR) \
									-DSIMULATION
		vvp ./build/out.vvp

.PHONY: tb_cekirdek
tb_cekirdek: builddir


		riscv64-unknown-elf-gcc $(TEST_DOSYASI_KLASOR)/$(TEST_DOSYASI_ADI).S -nostartfiles -nostdlib -march=rv32i -mabi=ilp32 -T$(TEST_DOSYASI_KLASOR)/link.ld -o ./build/$(TEST_DOSYASI_ADI).elf
		riscv64-unknown-elf-objcopy ./build/$(TEST_DOSYASI_ADI).elf -O binary ./build/$(TEST_DOSYASI_ADI).bin
		riscv64-unknown-elf-objdump -D ./build/$(TEST_DOSYASI_ADI).elf > ./build/$(TEST_DOSYASI_ADI).txt
		python3 $(ARACLAR)/makehex.py ./build/$(TEST_DOSYASI_ADI).bin > ./build/$(TEST_DOSYASI_ADI).hex


		$(SIMULATOR) -Wall -o ./build/out.vvp ./cekirdek/tb_cekirdek.v \
									$(KAYNAKLAR)/cekirdek/cekirdek.v \
									$(KAYNAKLAR)/cekirdek/denetim_durum_birimi.v \
									$(KAYNAKLAR)/cekirdek/boru_hatti/yurut/yurut.v \
									$(KAYNAKLAR)/cekirdek/boru_hatti/yurut/aritmetik_mantik_birimi.v \
									$(KAYNAKLAR)/cekirdek/boru_hatti/yurut/carry_lookahead_toplayici.v \
									$(KAYNAKLAR)/cekirdek/boru_hatti/getir/getir.v \
									$(KAYNAKLAR)/cekirdek/boru_hatti/getir/dallanma_ongorucu.v \
									$(KAYNAKLAR)/cekirdek/boru_hatti/coz_yazmacoku/coz_yazmacoku.v \
									$(KAYNAKLAR)/cekirdek/boru_hatti/coz_yazmacoku/yazmac_obegi.v \
									$(KAYNAKLAR)/cekirdek/boru_hatti/geri_yaz/geri_yaz.v \
									-I $(KAYNAKLAR) \
									-DSIMULATION
		vvp ./build/out.vvp

.PHONY: builddir
builddir:
	mkdir -p "./build"

.PHONY: clean
clean:
		-rm -rf FAILED
		-rm -rf PASSED
		-rm -rf UNKNOWN
		-rm -rf build/*.vvp
		-rm -rf build/*.vcd
		-rm -rf build/*.hex
		-rm -rf build/*.dec
