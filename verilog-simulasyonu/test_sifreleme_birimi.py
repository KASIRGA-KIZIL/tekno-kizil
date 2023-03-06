#test_sifreleme_birimi.py

import cocotb
from cocotb.triggers import Timer
import random


@cocotb.test()
async def test_hmdst(dut):
    # Sabit giris atamalari
    kontrol = 0
    dut.kontrol_i.value = kontrol
    
    # Dogruluk kontrolu
    test_sayisi = 100
    for test_idx in range(test_sayisi):
        deger1  = int(random.random()*2**31)
        deger2  = int(random.random()*2**31)
        dut.deger1_i.value = deger1
        dut.deger2_i.value = deger2
        sonuc = 0
        for index in range(32):
            sonuc = sonuc + int((deger1 ^ deger2)/2**index)%2
        await Timer(2,units="ns")
        assert(sonuc == dut.sonuc_o.value),f"deger1: {deger1}, deger2: {deger2}\n Beklenen sonuc = {sonuc}\nModul ciktisi = {dut.sonuc_o.value}"

@cocotb.test()
async def test_pkg(dut):
    # Sabit giris atamalari
    kontrol = 1
    dut.kontrol_i.value = kontrol
    
    # Dogruluk kontrolu
    test_sayisi = 100
    for test_idx in range(test_sayisi):
        deger1  = int(random.random()*2**31)
        deger2  = int(random.random()*2**31)
        dut.deger1_i.value = deger1
        dut.deger2_i.value = deger2
        sonuc = 0
        sonuc = ((deger2%(2**16)) << 16) + (deger1%(2**16))
        await Timer(2,units="ns")
        assert(sonuc == dut.sonuc_o.value),f"deger1: {deger1}, deger2: {deger2}\n Beklenen sonuc = {sonuc}\nModul ciktisi = {dut.sonuc_o.value}"

@cocotb.test()
async def test_rvrs(dut):
    # Sabit giris atamalari
    kontrol = 2
    dut.kontrol_i.value = kontrol
    
    # Dogruluk kontrolu
    test_sayisi = 100
    for test_idx in range(test_sayisi):
        deger1  = int(random.random()*2**31)
        dut.deger1_i.value = deger1
        sonuc = 0
        for i in range(4):
            sonuc = sonuc << 8
            sonuc = sonuc + deger1%(2**8)
            deger1 = deger1 >> 8
        await Timer(2,units="ns")
        assert(sonuc == dut.sonuc_o.value),f"deger1: {deger1}\n Beklenen sonuc = {sonuc}\nModul ciktisi = {dut.sonuc_o.value}"

@cocotb.test()
async def test_sladd(dut):
    # Sabit giris atamalari
    kontrol = 3
    dut.kontrol_i.value = kontrol
    
    # Dogruluk kontrolu
    test_sayisi = 100
    for test_idx in range(test_sayisi):
        deger1  = int(random.random()*2**30)
        deger2  = int(random.random()*2**30)
        dut.deger1_i.value = deger1
        dut.deger2_i.value = deger2
        sonuc = deger2 + (deger1<<1)
        await Timer(2,units="ns")
        assert(sonuc == dut.sonuc_o.value),f"deger1: {deger1}, deger2: {deger2}\n Beklenen sonuc = {sonuc}\nModul ciktisi = {dut.sonuc_o.value}"

@cocotb.test()
async def test_cntz(dut):
    # Sabit giris atamalari
    kontrol = 4
    dut.kontrol_i.value = kontrol
    
    # Dogruluk kontrolu
    test_sayisi = 100
    for test_idx in range(test_sayisi):
        deger1  = int(random.random()*2**31)
        dut.deger1_i.value = deger1
        sonuc = 0
        for index in range(32):
            if(deger1%2):
                break
            else:
                sonuc = sonuc + 1
                deger1 = deger1 >> 1
        await Timer(2,units="ns")
        assert(sonuc == dut.sonuc_o.value),f"deger1: {deger1}\n Beklenen sonuc = {sonuc}\nModul ciktisi = {dut.sonuc_o.value}"

@cocotb.test()
async def test_cntp(dut):
    # Sabit giris atamalari
    kontrol = 5
    dut.kontrol_i.value = kontrol
    
    # Dogruluk kontrolu
    test_sayisi = 100
    for test_idx in range(test_sayisi):
        deger1  = int(random.random()*2**31)
        deger2  = int(random.random()*2**31)
        dut.deger1_i.value = deger1
        dut.deger2_i.value = deger2
        sonuc = 0
        for index in range(32):
            sonuc = sonuc + (deger1%2)
            deger1 = deger1 >> 1
        await Timer(2,units="ns")
        assert(sonuc == dut.sonuc_o.value),f"deger1: {deger1}, deger2: {deger2}\n Beklenen sonuc = {sonuc}\nModul ciktisi = {dut.sonuc_o.value}"
