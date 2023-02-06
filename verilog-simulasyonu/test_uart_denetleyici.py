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

    dut.wb_adres_i.value = 0x0000_000C
    dut.wb_veri_i.value  = 0x0000_00BB
    dut.wb_gecerli_i.value = 1
    dut.wb_yaz_gecerli_i.value = 1

    await RisingEdge(dut.clk_i)

    dut.wb_adres_i.value = 0x0000_000C
    dut.wb_veri_i.value  = 0x0000_00CC
    dut.wb_gecerli_i.value = 1
    dut.wb_yaz_gecerli_i.value = 1

    await RisingEdge(dut.clk_i)

    dut.wb_adres_i.value = 0x0000_0000
    dut.wb_veri_i.value  = 0x0002_0001
    dut.wb_gecerli_i.value = 1
    dut.wb_yaz_gecerli_i.value = 1

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

# @cocotb.test()
# async def test_rx(dut):
#     clock = Clock(dut.clk_i, 10, units="ns")
#     cocotb.start_soon(clock.start())
#     dut.rst_i.value = 1
#     await RisingEdge(dut.clk_i)
#     await RisingEdge(dut.clk_i)
