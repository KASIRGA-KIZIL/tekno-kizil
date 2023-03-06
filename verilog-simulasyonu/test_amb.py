#test_amb.py

import cocotb
from cocotb.triggers import Timer
import random


@cocotb.test()
async def test_toplama(dut):
    # Sabit giris atamalari
    kontrol = 0
    dut.kontrol_i.value = kontrol
    
    # Dogruluk kontrolu
    test_sayisi = 1000
    for test_idx in range(test_sayisi):
        deger1  = int(random.random()*2**31)
        deger2  = int(random.random()*2**31)
        dut.deger1_i.value = deger1
        dut.deger2_i.value = deger2
        sonuc = deger1 + deger2
        await Timer(2,units="ns")
        assert(sonuc == dut.sonuc_o.value),f"Beklenen sonuc = {sonuc}\nModul ciktisi = {dut.sonuc_o.value}"

@cocotb.test()
async def test_cikarma(dut):
    # Sabit giris atamalari
    kontrol = 1
    dut.kontrol_i.value = kontrol
    
    # Dogruluk kontrolu
    test_sayisi = 1000
    for test_idx in range(test_sayisi):
        deger1  = int(random.random()*2**16+2**16)
        deger2  = int(random.random()*2**16)
        dut.deger1_i.value = deger1
        dut.deger2_i.value = deger2
        sonuc = deger1 - deger2
        await Timer(2,units="ns")
        assert(sonuc == dut.sonuc_o.value),f"deger1:{deger1}\ndeger2:{deger2}\nBeklenen sonuc = {sonuc}\nModul ciktisi = {dut.sonuc_o.value}"

@cocotb.test()
async def test_xor(dut):
    # Sabit giris atamalari
    kontrol = 2
    dut.kontrol_i.value = kontrol
    
    # Dogruluk kontrolu
    test_sayisi = 1000
    for test_idx in range(test_sayisi):
        deger1  = int(random.random()*2**32)
        deger2  = int(random.random()*2**32)
        dut.deger1_i.value = deger1
        dut.deger2_i.value = deger2
        sonuc = deger1 ^ deger2
        await Timer(2,units="ns")
        assert(sonuc == dut.sonuc_o.value),f"Beklenen sonuc = {sonuc}\nModul ciktisi = {dut.sonuc_o.value}"

@cocotb.test()
async def test_or(dut):
    # Sabit giris atamalari
    kontrol = 3
    dut.kontrol_i.value = kontrol
    
    # Dogruluk kontrolu
    test_sayisi = 1000
    for test_idx in range(test_sayisi):
        deger1  = int(random.random()*2**32)
        deger2  = int(random.random()*2**32)
        dut.deger1_i.value = deger1
        dut.deger2_i.value = deger2
        sonuc = deger1 | deger2
        await Timer(2,units="ns")
        assert(sonuc == dut.sonuc_o.value),f"Beklenen sonuc = {sonuc}\nModul ciktisi = {dut.sonuc_o.value}"

@cocotb.test()
async def test_and(dut):
    # Sabit giris atamalari
    kontrol = 4
    dut.kontrol_i.value = kontrol
    
    # Dogruluk kontrolu
    test_sayisi = 1000
    for test_idx in range(test_sayisi):
        deger1  = int(random.random()*2**32)
        deger2  = int(random.random()*2**32)
        dut.deger1_i.value = deger1
        dut.deger2_i.value = deger2
        sonuc = deger1 & deger2
        await Timer(2,units="ns")
        assert(sonuc == dut.sonuc_o.value),f"Beklenen sonuc = {sonuc}\nModul ciktisi = {dut.sonuc_o.value}"

@cocotb.test()
async def test_sll(dut):
    # Sabit giris atamalari
    kontrol = 5
    dut.kontrol_i.value = kontrol
    
    # Dogruluk kontrolu
    test_sayisi = 1000
    for test_idx in range(test_sayisi):
        deger1  = int(random.random()*2**32)
        deger2  = int(random.random()*2**5)
        dut.deger1_i.value = deger1
        dut.deger2_i.value = deger2
        sonuc = (deger1 << deger2)%2**32
        await Timer(2,units="ns")
        assert(sonuc == dut.sonuc_o.value),f"deger1:{deger1}\ndeger2:{deger2}\nBeklenen sonuc = {sonuc}\nModul ciktisi = {dut.sonuc_o.value}"

@cocotb.test()
async def test_srl(dut):
    # Sabit giris atamalari
    kontrol = 6
    dut.kontrol_i.value = kontrol
    
    # Dogruluk kontrolu
    test_sayisi = 1000
    for test_idx in range(test_sayisi):
        deger1  = int(random.random()*2**32)
        deger2  = int(random.random()*2**5)
        dut.deger1_i.value = deger1
        dut.deger2_i.value = deger2
        sonuc = deger1 >> deger2
        await Timer(2,units="ns")
        assert(sonuc == dut.sonuc_o.value),f"deger1:{deger1}\ndeger2:{deger2}\nBeklenen sonuc = {sonuc}\nModul ciktisi = {dut.sonuc_o.value}"

@cocotb.test()
async def test_sra(dut):
    # Sabit giris atamalari
    kontrol = 7
    dut.kontrol_i.value = kontrol
    
    # Dogruluk kontrolu
    test_sayisi = 1000
    for test_idx in range(test_sayisi):
        deger1  = int(random.random()*2**31)
        deger2  = int(random.random()*2**5)
        dut.deger1_i.value = deger1
        dut.deger2_i.value = deger2
        sonuc = deger1 >> (deger2%2**5)
        await Timer(2,units="ns")
        assert(sonuc == dut.sonuc_o.value),f"deger1:{deger1}\ndeger2:{deger2}\nBeklenen sonuc = {sonuc}\nModul ciktisi = {dut.sonuc_o.value}"

@cocotb.test()
async def test_slt(dut):
    # Sabit giris atamalari
    kontrol = 8
    dut.kontrol_i.value = kontrol
    
    # Dogruluk kontrolu
    test_sayisi = 1000
    for test_idx in range(test_sayisi):
        deger1  = int(random.random()*2**31)
        deger2  = int(random.random()*2**31)
        dut.deger1_i.value = deger1
        dut.deger2_i.value = deger2
        sonuc = (deger1 < deger2)
        await Timer(2,units="ns")
        assert(sonuc == dut.sonuc_o.value),f"deger1:{deger1}\ndeger2:{deger2}\nBeklenen sonuc = {sonuc}\nModul ciktisi = {dut.sonuc_o.value}"

@cocotb.test()
async def test_sltu(dut):
    # Sabit giris atamalari
    kontrol = 9
    dut.kontrol_i.value = kontrol
    
    # Dogruluk kontrolu
    test_sayisi = 1000
    for test_idx in range(test_sayisi):
        deger1  = int(random.random()*2**32)
        deger2  = int(random.random()*2**32)
        dut.deger1_i.value = deger1
        dut.deger2_i.value = deger2
        sonuc = (deger1 < deger2)
        await Timer(2,units="ns")
        assert(sonuc == dut.sonuc_o.value),f"deger1:{deger1}\ndeger2:{deger2}\nBeklenen sonuc = {sonuc}\nModul ciktisi = {dut.sonuc_o.value}"
