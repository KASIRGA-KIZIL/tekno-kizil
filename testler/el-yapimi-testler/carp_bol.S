.globl _start
_start:
# art arda carpma ve bolme yap

test_1:
addi	x7,x0,2
mul     x7,x7,x7 # 4
mul     x7,x7,x7 # 16
mul     x7,x7,x7 # 256
addi    x6,x0,256
bne     x7,x6,fail

test_2:
addi	x7,x0,2
mul     x7,x7,x7   # 4
div     x7,x7,x7   # 1
mul     x7,x7,x7   # 1
addi    x7, x7, -1 #0
addi    x6,x0,0
bne     x7,x6,fail

test_3:
addi	x7,x0,2
mul     x7,x7,x7   # 4
addi	x7,x0,2
addi    x6,x0,2
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





