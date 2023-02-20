XLEN ?= 64
TARGET ?= unknown-elf
RISCVPREFIX=riscv${XLEN}-${TARGET}
ASM_SRC_DIR := asm
COMMON_DIR := common
BIN_DIR := bin
OBJ_DIR := objdump
LOG_DIR := log
ISA ?= rv32im
ABI ?= ilp32
SPIKE_ISA ?= rv32im
INCLUDE_DIRS := common
CRT_FILE := common/crt.S
TEMPLATE_FILE := common/templates.S
GCC_OPTS := -march=$(ISA) -mabi=$(ABI) -DPREALLOCATE=1 -mcmodel=medany -static -std=gnu99 -O2 -fno-common -fno-builtin-printf
LINKER_OPTIONS := -static -nostdlib -nostartfiles -lm -lgcc -T

BASE_SRC_FILES := $(wildcard $(ASM_SRC_DIR)/*.S)
SRC_FILES := $(filter-out $(wildcard $(ASM_SRC_DIR)/*template.S),$(BASE_SRC_FILES))
BIN_FILES := $(patsubst $(ASM_SRC_DIR)/%.S, $(BIN_DIR)/%.riscv, $(SRC_FILES))
OBJ_FILES := $(patsubst $(ASM_SRC_DIR)/%.S, $(OBJ_DIR)/%.objdump, $(SRC_FILES))
LOG_FILES := $(patsubst $(ASM_SRC_DIR)/%.S, $(LOG_DIR)/%.log, $(SRC_FILES))
DUMP_FILES := $(patsubst $(ASM_SRC_DIR)/%.S, $(LOG_DIR)/%.dump, $(SRC_FILES))

all: build objdump run dump
	$(info ==================== Complete Build Finished =============)

build: $(BIN_FILES)
	$(info ==================== Build completed ====================)
	$(info )

$(BIN_DIR)/%.riscv: $(ASM_SRC_DIR)/%.S
	$(info ==================== Compiling asm to binary ============)
	${RISCVPREFIX}-gcc $(GCC_OPTS) -I $(INCLUDE_DIRS) -o $@ $< $(CRT_FILE) $(LINKER_OPTIONS) $(<D)/$*.ld


objdump: $(OBJ_FILES)
	$(info ==================== Objdump Completed ==================)
	$(info )

$(OBJ_DIR)/%.objdump: $(BIN_DIR)/%.riscv
	$(info ==================== Disassembling binary ===============)
	${RISCVPREFIX}-objdump -D $< > $@

run: $(LOG_FILES)
	$(info ==================== Spike Run Completed ================)
	$(info )

$(LOG_DIR)/%.log: $(BIN_DIR)/%.riscv
	$(info ==================== Simulating binary on Spike =========)
	spike -l -m0x40000000:0x80000 --isa=$(SPIKE_ISA) $< 2> $@

dump: $(DUMP_FILES)
	$(info ==================== Spike dump Completed ===============)
	$(info )

$(LOG_DIR)/%.dump: $(BIN_DIR)/%.riscv
	$(info ==================== Generating spike dump ==============)
	spike --log-commits --log  $@ -m0x40000000:0x80000 --isa=$(SPIKE_ISA) +signature=$@.sign $<



.PHONY: clean
clean:
	rm -rf bin/* log/* objdump/*