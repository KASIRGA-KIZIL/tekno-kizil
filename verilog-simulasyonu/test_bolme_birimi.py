#test_bolme_birimi.py

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge
from cocotb.triggers import FallingEdge
import random


@cocotb.test()
async def test_divu(dut):
    clock = Clock(dut.clk_i, 10, units="ns")
    cocotb.start_soon(clock.start())
    dut.rst_i.value   = 1
    await RisingEdge(dut.clk_i)
    await RisingEdge(dut.clk_i)
    dut.rst_i.value   = 0
    
    # Sabit giris atamalari
    islem = 0
    dut.islem_i.value = islem
    dut.basla_i.value   = 1

    # Dogruluk kontrolu
    test_sayisi = 100
    for test_idx in range(test_sayisi):
        deger1  = int(random.random()*2**31)
        deger2  = int(random.random()*2**31)
        dut.bolunen_i.value = deger1
        dut.bolen_i.value = deger2
        sonuc = int(deger1/deger2 if(deger1/deger2 >= 0) else (2**32+deger1/deger2))%2**32
        for cyc in range(18):
            await RisingEdge(dut.clk_i)
        await FallingEdge(dut.clk_i)
        assert(dut.bitti_o.value and sonuc == dut.sonuc_o.value),f"deger1:{deger1}\ndeger2:{deger2}\nBeklenen sonuc = {sonuc}\nModul ciktisi = {dut.sonuc_o.value}"
        await RisingEdge(dut.clk_i)
