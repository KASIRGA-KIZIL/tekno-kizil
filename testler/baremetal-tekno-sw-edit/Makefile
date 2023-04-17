#############################################################
# Configuration
#############################################################


# Default target
CHIP ?= tekno
PROGRAM ?= tekno_example

# Variables the user probably shouldn't override.
builddir := work/build
installdir := work/install

#############################################################
# Prints help message
#############################################################
.PHONY: help
help:
	@echo " This is a RISC-V Baremetal Program Generator used by TUBITAK" 
	@echo " Ported from SiFive Freedom E SDK"
	@echo "  Makefile targets:"
	@echo ""
	@echo " tools [BOARD=$(BOARD)]:"
	@echo "    Install compilation & debugging tools to target your desired board."
	@echo "    To use please set RISCV to compiler directory."
	@echo "    You can also set additional flags with XCFLAGS"	
	@echo ""
	@echo " software [PROGRAM=$(PROGRAM) BOARD=$(BOARD)]:"
	@echo "    Build a software program to load with the"
	@echo "    debugger. AS well as it's assebly code."
	@echo ""
	@echo " clean [PROGRAM=$(PROGRAM) BOARD=$(BOARD)]:"
	@echo "    Clean compiled objects for a specified "
	@echo "    software program."
	@echo ""
#############################################################
# This Section is for Requirement Checking
#############################################################

# Finds the directory in which this BSP is located, ensuring that there is
# exactly one.
board_dir := $(wildcard chip/$(BOARD))
ifeq ($(words $(board_dir)),0)
$(error Unable to find BSP for $(BOARD), expected to find either "bsp/$(BOARD)" or "bsp-addons/$(BOARD)")
endif
ifneq ($(words $(board_dir)),1)
$(error Found multiple BSPs for $(BOARD): "$(board_dir)")
endif

# There must be a settings makefile fragment in the BSP's board directory.
ifeq ($(wildcard $(board_dir)/settings.mk),)
$(error Unable to find BSP for $(BOARD), expected to find $(board_dir)/settings.mk)
endif
include $(board_dir)/settings.mk

ifeq ($(RISCV_ARCH),)
$(error $(board_dir)/settings.mk must set RISCV_ARCH, the RISC-V ISA string to target)
endif

ifeq ($(RISCV_ABI),)
$(error $(board_dir)/settings.mk must set RISCV_ABI, the ABI to target)
endif

# Determines the XLEN from the toolchain tuple
ifeq ($(patsubst rv32%,rv32,$(RISCV_ARCH)),rv32)
RISCV_XLEN := 32
else ifeq ($(patsubst rv64%,rv64,$(RISCV_ARCH)),rv64)
RISCV_XLEN := 64
else
$(error Unable to determine XLEN from $(RISCV_ARCH))
endif

# Check RISCV-PATH
ifeq ($(RISCV),)
$(error RISCV environment variable is not defined.)
endif

#set other variables
RISCV_GCC     := $(abspath $(RISCV)/bin/riscv32-unknown-elf-gcc)
RISCV_GXX     := $(abspath $(RISCV)/bin/riscv32-unknown-elf-g++)
RISCV_OBJDUMP := $(abspath $(RISCV)/bin/riscv32-unknown-elf-objdump)
RISCV_OBJCOPY := $(abspath $(RISCV)/bin/riscv32-unknown-elf-objcopy)
RISCV_GDB     := $(abspath $(RISCV)/bin/riscv32-unknown-elf-gdb)
RISCV_AR      := $(abspath $(RISCV)/bin/riscv32-unknown-elf-ar)

PATH := $(abspath $(RISCV)/bin):$(PATH)

	
#############################################################
# This Section is for Software Compilation
#############################################################

PROGRAM_DIR = software/$(PROGRAM)
PROGRAM_ELF = software/$(PROGRAM)/$(PROGRAM)

.PHONY: clean
clean: 
	$(MAKE) -C $(PROGRAM_DIR) CC=$(RISCV_GCC) RISCV_ARCH=$(RISCV_ARCH) RISCV_ABI=$(RISCV_ABI) AR=$(RISCV_AR) BSP_BASE=$(abspath chip) BOARD=$(BOARD)  RISCV_OBJCOPY=$(RISCV_OBJCOPY)  PROGRAM_ELF=$(abspath $(PROGRAM_ELF)) RISCV_OBJDUMP=$(RISCV_OBJDUMP) clean

.PHONY: software
software: clean
	$(MAKE) -C $(PROGRAM_DIR) CC=$(RISCV_GCC) RISCV_ARCH=$(RISCV_ARCH) RISCV_ABI=$(RISCV_ABI) AR=$(RISCV_AR) BSP_BASE=$(abspath chip) BOARD=$(BOARD)  RISCV_OBJCOPY=$(RISCV_OBJCOPY)  PROGRAM_ELF=$(abspath $(PROGRAM_ELF)) RISCV_OBJDUMP=$(RISCV_OBJDUMP)

	 rm -f drivers/src/*.o
	 rm -f chip/*.o
	 rm -f chip/tekno/*.o
	 rm -f software/$(PROGRAM)/*.o

	@echo ""
	@echo "-----------------------------------"
	@echo "Outputs were produced successfully."
	@echo "-----------------------------------"
