# This file is public domain, it can be freely copied without restrictions.
# SPDX-License-Identifier: CC0-1.0

import math
import os
from random import getrandbits
from typing import Any, Dict, List

import cocotb
from cocotb.binary import BinaryValue
from cocotb.clock import Clock
from cocotb.handle import SimHandleBase
from cocotb.queue import Queue
from cocotb.triggers import RisingEdge, FallingEdge, Edge

TIMEOUT = 10000

riscv_tests = {}
riscv_tests["auipc"] = {
    "TEST_FILE": "./data/rv32ui-p-auipc_static.hex",
    "fail_adr": 0x40000060,
    "pass_adr": 0x40000074,
    "buyruklar": []
}
riscv_tests["jal"] = {
    "TEST_FILE": "./data/rv32ui-p-jal_static.hex",
    "fail_adr": 0x40000070,
    "pass_adr": 0x40000084,
    "buyruklar": []
}
riscv_tests["jalr"] = {
    "TEST_FILE": "./data/rv32ui-p-jalr_static.hex",
    "fail_adr": 0x40000110,
    "pass_adr": 0x40000124,
    "buyruklar": []
}
riscv_tests["lui"] = {
    "TEST_FILE": "./data/rv32ui-p-lui_static.hex",
    "fail_adr": 0x4000007c,
    "pass_adr": 0x40000090,
    "buyruklar": []
}
riscv_tests["andi"] = {
    "TEST_FILE": "./data/rv32ui-p-andi_static.hex",
    "fail_adr": 0x400001dc,
    "pass_adr": 0x400001f0,
    "buyruklar": []
}
riscv_tests["ori"] = {
    "TEST_FILE": "./data/rv32ui-p-ori_static.hex",
    "fail_adr": 0x400001f8,
    "pass_adr": 0x4000020c,
    "buyruklar": []
}
riscv_tests["xori"] = {
    "TEST_FILE": "./data/rv32ui-p-xori_static.hex",
    "fail_adr": 0x40000200,
    "pass_adr": 0x40000214,
    "buyruklar": []
}
riscv_tests["addi"] = {
    "TEST_FILE": "./data/rv32ui-p-addi_static.hex",
    "fail_adr": 0x400002a4,
    "pass_adr": 0x400002b8,
    "buyruklar": []
}
riscv_tests["slli"] = {
    "TEST_FILE": "./data/rv32ui-p-slli_static.hex",
    "fail_adr": 0x400002a0,
    "pass_adr": 0x400002b4,
    "buyruklar": []
}
riscv_tests["slti"] = {
    "TEST_FILE": "./data/rv32ui-p-slti_static.hex",
    "fail_adr": 0x40000290,
    "pass_adr": 0x400002a4,
    "buyruklar": []
}
riscv_tests["sltiu"] = {
    "TEST_FILE": "./data/rv32ui-p-sltiu_static.hex",
    "fail_adr": 0x40000290,
    "pass_adr": 0x400002a4,
    "buyruklar": []
}
riscv_tests["and"] = {
    "TEST_FILE": "./data/rv32ui-p-and_static.hex",
    "fail_adr": 0x400004d4,
    "pass_adr": 0x400004e8,
    "buyruklar": []
}
riscv_tests["sll"] = {
    "TEST_FILE": "./data/rv32ui-p-sll_static.hex",
    "fail_adr": 0x4000056c,
    "pass_adr": 0x40000580,
    "buyruklar": []
}
riscv_tests["xor"] = {
    "TEST_FILE": "./data/rv32ui-p-xor_static.hex",
    "fail_adr": 0x400004dc,
    "pass_adr": 0x400004f0,
    "buyruklar": []
}
riscv_tests["or"] = {
    "TEST_FILE": "./data/rv32ui-p-or_static.hex",
    "fail_adr": 0x400004e0,
    "pass_adr": 0x400004f4,
    "buyruklar": []
}
riscv_tests["srl"] = {
    "TEST_FILE": "./data/rv32ui-p-srl_static.hex",
    "fail_adr": 0x400005a0,
    "pass_adr": 0x400005b4,
    "buyruklar": []
}
riscv_tests["sra"] = {
    "TEST_FILE": "./data/rv32ui-p-sra_static.hex",
    "fail_adr": 0x400005b8,
    "pass_adr": 0x400005cc,
    "buyruklar": []
}
riscv_tests["slt"] = {
    "TEST_FILE": "./data/rv32ui-p-slt_static.hex",
    "fail_adr": 0x400004e4,
    "pass_adr": 0x400004f8,
    "buyruklar": []
}
riscv_tests["sltu"] = {
    "TEST_FILE": "./data/rv32ui-p-sltu_static.hex",
    "fail_adr": 0x400004e4,
    "pass_adr": 0x400004f8,
    "buyruklar": []
}
riscv_tests["srli"] = {
    "TEST_FILE": "./data/rv32ui-p-srli_static.hex",
    "fail_adr": 0x400002bc,
    "pass_adr": 0x400002d0,
    "buyruklar": []
}
riscv_tests["srai"] = {
    "TEST_FILE": "./data/rv32ui-p-srai_static.hex",
    "fail_adr": 0x400002d4,
    "pass_adr": 0x400002e8,
    "buyruklar": []
}
riscv_tests["sub"] = {
    "TEST_FILE": "./data/rv32ui-p-sub_static.hex",
    "fail_adr": 0x400004dc,
    "pass_adr": 0x400004f0,
    "buyruklar": []
}





