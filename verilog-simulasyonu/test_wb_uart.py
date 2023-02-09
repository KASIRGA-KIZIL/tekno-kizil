# test_wb_uart.py

# bu dosya silinecek
# çekirdek öncesi wishbone ve uart denemek için oluşturuldu

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge
import random


@cocotb.test()
async def test_uart_tx(dut):
    clock = Clock(dut.clk_i, 10, units="ns")
    cocotb.start_soon(clock.start())
    dut.rst_i.value = 1
    await RisingEdge(dut.clk_i)
    await RisingEdge(dut.clk_i)
    dut.rst_i.value = 0

    dut.cekirdek_wb_adres_i.value = 0x2000_000C
    dut.cekirdek_wb_veri_i.value  = 0x0000_00AA
    dut.cekirdek_wb_veri_maske_i.value = 0xF
    dut.cekirdek_wb_yaz_gecerli_i.value = 1
    dut.cekirdek_wb_sec_n_i.value = 0
    
    await RisingEdge(dut.clk_i)

    dut.cekirdek_wb_adres_i.value = 0x0000_0000
    dut.cekirdek_wb_veri_i.value  = 0x0000_0000
    dut.cekirdek_wb_veri_maske_i.value = 0x0
    dut.cekirdek_wb_yaz_gecerli_i.value = 0
    dut.cekirdek_wb_sec_n_i.value = 0

    await RisingEdge(dut.clk_i)

    await RisingEdge(dut.clk_i)

    dut.cekirdek_wb_adres_i.value = 0x2000_000C
    dut.cekirdek_wb_veri_i.value  = 0x0000_00BB
    dut.cekirdek_wb_veri_maske_i.value = 0xF
    dut.cekirdek_wb_yaz_gecerli_i.value = 1
    dut.cekirdek_wb_sec_n_i.value = 0
    
    await RisingEdge(dut.clk_i)

    dut.cekirdek_wb_adres_i.value = 0x0000_0000
    dut.cekirdek_wb_veri_i.value  = 0x0000_0000
    dut.cekirdek_wb_veri_maske_i.value = 0x0
    dut.cekirdek_wb_yaz_gecerli_i.value = 0
    dut.cekirdek_wb_sec_n_i.value = 0

    await RisingEdge(dut.clk_i)
    
    await RisingEdge(dut.clk_i)

    dut.cekirdek_wb_adres_i.value = 0x2000_0000
    dut.cekirdek_wb_veri_i.value  = 0x0002_0001
    dut.cekirdek_wb_veri_maske_i.value = 0xF
    dut.cekirdek_wb_yaz_gecerli_i.value = 1
    dut.cekirdek_wb_sec_n_i.value = 0
    
    await RisingEdge(dut.clk_i)

    dut.cekirdek_wb_adres_i.value = 0x0000_0000
    dut.cekirdek_wb_veri_i.value  = 0x0000_0000
    dut.cekirdek_wb_veri_maske_i.value = 0x0
    dut.cekirdek_wb_yaz_gecerli_i.value = 0
    dut.cekirdek_wb_sec_n_i.value = 0
    
    for wait_cyc in range(100):
        await RisingEdge(dut.clk_i)

