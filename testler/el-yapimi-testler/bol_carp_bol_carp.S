.globl _start
_start:

addi	x7,x0,170
bne     x7,x7,fail
addi    x1,x0,1

addi    x7,x0,169
j       tmp0
tmp0:
j       tmp1
tmp1:
j       tmp2
tmp2:
addi    x7, x7, 1
addi    x7, x7, -1
addi    x7, x7, -1
mv      x6, x7
addi    x7, x7, 1
addi    x6, x6, 1
bne     x7,x6,fail
mul     x6,x6,x1
mul     x6,x6,x6
div     x6,x6,x7
beq     x7,x6,pass
bne     x7,x6,fail

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
tdat2:  .half 0xbeef
tdat3:  .half 0xbeef
tdat4:  .half 0xbeef
tdat5:  .half 0xbeef
tdat6:  .half 0xbeef
tdat7:  .half 0xbeef
tdat8:  .half 0xbeef
tdat9:  .half 0xbeef
tdat10: .half 0xbeef





