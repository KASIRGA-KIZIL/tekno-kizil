
RISCVTYPE = riscv32-unknown-elf
CC = $(RISCVTYPE)-gcc

LINKER_SCRIPT ?= link.ld

CFLAGS ?= -O2 -mcmodel=medany -static -std=gnu99 -nostartfiles -ffunction-sections -lm -lgcc -T $(LINKER_SCRIPT) -march=rv32im -mabi=ilp32

CFILE ?= uart_demo

SRCS ?= ${CFILE}.c start.S #syscalls.c crt.S

OUTNAME ?= ${CFILE}.riscv

compile:
	$(CC) $(CFLAGS) $(SRCS) -o $(OUTNAME)
	$(CC) -S $(CFLAGS) $(SRCS)
	$(CC) -c $(CFLAGS) $(SRCS)
	
	$(RISCVTYPE)-objdump -d -M numeric,no-aliases $(CFILE).riscv > $(CFILE)_disassembled.txt
	
	$(RISCVTYPE)-objcopy -O binary $(CFILE).riscv $(CFILE).bin
	python3 get_static_hex.py --binfile=$(CFILE).bin
	
	$(RISCVTYPE)-objcopy -O verilog $(CFILE).riscv $(CFILE).vh
	python3 vhtocoe.py --vhfile=$(CFILE).vh
	
	python3 makehexmem.py $(CFILE).bin > progmem.v

.PHONY: clean
clean:
	rm -f $(OUTFILE) $(OBJS) $(OPATH)*.log *.info $(OPATH)index.html $(PORT_CLEAN) *.o *.s *.riscv *.bin *.hex *.vh *.coe *.txt *.v

