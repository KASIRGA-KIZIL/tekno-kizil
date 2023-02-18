.globl _start
_start:
# Timer'in ust ve alt kisimlarini oku.


# sanity check
mv      x1, x0
addi    x1, x1, 1
beq     x1, x0, fail

# initialize variables
addi    x3, x0, 0
addi    x4, x0, 1024
li      x7, 0x30000000

# read lower word of the timer
here:
lw      x8, 0(x7)
beq     x1,x8, fail
mv      x1, x8
addi    x3, x3, 1
bne     x3,x4,here


addi    x3, x0, 0

lw      x8, 4(x7)
mv      x1, x8
there:
lw      x8, 4(x7)
bne     x1, x8, fail
mv      x1, x8
addi    x3, x3, 1
bne     x3,x4,there

j       pass


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