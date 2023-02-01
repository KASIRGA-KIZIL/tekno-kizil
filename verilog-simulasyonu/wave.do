onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /cekirdek/getir_dut/clk_i
add wave -noupdate /cekirdek/getir_dut/rst_i
add wave -noupdate -divider getir
add wave -noupdate /cekirdek/getir_dut/cyo_l1b_ps_o
add wave -noupdate /cekirdek/getir_dut/l1b_deger_i
add wave -noupdate /cekirdek/getir_dut/tahmin_et
add wave -noupdate /cekirdek/getir_dut/hata_duzelt
add wave -noupdate -radix ascii /cekirdek/getir_dut/coz_str_debug
add wave -noupdate -radix ascii /cekirdek/getir_dut/ctipi_coz_str
add wave -noupdate -divider coz
add wave -noupdate -radix ascii /cekirdek/coz_yazmacoku_dut/coz_str
add wave -noupdate /cekirdek/coz_yazmacoku_dut/deger1_w
add wave -noupdate /cekirdek/coz_yazmacoku_dut/deger2_w
add wave -noupdate /cekirdek/coz_yazmacoku_dut/lt_w
add wave -noupdate /cekirdek/coz_yazmacoku_dut/ltu_w
add wave -noupdate /cekirdek/coz_yazmacoku_dut/eq_w
add wave -noupdate /cekirdek/coz_yazmacoku_dut/ddb_yonlendir_kontrol1_i
add wave -noupdate /cekirdek/coz_yazmacoku_dut/ddb_yonlendir_kontrol2_i
add wave -noupdate -divider yurut
add wave -noupdate /cekirdek/yurut_dut/exception
add wave -noupdate /cekirdek/yurut_dut/dallanma_kosulu_w
add wave -noupdate /cekirdek/yurut_dut/gtr_atlanan_ps_gecerli_o
add wave -noupdate /cekirdek/yurut_dut/gtr_atlanan_ps_o
add wave -noupdate -divider geriyaz
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1085000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {4730251 ps}
