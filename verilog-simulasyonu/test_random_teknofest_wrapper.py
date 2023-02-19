from random import getrandbits
from typing import Any, Dict, List

import cocotb
from cocotb.binary import BinaryValue
from cocotb.clock import Clock
from cocotb.handle import SimHandleBase
from cocotb.queue import Queue
from cocotb.triggers import RisingEdge, FallingEdge, Edge


TIMEOUT = 2000000
tests = {}
final_logs = []

# <label>:
random_test = {'random_test':{
    "TEST_FILE": "../testler/aapg/build/tmp.hex",
    "DUMP_FILE": "../testler/aapg/build/tmp.dump",
    "finish_adr": 0x40000060,
    "buyruklar": []
}}

label_line = False
with open(random_test["random_test"]["DUMP_FILE"], 'r') as f:
    for line in f:
      if '<label>:' in line:
            label_line = True
            print(line)
            continue
      if label_line:
            print(line)
            label_line = False
            finish_adr = int(line.split(':')[0].replace(' ', ''), 16)
            random_test["random_test"]["finish_adr"] = finish_adr
            print("found ", random_test["random_test"]["finish_adr"])

tests.update(random_test)

@cocotb.coroutine
async def buyruklari_oku():
    with open(random_test["random_test"]["TEST_FILE"], 'r') as f:
        buyruklar = [line.rstrip('\n') for line in f]
    random_test["random_test"]["buyruklar"] = buyruklar

@cocotb.coroutine
async def anabellek(dut):
    f = open("test.log", "w")
    await RisingEdge(dut.clk_i)
    for test in tests:
        time_step = 0
        timout = 0
        dut.rst_ni.value = 0
        await RisingEdge(dut.clk_i)
        for index, buyruk in enumerate(random_test["random_test"]["buyruklar"]):
            dut.main_memory.ram[index].value = int(buyruk,16)
        await RisingEdge(dut.clk_i)
        dut.rst_ni.value = 1
        prebosalt = 0
        while(1):
            try:
                if(random_test["random_test"]["finish_adr"] == dut.iomem_addr.value.integer):
                    print("[FINISHED] ")
                    f.write('\n'.join(final_logs))
                    break
            except:
                print("[WARNING] ADR is XXXXXXXXX")
            await RisingEdge(dut.clk_i)
            if(not dut.soc.cek.coz_yazmacoku_dut.ddb_durdur_i.value):
                if(not dut.soc.cek.coz_yazmacoku_dut.ddb_bosalt_i.value):
                    if((not dut.soc.cek.coz_yazmacoku_dut.ddb_bosalt_i.value) and (not prebosalt)):
                        try:
                            address     = "{0:#0{1}x}".format(dut.soc.cek.coz_yazmacoku_dut.debug_ps.value.integer,10)
                            instruction = "{0:#0{1}x}".format(dut.soc.cek.coz_yazmacoku_dut.gtr_buyruk_i.value.integer,10)
                            final_logs.append(f"{time_step}   {address}   {instruction}")
                            time_step = time_step + 1
                        except:
                            pass

            if(not dut.soc.cek.coz_yazmacoku_dut.ddb_durdur_i.value):
                prebosalt = dut.soc.cek.coz_yazmacoku_dut.ddb_bosalt_i.value

            timout = timout + 1
            if(timout > TIMEOUT):
                print("[TEST] ", test, " FAILED TIMOUT")
                ps     = "{0:#0{1}x}".format(dut.iomem_addr.value.integer,10)
                print("current PC: ", ps)
                f.write('\n'.join(final_logs))
                assert 0
                break
    f.close()


@cocotb.test()
async def test_random_teknofest_wrapper(dut):
    await buyruklari_oku()

    await cocotb.start(Clock(dut.clk_i, 10, 'ns').start(start_high=False))

    dut.rst_ni.value = 0
    await RisingEdge(dut.clk_i)
    await RisingEdge(dut.clk_i)
    dut.rst_ni.value = 1
    blk = cocotb.start_soon(anabellek(dut))
    await blk
    # print("Comparing...")
