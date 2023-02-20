RISCVTYPE = /home/shc/projects/riscv32im-toolchain/_install/bin/riscv32-unknown-elf
CC = $(RISCVTYPE)-gcc

DHRY-LFLAGS =

DHRY-CFLAGS := -O3 -DTIME -DNOENUM -Wno-implicit -save-temps -mcmodel=medany -ffreestanding -static -static-libgcc -lgcc -std=gnu99 -fno-common -nostdlib -nostartfiles -fno-builtin -ffunction-sections
DHRY-CFLAGS += -fno-builtin-printf -fno-common -falign-functions=4 -fno-builtin -fno-common

#Uncomment below for FPGA run, default DHRY_ITERS is 2000 for RTL
#DHRY-CFLAGS += -DDHRY_ITERS=20000000
# strcmp.S
SRC = dhry_1.c dhry_2.c start.S strcmp.S #stdlib.c
HDR = dhry.h

LINKER_SCRIPT ?= link.ld

override CFLAGS += $(DHRY-CFLAGS) $(XCFLAGS) -Xlinker --defsym=__stack_size=0x800 -Xlinker --defsym=__heap_size=0x1000 -march=rv32im -mabi=ilp32 -mcmodel=medany -static -std=gnu99 -fno-common -nostdlib -nostartfiles -T $(LINKER_SCRIPT) -lgcc -Wl,--start-group -lc -lgloss -Wl,--end-group -lgcc -lm
dhrystone: $(SRC) $(HDR)
	$(CC) $(CFLAGS) $(SRC) $(LDFLAGS) $(LOADLIBES) $(LDLIBS) -o $@.riscv

	$(CC) -S $(CFLAGS) $(XCFLAGS) $(SRCS)
	$(CC) -c $(CFLAGS) $(XCFLAGS) $(SRCS)
	$(RISCVTYPE)-objdump -d -M numeric,no-aliases $@.riscv > $@_disassembled.dump
	$(RISCVTYPE)-objcopy -O binary $@.riscv $@.bin
	python3 ./get_static_hex.py --binfile=$@.bin
	$(RISCVTYPE)-objcopy -O verilog $@.riscv $@.vh
	python3 ./vhtocoe.py --vhfile=$@.vh

clean:
	rm -f *.i *.s *.o dhrystone dhrystone.hex *.riscv *.dump *.hex *.bin *.coe *.vh

