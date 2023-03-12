#!/usr/bin/env python3
import os, sys
from pathlib import Path
import logging
from log_parser import log_parser

logging.basicConfig(level=logging.DEBUG)

BUILD_DIR = "./build"

XLEN   = 32
TARGET = "unknown-elf"
BASE_NAME = "base_work"
RISCVPREFIX = f"riscv{XLEN}-{TARGET}"

ROOT_PATH  = Path(__file__).parent
BASE_PATH  = ROOT_PATH / BASE_NAME
WORK_PATH  = ROOT_PATH / "work"
ASM_PATH   = WORK_PATH / 'asm'
LOG_PATH   = WORK_PATH / 'log'
BIN_PATH   = WORK_PATH / 'bin'
DUMP_PATH  = WORK_PATH / 'objdump'

NUM_PROGRAMS = 1

def main():
    try:
        Path(BUILD_DIR).mkdir(parents=True)
    except FileExistsError:
        pass

    os.system("aapg setup")
    os.system(f"cp {BASE_PATH}/config.yaml {WORK_PATH}")
    os.system(f"aapg gen --arch rv32 --num_programs {NUM_PROGRAMS}")
    os.system(f"cp -r {BASE_PATH}/common {WORK_PATH}")
    os.system(f"cp    {BASE_PATH}/Makefile {WORK_PATH}")

    for index, path in enumerate(ASM_PATH.rglob('*.ld')):
        os.system(f"cp    {BASE_PATH}/out_config_00000.ld {path}")
        logging.debug(f"cp    {BASE_PATH}/out_config_00000.ld {path}")

    logging.info(f"Removing CSRs.")
    for index, path in enumerate(ASM_PATH.rglob('*.S')):
        os.system(f"grep -v 'csr' {path} > temp; mv temp {path}")
        if("template" not in str(path)):
            with open(path, 'a') as sys.stdout:
                print(".dword              0x0a0a0a0a0a0a0a0a")


    logging.info(f"Compiling and Simulating Random Tests")
    os.system(f"cd {WORK_PATH}; make")

    for index, path in enumerate(BIN_PATH.rglob('*.riscv')):
        os.system(f"{RISCVPREFIX}-objcopy -O binary {path} {BIN_PATH}/{path.stem}.bin")

    for index, path in enumerate(BIN_PATH.rglob('*.bin')):
        os.system(f"../../araclar/makehex.py {path} > {BUILD_DIR}/{path.stem}.hex")

    for index, path in enumerate(LOG_PATH.rglob('*.log')):
        os.system(f"cp  {path}  {BUILD_DIR}/{path.stem}.log_detailed")
        with open(f'{BUILD_DIR}/{path.stem}.log', 'w') as sys.stdout:
            log_parser(path)

    for index, path in enumerate(LOG_PATH.rglob('*.sign')):
        os.system(f"cp  {path}  {BUILD_DIR}/{str(path.stem).split('.', 1)[0]}.sign")

    for index, path in enumerate(DUMP_PATH.rglob('*.objdump')):
        os.system(f"cp  {path}  {BUILD_DIR}/{path.stem}.dump")

    for index, path in enumerate(ASM_PATH.rglob('*.S')):
        os.system(f"cp  {path}  {BUILD_DIR}/{path.stem}.S")


    for index, path in enumerate(ASM_PATH.rglob('*.S')):
        if("template" not in str(path)):
            with open(path, 'r') as file:
                lines = file.readlines()

            with open(f"{BUILD_DIR}/{path.stem}.sign_initial", 'w') as sys.stdout:
                row = ""
                counter = 0
                for line in lines:
                    if(".dword" in line):
                        row = line.split("0x")[1].strip("\n") + row
                        counter = counter + 1
                    if(counter == 2):
                        print(row)
                        counter = 0
                        row = ""

if __name__ == "__main__":
    main()
