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
from cocotb.triggers import RisingEdge, FallingEdge


TEST_FILE = "./data/rv32.hex"



@cocotb.coroutine
async def buyruklari_oku():
    with open(TEST_FILE, 'r') as f:
        buyruklar = [line.rstrip('\n') for line in f]
    return buyruklar

@cocotb.coroutine
async def anabellek(dut,buyruklar):
    while(1):
        dut.l1b_deger_i.value = int(buyruklar[dut.l1b_adres_o.value.integer >> 2],16)
        await RisingEdge(dut.clk_i)


@cocotb.test()
async def test_cekirdek(dut):
    buyruklar = await buyruklari_oku()

    await cocotb.start(Clock(dut.clk_i, 10, 'ns').start(start_high=False))

    dut.rst_i.value = 1
    await RisingEdge(dut.clk_i)
    await RisingEdge(dut.clk_i)
    cocotb.start_soon(anabellek(dut,buyruklar))
    dut.rst_i.value = 0
    dut.l1b_bekle_i.value = 0
    for idx in range(len(buyruklar)):
        await RisingEdge(dut.clk_i)

    await RisingEdge(dut.clk_i)
