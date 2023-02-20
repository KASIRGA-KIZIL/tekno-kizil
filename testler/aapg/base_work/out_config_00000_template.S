#define PRV_S 1
#define PRV_U 0
#define MSTATUS_MPP 0x00001800
#if __riscv_xlen == 64
  #define LREG ld
  #define SREG sd
  #define LREGU lwu
  #define REGBYTES 8
  #define FMV fmv.d.x
#else
  #define LREG lw
  #define LREGU lw
  #define SREG sw
  #define REGBYTES 4
  #define FMV fmv.w.x
#endif


# From here
.align 2
.globl custom_trap_handler_s
custom_trap_handler_s:

.align 2
.globl custom_trap_handler
custom_trap_handler:


# To here
# Instructions to be inserted before and after the program
# Possible setups inside this macro can be
#   1. Privilege mode change
#   2. PMP Configuration - csrw pmpcfg0 xxx, csrw pmpcfg1 xxx

############################
### Exception generation ###
############################

# Instruction address misaligned
.macro ecause00
.endm

# Instruction access fault
.macro ecause01
li x15, -10
jr x15
.endm

# Illegal Instruction
.macro ecause02
.word 0x01239239812981
.endm

# Breakpoint
.macro ecause03
ebreak
.endm

# Load address misaligned
.macro ecause04
LREG x0, (REGBYTES-2)(sp)
.endm

# Load access fault
.macro ecause05
.endm

# Store/AMO address misaligned
.macro ecause06
SREG x0, (REGBYTES-2)(sp)
.endm

# Store/AMO access fault
.macro ecause07
.endm

# Env call from U-mode
.macro ecause08
.endm

# Env call from S-mode
.macro ecause09
.endm

# Reserved
.macro ecause10
.endm

# Env call from M-mode
.macro ecause11
ecall
.endm

# Instruction page fault
.macro ecause12
.endm

# Load page fault
.macro ecause13
.endm

# Reserved
.macro ecause14
.endm

# Store/AMO page fault
.macro ecause15
.endm

# Env call
.macro switchmodes
ecall
.endm

.macro test_entry_macro
.endm
.macro pre_program_macro
add x0,x0,x0
 .endm
.macro post_program_macro
add x0,x0,x0
 .endm
.macro pre_branch_macro
add x0,x0,x0
 .endm
.macro post_branch_macro
add x0,x0,x0
 .endm
.macro test_pass_macro
la      sp, begin_signature; addi    sp, sp, 2*REGBYTES; li      t1, 0xfffff; SREG    t1, 0*REGBYTES(sp)
 .endm
.macro test_fail_macro
add x0,x0,x0
 .endm

# User defined functions to be called

.globl func1
func1:
add x0,x0,x0
