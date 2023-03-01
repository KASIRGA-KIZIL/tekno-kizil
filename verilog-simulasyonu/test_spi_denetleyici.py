# test_spi_denetleyici.py

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge
from cocotb.triggers import FallingEdge
import random


@cocotb.test()
async def test_spi_mosi(dut):
    clock = Clock(dut.clk_i, 10, units="ns")
    cocotb.start_soon(clock.start())
    dut.rst_i.value = 1
    await RisingEdge(dut.clk_i)
    await RisingEdge(dut.clk_i)
    dut.rst_i.value = 0

    await RisingEdge(dut.clk_i)

    # SPI_WDAT
    dut.wb_cyc_i.value = 1
    dut.wb_stb_i.value = 1
    dut.wb_adr_i.value = 0x000C
    dut.wb_dat_i.value = 0xFFFF_FFFF
    dut.wb_sel_i.value = 0xF
    dut.wb_we_i.value  = 1
    await RisingEdge(dut.clk_i)
    await RisingEdge(dut.clk_i)
    dut.wb_cyc_i.value = 0
    dut.wb_stb_i.value = 0
    dut.wb_adr_i.value = 0
    dut.wb_dat_i.value = 0
    dut.wb_sel_i.value = 0
    dut.wb_we_i.value  = 0
    await RisingEdge(dut.clk_i)
    # SPI_WDAT
    dut.wb_cyc_i.value = 1
    dut.wb_stb_i.value = 1
    dut.wb_adr_i.value = 0x000C
    dut.wb_dat_i.value = 0xEEEE_EEEE
    dut.wb_sel_i.value = 0xF
    dut.wb_we_i.value  = 1
    await RisingEdge(dut.clk_i)
    await RisingEdge(dut.clk_i)
    dut.wb_cyc_i.value = 0
    dut.wb_stb_i.value = 0
    dut.wb_adr_i.value = 0
    dut.wb_dat_i.value = 0
    dut.wb_sel_i.value = 0
    dut.wb_we_i.value  = 0
    await RisingEdge(dut.clk_i)
    # SPI_WDAT
    dut.wb_cyc_i.value = 1
    dut.wb_stb_i.value = 1
    dut.wb_adr_i.value = 0x000C
    dut.wb_dat_i.value = 0xDDDD_DDDD
    dut.wb_sel_i.value = 0xF
    dut.wb_we_i.value  = 1
    await RisingEdge(dut.clk_i)
    await RisingEdge(dut.clk_i)
    dut.wb_cyc_i.value = 0
    dut.wb_stb_i.value = 0
    dut.wb_adr_i.value = 0
    dut.wb_dat_i.value = 0
    dut.wb_sel_i.value = 0
    dut.wb_we_i.value  = 0
    await RisingEdge(dut.clk_i)
    # SPI_WDAT
    dut.wb_cyc_i.value = 1
    dut.wb_stb_i.value = 1
    dut.wb_adr_i.value = 0x000C
    dut.wb_dat_i.value = 0xCCCC_CCCC
    dut.wb_sel_i.value = 0xF
    dut.wb_we_i.value  = 1
    await RisingEdge(dut.clk_i)
    await RisingEdge(dut.clk_i)
    dut.wb_cyc_i.value = 0
    dut.wb_stb_i.value = 0
    dut.wb_adr_i.value = 0
    dut.wb_dat_i.value = 0
    dut.wb_sel_i.value = 0
    dut.wb_we_i.value  = 0
    await RisingEdge(dut.clk_i)
    # SPI_WDAT
    dut.wb_cyc_i.value = 1
    dut.wb_stb_i.value = 1
    dut.wb_adr_i.value = 0x000C
    dut.wb_dat_i.value = 0xBBBB_BBBB
    dut.wb_sel_i.value = 0xF
    dut.wb_we_i.value  = 1
    await RisingEdge(dut.clk_i)
    await RisingEdge(dut.clk_i)
    dut.wb_cyc_i.value = 0
    dut.wb_stb_i.value = 0
    dut.wb_adr_i.value = 0
    dut.wb_dat_i.value = 0
    dut.wb_sel_i.value = 0
    dut.wb_we_i.value  = 0
    await RisingEdge(dut.clk_i)
    # SPI_CTRL sck = 1, spi_en = 1
    dut.wb_cyc_i.value = 1
    dut.wb_stb_i.value = 1
    dut.wb_adr_i.value = 0x0000
    dut.wb_dat_i.value = 0x0001_0001
    dut.wb_sel_i.value = 0xF
    dut.wb_we_i.value  = 1
    await RisingEdge(dut.clk_i)
    await RisingEdge(dut.clk_i)
    dut.wb_cyc_i.value = 0
    dut.wb_stb_i.value = 0
    dut.wb_adr_i.value = 0
    dut.wb_dat_i.value = 0
    dut.wb_sel_i.value = 0
    dut.wb_we_i.value  = 0
    await RisingEdge(dut.clk_i)
    # SPI_CMD mosi_en = 1
    dut.wb_cyc_i.value = 1
    dut.wb_stb_i.value = 1
    dut.wb_adr_i.value = 0x0010
    dut.wb_dat_i.value = 0x0000_2008
    dut.wb_sel_i.value = 0xF
    dut.wb_we_i.value  = 1
    await RisingEdge(dut.clk_i)
    await RisingEdge(dut.clk_i)
    dut.wb_cyc_i.value = 0
    dut.wb_stb_i.value = 0
    dut.wb_adr_i.value = 0
    dut.wb_dat_i.value = 0
    dut.wb_sel_i.value = 0
    dut.wb_we_i.value  = 0
    await RisingEdge(dut.clk_i)
    # SPI_CMD mosi_en = 1
    dut.wb_cyc_i.value = 1
    dut.wb_stb_i.value = 1
    dut.wb_adr_i.value = 0x0010
    dut.wb_dat_i.value = 0x0000_2001
    dut.wb_sel_i.value = 0xF
    dut.wb_we_i.value  = 1
    await RisingEdge(dut.clk_i)
    await RisingEdge(dut.clk_i)
    dut.wb_cyc_i.value = 0
    dut.wb_stb_i.value = 0
    dut.wb_adr_i.value = 0
    dut.wb_dat_i.value = 0
    dut.wb_sel_i.value = 0
    dut.wb_we_i.value  = 0
    await RisingEdge(dut.clk_i)

    for i in range(500):
        await RisingEdge(dut.clk_i)

