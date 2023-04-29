	.file	"core_state.c"
	.option nopic
	.attribute arch, "rv32i2p0_m2p0_c2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.section	.text.core_init_state,"ax",@progbits
	.align	1
	.globl	core_init_state
	.type	core_init_state, @function
core_init_state:
	addi	a6,a0,-1
	li	a5,1
	bleu	a6,a5,.L12
	addi	a1,a1,1
	slli	a1,a1,16
	srli	a1,a1,16
	addi	sp,sp,-16
	srli	a5,a1,3
	sw	s0,12(sp)
	li	t3,7
	andi	a3,a1,7
	li	a4,0
	lla	t4,.LANCHOR0
	li	t1,4
	li	a7,1
	li	t5,44
	andi	a5,a5,3
	beq	a3,t3,.L5
.L23:
	bgtu	a3,t1,.L6
	addi	a3,a3,-3
	slli	a3,a3,16
	slli	a5,a5,2
	srli	a3,a3,16
	add	a5,t4,a5
	bgtu	a3,a7,.L22
	lw	a5,16(a5)
	li	t0,8
.L8:
	addi	a3,a4,1
	add	s0,a3,t0
	bgeu	s0,a6,.L9
.L24:
	add	a4,a2,a4
	mv	a3,a4
	add	t2,a5,t0
.L4:
	lbu	t6,0(a5)
	addi	a5,a5,1
	addi	a3,a3,1
	sb	t6,-1(a3)
	bne	t2,a5,.L4
	addi	a1,a1,1
	slli	a1,a1,16
	add	a4,a4,t0
	srli	a1,a1,16
	sb	t5,0(a4)
	srli	a5,a1,3
	andi	a3,a1,7
	mv	a4,s0
	andi	a5,a5,3
	bne	a3,t3,.L23
.L5:
	slli	a5,a5,2
	li	t0,8
	addi	a3,a4,1
	add	a5,t4,a5
	add	s0,a3,t0
	lw	a5,48(a5)
	bltu	s0,a6,.L24
.L9:
	bltu	a4,a0,.L10
	j	.L1
.L25:
	addi	a3,a3,1
.L10:
	add	a4,a2,a4
	sb	zero,0(a4)
	mv	a4,a3
	bgtu	a0,a3,.L25
.L1:
	lw	s0,12(sp)
	addi	sp,sp,16
	jr	ra
.L22:
	lw	a5,0(a5)
	li	t0,4
	j	.L8
.L6:
	slli	a5,a5,2
	add	a5,t4,a5
	lw	a5,32(a5)
	li	t0,8
	j	.L8
.L12:
	li	a4,0
	li	a3,1
	j	.L16
.L26:
	addi	a3,a3,1
.L16:
	add	a4,a2,a4
	sb	zero,0(a4)
	mv	a4,a3
	bgtu	a0,a3,.L26
	ret
	.size	core_init_state, .-core_init_state
	.section	.text.core_state_transition,"ax",@progbits
	.align	1
	.globl	core_state_transition
	.type	core_state_transition, @function
core_state_transition:
	lw	a4,0(a0)
	mv	a2,a0
	lbu	a3,0(a4)
	beq	a3,zero,.L53
	li	a5,44
	li	a0,0
	beq	a3,a5,.L34
	addi	a0,a3,-48
	andi	a0,a0,0xff
	li	a6,9
	bleu	a0,a6,.L30
	li	a0,45
	beq	a3,a0,.L33
	li	a0,46
	beq	a3,a0,.L32
	li	a0,43
	beq	a3,a0,.L33
	lw	a3,4(a1)
	lw	a5,0(a1)
	addi	a4,a4,1
	addi	a3,a3,1
	addi	a5,a5,1
	sw	a3,4(a1)
	sw	a5,0(a1)
	li	a0,1
	sw	a4,0(a2)
	ret
.L30:
	lw	a0,0(a1)
	addi	a3,a4,1
	addi	a0,a0,1
	sw	a0,0(a1)
	lbu	a4,1(a4)
	beq	a4,zero,.L62
.L78:
	beq	a4,a5,.L82
	li	a5,46
	beq	a4,a5,.L83
	addi	a4,a4,-48
	andi	a4,a4,0xff
	li	a5,9
	bgtu	a4,a5,.L84
.L43:
	lbu	a4,1(a3)
	addi	a3,a3,1
	beq	a4,zero,.L62
	li	a5,44
	j	.L78
.L84:
	lw	a5,16(a1)
	addi	a4,a3,1
	li	a0,1
	addi	a5,a5,1
	sw	a5,16(a1)
.L28:
	sw	a4,0(a2)
	ret
.L32:
	lw	a0,0(a1)
	addi	a3,a4,1
	addi	a0,a0,1
	sw	a0,0(a1)
	lbu	a4,1(a4)
	beq	a4,zero,.L66
