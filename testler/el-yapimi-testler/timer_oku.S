.globl _start
_start:




addi    x3, x0, 0
addi    x4, x0, 1024
li      x7, 0x30000000

here:
lw      x1, 0(x7)
addi    x3, x3, 1
bne     x3,x4,here

addi x0,x0,1
addi x0,x0,1
addi x0,x0,1
addi x0,x0,1
addi x0,x0,1
addi x0,x0,1
addi x0,x0,1
ecall

