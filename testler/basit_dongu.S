.globl _start
_start:
	addi	t0, zero, 0
	addi	t0,   t0, 1
	addi	t0,   t0, 1
	addi	t0,   t0, 1
	addi	t0,   t0, 1
	and t2, zero, zero
	addi	t2,   t2, 1
	addi	t2,   t2, 1
	addi	t2,   t2, 1
	addi	t2,   t2, 1
	j _start
