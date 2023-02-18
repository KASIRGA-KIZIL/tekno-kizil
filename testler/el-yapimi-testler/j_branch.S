.globl _start
_start:
# Jump ve Branch testi.
# Art arda jump ve branch yaparak Dallanma ongorucu ve Getir'i test et.

addi	x1,x0,1
beq     x1,x0,fail
beq     x1,x0,fail
beq     x1,x0,fail
beq     x1,x0,fail
ble     x1,x0,fail
ble     x1,x0,fail
ble     x1,x0,fail
bleu    x1,x0,fail
bleu    x1,x0,fail
bleu    x1,x0,fail
bleu    x1,x0,fail
blt     x1,x0,fail
blt     x1,x0,fail
blt     x1,x0,fail
blt     x1,x0,fail

jal     x2, test2
jal     x2, test1
jal     x2, test3
jal     x2, test4
jal     x2, test5
j       pass
j       fail

test1:
addi    x1,x1,-1
bgt     x1,x0, fail
bgt     x1,x0, fail
bgt     x1,x0, fail
bgt     x1,x0, fail
jr      x2
j       fail


test2:
addi    x1,x1,-1
bgt     x1,x0, fail
bgt     x1,x0, fail
bgt     x1,x0, fail
bgt     x1,x0, fail
jr      x2
j       fail


test3:
addi    x1,x1,-1
bgt     x1,x0, fail
bgt     x1,x0, fail
bgt     x1,x0, fail
bgt     x1,x0, fail
jr      x2
j       fail


test4:
addi    x1,x1,1
bgt     x1,x0, fail
bgt     x1,x0, fail
bgt     x1,x0, fail
bgt     x1,x0, fail
jr      x2
j       fail

test5:
addi    x1,x1,1
bgt     x1,x0, fail
bgt     x1,x0, fail
bgt     x1,x0, fail
bgt     x1,x0, fail
jr      x2

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

