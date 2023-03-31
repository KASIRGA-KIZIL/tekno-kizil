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
from testler.random_tests import compare_signs

TIMEOUT = 2000000
tests = {}

tests.update(random_tests)


@cocotb.coroutine
async def anabellek(dut):
    await RisingEdge(dut.clk_i)
    print(len(tests))
    for test_name, test in tests.items():
        print(test["finish_adr"])
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
                    if(test["finish_adr"] == dut.soc.cek.getir_dut.debug_ps.value.integer):
                        print("[FINISHED] ")
                        dut.rst_ni.value = 0
                        await RisingEdge(dut.clk_i)
                        f.write('\n'.join(final_logs))
                        for idx in range(0,256):
                            if(dut.soc.veri_onbellegi_dut.valid_yol0_r[idx].value.integer and dut.soc.veri_onbellegi_dut.dirty_yol0_r[idx].value.integer):
                                cline = dut.soc.veri_onbellegi_dut.vo1.RAM[idx].value.binstr
                                ctag  = dut.soc.veri_onbellegi_dut.vo1.RAM[idx].value.binstr[0:9]
                                cval  = dut.soc.veri_onbellegi_dut.vo1.RAM[idx].value.binstr[9:41]
                                cadr  = "0100000000000" + ctag + f'{idx:08b}' + "00"
                                cadr_int = (int(cadr,2) - 0x40000000)//4
                                cadr_hex   = "{0:#0{1}x}".format(int(cadr,2),10)
                                cval_hex   = "{0:#0{1}x}".format(int(cval,2),10)
                                print(f"Writing back: Adr:{cadr_hex} idx:{cadr_int} val:{cval_hex} ctag: {ctag} cval:{cval} cline:{cline} cacheidx:{idx} way0")
                                dut.main_memory.ram[cadr_int].value = int(cval,2)
                        for idx in range(0,256):
                            if(dut.soc.veri_onbellegi_dut.valid_yol1_r[idx].value.integer and dut.soc.veri_onbellegi_dut.dirty_yol1_r[idx].value.integer):
                                cline = dut.soc.veri_onbellegi_dut.vo2.RAM[idx].value.binstr
                                ctag  = dut.soc.veri_onbellegi_dut.vo2.RAM[idx].value.binstr[0:9]
                                cval  = dut.soc.veri_onbellegi_dut.vo2.RAM[idx].value.binstr[9:41]
                                cadr  = "0100000000000" + ctag + f'{idx:08b}' + "00"
                                cadr_int = (int(cadr,2) - 0x40000000)//4
                                cadr_hex   = "{0:#0{1}x}".format(int(cadr,2),10)
                                cval_hex   = "{0:#0{1}x}".format(int(cval,2),10)
                                print(f"Writing back: Adr:{cadr_hex} idx:{cadr_int} val:{cval_hex} ctag: {ctag} cval:{cval} cline:{cline} cacheidx:{idx} way1")
                                dut.main_memory.ram[cadr_int].value = int(cval,2)

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
                    print("[TEST] ", test_name, " FAILED TIMOUT")
                    ps     = "{0:#0{1}x}".format(dut.soc.cek.getir_dut.debug_ps.value.integer,10)
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
    print("[OUTSIDE BLK] ")
    return_code = await compare_logs("./")
    return_code = await compare_signs("./")