.L80:
	beq	a4,a5,.L85
	andi	a5,a4,223
	li	a0,69
	beq	a5,a0,.L86
	addi	a4,a4,-48
	andi	a4,a4,0xff
	li	a5,9
	bgtu	a4,a5,.L46
.L41:
	lbu	a4,1(a3)
	addi	a3,a3,1
	beq	a4,zero,.L66
	li	a5,44
	j	.L80
.L86:
	lw	a5,20(a1)
	addi	a4,a3,1
	addi	a5,a5,1
	sw	a5,20(a1)
	lbu	a5,1(a3)
	beq	a5,zero,.L64
	li	a0,44
	beq	a5,a0,.L87
	lw	a4,12(a1)
	addi	a5,a5,-43
	andi	a5,a5,253
	addi	a4,a4,1
	sw	a4,12(a1)
	beq	a5,zero,.L88
	addi	a4,a3,2
	li	a0,1
	sw	a4,0(a2)
	ret
.L88:
	lbu	a5,2(a3)
	addi	a4,a3,2
	beq	a5,zero,.L68
	beq	a5,a0,.L89
	lw	a0,24(a1)
	addi	a5,a5,-48
	andi	a5,a5,0xff
	addi	a0,a0,1
	li	a6,9
	sw	a0,24(a1)
	bleu	a5,a6,.L49
	addi	a4,a3,3
	li	a0,1
	sw	a4,0(a2)
	ret
.L49:
	li	a0,9
.L50:
	lbu	a3,1(a4)
	mv	a6,a4
	li	a7,44
	addi	a5,a3,-48
	addi	a4,a4,1
	andi	a5,a5,0xff
	beq	a3,zero,.L70
	beq	a3,a7,.L90
	bleu	a5,a0,.L50
	lw	a5,4(a1)
	addi	a4,a6,2
	li	a0,1
	addi	a5,a5,1
	sw	a5,4(a1)
	j	.L28
.L83:
	lw	a5,16(a1)
	addi	a5,a5,1
	sw	a5,16(a1)
	j	.L41
.L82:
	mv	a4,a3
	li	a0,4
.L34:
	addi	a4,a4,1
	j	.L28
.L46:
	lw	a5,20(a1)
	addi	a4,a3,1
	li	a0,1
	addi	a5,a5,1
	sw	a5,20(a1)
	j	.L28
.L33:
	lw	a0,0(a1)
	addi	a3,a4,1
	addi	a0,a0,1
	sw	a0,0(a1)
	lbu	a6,1(a4)
	beq	a6,zero,.L60
	beq	a6,a5,.L61
	lw	a4,8(a1)
	addi	a5,a6,-48
	andi	a5,a5,0xff
	li	a0,9
	addi	a4,a4,1
	bleu	a5,a0,.L38
	li	a5,46
	beq	a6,a5,.L91
	sw	a4,8(a1)
	li	a0,1
	addi	a4,a3,1
	j	.L28
.L38:
	sw	a4,8(a1)
	j	.L43
.L91:
	sw	a4,8(a1)
	j	.L41
.L62:
	mv	a4,a3
	li	a0,4
	j	.L28
.L66:
	mv	a4,a3
	li	a0,5
	j	.L28
.L53:
	li	a0,0
	j	.L28
.L68:
	li	a0,6
	j	.L28
.L64:
	li	a0,3
	j	.L28
.L87:
	li	a0,3
	addi	a4,a4,1
	j	.L28
.L89:
	li	a0,6
	addi	a4,a4,1
	j	.L28
.L90:
	li	a0,7
	addi	a4,a4,1
	j	.L28
.L70:
	li	a0,7
	j	.L28
.L85:
	mv	a4,a3
	li	a0,5
	addi	a4,a4,1
	j	.L28
.L61:
	mv	a4,a3
	li	a0,2
	addi	a4,a4,1
	j	.L28
.L60:
	mv	a4,a3
	li	a0,2
	j	.L28
	.size	core_state_transition, .-core_state_transition
	.section	.text.core_bench_state,"ax",@progbits
	.align	1
	.globl	core_bench_state
	.type	core_bench_state, @function
core_bench_state:
	addi	sp,sp,-128
	sw	s1,116(sp)
	sw	s3,108(sp)
	addi	s1,sp,16
	addi	s3,sp,48
	sw	s0,120(sp)
	sw	s2,112(sp)
	sw	s4,104(sp)
	sw	s6,96(sp)
	sw	s7,92(sp)
	sw	s8,88(sp)
	mv	s6,a3
	mv	s4,a4
	mv	s2,a5
	sw	ra,124(sp)
	sw	s5,100(sp)
	mv	s0,a1
	mv	s8,a0
	mv	s7,a2
	sw	a1,12(sp)
	addi	a3,sp,80
	mv	a4,s1
	mv	a5,s3
