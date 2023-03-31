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
  addi sp, sp, -40*REGBYTES

  SREG x1, 1*REGBYTES(sp)
  SREG x3, 3*REGBYTES(sp)
  SREG x4, 4*REGBYTES(sp)
  SREG x5, 5*REGBYTES(sp)
  SREG x6, 6*REGBYTES(sp)
  SREG x7, 7*REGBYTES(sp)
  SREG x8, 8*REGBYTES(sp)
  SREG x9, 9*REGBYTES(sp)
  SREG x10, 10*REGBYTES(sp)
  SREG x11, 11*REGBYTES(sp)
  SREG x12, 12*REGBYTES(sp)
  SREG x13, 13*REGBYTES(sp)
  SREG x14, 14*REGBYTES(sp)
  SREG x15, 15*REGBYTES(sp)
  SREG x16, 16*REGBYTES(sp)
  SREG x17, 17*REGBYTES(sp)
  SREG x18, 18*REGBYTES(sp)
  SREG x19, 19*REGBYTES(sp)
  SREG x20, 20*REGBYTES(sp)
  SREG x21, 21*REGBYTES(sp)
  SREG x22, 22*REGBYTES(sp)
  SREG x23, 23*REGBYTES(sp)
  SREG x24, 24*REGBYTES(sp)
  SREG x25, 25*REGBYTES(sp)
  SREG x26, 26*REGBYTES(sp)
  SREG x27, 27*REGBYTES(sp)
  SREG x28, 28*REGBYTES(sp)
  SREG x29, 29*REGBYTES(sp)
  SREG x30, 30*REGBYTES(sp)
  SREG x31, 31*REGBYTES(sp)
  li a2, 0
  beq a0, a2, 1f
  li a2, 1
  beq a0, a2, 1f
  # li a2, 2
  # beq a0, a2, inst32_s
1:
  lh a2, (a1)
  # check the lower 2 bits to see if the instruction is 32-bit or 16-bit.
  andi a2, a2, 0x3;
  li t0, 0x3
  bne a2,t0,inst16_s
inst32_s:                           # is 32-bit instruction then increment by 4
  addi a1,a1,0x4
  beqz x0,1f
inst16_s:
  addi a1,a1,0x2                  # is 16-bit instruction then increment by 2
1: 


  LREG x1, 1*REGBYTES(sp)
  LREG x3, 3*REGBYTES(sp)
  LREG x4, 4*REGBYTES(sp)
  LREG x5, 5*REGBYTES(sp)
  LREG x6, 6*REGBYTES(sp)
  LREG x7, 7*REGBYTES(sp)
  LREG x8, 8*REGBYTES(sp)
  LREG x9, 9*REGBYTES(sp)
  LREG x10, 10*REGBYTES(sp)
  LREG x11, 11*REGBYTES(sp)
  LREG x12, 12*REGBYTES(sp)
  LREG x13, 13*REGBYTES(sp)
  LREG x14, 14*REGBYTES(sp)
  LREG x15, 15*REGBYTES(sp)
  LREG x16, 16*REGBYTES(sp)
  LREG x17, 17*REGBYTES(sp)
  LREG x18, 18*REGBYTES(sp)
  LREG x19, 19*REGBYTES(sp)
  LREG x20, 20*REGBYTES(sp)
  LREG x21, 21*REGBYTES(sp)
  LREG x22, 22*REGBYTES(sp)
  LREG x23, 23*REGBYTES(sp)
  LREG x24, 24*REGBYTES(sp)
  LREG x25, 25*REGBYTES(sp)
  LREG x26, 26*REGBYTES(sp)
  LREG x27, 27*REGBYTES(sp)
  LREG x28, 28*REGBYTES(sp)
  LREG x29, 29*REGBYTES(sp)
  LREG x30, 30*REGBYTES(sp)
  LREG x31, 31*REGBYTES(sp)
  addi sp, sp, 40*REGBYTES
  sret

