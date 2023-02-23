.globl _start
_start:

addi x1, x0, 100
addi x4, x0, 1
start:
addi x1, x1, -1
slli x2, x1, 3
srli x2, x2, 3
bne x2, x4, l1
addi x5, x5, 1
l1:
slli x6, x1, 2
srli x6, x6, 2
addi x7, x7, 1
l2:
bne x1, x0, start

finished:
add x0,x0,x0
add x0,x0,x0
add x0,x0,x0
add x0,x0,x0
add x0,x0,x0
add x0,x0,x0
add x0,x0,x0
add x0,x0,x0
add x0,x0,x0
j finished