.L93:
	sw	zero,0(a5)
	sw	zero,0(a4)
	addi	a5,a5,4
	addi	a4,a4,4
	bne	a5,a3,.L93
	lbu	a5,0(s0)
	addi	s5,sp,12
	beq	a5,zero,.L120
.L94:
	addi	a1,sp,48
	mv	a0,s5
	call	core_state_transition
	slli	a6,a0,2
	addi	a5,a6,80
	add	a6,a5,sp
	lw	a4,12(sp)
	lw	a5,-64(a6)
	lbu	a4,0(a4)
	addi	a5,a5,1
	sw	a5,-64(a6)
	bne	a4,zero,.L94
	sw	s0,12(sp)
	add	s8,s0,s8
	bgeu	s0,s8,.L102
.L95:
	mv	a5,s0
	li	a2,44
.L100:
	lbu	a4,0(a5)
	xor	a3,a4,s7
	beq	a4,a2,.L99
	sb	a3,0(a5)
.L99:
	add	a5,a5,s4
	bgtu	s8,a5,.L100
	lbu	a5,0(s0)
	addi	s5,sp,12
	beq	a5,zero,.L103
.L102:
	addi	a1,sp,48
	mv	a0,s5
	call	core_state_transition
	slli	a2,a0,2
	addi	a5,a2,80
	add	a2,a5,sp
	lw	a4,12(sp)
	lw	a5,-64(a2)
	lbu	a4,0(a4)
	addi	a5,a5,1
	sw	a5,-64(a2)
	bne	a4,zero,.L102
.L103:
	sw	s0,12(sp)
	li	a3,44
	bgeu	s0,s8,.L104
.L106:
	lbu	a5,0(s0)
	xor	a4,a5,s6
	beq	a5,a3,.L105
	sb	a4,0(s0)
.L105:
	add	s0,s0,s4
	bgtu	s8,s0,.L106
.L104:
	addi	s0,s1,32
.L107:
	lw	a0,0(s1)
	mv	a1,s2
	addi	s1,s1,4
	call	crcu32
	mv	a1,a0
	lw	a0,0(s3)
	addi	s3,s3,4
	call	crcu32
	mv	s2,a0
	bne	s0,s1,.L107
	lw	ra,124(sp)
	lw	s0,120(sp)
	lw	s1,116(sp)
	lw	s2,112(sp)
	lw	s3,108(sp)
	lw	s4,104(sp)
	lw	s5,100(sp)
	lw	s6,96(sp)
	lw	s7,92(sp)
	lw	s8,88(sp)
	addi	sp,sp,128
	jr	ra
.L120:
	add	s8,s0,s8
	bltu	s0,s8,.L95
	j	.L104
	.size	core_bench_state, .-core_bench_state
	.section	.rodata.str1.4,"aMS",@progbits,1
	.align	2
.LC0:
	.string	"T0.3e-1F"
	.align	2
.LC1:
	.string	"-T.T++Tq"
	.align	2
.LC2:
	.string	"1T3.4e4z"
	.align	2
.LC3:
	.string	"34.0e-T^"
	.align	2
.LC4:
	.string	"5.500e+3"
	.align	2
.LC5:
	.string	"-.123e-2"
	.align	2
.LC6:
	.string	"-87e+832"
	.align	2
.LC7:
	.string	"+0.6e-12"
	.align	2
.LC8:
	.string	"35.54400"
	.align	2
.LC9:
	.string	".1234500"
	.align	2
.LC10:
	.string	"-110.700"
	.align	2
.LC11:
	.string	"+0.64400"
	.align	2
.LC12:
	.string	"5012"
	.align	2
.LC13:
	.string	"1234"
	.align	2
.LC14:
	.string	"-874"
	.align	2
.LC15:
	.string	"+122"
	.section	.rodata
	.align	2
	.set	.LANCHOR0,. + 0
	.type	intpat, @object
	.size	intpat, 16
intpat:
	.word	.LC12
	.word	.LC13
	.word	.LC14
	.word	.LC15
	.type	floatpat, @object
	.size	floatpat, 16
floatpat:
	.word	.LC8
	.word	.LC9
	.word	.LC10
	.word	.LC11
	.type	scipat, @object
	.size	scipat, 16
scipat:
	.word	.LC4
	.word	.LC5
	.word	.LC6
	.word	.LC7
	.type	errpat, @object
	.size	errpat, 16
errpat:
	.word	.LC0
	.word	.LC1
	.word	.LC2
	.word	.LC3
	.ident	"GCC: (g2ee5e430018) 12.2.0"
