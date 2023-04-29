	.file	"core_matrix.c"
	.option nopic
	.attribute arch, "rv32i2p0_m2p0_c2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.section	.text.core_init_matrix,"ax",@progbits
	.align	1
	.globl	core_init_matrix
	.type	core_init_matrix, @function
core_init_matrix:
	addi	sp,sp,-16
	sw	s0,12(sp)
	sw	s1,8(sp)
	sw	s2,4(sp)
	sw	s3,0(sp)
	mv	a6,a0
	bne	a2,zero,.L2
	li	a2,1
.L2:
	li	a5,0
	beq	a6,zero,.L14
.L3:
	mv	a0,a5
	addi	a5,a5,1
	mul	a4,a5,a5
	slli	a4,a4,3
	bgtu	a6,a4,.L3
	mul	t0,a0,a0
	addi	a1,a1,-1
	andi	a5,a1,-4
	addi	s1,a5,4
	mv	s2,a0
	mv	t3,s1
	slli	t0,t0,1
	add	t2,s1,t0
	beq	a0,zero,.L5
.L4:
	li	t4,65536
	addi	t1,a0,1
	slli	s0,a0,1
	mv	t5,t2
	li	t6,0
	li	a4,1
	sub	t3,t3,t2
	addi	t4,t4,-1
.L6:
	mv	s3,a4
	mv	a6,t5
.L7:
	mul	a2,a2,a4
	slli	a5,a4,16
	srli	a5,a5,16
	add	a7,t3,a6
	addi	a6,a6,2
	addi	a4,a4,1
	srai	a1,a2,31
	srli	a1,a1,16
	add	a2,a2,a1
	and	a2,a2,t4
	sub	a2,a2,a1
	add	a1,a5,a2
	slli	a1,a1,16
	srli	a1,a1,16
	add	a5,a1,a5
	sh	a1,-2(a6)
	andi	a5,a5,255
	sh	a5,0(a7)
	bne	a4,t1,.L7
	addi	t6,t6,1
	add	a4,a0,s3
	add	t1,t1,a0
	add	t5,t5,s0
	bne	t6,a0,.L6
.L5:
	add	a5,t2,t0
	addi	a5,a5,-1
	lw	s0,12(sp)
	andi	a5,a5,-4
	addi	a5,a5,4
	sw	s1,4(a3)
	sw	s2,0(a3)
	sw	t2,8(a3)
	sw	a5,12(a3)
	lw	s1,8(sp)
	lw	s2,4(sp)
	lw	s3,0(sp)
	addi	sp,sp,16
	jr	ra
.L14:
	addi	a1,a1,-1
	andi	t2,a1,-4
	addi	t3,t2,4
	mv	s1,t3
	addi	t2,t2,6
	li	s2,-1
	li	t0,2
	li	a0,-1
	j	.L4
	.size	core_init_matrix, .-core_init_matrix
	.section	.text.matrix_sum,"ax",@progbits
	.align	1
	.globl	matrix_sum
	.type	matrix_sum, @function
matrix_sum:
	mv	t4,a0
	beq	a0,zero,.L21
	slli	t6,a0,2
	neg	t5,a0
	add	a7,a1,t6
	li	t3,0
	li	a0,0
	li	a4,0
	li	a1,0
	slli	t5,t5,3
.L20:
	sub	t1,a7,t6
	mv	a5,t1
	j	.L19
.L25:
	slli	a0,a0,16
	addi	a5,a5,4
	srai	a0,a0,16
	beq	a7,a5,.L24
.L19:
	mv	a3,a4
	lw	a4,0(a5)
	slli	a0,a0,16
	srli	a0,a0,16
	slt	a3,a3,a4
	add	a1,a1,a4
	addi	a6,a0,10
	add	a0,a0,a3
	bge	a2,a1,.L25
	slli	a0,a6,16
	addi	a5,a5,4
	srai	a0,a0,16
	li	a1,0
	bne	a7,a5,.L19
.L24:
	addi	t3,t3,1
	sub	a7,t1,t5
	bne	t4,t3,.L20
	ret
.L21:
	li	a0,0
	ret
	.size	matrix_sum, .-matrix_sum
	.section	.text.matrix_mul_const,"ax",@progbits
	.align	1
	.globl	matrix_mul_const
	.type	matrix_mul_const, @function
matrix_mul_const:
	beq	a0,zero,.L26
	slli	t5,a0,1
	neg	t4,a0
	add	a6,a2,t5
	li	t1,0
	li	t3,0
	slli	t4,t4,2
.L28:
	sub	a7,a6,t5
	slli	a2,t1,2
	add	a2,a1,a2
	mv	a5,a7
