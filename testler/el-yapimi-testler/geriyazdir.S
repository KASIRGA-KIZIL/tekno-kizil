.globl _start
_start:



la	x7, tdat1
addi    x1,x0,0
li      x2,4000


here:
sw      x1,(x7)
addi    x1, x1, 1
addi    x7, x7, 4
bne     x1,x2,here

la	x7, tdat1
addi    x1,x0,0

reads:
lw      x3,(x7)
bne     x1,x3,fail
addi    x1, x1, 1
addi    x7, x7, 4
bne     x1,x2,reads

j       pass

fail:
	add x0,x0,x0
	add x0,x0,x0
	add x0,x0,x0
	add x0,x0,x0
	add x0,x0,x0
	ecall

pass:
	add x0,x0,x0
	add x0,x0,x0
	add x0,x0,x0
	add x0,x0,x0
	add x0,x0,x0
	ecall


.data
tdat:
tdat1:  .half 0xbeef



