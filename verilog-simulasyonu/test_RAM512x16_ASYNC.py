from random import getrandbits, randint
from typing import Any, Dict, List

import cocotb
from cocotb.binary import BinaryValue
from cocotb.clock import Clock
from cocotb.handle import SimHandleBase
from cocotb.queue import Queue
from cocotb.triggers import RisingEdge, FallingEdge, Edge

TIMEOUT = 200000
SAMPLE_SIZE = 2000

@cocotb.coroutine
async def write(dut,adr,data):
    dut.A0.value  = adr
    dut.Di0.value = data
    dut.WE0.value = 0b11
    await RisingEdge(dut.CLK)
    dut.WE0.value = 0

@cocotb.coroutine
async def random_tests(dut):
    for _ in range(SAMPLE_SIZE):
        adr  = getrandbits(9)
        data = getrandbits(16)
        await write(dut,adr,data)
        dut.A0.value  = adr
        await FallingEdge(dut.CLK)
        assert (data == dut.Do0.value, "nope")

@cocotb.test()
async def test_RAM512x16_ASYNC(dut):
    await cocotb.start(Clock(dut.CLK, 10, 'ns').start(start_high=False))
    await random_tests(dut)
