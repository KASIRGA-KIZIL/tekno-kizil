.globl _start
_start:
# Anabellekten oku ve yaz

test_1:
la	x1,tdat1
lh	x2,0(x1)
li	x7,0xffffbeef
bne     x2,x7,fail

test_2:
lh	x2,2(x1)
li	x7,0xffffabab
bne     x2,x7,fail

test_3:
li      x2,0xff
sb	x2,3(x1)
li	x7,0xffffabab
lb	x2,2(x1)
li	x7,0xffffffab
bne     x2,x7,fail
lb	x2,3(x1)
li	x7,0xffffffff
bne     x2,x7,fail
lb	x2,4(x1)
li	x7,0xfffffffe
bne     x2,x7,fail
beq     x2,x7,pass



fail:
add   x0,x0,x0
add   x0,x0,x0
add   x0,x0,x0
add   x0,x0,x0
add   x0,x0,x0
ecall


pass:
add   x0,x0,x0
add   x0,x0,x0
add   x0,x0,x0
add   x0,x0,x0
add   x0,x0,x0
ecall



.data
tdat:
tdat1:  .half 0xbeef
tdat2:  .half 0xabab
tdat3:  .half 0xcafe
tdat4:  .half 0xbee0
tdat5:  .half 0xbee1
tdat6:  .half 0xbee2
tdat7:  .half 0xbee3
tdat8:  .half 0xbee4
tdat9:  .half 0xbee5
tdat10: .half 0xbee6



