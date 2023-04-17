# See LICENSE for license details.

ifndef _TEKNO_MK_COMMON
_SIFIVE_MK_COMMON := # defined

.PHONY: all
all: $(TARGET)

COMMON_DIR = $(BSP_BASE)/../common

ENV_DIR = $(BSP_BASE)
ASM_SRCS += $(ENV_DIR)/start.S

 C_SRCS += $(ENV_DIR)/../drivers/src/uart_driver.c
C_SRCS += $(ENV_DIR)/../drivers/src/spi_driver.c
C_SRCS += $(ENV_DIR)/../drivers/src/pwm_driver.c
C_SRCS += $(ENV_DIR)/../drivers/src/cryptography_driver.c
C_SRCS += $(ENV_DIR)/../drivers/src/accelerator_driver.c

# BOARD dependend code

PLATFORM_DIR = $(ENV_DIR)/$(BOARD)
C_SRCS += $(PLATFORM_DIR)/init.c
LINKER_SCRIPT := $(PLATFORM_DIR)/linker.lds

INCLUDES += -I$(COMMON_DIR)/include
INCLUDES += -I$(COMMON_DIR)/drivers/
INCLUDES += -I$(ENV_DIR)
INCLUDES += -I$(PLATFORM_DIR)

TOOL_DIR = $(RISCV)/bin

LDFLAGS += -T $(LINKER_SCRIPT) -nostartfiles
LDFLAGS += -L$(ENV_DIR) --specs=nano.specs
LDFLAGS += -static -lm -fno-builtin-printf

ASM_OBJS := $(ASM_SRCS:.S=.o)
C_OBJS := $(C_SRCS:.c=.o) 

LINK_OBJS += $(ASM_OBJS) $(C_OBJS) 
LINK_DEPS += $(LINKER_SCRIPT)

CLEAN_OBJS += $(TARGET) $(LINK_OBJS)

CFLAGS += -g
CFLAGS += -march=$(RISCV_ARCH)
CFLAGS += -mabi=$(RISCV_ABI)
CFLAGS += -mcmodel=medany 

$(TARGET): $(LINK_OBJS) $(LINK_DEPS)
	$(CC) $(CFLAGS) $(INCLUDES) $(LINK_OBJS) -o $(PROGRAM_ELF).elf $(LDFLAGS) $(XCFLAGS) 
	$(RISCV_OBJDUMP) -D --disassembler-options=no-aliases,numeric -m   riscv:rv32 $(PROGRAM_ELF).elf > $(PROGRAM_ELF).asm;
	$(RISCV_OBJCOPY) -O binary -j .text*  $(PROGRAM_ELF).elf $(PROGRAM_ELF).bin
	
	# group as little endian as 4 bytes
	od -t x4 -An -w4 -v $(PROGRAM_ELF).bin > $(PROGRAM_ELF).hex

	mv $(PROGRAM_ELF).elf $(ENV_DIR)/../outputs
	mv $(PROGRAM_ELF).hex $(ENV_DIR)/../outputs
	mv $(PROGRAM_ELF).bin $(ENV_DIR)/../outputs
	mv $(PROGRAM_ELF).asm $(ENV_DIR)/../outputs

$(ASM_OBJS): %.o: %.S $(HEADERS)
	$(CC) $(CFLAGS) $(INCLUDES) -c -o $@ $<

$(C_OBJS): %.o: %.c $(HEADERS)
	$(CC) $(CFLAGS) $(INCLUDES) -include sys/cdefs.h -c -o $@ $<

.PHONY: clean
clean:
	rm -f $(CLEAN_OBJS) 
	rm -f *.bin *.hex *.asm *.elf libwrap.a

endif # _TEKNO_MK_COMMON
