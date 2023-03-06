#test_carpma_birimi.py

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge
import random


@cocotb.test()
async def test_mul(dut):
    clock = Clock(dut.clk_i, 10, units="ns")
    cocotb.start_soon(clock.start())
    dut.rst_i.value = 1
    await RisingEdge(dut.clk_i)
    await RisingEdge(dut.clk_i)
    # Sabit giris atamalari
    kontrol = 0
    biriktir = 0
    dut.durdur_i.value = 0
    dut.kontrol_i.value = kontrol
    dut.rst_i.value = not biriktir
    
    dut.deger1_i.value = 0
    dut.deger2_i.value = 0
    sonuc_next = 0
    await RisingEdge(dut.clk_i)
    await RisingEdge(dut.clk_i)
    sonuc = sonuc_next
    # Dogruluk kontrolu
    test_sayisi = 100
    for test_idx in range(test_sayisi):
        deger1  = int(random.random()*2**32)-2**31
        deger2  = int(random.random()*2**32)-2**31
        dut.deger1_i.value = deger1
        dut.deger2_i.value = deger2
        sonuc_next = int(deger1*deger2 if(deger1*deger2 >= 0) else (2**64+deger1*deger2))%2**32
        await RisingEdge(dut.clk_i)
        assert(sonuc == dut.sonuc_o.value),f"deger1:{deger1}\ndeger2:{deger2}\nBeklenen sonuc = {sonuc}\nModul ciktisi = {dut.sonuc_o.value}"
        sonuc = sonuc_next

@cocotb.test()
async def test_mulh(dut):
    clock = Clock(dut.clk_i, 10, units="ns")
    cocotb.start_soon(clock.start())
    dut.rst_i.value = 1
    await RisingEdge(dut.clk_i)
    await RisingEdge(dut.clk_i)
    # Sabit giris atamalari
    kontrol = 1
    biriktir = 0
    dut.durdur_i.value = 0
    dut.kontrol_i.value = kontrol
    dut.rst_i.value = not biriktir
    
    dut.deger1_i.value = 0
    dut.deger2_i.value = 0
    sonuc_next = 0
    await RisingEdge(dut.clk_i)
    await RisingEdge(dut.clk_i)
    sonuc = sonuc_next
    # Dogruluk kontrolu
    test_sayisi = 100
    for test_idx in range(test_sayisi):
        deger1  = int(random.random()*2**32)-2**31
        deger2  = int(random.random()*2**32)-2**31
        dut.deger1_i.value = deger1
        dut.deger2_i.value = deger2
        sonuc_next = int((deger1*deger2 if(deger1*deger2 >= 0) else (2**64+deger1*deger2))/2**32)%2**32
        await RisingEdge(dut.clk_i)
        assert(sonuc == dut.sonuc_o.value),f"deger1:{deger1}\ndeger2:{deger2}\nBeklenen sonuc = {sonuc}\nModul ciktisi = {dut.sonuc_o.value}"
        sonuc = sonuc_next

@cocotb.test()
async def test_conv(dut):
    clock = Clock(dut.clk_i, 10, units="ns")
    cocotb.start_soon(clock.start())
    dut.rst_i.value = 1
    await RisingEdge(dut.clk_i)
    await RisingEdge(dut.clk_i)
    # Sabit giris atamalari
    kontrol = 0
    biriktir = 1
    dut.durdur_i.value = 0
    dut.kontrol_i.value = kontrol
    dut.rst_i.value = not biriktir
    
    dut.deger1_i.value = 0
    dut.deger2_i.value = 0
    sonuc_next = 0
    await RisingEdge(dut.clk_i)
    await RisingEdge(dut.clk_i)
    sonuc = sonuc_next
    # Dogruluk kontrolu
    test_sayisi = 10
    for test_idx in range(test_sayisi):
        deger1  = int(random.random()*2**5)
        deger2  = int(random.random()*2**5)
        dut.deger1_i.value = deger1
        dut.deger2_i.value = deger2
        sonuc_next = int((deger1*deger2 if(deger1*deger2 >= 0) else (2**64+deger1*deger2))/2**32)%2**32
        await RisingEdge(dut.clk_i)
        assert(sonuc_next == dut.sonuc_o.value),f"deger1:{deger1}\ndeger2:{deger2}\nBeklenen sonuc = {sonuc_next}\nModul ciktisi = {dut.sonuc_o.value}"
        sonuc += sonuc_next
