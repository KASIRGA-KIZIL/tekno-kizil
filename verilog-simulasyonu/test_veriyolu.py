# test_veriyolu.py

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge
import random


@cocotb.test()
async def test_uart(dut):
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

    dut.uart_wb_mesgul_i.value = 0
    dut.cekirdek_wb_adres_i.value = 0x2000_0008
    dut.cekirdek_wb_veri_i.value  = 0x0000_0000
    dut.cekirdek_wb_yaz_gecerli_i.value = 0
    dut.cekirdek_wb_sec_n_i.value = 1
    
    await RisingEdge(dut.clk_i)

    dut.cekirdek_wb_adres_i.value = 0x0000_0000
    dut.cekirdek_wb_veri_i.value  = 0x0000_0000
    dut.cekirdek_wb_yaz_gecerli_i.value = 0
    dut.cekirdek_wb_sec_n_i.value = 0

    dut.uart_wb_oku_veri_i.value = 0xAA
    dut.uart_wb_oku_veri_gecerli_i.value = 1
    dut.uart_wb_mesgul_i.value = 0

    await RisingEdge(dut.clk_i)

    await RisingEdge(dut.clk_i)

    await RisingEdge(dut.clk_i)

@cocotb.test()
async def test_spi(dut):
    clock = Clock(dut.clk_i, 10, units="ns")
    cocotb.start_soon(clock.start())
    dut.rst_i.value = 1
    await RisingEdge(dut.clk_i)
    await RisingEdge(dut.clk_i)
    dut.rst_i.value = 0

    dut.cekirdek_wb_adres_i.value = 0x2001_000C
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

    dut.cekirdek_wb_adres_i.value = 0x2001_000C
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

    dut.uart_wb_mesgul_i.value = 0
    dut.cekirdek_wb_adres_i.value = 0x2001_0008
    dut.cekirdek_wb_veri_i.value  = 0x0000_0000
    dut.cekirdek_wb_yaz_gecerli_i.value = 0
    dut.cekirdek_wb_sec_n_i.value = 1
    
    await RisingEdge(dut.clk_i)

    dut.cekirdek_wb_adres_i.value = 0x0000_0000
    dut.cekirdek_wb_veri_i.value  = 0x0000_0000
    dut.cekirdek_wb_yaz_gecerli_i.value = 0
    dut.cekirdek_wb_sec_n_i.value = 0

    dut.uart_wb_oku_veri_i.value = 0xAA
    dut.uart_wb_oku_veri_gecerli_i.value = 1
    dut.uart_wb_mesgul_i.value = 0

    await RisingEdge(dut.clk_i)

    await RisingEdge(dut.clk_i)

    await RisingEdge(dut.clk_i)


@cocotb.test()
async def test_pwm(dut):
    clock = Clock(dut.clk_i, 10, units="ns")
    cocotb.start_soon(clock.start())
    dut.rst_i.value = 1
    await RisingEdge(dut.clk_i)
    await RisingEdge(dut.clk_i)
    dut.rst_i.value = 0

    dut.cekirdek_wb_adres_i.value = 0x2002_000C
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

    dut.cekirdek_wb_adres_i.value = 0x2002_000C
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

    dut.uart_wb_mesgul_i.value = 0
    dut.cekirdek_wb_adres_i.value = 0x2002_0008
    dut.cekirdek_wb_veri_i.value  = 0x0000_0000
    dut.cekirdek_wb_yaz_gecerli_i.value = 0
    dut.cekirdek_wb_sec_n_i.value = 1
    
    await RisingEdge(dut.clk_i)

    dut.cekirdek_wb_adres_i.value = 0x0000_0000
    dut.cekirdek_wb_veri_i.value  = 0x0000_0000
    dut.cekirdek_wb_yaz_gecerli_i.value = 0
    dut.cekirdek_wb_sec_n_i.value = 0

    dut.uart_wb_oku_veri_i.value = 0xAA
    dut.uart_wb_oku_veri_gecerli_i.value = 1
    dut.uart_wb_mesgul_i.value = 0

    await RisingEdge(dut.clk_i)

    await RisingEdge(dut.clk_i)

    await RisingEdge(dut.clk_i)

@cocotb.test()
async def test_vb(dut):
    clock = Clock(dut.clk_i, 10, units="ns")
    cocotb.start_soon(clock.start())
    dut.rst_i.value = 1
    await RisingEdge(dut.clk_i)
    await RisingEdge(dut.clk_i)
    dut.rst_i.value = 0

    dut.cekirdek_wb_adres_i.value = 0x0000_000C
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

    dut.cekirdek_wb_adres_i.value = 0x0000_000C
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

    dut.uart_wb_mesgul_i.value = 0
    dut.cekirdek_wb_adres_i.value = 0x0000_0008
    dut.cekirdek_wb_veri_i.value  = 0x0000_0000
    dut.cekirdek_wb_yaz_gecerli_i.value = 0
    dut.cekirdek_wb_sec_n_i.value = 1
    
    await RisingEdge(dut.clk_i)

    dut.cekirdek_wb_adres_i.value = 0x0000_0000
    dut.cekirdek_wb_veri_i.value  = 0x0000_0000
    dut.cekirdek_wb_yaz_gecerli_i.value = 0
    dut.cekirdek_wb_sec_n_i.value = 0

    dut.uart_wb_oku_veri_i.value = 0xAA
    dut.uart_wb_oku_veri_gecerli_i.value = 1
    dut.uart_wb_mesgul_i.value = 0

    await RisingEdge(dut.clk_i)

    await RisingEdge(dut.clk_i)

    await RisingEdge(dut.clk_i)