@cocotb.test()
async def test_uart_rx(dut):
    clock = Clock(dut.clk_i, 10, units="ns")
    cocotb.start_soon(clock.start())
    dut.uart_rx_i.value = 1
    dut.rst_i.value = 1
    await RisingEdge(dut.clk_i)
    await RisingEdge(dut.clk_i)
    dut.rst_i.value = 0

    dut.cekirdek_wb_adres_i.value = 0x2000_0000
    dut.cekirdek_wb_veri_i.value  = 0x0002_0002
    dut.cekirdek_wb_veri_maske_i.value = 0xF
    dut.cekirdek_wb_yaz_gecerli_i.value = 1
    dut.cekirdek_wb_sec_n_i.value = 0
    
    await RisingEdge(dut.clk_i)

    dut.cekirdek_wb_adres_i.value = 0x0000_0000
    dut.cekirdek_wb_veri_i.value  = 0x0000_0000
    dut.cekirdek_wb_veri_maske_i.value = 0x0
    dut.cekirdek_wb_yaz_gecerli_i.value = 0
    dut.cekirdek_wb_sec_n_i.value = 0

    await RisingEdge(dut.clk_i)

    await RisingEdge(dut.clk_i)
    
    await RisingEdge(dut.clk_i)

    await RisingEdge(dut.clk_i)

    await RisingEdge(dut.clk_i)

    dut.uart_rx_i.value = 0 # start bit

    await RisingEdge(dut.clk_i)
    await RisingEdge(dut.clk_i)
    await RisingEdge(dut.clk_i)

    dut.uart_rx_i.value = 0 # AA[0]

    await RisingEdge(dut.clk_i)
    await RisingEdge(dut.clk_i)
    await RisingEdge(dut.clk_i)

    dut.uart_rx_i.value = 1 # AA[1]

    await RisingEdge(dut.clk_i)
    await RisingEdge(dut.clk_i)
    await RisingEdge(dut.clk_i)

    dut.uart_rx_i.value = 0 # AA[2]

    await RisingEdge(dut.clk_i)
    await RisingEdge(dut.clk_i)
    await RisingEdge(dut.clk_i)

    dut.uart_rx_i.value = 1 # AA[3]

    await RisingEdge(dut.clk_i)
    await RisingEdge(dut.clk_i)
    await RisingEdge(dut.clk_i)

    dut.uart_rx_i.value = 0 # AA[4]

    await RisingEdge(dut.clk_i)
    await RisingEdge(dut.clk_i)
    await RisingEdge(dut.clk_i)

    dut.uart_rx_i.value = 1 # AA[5]

    await RisingEdge(dut.clk_i)
    await RisingEdge(dut.clk_i)
    await RisingEdge(dut.clk_i)

    dut.uart_rx_i.value = 0 # AA[6]

    await RisingEdge(dut.clk_i)
    await RisingEdge(dut.clk_i)
    await RisingEdge(dut.clk_i)

    dut.uart_rx_i.value = 1 # AA[7]

    await RisingEdge(dut.clk_i)
    await RisingEdge(dut.clk_i)
    await RisingEdge(dut.clk_i)

    dut.uart_rx_i.value = 1 # stop bit

    await RisingEdge(dut.clk_i)
    
    await RisingEdge(dut.clk_i)

    await RisingEdge(dut.clk_i)
    
    await RisingEdge(dut.clk_i)

    await RisingEdge(dut.clk_i)
    
    await RisingEdge(dut.clk_i)

    await RisingEdge(dut.clk_i)
    
    await RisingEdge(dut.clk_i)

    dut.cekirdek_wb_adres_i.value = 0x2000_0008
    dut.cekirdek_wb_veri_i.value  = 0x0000_0000
    dut.cekirdek_wb_veri_maske_i.value = 0xF
    dut.cekirdek_wb_yaz_gecerli_i.value = 0
    dut.cekirdek_wb_sec_n_i.value = 1
    
    await RisingEdge(dut.clk_i)

    dut.cekirdek_wb_adres_i.value = 0x0000_0000
    dut.cekirdek_wb_veri_i.value  = 0x0000_0000
    dut.cekirdek_wb_veri_maske_i.value = 0x0
    dut.cekirdek_wb_yaz_gecerli_i.value = 0
    dut.cekirdek_wb_sec_n_i.value = 0
    
    await RisingEdge(dut.clk_i)
    
    await RisingEdge(dut.clk_i)
    
    await RisingEdge(dut.clk_i)
    
    await RisingEdge(dut.clk_i)
    
    await RisingEdge(dut.clk_i)
    
    await RisingEdge(dut.clk_i)
    
    await RisingEdge(dut.clk_i)
    
    await RisingEdge(dut.clk_i)

    