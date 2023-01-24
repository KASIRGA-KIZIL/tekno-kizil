######################################################
## Simulasyonlar icin make dosyasi.
######################################################

# Icarus Verilog
SIMULATOR  = iverilog
FLAGS      = -Wall
KAYNAKLAR := ../verilog-tasarimi

.PHONY: tb_coz_yazmacoku
tb_coz_yazmacoku: builddir
		$(SIMULATOR) -Wall -o ./build/out.vvp ./cekirdek/boru_hatti/coz_yazmacoku/tb_coz_yazmacoku.v \
									$(KAYNAKLAR)/cekirdek/boru_hatti/coz_yazmacoku/coz_yazmacoku.v \
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

.PHONY: tb_aritmetik_mantik_birimi
tb_aritmetik_mantik_birimi: builddir
		$(SIMULATOR) -Wall -o ./build/out.vvp ./cekirdek/boru_hatti/yurut/tb_aritmetik_mantik_birimi.v \
									$(KAYNAKLAR)/cekirdek/boru_hatti/yurut/aritmetik_mantik_birimi.v \
									$(KAYNAKLAR)/cekirdek/boru_hatti/yurut/carry_lookahead_toplayici.v \
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