.align 2
.globl custom_trap_handler
custom_trap_handler:
  addi sp, sp, -40*REGBYTES

  SREG x1, 1*REGBYTES(sp)
  SREG x3, 3*REGBYTES(sp)
  SREG x4, 4*REGBYTES(sp)
  SREG x5, 5*REGBYTES(sp)
  SREG x6, 6*REGBYTES(sp)
  SREG x7, 7*REGBYTES(sp)
  SREG x8, 8*REGBYTES(sp)
  SREG x9, 9*REGBYTES(sp)
  SREG x10, 10*REGBYTES(sp)
  SREG x11, 11*REGBYTES(sp)
  SREG x12, 12*REGBYTES(sp)
  SREG x13, 13*REGBYTES(sp)
  SREG x14, 14*REGBYTES(sp)
  SREG x15, 15*REGBYTES(sp)
  SREG x16, 16*REGBYTES(sp)
  SREG x17, 17*REGBYTES(sp)
  SREG x18, 18*REGBYTES(sp)
  SREG x19, 19*REGBYTES(sp)
  SREG x20, 20*REGBYTES(sp)
  SREG x21, 21*REGBYTES(sp)
  SREG x22, 22*REGBYTES(sp)
  SREG x23, 23*REGBYTES(sp)
  SREG x24, 24*REGBYTES(sp)
  SREG x25, 25*REGBYTES(sp)
  SREG x26, 26*REGBYTES(sp)
  SREG x27, 27*REGBYTES(sp)
  SREG x28, 28*REGBYTES(sp)
  SREG x29, 29*REGBYTES(sp)
  SREG x30, 30*REGBYTES(sp)
  SREG x31, 31*REGBYTES(sp)
  li a2, 0
  beq a0, a2, 1f
  li a2, 1
  beq a0, a2, 1f
  # li a2, 2
  # beq a0, a2, inst32
1:
  lh a2, (a1)
  # check the lower 2 bits to see if the instruction is 32-bit or 16-bit.
  andi a2, a2, 0x3;
  li t0, 0x3
  bne a2,t0,inst16
inst32:                           # is 32-bit instruction then increment by 4
  addi a1,a1,0x4
  beqz x0,1f
inst16:
  addi a1,a1,0x2                  # is 16-bit instruction then increment by 2
1: 


  LREG x1, 1*REGBYTES(sp)
  LREG x3, 3*REGBYTES(sp)
  LREG x4, 4*REGBYTES(sp)
  LREG x5, 5*REGBYTES(sp)
  LREG x6, 6*REGBYTES(sp)
  LREG x7, 7*REGBYTES(sp)
  LREG x8, 8*REGBYTES(sp)
  LREG x9, 9*REGBYTES(sp)
  LREG x10, 10*REGBYTES(sp)
  LREG x11, 11*REGBYTES(sp)
  LREG x12, 12*REGBYTES(sp)
  LREG x13, 13*REGBYTES(sp)
  LREG x14, 14*REGBYTES(sp)
  LREG x15, 15*REGBYTES(sp)
  LREG x16, 16*REGBYTES(sp)
  LREG x17, 17*REGBYTES(sp)
  LREG x18, 18*REGBYTES(sp)
  LREG x19, 19*REGBYTES(sp)
  LREG x20, 20*REGBYTES(sp)
  LREG x21, 21*REGBYTES(sp)
  LREG x22, 22*REGBYTES(sp)
  LREG x23, 23*REGBYTES(sp)
  LREG x24, 24*REGBYTES(sp)
  LREG x25, 25*REGBYTES(sp)
  LREG x26, 26*REGBYTES(sp)
  LREG x27, 27*REGBYTES(sp)
  LREG x28, 28*REGBYTES(sp)
  LREG x29, 29*REGBYTES(sp)
  LREG x30, 30*REGBYTES(sp)
  LREG x31, 31*REGBYTES(sp)
  addi sp, sp, 40*REGBYTES
  mret


# To here
# Instructions to be inserted before and after the program
# Possible setups inside this macro can be
#   1. Privilege mode change

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
  ret
