######################################################
## Simulasyonlar icin make dosyasi.
######################################################

# Icarus Verilog
SIMULATOR  = iverilog
FLAGS      = -Wall
KAYNAKLAR := ../verilog-tasarimi

.PHONY: tb_coz_yazmacoku
tb_coz_yazmacoku:
		$(SIMULATOR) -Wall -o ./build/out.vvp ./cekirdek/boru_hatti/coz_yazmacoku/tb_coz_yazmacoku.v \
									$(KAYNAKLAR)/cekirdek/boru_hatti/coz_yazmacoku/coz_yazmacoku.v \
									-I $(KAYNAKLAR) \
									-DSIMULATION
		vvp ./build/out.vvp

.PHONY: clean
clean:
		-rm -rf FAILED
		-rm -rf PASSED
		-rm -rf UNKNOWN
		-rm -rf build/*.vvp
		-rm -rf build/*.vcd
		-rm -rf build/*.hex
		-rm -rf build/*.dec
