
import math
import os
import glob
from random import getrandbits
from typing import Any, Dict, List

import cocotb
from cocotb.binary import BinaryValue
from cocotb.clock import Clock
from cocotb.handle import SimHandleBase
from cocotb.queue import Queue
from cocotb.triggers import RisingEdge, FallingEdge, Edge


TIMEOUT = 49000

riscv_tests = {}

"""
# Sonsuz test. TIMEOUT bekleniyor.
riscv_tests["uart"] = {
    "TEST_FILE": "../testler/uart-demo/uart_demo_static.hex",
    "fail_adr": 0x40f00060,
    "pass_adr": 0x40f00074,
    "buyruklar": []
}
riscv_tests["bol_carp_bol_carp"] = {
    "TEST_FILE": "../testler/el-yapimi-testler/build/bol_carp_bol_carp.hex",
    "fail_adr": 0x40000060,
    "pass_adr": 0x40000078,
    "buyruklar": []
}
riscv_tests["coremark"] = {
    "TEST_FILE": "../testler/coremark/coremark_baremetal_static.hex",
    "fail_adr": 0x40f00060,
    "pass_adr": 0x40f00078,
    "buyruklar": []
}
riscv_tests["geriyazdir"] = {
    "TEST_FILE": "../testler/el-yapimi-testler/build/geriyazdir.hex",
    "fail_adr": 0x4000005c,
    "pass_adr": 0x40000074,
    "buyruklar": []
}
riscv_tests["timer_oku"] = {
    "TEST_FILE": "../testler/el-yapimi-testler/build/timer_oku.hex",
    "fail_adr": 0x4010005c,
    "pass_adr": 0x40000034,
    "buyruklar": []
}
insttestlist = []
"""


# teknofest/tekno-kizil/testler/riscv-arch-test/work/rv32i_m/I
"""
insttestlist = ["auipc","jal","jalr","lui","andi","ori","xori","addi","slli","slti","sltiu","and","sll","xor","or","srl","sra","slt","sltu","srli","srai","sub","bgeu","bltu","blt","bne","beq","bge","add","mul","mulh","mulhu","mulhsu","div","divu","rem","remu","lw","lh","lb","lbu","lhu","sw","sb","sh", 'hmdst', 'rvrs', 'pkg', 'sladd', 'cntz', 'cntp','conv']
TESTS_FOLDER = "../testler/riscv-tests/isa"
for each in insttestlist:
  ecallfail = False
  ecallpass = False
  fail_adr = 0
  pass_adr = 0
  filename = glob.glob(TESTS_FOLDER + '/*-' + each + '.dump')[0] #'./data/rv32ui-p-sb.dump'
  with open(filename, 'r') as f:
    for line in f:
      if 'fail' in line:
          ecallfail = True
      elif 'pass' in line:
          ecallpass = True

      if ecallfail and 'ecall' in line:
          ecallfail = False
          fail_adr = int(line.split(':')[0].replace(' ', ''), 16)
      elif ecallpass and 'ecall' in line:
          ecallpass = False
          pass_adr = int(line.split(':')[0].replace(' ', ''), 16)
  riscv_tests[each] = {
    "TEST_FILE": glob.glob(TESTS_FOLDER + '/*-' + each + '_static.hex')[0], #"./data/rv32ui-p-sb_static.hex",
    "fail_adr": fail_adr,
    "pass_adr": pass_adr,
    "buyruklar": []
  }
"""

insttestlist = ["auipc"]
TESTS_FOLDER = "../testler/riscv-arch-test/work/rv32i_m/I"
for each in insttestlist:
  ecallfail = False
  ecallpass = False
  fail_adr = 0
  pass_adr = 0
  filename = glob.glob(TESTS_FOLDER + '/' + each + '-*.objdump')[0] #'./data/rv32ui-p-sb.dump'
  with open(filename, 'r') as f:
    for line in f:
      if '<fail>:' in line:
          ecallfail = True
      elif '<rvtest_code_end>:' in line:
          ecallpass = True

      if ecallfail and 'ecall' in line:
          ecallfail = False
          fail_adr = int(line.split(':')[0].replace(' ', ''), 16)
      elif ecallpass and 'jal' in line:
          ecallpass = False
          pass_adr = int(line.split(':')[0].replace(' ', ''), 16)
  riscv_tests[each] = {
    "TEST_FILE": glob.glob(TESTS_FOLDER + '/' + each + '-*.hex')[0], #'./data/rv32ui-p-sb.dump'
    "fail_adr": fail_adr,
    "pass_adr": pass_adr,
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
    await RisingEdge(dut.clk_i)
    for test in riscv_tests:
        timout = 0
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