.L29:
	lh	a4,0(a5)
	addi	a2,a2,4
	addi	a5,a5,2
	mul	a4,a4,a3
	sw	a4,-4(a2)
	bne	a6,a5,.L29
	addi	t3,t3,1
	add	t1,t1,a0
	sub	a6,a7,t4
	bne	a0,t3,.L28
.L26:
	ret
	.size	matrix_mul_const, .-matrix_mul_const
	.section	.text.matrix_add_const,"ax",@progbits
	.align	1
	.globl	matrix_add_const
	.type	matrix_add_const, @function
matrix_add_const:
	beq	a0,zero,.L34
	slli	t1,a0,1
	neg	a7,a0
	slli	a2,a2,16
	srli	a2,a2,16
	add	a3,a1,t1
	li	a6,0
	slli	a7,a7,2
.L36:
	sub	a1,a3,t1
	mv	a5,a1
.L37:
	lhu	a4,0(a5)
	addi	a5,a5,2
	add	a4,a2,a4
	sh	a4,-2(a5)
	bne	a3,a5,.L37
	addi	a6,a6,1
	sub	a3,a1,a7
	bne	a0,a6,.L36
.L34:
	ret
	.size	matrix_add_const, .-matrix_add_const
	.section	.text.matrix_mul_vect,"ax",@progbits
	.align	1
	.globl	matrix_mul_vect
	.type	matrix_mul_vect, @function
matrix_mul_vect:
	beq	a0,zero,.L42
	slli	t5,a0,2
	slli	t3,a0,1
	add	t5,a1,t5
	add	t3,a3,t3
	li	t4,0
.L45:
	slli	a6,t4,1
	add	a6,a2,a6
	mv	a5,a3
	li	a7,0
.L44:
	lh	a4,0(a6)
	lh	t1,0(a5)
	addi	a5,a5,2
	addi	a6,a6,2
	mul	a4,a4,t1
	add	a7,a7,a4
	bne	t3,a5,.L44
	sw	a7,0(a1)
	addi	a1,a1,4
	add	t4,t4,a0
	bne	t5,a1,.L45
.L42:
	ret
	.size	matrix_mul_vect, .-matrix_mul_vect
	.section	.text.matrix_mul_matrix,"ax",@progbits
	.align	1
	.globl	matrix_mul_matrix
	.type	matrix_mul_matrix, @function
matrix_mul_matrix:
	beq	a0,zero,.L60
	addi	sp,sp,-16
	mv	t5,a0
	slli	a0,a0,1
	sw	s0,12(sp)
	mv	t2,a1
	mv	s0,a3
	mv	t4,a2
	add	a6,a2,a0
	li	t6,0
	li	t0,0
.L51:
	slli	a7,t6,2
	add	a7,t2,a7
	mv	t1,s0
	li	t3,0
.L53:
	mv	a3,t1
	mv	a5,t4
	li	a2,0
.L52:
	lh	a4,0(a5)
	lh	a1,0(a3)
	addi	a5,a5,2
	add	a3,a3,a0
	mul	a4,a4,a1
	add	a2,a2,a4
	bne	a6,a5,.L52
	sw	a2,0(a7)
	addi	a5,t3,1
	addi	a7,a7,4
	addi	t1,t1,2
	beq	t5,a5,.L63
	mv	t3,a5
	j	.L53
.L63:
	addi	a5,t0,1
	add	t4,t4,a0
	add	t6,t6,t5
	add	a6,a6,a0
	beq	t0,t3,.L49
	mv	t0,a5
	j	.L51
.L49:
	lw	s0,12(sp)
	addi	sp,sp,16
	jr	ra
.L60:
	ret
	.size	matrix_mul_matrix, .-matrix_mul_matrix
	.section	.text.matrix_mul_matrix_bitextract,"ax",@progbits
	.align	1
	.globl	matrix_mul_matrix_bitextract
	.type	matrix_mul_matrix_bitextract, @function
matrix_mul_matrix_bitextract:
	beq	a0,zero,.L75
	addi	sp,sp,-16
	mv	t5,a0
	slli	a0,a0,1
	sw	s0,12(sp)
	mv	t2,a1
	mv	s0,a3
	mv	t4,a2
	add	a6,a2,a0
	li	t6,0
	li	t0,0
.L66:
	slli	a7,t6,2
	add	a7,t2,a7
	mv	t1,s0
	li	t3,0
.L68:
	mv	a2,t1
	mv	a3,t4
	li	a1,0
.L67:
	lh	a4,0(a2)
	lh	a5,0(a3)
	addi	a3,a3,2
	add	a2,a2,a0
	mul	a5,a5,a4
	srai	a4,a5,2
	srai	a5,a5,5
	andi	a4,a4,15
	andi	a5,a5,127
	mul	a5,a4,a5
	add	a1,a1,a5
	bne	a6,a3,.L67
	sw	a1,0(a7)
	addi	a5,t3,1
	addi	a7,a7,4
	addi	t1,t1,2
	beq	t5,a5,.L78
	mv	t3,a5
	j	.L68
