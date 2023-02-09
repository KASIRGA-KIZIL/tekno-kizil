#test_bolme_birimi.py

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge
import random


@cocotb.test()
async def test_tx(dut):
    clock = Clock(dut.clk_i, 10, units="ns")
    cocotb.start_soon(clock.start())
    dut.rst_i.value = 1
    await RisingEdge(dut.clk_i)
    await RisingEdge(dut.clk_i)
    dut.rst_i.value = 0

    await RisingEdge(dut.clk_i)

    dut.wb_adres_i.value = 0x0000_0000
    dut.wb_veri_i.value  = 0x0000_0000
    dut.wb_gecerli_i.value = 0
    dut.wb_yaz_gecerli_i.value = 0

    await RisingEdge(dut.clk_i)

    dut.wb_adres_i.value = 0x0000_000C
    dut.wb_veri_i.value  = 0x0000_00AA
    dut.wb_gecerli_i.value = 1
    dut.wb_yaz_gecerli_i.value = 1

    await RisingEdge(dut.clk_i)

    dut.wb_adres_i.value = 0x0000_0000
    dut.wb_veri_i.value  = 0x0000_0000
    dut.wb_gecerli_i.value = 0
    dut.wb_yaz_gecerli_i.value = 0

    await RisingEdge(dut.clk_i)

    dut.wb_adres_i.value = 0x0000_000C
    dut.wb_veri_i.value  = 0x0000_00BB
    dut.wb_gecerli_i.value = 1
    dut.wb_yaz_gecerli_i.value = 1

    await RisingEdge(dut.clk_i)

    dut.wb_adres_i.value = 0x0000_0000
    dut.wb_veri_i.value  = 0x0000_0000
    dut.wb_gecerli_i.value = 0
    dut.wb_yaz_gecerli_i.value = 0

    await RisingEdge(dut.clk_i)

    dut.wb_adres_i.value = 0x0000_000C
    dut.wb_veri_i.value  = 0x0000_00CC
    dut.wb_gecerli_i.value = 1
    dut.wb_yaz_gecerli_i.value = 1

    await RisingEdge(dut.clk_i)

    dut.wb_adres_i.value = 0x0000_0000
    dut.wb_veri_i.value  = 0x0000_0000
    dut.wb_gecerli_i.value = 0
    dut.wb_yaz_gecerli_i.value = 0

    await RisingEdge(dut.clk_i)

    dut.wb_adres_i.value = 0x0000_0000
    dut.wb_veri_i.value  = 0x0002_0001 # .vcd dosyasinda inceleyebilmek icin yuksek baudrate
    dut.wb_gecerli_i.value = 1
    dut.wb_yaz_gecerli_i.value = 1

    await RisingEdge(dut.clk_i)

    dut.wb_adres_i.value = 0x0000_0000
    dut.wb_veri_i.value  = 0x0000_0000
    dut.wb_gecerli_i.value = 0
    dut.wb_yaz_gecerli_i.value = 0

    await RisingEdge(dut.clk_i)

    for wait_cyc in range(100):
        await RisingEdge(dut.clk_i)

    dut.wb_adres_i.value = 0x0000_0000
    dut.wb_veri_i.value  = 0x0000_0000
    dut.wb_gecerli_i.value = 0
    dut.wb_yaz_gecerli_i.value = 0

    await RisingEdge(dut.clk_i)

    for wait_cyc in range(1000):
        await RisingEdge(dut.clk_i)

@cocotb.test()
async def test_rx(dut):
    clock = Clock(dut.clk_i, 10, units="ns")
    cocotb.start_soon(clock.start())
    dut.rst_i.value = 1
    await RisingEdge(dut.clk_i)
    await RisingEdge(dut.clk_i)
    dut.rst_i.value = 0

    dut.uart_rx_i.value = 1
    await RisingEdge(dut.clk_i)

    dut.wb_adres_i.value = 0x0000_0000
    dut.wb_veri_i.value  = 0x0002_0002
    dut.wb_gecerli_i.value = 1
    dut.wb_yaz_gecerli_i.value = 1

    await RisingEdge(dut.clk_i)

    dut.wb_adres_i.value = 0x0000_0000
    dut.wb_veri_i.value  = 0x0000_0000
    dut.wb_gecerli_i.value = 0
    dut.wb_yaz_gecerli_i.value = 0

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

    for wait_cycle in range(16):
        await RisingEdge(dut.clk_i)

    dut.wb_adres_i.value = 0x0000_0008 # Degeri oku
    dut.wb_veri_i.value  = 0x0000_0000
    dut.wb_gecerli_i.value = 1
    dut.wb_yaz_gecerli_i.value = 0

    await RisingEdge(dut.clk_i)

    dut.wb_adres_i.value = 0x0000_0000
    dut.wb_veri_i.value  = 0x0000_0000
    dut.wb_gecerli_i.value = 0
    dut.wb_yaz_gecerli_i.value = 0

    for wait_cycle in range(16):
        await RisingEdge(dut.clk_i)





