
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


TIMEOUT = 185000

riscv_tests = {}
riscv_tests["auipc"] = {
    "TEST_FILE": "./data/rv32ui-p-auipc_static.hex",
    "fail_adr": 0x40000060,
    "pass_adr": 0x40000074,
    "buyruklar": []
}
riscv_tests["lw"] = {
    "TEST_FILE": "./data/rv32ui-p-lw_static.hex",
    "fail_adr": 0x400002e8,
    "pass_adr": 0x400002fc,
    "buyruklar": []
}


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
        dut.rst_ni.value = 0
        await RisingEdge(dut.clk_i)
        for index, buyruk in enumerate(riscv_tests[test]["buyruklar"]):
            dut.main_memory.ram[index] = int(buyruk,16)
        await RisingEdge(dut.clk_i)
        dut.rst_ni.value = 1
        while(1):
            try:
                if(riscv_tests[test]["pass_adr"] == dut.soc.cek.l1b_adres_o.value.integer):
                    print("[TEST] ", test, " passed")
                    break
                if(riscv_tests[test]["fail_adr"] == dut.soc.cek.l1b_adres_o.value.integer):
                    print("[TEST] ", test, " FAILED")
                    assert 0
                    break
            except:
                print("[WARNING] ADR is XXXXXXXXX")
            await RisingEdge(dut.clk_i)
            timout = timout + 1
            if(timout > TIMEOUT):
                print("[TEST] ", test, " FAILED TIMOUT")
                assert 0
                break

@cocotb.test()
async def test_teknofest_wrapper(dut):
    await buyruklari_oku()

    await cocotb.start(Clock(dut.clk_i, 10, 'ns').start(start_high=False))

    dut.rst_ni.value = 0
    await RisingEdge(dut.clk_i)
    await RisingEdge(dut.clk_i)
    dut.rst_ni.value = 1
    blk = cocotb.start_soon(anabellek(dut))
    await blk
