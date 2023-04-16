onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /teknofest_wrapper/main_memory/ram
add wave -noupdate /teknofest_wrapper/soc/isl_blksiz/cek/arka_taraf_dut/clk_i
add wave -noupdate /teknofest_wrapper/soc/isl_blksiz/cek/arka_taraf_dut/rst_i
add wave -noupdate -divider getir
add wave -noupdate /teknofest_wrapper/soc/isl_blksiz/cek/getir_dut/l1b_bekle_i
add wave -noupdate /teknofest_wrapper/soc/isl_blksiz/cek/getir_dut/l1b_deger_i
add wave -noupdate /teknofest_wrapper/soc/isl_blksiz/cek/getir_dut/debug_ps
add wave -noupdate -radix ascii /teknofest_wrapper/soc/isl_blksiz/cek/getir_dut/coz_str_debug
add wave -noupdate -divider coz
add wave -noupdate /teknofest_wrapper/soc/isl_blksiz/cek/arka_taraf_dut/coz_yazmacoku_dut/debug_ps
add wave -noupdate -radix ascii /teknofest_wrapper/soc/isl_blksiz/cek/arka_taraf_dut/coz_yazmacoku_dut/coz_str
add wave -noupdate -divider yurut
add wave -noupdate -radix ascii /teknofest_wrapper/soc/isl_blksiz/cek/arka_taraf_dut/yurut_dut/micro_str
add wave -noupdate /teknofest_wrapper/soc/isl_blksiz/cek/arka_taraf_dut/yurut_dut/bib/adr_i
add wave -noupdate /teknofest_wrapper/soc/isl_blksiz/cek/arka_taraf_dut/yurut_dut/bib/deger_i
add wave -noupdate -divider veri_onbellegi
add wave -noupdate /teknofest_wrapper/soc/isl_blksiz/veri_onbellegi_denetleyici_dut/iomem_addr_o
add wave -noupdate /teknofest_wrapper/soc/isl_blksiz/veri_onbellegi_denetleyici_dut/iomem_valid_o
add wave -noupdate /teknofest_wrapper/soc/isl_blksiz/veri_onbellegi_denetleyici_dut/iomem_wdata_o
add wave -noupdate /teknofest_wrapper/soc/isl_blksiz/veri_onbellegi_denetleyici_dut/iomem_wstrb_o
add wave -noupdate /teknofest_wrapper/soc/isl_blksiz/veri_onbellegi_denetleyici_dut/iomem_rdata_i
add wave -noupdate /teknofest_wrapper/soc/isl_blksiz/veri_onbellegi_denetleyici_dut/iomem_ready_i
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2058705000 ps} 0} {{Cursor 2} {2055855894 ps} 0}
quietly wave cursor active 2
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
WaveRestoreZoom {2058222822 ps} {2059358414 ps}