.L78:
	addi	a5,t0,1
	add	t4,t4,a0
	add	t6,t6,t5
	add	a6,a6,a0
	beq	t0,t3,.L64
	mv	t0,a5
	j	.L66
.L64:
	lw	s0,12(sp)
	addi	sp,sp,16
	jr	ra
.L75:
	ret
	.size	matrix_mul_matrix_bitextract, .-matrix_mul_matrix_bitextract
	.section	.text.matrix_test,"ax",@progbits
	.align	1
	.globl	matrix_test
	.type	matrix_test, @function
matrix_test:
	addi	sp,sp,-64
	sw	s0,56(sp)
	sw	s1,52(sp)
	sw	s6,32(sp)
	sw	ra,60(sp)
	sw	s2,48(sp)
	sw	s3,44(sp)
	sw	s4,40(sp)
	sw	s5,36(sp)
	sw	s7,28(sp)
	sw	s8,24(sp)
	sw	s9,20(sp)
	sw	s10,16(sp)
	sw	s11,12(sp)
	mv	s6,a1
	mv	s0,a2
	mv	s1,a3
	beq	a0,zero,.L80
	slli	t5,a0,1
	add	a1,a2,t5
	neg	s9,a0
	slli	s3,a4,16
	mv	s11,a0
	srli	s3,s3,16
	mv	a2,a1
	li	a6,0
	slli	a7,s9,2
.L81:
	sub	t1,a2,t5
	mv	a5,t1
.L82:
	lhu	a3,0(a5)
	addi	a5,a5,2
	add	a3,s3,a3
	sh	a3,-2(a5)
	bne	a5,a2,.L82
	addi	a0,a6,1
	sub	a2,t1,a7
	beq	s11,a0,.L83
	mv	a6,a0
	j	.L81
.L83:
	li	t3,0
	li	t4,0
.L85:
	sub	t1,a1,t5
	slli	a2,t3,2
	add	a2,a2,s6
	mv	a5,t1
.L84:
	lh	a3,0(a5)
	addi	a2,a2,4
	addi	a5,a5,2
	mul	a3,a3,a4
	sw	a3,-4(a2)
	bne	a1,a5,.L84
	addi	a5,t4,1
	add	t3,t3,a0
	sub	a1,t1,a7
	beq	t4,a6,.L121
	mv	t4,a5
	j	.L85
.L121:
	neg	t3,a0
	li	a5,-4096
	or	s2,a4,a5
	sub	t1,s6,a7
	li	a0,0
	li	a4,0
	li	a2,0
	li	t5,0
	slli	t3,t3,3
.L86:
	add	t4,t1,a7
	mv	a5,t4
	j	.L89
.L123:
	slli	a0,a0,16
	addi	a5,a5,4
	srai	a0,a0,16
	beq	a5,t1,.L122
.L89:
	mv	a3,a4
	lw	a4,0(a5)
	slli	a0,a0,16
	srli	a0,a0,16
	slt	a3,a3,a4
	add	a2,a2,a4
	addi	a1,a0,10
	add	a0,a0,a3
	bge	s2,a2,.L123
	slli	a0,a1,16
	addi	a5,a5,4
	srai	a0,a0,16
	li	a2,0
	bne	a5,t1,.L89
.L122:
	addi	a5,t5,1
	sub	t1,t4,t3
	beq	a6,t5,.L124
	mv	t5,a5
	j	.L86
.L124:
	li	a1,0
	call	crc16
	mv	a2,s0
	mv	s7,a0
	mv	a3,s1
	mv	a0,s11
	mv	a1,s6
	slli	s4,s11,2
	call	matrix_mul_vect
	add	s4,s6,s4
	slli	s8,s9,2
	mv	a6,s4
	li	a0,0
	li	a4,0
	li	a2,0
	li	s5,0
	slli	s9,s9,3
.L94:
	add	a7,s8,a6
	mv	a5,a7
	j	.L93
.L126:
	slli	a0,a0,16
	addi	a5,a5,4
	srai	a0,a0,16
	beq	a5,a6,.L125
.L93:
	mv	a3,a4
	lw	a4,0(a5)
	slli	a0,a0,16
	srli	a0,a0,16
	slt	a3,a3,a4
	add	a2,a2,a4
	addi	a1,a0,10
	add	a0,a0,a3
	bge	s2,a2,.L126
	slli	a0,a1,16
	addi	a5,a5,4
	srai	a0,a0,16
	li	a2,0
	bne	a5,a6,.L93
.L125:
	addi	s10,s5,1
	sub	a6,a7,s9
	beq	s11,s10,.L127
	mv	s5,s10
	j	.L94
