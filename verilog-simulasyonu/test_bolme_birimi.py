#test_bolme_birimi.py

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge
import random


@cocotb.test()
async def test_divu(dut):
    clock = Clock(dut.clk_i, 10, units="ns")
    cocotb.start_soon(clock.start())
    # Sabit giris atamalari
    islem = 0
    dut.islem_i.value = islem
    dut.rst_i.value   = 0
    
    # Dogruluk kontrolu
    test_sayisi = 1000
    for test_idx in range(test_sayisi):
        # deger1  = int(random.random()*2**31)
        # deger2  = int(random.random()*2**31)
        deger1 = 16
        deger2 = 3
        dut.bolunen_i.value = deger1
        dut.bolen_i.value = deger2
        sonuc = int(deger1/deger2 if(deger1/deger2 >= 0) else (2**32+deger1/deger2))%2**32
        await RisingEdge(dut.bitti_o)
        assert(dut.bitti_o.value and sonuc == dut.sonuc_o.value),f"deger1:{deger1}\ndeger2:{deger2}\nBeklenen sonuc = {sonuc}\nModul ciktisi = {dut.sonuc_o.value}"