"""
riscv_tests["bgeu"] = {
    "TEST_FILE": "./data/rv32ui-p-bgeu_static.hex",
    "fail_adr": 0x40000370,
    "pass_adr": 0x40000384,
    "buyruklar": []
}
riscv_tests["bltu"] = {
    "TEST_FILE": "./data/rv32ui-p-bltu_static.hex",
    "fail_adr": 0x40000310,
    "pass_adr": 0x40000324,
    "buyruklar": []
}
riscv_tests["blt"] = {
    "TEST_FILE": "./data/rv32ui-p-blt_static.hex",
    "fail_adr": 0x400002dc,
    "pass_adr": 0x400002f0,
    "buyruklar": []
}
riscv_tests["bne"] = {
    "TEST_FILE": "./data/rv32ui-p-bne_static.hex",
    "fail_adr": 0x400002e0,
    "pass_adr": 0x400002f4,
    "buyruklar": []
}
riscv_tests["beq"] = {
    "TEST_FILE": "./data/rv32ui-p-beq_static.hex",
    "fail_adr": 0x400002dc,
    "pass_adr": 0x400002f0,
    "buyruklar": []
}
riscv_tests["bge"] = {
    "TEST_FILE": "./data/rv32ui-p-bge_static.hex",
    "fail_adr": 0x4000033c,
    "pass_adr": 0x40000350,
    "buyruklar": []
}
riscv_tests["add"] = {
    "TEST_FILE": "./data/rv32ui-p-add_static.hex",
    "fail_adr": 0x400004fc,
    "pass_adr": 0x40000510,
    "buyruklar": []
}
"""
@cocotb.coroutine
async def buyruklari_oku():
    for test in riscv_tests:
        with open(riscv_tests[test]["TEST_FILE"], 'r') as f:
            buyruklar = [line.rstrip('\n') for line in f]
        riscv_tests[test]["buyruklar"] = buyruklar

@cocotb.coroutine
async def anabellek(dut):
    timout = 0
    await RisingEdge(dut.clk_i)
    for test in riscv_tests:
        while(1):
            memidx = (dut.l1b_adres_o.value.integer-0x40000000) >> 2
            try:
                dut.l1b_deger_i.value = int(riscv_tests[test]["buyruklar"][memidx],16)
            except:
                print("Bos adres: {}".format(memidx))
            if(riscv_tests[test]["pass_adr"] == dut.l1b_adres_o.value.integer):
                print("[TEST] ", test, " passed")
                break
            if(riscv_tests[test]["fail_adr"] == dut.l1b_adres_o.value.integer):
                print("[TEST] ", test, " FAILED")
                assert 0
            await RisingEdge(dut.clk_i)
            timout = timout + 1
            if(timout > TIMEOUT):
                print("[TEST] ", test, " FAILED TIMOUT")
                assert 0
                break
        dut.rst_i.value = 1
        await RisingEdge(dut.clk_i)
        await RisingEdge(dut.clk_i)
        dut.rst_i.value = 0

@cocotb.test()
async def test_cekirdek(dut):
    await buyruklari_oku()

    await cocotb.start(Clock(dut.clk_i, 10, 'ns').start(start_high=False))

    dut.rst_i.value = 1
    await RisingEdge(dut.clk_i)
    await RisingEdge(dut.clk_i)
    blk = cocotb.start_soon(anabellek(dut))
    dut.rst_i.value = 0
    dut.l1b_bekle_i.value = 0
    await blk