.L127:
	mv	a1,s7
	call	crc16
	mv	a2,s0
	mv	s7,a0
	mv	a3,s1
	mv	a0,s10
	mv	a1,s6
	call	matrix_mul_matrix
	mv	a6,s4
	li	a0,0
	li	a4,0
	li	a2,0
	li	t1,0
.L98:
	add	a7,a6,s8
	mv	a5,a7
	j	.L97
.L129:
	slli	a0,a0,16
	addi	a5,a5,4
	srai	a0,a0,16
	beq	a6,a5,.L128
.L97:
	mv	a3,a4
	lw	a4,0(a5)
	slli	a0,a0,16
	srli	a0,a0,16
	sgt	a3,a4,a3
	add	a2,a2,a4
	addi	a1,a0,10
	add	a0,a0,a3
	ble	a2,s2,.L129
	slli	a0,a1,16
	addi	a5,a5,4
	srai	a0,a0,16
	li	a2,0
	bne	a6,a5,.L97
.L128:
	addi	a5,t1,1
	sub	a6,a7,s9
	beq	t1,s5,.L130
	mv	t1,a5
	j	.L98
.L130:
	mv	a1,s7
	call	crc16
	mv	a5,a0
	mv	a3,s1
	mv	a2,s0
	mv	a0,s10
	mv	a1,s6
	mv	s1,a5
	call	matrix_mul_matrix_bitextract
	li	a0,0
	li	a4,0
	li	a2,0
	li	a7,0
.L102:
	add	a6,s4,s8
	mv	a5,a6
	j	.L101
.L132:
	slli	a0,a0,16
	addi	a5,a5,4
	srai	a0,a0,16
	beq	s4,a5,.L131
.L101:
	mv	a3,a4
	lw	a4,0(a5)
	slli	a0,a0,16
	srli	a0,a0,16
	sgt	a3,a4,a3
	add	a2,a2,a4
	addi	a1,a0,10
	add	a0,a0,a3
	ble	a2,s2,.L132
	slli	a0,a1,16
	addi	a5,a5,4
	srai	a0,a0,16
	li	a2,0
	bne	s4,a5,.L101
.L131:
	addi	a5,a7,1
	sub	s4,a6,s9
	beq	a7,s5,.L133
	mv	a7,a5
	j	.L102
.L133:
	mv	a1,s1
	call	crc16
	slli	s10,s10,1
	add	s0,s0,s10
	li	a2,0
.L103:
	sub	a3,s0,s10
	mv	a5,a3
.L104:
	lhu	a4,0(a5)
	addi	a5,a5,2
	sub	a4,a4,s3
	sh	a4,-2(a5)
	bne	a5,s0,.L104
	addi	a5,a2,1
	sub	s0,a3,s8
	beq	a2,s5,.L105
	mv	a2,a5
	j	.L103
.L80:
	li	a1,0
	call	crc16
	mv	a2,s0
	mv	s2,a0
	mv	a3,s1
	li	a0,0
	mv	a1,s6
	call	matrix_mul_vect
	mv	a1,s2
	li	a0,0
	call	crc16
	mv	a2,s0
	mv	a3,s1
	mv	s2,a0
	mv	a1,s6
	li	a0,0
	call	matrix_mul_matrix
	mv	a1,s2
	li	a0,0
	call	crc16
	mv	a5,a0
	mv	a2,s0
	li	a0,0
	mv	a1,s6
	mv	a3,s1
	mv	s0,a5
	call	matrix_mul_matrix_bitextract
	mv	a1,s0
	li	a0,0
	call	crc16
.L105:
	lw	ra,60(sp)
	lw	s0,56(sp)
	slli	a0,a0,16
	lw	s1,52(sp)
	lw	s2,48(sp)
	lw	s3,44(sp)
	lw	s4,40(sp)
	lw	s5,36(sp)
	lw	s6,32(sp)
	lw	s7,28(sp)
	lw	s8,24(sp)
	lw	s9,20(sp)
	lw	s10,16(sp)
	lw	s11,12(sp)
	srai	a0,a0,16
	addi	sp,sp,64
	jr	ra
	.size	matrix_test, .-matrix_test
	.section	.text.core_bench_matrix,"ax",@progbits
	.align	1
	.globl	core_bench_matrix
	.type	core_bench_matrix, @function
core_bench_matrix:
	addi	sp,sp,-16
	sw	s0,8(sp)
	lw	a3,8(a0)
	mv	s0,a2
	mv	a4,a1
	lw	a2,4(a0)
	lw	a1,12(a0)
	lw	a0,0(a0)
	sw	ra,12(sp)
	call	matrix_test
	mv	a1,s0
	lw	s0,8(sp)
	lw	ra,12(sp)
	addi	sp,sp,16
	tail	crc16
	.size	core_bench_matrix, .-core_bench_matrix
	.ident	"GCC: (g2ee5e430018) 12.2.0"
