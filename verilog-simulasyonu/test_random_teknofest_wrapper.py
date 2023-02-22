from random import getrandbits
from typing import Any, Dict, List
from pathlib import Path
import logging

import cocotb
from cocotb.binary import BinaryValue
from cocotb.clock import Clock
from cocotb.handle import SimHandleBase
from cocotb.queue import Queue
from cocotb.triggers import RisingEdge, FallingEdge, Edge


logging.basicConfig(level=logging.DEBUG)

from testler.random_tests import random_tests
from testler.random_tests import compare_logs

TIMEOUT = 2000000
tests = {}

tests.update(random_tests)


@cocotb.coroutine
async def anabellek(dut):
    await RisingEdge(dut.clk_i)
    for test_name, test in tests.items():
        time_step = 0
        timout = 0
        prebosalt = 0
        final_logs = []
        first = 1
        with open(f"{test_name}.log", 'w') as f:
            dut.rst_ni.value = 0
            await RisingEdge(dut.clk_i)
            for index, buyruk in enumerate(test["buyruklar"]):
                dut.main_memory.ram[index].value = int(buyruk,16)
            await RisingEdge(dut.clk_i)
            dut.rst_ni.value = 1
            while(1):
                try:
                    if(test["finish_adr"] == dut.iomem_addr.value.integer):
                        print("[FINISHED] ")
                        dut.rst_ni.value = 0
                        await RisingEdge(dut.clk_i)
                        f.write('\n'.join(final_logs))
                        for idx in range(0,512):
                            if(dut.soc.veri_onbellegi_dut.dirty_r[idx].value.integer):
                                if(dut.soc.veri_onbellegi_dut.valid_r[idx].value.integer):
                                    cval = dut.soc.veri_onbellegi_dut.sram.mem[idx].value.binstr[-32:]
                                    ctag = dut.soc.veri_onbellegi_dut.sram.mem[idx].value.binstr[-40:-33]
                                    cadr = "0100000000000" + ctag + f'{idx:010b}' + "00"
                                    cadr_int = (int(cadr,2) - 0x40000000)//4
                                    dut.main_memory.ram[cadr_int].value = int(cval,2)
                                    cadr_hex   = "{0:#0{1}x}".format(int(cadr,2),10)
                                    cval_hex   = "{0:#0{1}x}".format(int(cval,2),10)
                                    print(f"Writing back: Adr:{cadr_hex} idx:{cadr_int} val:{cval_hex}")
                        await RisingEdge(dut.clk_i)
                        with open(f"{test_name}.sign", 'w') as d, open(f"{test_name}.signadr", 'w') as b:
                            begin_adr = (test["begin_sign_adr"]-0x40000000)//4
                            end_adr   = (test["end_sign_adr"]  -0x40000000)//4
                            for index in range(begin_adr,end_adr+1,4):
                                row     = ""
                                row_adr = ""
                                data0   = "{0:#0{1}x}".format(dut.main_memory.ram[index+0].value.integer,10)
                                data1   = "{0:#0{1}x}".format(dut.main_memory.ram[index+1].value.integer,10)
                                data2   = "{0:#0{1}x}".format(dut.main_memory.ram[index+2].value.integer,10)
                                data3   = "{0:#0{1}x}".format(dut.main_memory.ram[index+3].value.integer,10)
                                row     =  data3[2:] + data2[2:] + data1[2:] + data0[2:]
                                row_adr =  f"{(index+3):8}" + f"{(index+2):8}" + f"{(index+1):8}" + f"{(index+0):8}"
                                d.write(f"{row}\n")
                                b.write(f"{row_adr}\n")
                        break
                except  Exception as e:
                    print(e)

                await RisingEdge(dut.clk_i)
                if(not dut.soc.cek.coz_yazmacoku_dut.ddb_durdur_i.value):
                    if(not dut.soc.cek.coz_yazmacoku_dut.ddb_bosalt_i.value):
                        if(not first):
                            if((not dut.soc.cek.coz_yazmacoku_dut.ddb_bosalt_i.value) and (not prebosalt)):
                                try:
                                    address     = "{0:#0{1}x}".format(dut.soc.cek.coz_yazmacoku_dut.debug_ps.value.integer,10)
                                    instruction = "{0:#0{1}x}".format(dut.soc.cek.coz_yazmacoku_dut.gtr_buyruk_i.value.integer,10)
                                    final_logs.append(f"{time_step}   {address}   {instruction}")
                                    time_step = time_step + 1
                                except:
                                    pass
                        first = 0

                if(not dut.soc.cek.coz_yazmacoku_dut.ddb_durdur_i.value):
                    prebosalt = dut.soc.cek.coz_yazmacoku_dut.ddb_bosalt_i.value

                timout = timout + 1
                if(timout > TIMEOUT):
                    print("[TEST] ", test, " FAILED TIMOUT")
                    ps     = "{0:#0{1}x}".format(dut.iomem_addr.value.integer,10)
                    print("current PC: ", ps)
                    f.write('\n'.join(final_logs))
                    f.close()
                    assert 0
                    break

            dut.rst_ni.value = 0
            await RisingEdge(dut.clk_i)
            dut.rst_ni.value = 1
            await RisingEdge(dut.clk_i)
            dut.rst_ni.value = 0




@cocotb.test()
async def test_random_teknofest_wrapper(dut):

    await cocotb.start(Clock(dut.clk_i, 10, 'ns').start(start_high=False))

    dut.rst_ni.value = 0
    await RisingEdge(dut.clk_i)
    await RisingEdge(dut.clk_i)
    dut.rst_ni.value = 1
    blk = cocotb.start_soon(anabellek(dut))
    await blk
    return_code = await compare_logs("./")

