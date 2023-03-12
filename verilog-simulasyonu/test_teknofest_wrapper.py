from random import getrandbits
from typing import Any, Dict, List

import cocotb
from cocotb.binary import BinaryValue
from cocotb.clock import Clock
from cocotb.handle import SimHandleBase
from cocotb.queue import Queue
from cocotb.triggers import RisingEdge, FallingEdge, Edge

# PASS FAIL Testleri
from testler.el_yapimi_testler import carp_bol
from testler.el_yapimi_testler import yaz_oku_1
from testler.el_yapimi_testler import yaz_oku_0
from testler.el_yapimi_testler import timer_oku
from testler.el_yapimi_testler import j_branch
from testler.el_yapimi_testler import btb_loopy
from testler.el_yapimi_testler import uart_test
from testler.el_yapimi_testler import pwm_demo
from testler.el_yapimi_testler import compres_0

from testler.riscv_tests       import riscv_tests
# from testler.riscv_arch_tests  import riscv_arch_tests

# Sonsuz Testler
# from testler.el_yapimi_testler import uart_test

# ;(
# from testler.el_yapimi_testler import coremark


TIMEOUT = 200000
tests = {}

tests.update(carp_bol)

@cocotb.coroutine
async def buyruklari_oku():
    for test in tests:
        with open(tests[test]["TEST_FILE"], 'r') as f:
            buyruklar = [line.rstrip('\n') for line in f]
        tests[test]["buyruklar"] = buyruklar

@cocotb.coroutine
async def anabellek(dut):
    await RisingEdge(dut.clk_i)
    for test in tests:
        timout = 0
        dut.rst_ni.value = 0
        await RisingEdge(dut.clk_i)
        for index, buyruk in enumerate(tests[test]["buyruklar"]):
            dut.main_memory.ram[index].value = int(buyruk,16)
        await RisingEdge(dut.clk_i)
        dut.rst_ni.value = 1
        while(1):
            try:
                if(tests[test]["pass_adr"] == dut.soc.cek.getir_dut.debug_ps.value.integer):
                    print("[TEST] ", test, " passed")
                    break
                if(tests[test]["fail_adr"] == dut.soc.cek.getir_dut.debug_ps.value.integer):
                    print("[TEST] ", test, " FAILED")
                    assert 0
                    break
            except:
                print("[WARNING] ADR is XXXXXXXXX")
            await RisingEdge(dut.clk_i)
            timout = timout + 1
            if(timout > TIMEOUT):
                print("[TEST] ", test, " FAILED TIMOUT")
                print("current PC: ", dut.soc.cek.getir_dut.debug_ps.value.integer)
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