@cocotb.test()
async def test_spi_m(dut):
    clock = Clock(dut.clk_i, 10, units="ns")
    cocotb.start_soon(clock.start())
    dut.rst_i.value = 1
    await RisingEdge(dut.clk_i)
    await RisingEdge(dut.clk_i)
    dut.rst_i.value = 0

    dut.spi_miso_i.value = 0

    # SPI_CTRL sck = 1, spi_en = 1
    dut.wb_cyc_i.value = 1
    dut.wb_stb_i.value = 1
    dut.wb_adr_i.value = 0x0000
    dut.wb_dat_i.value = 0x0001_0001
    dut.wb_sel_i.value = 0xF
    dut.wb_we_i.value  = 1
    await RisingEdge(dut.clk_i)
    await RisingEdge(dut.clk_i)
    dut.wb_cyc_i.value = 0
    dut.wb_stb_i.value = 0
    dut.wb_adr_i.value = 0
    dut.wb_dat_i.value = 0
    dut.wb_sel_i.value = 0
    dut.wb_we_i.value  = 0
    await RisingEdge(dut.clk_i)
    # SPI_CMD miso_en = 1, length = 3
    dut.wb_cyc_i.value = 1
    dut.wb_stb_i.value = 1
    dut.wb_adr_i.value = 0x0010
    dut.wb_dat_i.value = 0x0000_100E
    dut.wb_sel_i.value = 0xF
    dut.wb_we_i.value  = 1
    await RisingEdge(dut.clk_i)
    await RisingEdge(dut.clk_i)
    dut.wb_cyc_i.value = 0
    dut.wb_stb_i.value = 0
    dut.wb_adr_i.value = 0
    dut.wb_dat_i.value = 0
    dut.wb_sel_i.value = 0
    dut.wb_we_i.value  = 0
    await FallingEdge(dut.spi_cs_o)
    for i in range(4):
        # AA gonder
        dut.spi_miso_i.value = 0
        await FallingEdge(dut.spi_sck_o)
        dut.spi_miso_i.value = 1
        await FallingEdge(dut.spi_sck_o)
        dut.spi_miso_i.value = 0
        await FallingEdge(dut.spi_sck_o)
        dut.spi_miso_i.value = 1
        await FallingEdge(dut.spi_sck_o)
        dut.spi_miso_i.value = 0
        await FallingEdge(dut.spi_sck_o)
        dut.spi_miso_i.value = 1
        await FallingEdge(dut.spi_sck_o)
        dut.spi_miso_i.value = 0
        await FallingEdge(dut.spi_sck_o)
        dut.spi_miso_i.value = 1
        await FallingEdge(dut.spi_sck_o)
    for i in range(4):
        # BB gonder
        dut.spi_miso_i.value = 1
        await FallingEdge(dut.spi_sck_o)
        dut.spi_miso_i.value = 1
        await FallingEdge(dut.spi_sck_o)
        dut.spi_miso_i.value = 0
        await FallingEdge(dut.spi_sck_o)
        dut.spi_miso_i.value = 1
        await FallingEdge(dut.spi_sck_o)
        dut.spi_miso_i.value = 1
        await FallingEdge(dut.spi_sck_o)
        dut.spi_miso_i.value = 1
        await FallingEdge(dut.spi_sck_o)
        dut.spi_miso_i.value = 0
        await FallingEdge(dut.spi_sck_o)
        dut.spi_miso_i.value = 1
        await FallingEdge(dut.spi_sck_o)
    for i in range(4):
        # AB gonder
        dut.spi_miso_i.value = 1
        await FallingEdge(dut.spi_sck_o)
        dut.spi_miso_i.value = 1
        await FallingEdge(dut.spi_sck_o)
        dut.spi_miso_i.value = 0
        await FallingEdge(dut.spi_sck_o)
        dut.spi_miso_i.value = 1
        await FallingEdge(dut.spi_sck_o)
        dut.spi_miso_i.value = 0
        await FallingEdge(dut.spi_sck_o)
        dut.spi_miso_i.value = 1
        await FallingEdge(dut.spi_sck_o)
        dut.spi_miso_i.value = 0
        await FallingEdge(dut.spi_sck_o)
        dut.spi_miso_i.value = 1
        await FallingEdge(dut.spi_sck_o)
        dut.spi_miso_i.value = 0
    # Transfer bitti
    # AA gonder
    dut.spi_miso_i.value = 0
    await FallingEdge(dut.spi_sck_o)
    dut.spi_miso_i.value = 1
    await FallingEdge(dut.spi_sck_o)
    dut.spi_miso_i.value = 0
    await FallingEdge(dut.spi_sck_o)
    dut.spi_miso_i.value = 1
    await FallingEdge(dut.spi_sck_o)
    dut.spi_miso_i.value = 0
    await FallingEdge(dut.spi_sck_o)
    dut.spi_miso_i.value = 1
    await FallingEdge(dut.spi_sck_o)
    dut.spi_miso_i.value = 0
    await FallingEdge(dut.spi_sck_o)
    dut.spi_miso_i.value = 1
    await FallingEdge(dut.spi_sck_o)
    # AA gonder
    dut.spi_miso_i.value = 0
    await FallingEdge(dut.spi_sck_o)
    dut.spi_miso_i.value = 1
    await FallingEdge(dut.spi_sck_o)
    dut.spi_miso_i.value = 0
    await FallingEdge(dut.spi_sck_o)
    dut.spi_miso_i.value = 1
    await FallingEdge(dut.spi_sck_o)
    dut.spi_miso_i.value = 0
    await FallingEdge(dut.spi_sck_o)
    dut.spi_miso_i.value = 1
    await FallingEdge(dut.spi_sck_o)
    dut.spi_miso_i.value = 0
    await FallingEdge(dut.spi_sck_o)
    dut.spi_miso_i.value = 1
    await FallingEdge(dut.spi_sck_o)
    # BB gonder
    dut.spi_miso_i.value = 1
    await FallingEdge(dut.spi_sck_o)
    dut.spi_miso_i.value = 1
    await FallingEdge(dut.spi_sck_o)
    dut.spi_miso_i.value = 0
    await FallingEdge(dut.spi_sck_o)
    dut.spi_miso_i.value = 1
    await FallingEdge(dut.spi_sck_o)
    dut.spi_miso_i.value = 1
    await FallingEdge(dut.spi_sck_o)
    dut.spi_miso_i.value = 1
    await FallingEdge(dut.spi_sck_o)
    dut.spi_miso_i.value = 0
    await FallingEdge(dut.spi_sck_o)
    dut.spi_miso_i.value = 1
    await FallingEdge(dut.spi_sck_o)

    await RisingEdge(dut.clk_i)
    dut.spi_miso_i.value = 0
    await RisingEdge(dut.clk_i)
    await RisingEdge(dut.clk_i)
    await RisingEdge(dut.clk_i)
    # SPI_RDAT
    dut.wb_cyc_i.value = 1
    dut.wb_stb_i.value = 1
    dut.wb_adr_i.value = 0x0008
    dut.wb_dat_i.value = 0
    dut.wb_sel_i.value = 0xF
    dut.wb_we_i.value  = 0
    await RisingEdge(dut.clk_i)
    await RisingEdge(dut.clk_i)
    dut.wb_cyc_i.value = 0
    dut.wb_stb_i.value = 0
    dut.wb_adr_i.value = 0
    dut.wb_dat_i.value = 0
    dut.wb_sel_i.value = 0
    dut.wb_we_i.value  = 0
    await RisingEdge(dut.clk_i)
    # SPI_RDAT
    dut.wb_cyc_i.value = 1
    dut.wb_stb_i.value = 1
    dut.wb_adr_i.value = 0x0008
    dut.wb_dat_i.value = 0
    dut.wb_sel_i.value = 0xF
    dut.wb_we_i.value  = 0
    await RisingEdge(dut.clk_i)
    await RisingEdge(dut.clk_i)
    dut.wb_cyc_i.value = 0
    dut.wb_stb_i.value = 0
    dut.wb_adr_i.value = 0
    dut.wb_dat_i.value = 0
    dut.wb_sel_i.value = 0
    dut.wb_we_i.value  = 0
    await RisingEdge(dut.clk_i)
    # SPI_RDAT
    dut.wb_cyc_i.value = 1
    dut.wb_stb_i.value = 1
    dut.wb_adr_i.value = 0x0008
    dut.wb_dat_i.value = 0
    dut.wb_sel_i.value = 0xF
    dut.wb_we_i.value  = 0
    await RisingEdge(dut.clk_i)
    await RisingEdge(dut.clk_i)
    dut.wb_cyc_i.value = 0
    dut.wb_stb_i.value = 0
    dut.wb_adr_i.value = 0
    dut.wb_dat_i.value = 0
    dut.wb_sel_i.value = 0
    dut.wb_we_i.value  = 0
    await RisingEdge(dut.clk_i)
    await RisingEdge(dut.clk_i)
