#test_bolme_birimi.py

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge
import random


@cocotb.test()
async def test_mul(dut):
    clock = Clock(dut.clk_i, 10, units="ns")
    cocotb.start_soon(clock.start())
    # Sabit giris atamalari
    kontrol = 0
    dut.kontrol.value = kontrol
    dut.rst_i.value = 1
    
    dut.deger1_i.value = 0
    dut.deger2_i.value = 0
    sonuc_next = 0
    await RisingEdge(dut.clk_i)
    await RisingEdge(dut.clk_i)
    sonuc = sonuc_next
    # Dogruluk kontrolu
    test_sayisi = 1000
    for test_idx in range(test_sayisi):
        deger1  = int(random.random()*2**32)-2**31
        deger2  = int(random.random()*2**32)-2**31
        dut.deger1_i.value = deger1
        dut.deger2_i.value = deger2
        sonuc_next = (deger1*deger2)%(2**32)
        await RisingEdge(dut.clk_i)
        assert(sonuc == dut.sonuc_o.value),f"deger1:{deger1}\ndeger2:{deger2}\nBeklenen sonuc = {sonuc}\nModul ciktisi = {dut.sonuc_o.value}"
        sonuc = sonuc_next if(sonuc_next >= 0) else 2**32+sonuc_next

@cocotb.test()
async def test_mulh(dut):
    clock = Clock(dut.clk_i, 10, units="ns")
    cocotb.start_soon(clock.start())
    # Sabit giris atamalari
    kontrol = 1
    dut.kontrol.value = kontrol
    dut.rst_i.value = 1
    
    dut.deger1_i.value = 0
    dut.deger2_i.value = 0
    sonuc_next = 0
    await RisingEdge(dut.clk_i)
    await RisingEdge(dut.clk_i)
    sonuc = sonuc_next
    # Dogruluk kontrolu
    test_sayisi = 1000
    for test_idx in range(test_sayisi):
        deger1  = int(random.random()*2**32)-2**31
        deger2  = int(random.random()*2**32)-2**31
        dut.deger1_i.value = deger1
        dut.deger2_i.value = deger2
        sonuc_next = int((deger1*deger2 if(deger1*deger2 >= 0) else (2**64+deger1*deger2))/2**32)%2**32
        await RisingEdge(dut.clk_i)
        assert(sonuc == dut.sonuc_o.value),f"deger1:{deger1}\ndeger2:{deger2}\nBeklenen sonuc = {sonuc}\nModul ciktisi = {dut.sonuc_o.value}"
        sonuc = sonuc_next
