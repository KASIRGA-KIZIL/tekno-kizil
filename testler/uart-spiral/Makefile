
RISCVTYPE = riscv32-unknown-elf
CC = $(RISCVTYPE)-gcc

LINKER_SCRIPT ?= link.ld

CFLAGS ?= -I./ -O2 -mcmodel=medany -static -std=gnu99 -fno-common -nostartfiles -fno-builtin -ffunction-sections -lm -lgcc -T $(LINKER_SCRIPT) -march=rv32imc -mabi=ilp32 -Wl,--start-group -lc -lgloss -Wl,--end-group -lgcc -lm

CFILE ?= donut

SRCS ?= ${CFILE}.c tekno.c ee_printf.c syscalls.c start.S

OUTNAME ?= ${CFILE}.riscv

compile:
	$(CC) $(CFLAGS) $(SRCS) -o $(OUTNAME) -lm
	$(CC) -S $(CFLAGS) $(SRCS)
	$(CC) -c $(CFLAGS) $(SRCS)

	$(RISCVTYPE)-objdump -d -M numeric,no-aliases $(CFILE).riscv > $(CFILE)_disassembled.txt

	$(RISCVTYPE)-objcopy -O binary $(CFILE).riscv $(CFILE).bin
	python3 get_static_hex.py --binfile=$(CFILE).bin

	$(RISCVTYPE)-objcopy -O verilog $(CFILE).riscv $(CFILE).vh

.PHONY: clean
clean:
	rm -f $(OUTFILE) $(OBJS) $(OPATH)*.log *.info $(OPATH)index.html $(PORT_CLEAN) *.o *.s *.riscv *.bin *.hex *.vh *.coe *.txt *.v
