	.file	"core_list_join.c"
	.option nopic
	.attribute arch, "rv32i2p0_m2p0_c2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.section	.text.cmp_idx,"ax",@progbits
	.align	1
	.globl	cmp_idx
	.type	cmp_idx, @function
cmp_idx:
	beq	a2,zero,.L4
	lh	a0,2(a0)
	lh	a5,2(a1)
	sub	a0,a0,a5
	ret
.L4:
	lh	a5,0(a0)
	slli	a4,a5,16
	srli	a4,a4,16
	srli	a4,a4,8
	andi	a5,a5,-256
	or	a5,a5,a4
	sh	a5,0(a0)
	lh	a5,0(a1)
	lh	a0,2(a0)
	slli	a4,a5,16
	srli	a4,a4,16
	srli	a4,a4,8
	andi	a5,a5,-256
	or	a5,a5,a4
	sh	a5,0(a1)
	lh	a5,2(a1)
	sub	a0,a0,a5
	ret
	.size	cmp_idx, .-cmp_idx
	.section	.text.calc_func,"ax",@progbits
	.align	1
	.globl	calc_func
	.type	calc_func, @function
calc_func:
	addi	sp,sp,-32
	sw	s0,24(sp)
	lh	s0,0(a0)
	sw	ra,28(sp)
	sw	s1,20(sp)
	srai	a5,s0,7
	sw	s2,16(sp)
	sw	s3,12(sp)
	andi	a5,a5,1
	beq	a5,zero,.L6
	lw	ra,28(sp)
	andi	a0,s0,127
	lw	s0,24(sp)
	lw	s1,20(sp)
	lw	s2,16(sp)
	lw	s3,12(sp)
	addi	sp,sp,32
	jr	ra
.L6:
	srai	a4,s0,3
	andi	a4,a4,15
	mv	s1,a1
	andi	a3,s0,7
	slli	a1,a4,4
	lhu	a5,56(s1)
	mv	s3,a0
	or	a1,a1,a4
	beq	a3,zero,.L8
	li	a4,1
	beq	a3,a4,.L9
	slli	a0,s0,16
	srli	a0,a0,16
	mv	s2,s0
.L10:
	mv	a1,a5
	call	crcu16
	mv	a5,a0
	andi	s0,s0,-256
	andi	a0,s2,127
	or	s0,a0,s0
	sh	a5,56(s1)
	ori	s0,s0,128
	sh	s0,0(s3)
	lw	ra,28(sp)
	lw	s0,24(sp)
	lw	s1,20(sp)
	lw	s2,16(sp)
	lw	s3,12(sp)
	addi	sp,sp,32
	jr	ra
.L8:
	li	a3,34
	mv	a4,a1
	bge	a1,a3,.L11
	li	a4,34
.L11:
	lh	a3,2(s1)
	lh	a2,0(s1)
	lw	a1,20(s1)
	lw	a0,24(s1)
	andi	a4,a4,0xff
	call	core_bench_state
	lhu	a5,62(s1)
	bne	a5,zero,.L15
	sh	a0,62(s1)
.L15:
	slli	s2,a0,16
	lhu	a5,56(s1)
	srai	s2,s2,16
	j	.L10
.L9:
	mv	a2,a5
	addi	a0,s1,40
	call	core_bench_matrix
	lhu	a5,60(s1)
	bne	a5,zero,.L15
	sh	a0,60(s1)
	j	.L15
	.size	calc_func, .-calc_func
	.section	.text.cmp_complex,"ax",@progbits
	.align	1
	.globl	cmp_complex
	.type	cmp_complex, @function
cmp_complex:
	addi	sp,sp,-16
	sw	s1,4(sp)
	mv	s1,a1
	mv	a1,a2
	sw	ra,12(sp)
	sw	s0,8(sp)
	mv	s0,a2
	call	calc_func
	mv	a5,a0
	mv	a1,s0
	mv	a0,s1
	mv	s0,a5
	call	calc_func
	lw	ra,12(sp)
	sub	a0,s0,a0
	lw	s0,8(sp)
	lw	s1,4(sp)
	addi	sp,sp,16
	jr	ra
	.size	cmp_complex, .-cmp_complex
	.section	.text.copy_info,"ax",@progbits
	.align	1
	.globl	copy_info
	.type	copy_info, @function
copy_info:
	lh	a4,0(a1)
	lh	a5,2(a1)
	sh	a4,0(a0)
	sh	a5,2(a0)
	ret
	.size	copy_info, .-copy_info
	.section	.text.core_list_insert_new,"ax",@progbits
	.align	1
	.globl	core_list_insert_new
	.type	core_list_insert_new, @function
core_list_insert_new:
	lw	a6,0(a2)
	addi	a7,a6,8
	bgeu	a7,a4,.L23
	lw	a4,0(a3)
	addi	t1,a4,4
	bleu	a5,t1,.L23
	sw	a7,0(a2)
	lw	a5,0(a0)
	lh	a7,0(a1)
	lh	a2,2(a1)
	sw	a5,0(a6)
	sw	a6,0(a0)
	sw	a4,4(a6)
	lw	a5,0(a3)
	mv	a0,a6
	addi	a5,a5,4
	sw	a5,0(a3)
	lw	a5,4(a6)
	sh	a7,0(a5)
	sh	a2,2(a5)
	ret
.L23:
	li	a6,0
	mv	a0,a6
	ret
	.size	core_list_insert_new, .-core_list_insert_new
	.section	.text.core_list_remove,"ax",@progbits
	.align	1
	.globl	core_list_remove
	.type	core_list_remove, @function
core_list_remove:
	mv	a5,a0
	lw	a0,0(a0)
	lw	a3,4(a5)
	lw	a2,4(a0)
	lw	a4,0(a0)
	sw	a2,4(a5)
	sw	a3,4(a0)
	sw	a4,0(a5)
	sw	zero,0(a0)
	ret
	.size	core_list_remove, .-core_list_remove
	.section	.text.core_list_undo_remove,"ax",@progbits
	.align	1
	.globl	core_list_undo_remove
	.type	core_list_undo_remove, @function
core_list_undo_remove:
	lw	a2,4(a1)
	lw	a3,4(a0)
	lw	a4,0(a1)
	sw	a2,4(a0)
	sw	a3,4(a1)
	sw	a4,0(a0)
	sw	a0,0(a1)
	ret
	.size	core_list_undo_remove, .-core_list_undo_remove
	.section	.text.core_list_find,"ax",@progbits
	.align	1
	.globl	core_list_find
	.type	core_list_find, @function
core_list_find:
	lh	a4,2(a1)
	blt	a4,zero,.L39
	bne	a0,zero,.L30
	j	.L40
.L31:
	lw	a0,0(a0)
	beq	a0,zero,.L34
.L30:
	lw	a5,4(a0)
	lh	a5,2(a5)
	bne	a5,a4,.L31
	ret
.L39:
	beq	a0,zero,.L34
	lh	a4,0(a1)
	j	.L29
.L32:
	lw	a0,0(a0)
	beq	a0,zero,.L26
.L29:
	lw	a5,4(a0)
	lbu	a5,0(a5)
	bne	a5,a4,.L32
	ret
.L34:
	li	a0,0
.L26:
	ret
.L40:
	ret
	.size	core_list_find, .-core_list_find
	.section	.text.core_list_reverse,"ax",@progbits
	.align	1
	.globl	core_list_reverse
	.type	core_list_reverse, @function
core_list_reverse:
	beq	a0,zero,.L42
	li	a4,0
	j	.L43
.L44:
	mv	a0,a5
.L43:
	lw	a5,0(a0)
	sw	a4,0(a0)
	mv	a4,a0
	bne	a5,zero,.L44
.L42:
	ret
	.size	core_list_reverse, .-core_list_reverse
	.section	.text.core_list_mergesort,"ax",@progbits
	.align	1
	.globl	core_list_mergesort
	.type	core_list_mergesort, @function
core_list_mergesort:
	addi	sp,sp,-48
	sw	s3,28(sp)
	sw	s5,20(sp)
	sw	s7,12(sp)
	sw	s8,8(sp)
	sw	s10,0(sp)
	sw	ra,44(sp)
	sw	s0,40(sp)
	sw	s1,36(sp)
	sw	s2,32(sp)
	sw	s4,24(sp)
	sw	s6,16(sp)
	sw	s9,4(sp)
	mv	s3,a0
	mv	s8,a1
	mv	s7,a2
	li	s5,1
	li	s10,1
	beq	s3,zero,.L49
.L79:
	li	s9,0
	li	s1,0
	li	s6,0
.L63:
	addi	s9,s9,1
	mv	a5,s3
	li	s0,0
.L52:
	lw	a5,0(a5)
	addi	s0,s0,1
	beq	a5,zero,.L53
	bne	s5,s0,.L52
.L53:
	mv	s2,s3
	mv	s4,s5
	mv	s3,a5
	ble	s0,zero,.L75
.L59:
	bne	s4,zero,.L76
.L74:
	mv	a5,s2
	lw	s2,0(s2)
	addi	s0,s0,-1
.L55:
	beq	s1,zero,.L66
.L77:
	sw	a5,0(s1)
	mv	s1,a5
.L78:
	bgt	s0,zero,.L59
.L75:
	ble	s4,zero,.L60
	beq	s3,zero,.L62
	bne	s0,zero,.L54
	mv	a5,s3
	addi	s4,s4,-1
	lw	s3,0(s3)
	bne	s1,zero,.L77
.L66:
	mv	s6,a5
	mv	s1,a5
	j	.L78
.L76:
	beq	s3,zero,.L74
.L54:
	lw	a1,4(s3)
	lw	a0,4(s2)
	mv	a2,s7
	jalr	s8
	ble	a0,zero,.L74
	mv	a5,s3
	addi	s4,s4,-1
	lw	s3,0(s3)
	j	.L55
.L60:
	bne	s3,zero,.L63
.L62:
	sw	zero,0(s1)
	beq	s9,s10,.L72
	mv	s3,s6
	slli	s5,s5,1
	bne	s3,zero,.L79
.L49:
	sw	zero,0(zero)
	ebreak
.L72:
	lw	ra,44(sp)
	lw	s0,40(sp)
	lw	s1,36(sp)
	lw	s2,32(sp)
	lw	s3,28(sp)
	lw	s4,24(sp)
	lw	s5,20(sp)
	lw	s7,12(sp)
	lw	s8,8(sp)
	lw	s9,4(sp)
	lw	s10,0(sp)
	mv	a0,s6
	lw	s6,16(sp)
	addi	sp,sp,48
	jr	ra
	.size	core_list_mergesort, .-core_list_mergesort
	.section	.text.core_bench_list,"ax",@progbits
	.align	1
	.globl	core_bench_list
	.type	core_bench_list, @function
core_bench_list:
	mv	a2,a0
	lh	a0,4(a0)
	addi	sp,sp,-32
	sw	s0,24(sp)
	sw	s1,20(sp)
	sw	ra,28(sp)
	sw	s2,16(sp)
	sw	s3,12(sp)
	sw	s4,8(sp)
	sw	s5,4(sp)
	lw	s0,36(a2)
	mv	s1,a1
	ble	a0,zero,.L108
	li	a7,0
	li	t3,0
	li	t1,0
	li	a6,0
.L95:
	andi	s4,a7,0xff
	blt	s1,zero,.L141
	beq	s0,zero,.L84
	mv	a5,s0
	j	.L85
.L87:
	lw	a5,0(a5)
	beq	a5,zero,.L86
.L85:
	lw	a4,4(a5)
	lh	a4,2(a4)
	bne	a4,s1,.L87
.L86:
	li	a3,0
	j	.L89
.L111:
	mv	s0,a4
.L89:
	lw	a4,0(s0)
	sw	a3,0(s0)
	mv	a3,s0
	bne	a4,zero,.L111
	beq	a5,zero,.L142
	lw	a4,4(a5)
	lh	a4,0(a4)
	andi	a3,a4,1
	beq	a3,zero,.L92
	srai	a4,a4,9
	andi	a4,a4,1
	add	a4,a6,a4
	slli	a6,a4,16
	srli	a6,a6,16
.L92:
	lw	a4,0(a5)
	beq	a4,zero,.L93
	lw	a3,0(a4)
	sw	a3,0(a5)
	lw	a5,0(s0)
	sw	a5,0(a4)
	sw	a4,0(s0)
.L93:
	addi	t1,t1,1
	slli	t1,t1,16
	srli	t1,t1,16
.L91:
	blt	s1,zero,.L94
	addi	s1,s1,1
	slli	s1,s1,16
	srai	s1,s1,16
.L94:
	addi	a7,a7,1
	slli	a7,a7,16
	srai	a7,a7,16
	bne	a0,a7,.L95
	slli	a5,t1,2
	sub	a5,a5,t3
	add	a6,a6,a5
	slli	s2,a6,16
	srli	s2,s2,16
.L81:
	ble	a1,zero,.L96
	mv	a0,s0
	lla	a1,cmp_complex
	call	core_list_mergesort
	mv	s0,a0
.L96:
	lw	a5,0(s0)
	mv	s3,s0
	lw	s5,0(a5)
	lw	a4,4(a5)
	lw	a2,4(s5)
	lw	a3,0(s5)
	sw	a2,4(a5)
	sw	a4,4(s5)
	sw	a3,0(a5)
	sw	zero,0(s5)
	bge	s1,zero,.L97
	j	.L98
.L100:
	lw	s3,0(s3)
	beq	s3,zero,.L99
.L97:
	lw	a5,4(s3)
	lh	a5,2(a5)
	bne	a5,s1,.L100
.L103:
	lw	a5,4(s0)
	mv	a1,s2
	lh	a0,0(a5)
	call	crc16
	lw	s3,0(s3)
	mv	s2,a0
	bne	s3,zero,.L103
.L143:
	lw	s3,0(s0)
	lw	a4,4(s5)
.L107:
	lw	a3,4(s3)
	lw	a5,0(s3)
	mv	a0,s0
	sw	a3,4(s5)
	sw	a4,4(s3)
	sw	a5,0(s5)
	li	a2,0
	sw	s5,0(s3)
	lla	a1,cmp_idx
	call	core_list_mergesort
	lw	s0,0(a0)
	mv	s1,a0
	beq	s0,zero,.L113
.L105:
	lw	a5,4(s1)
	mv	a1,s2
	lh	a0,0(a5)
	call	crc16
	lw	s0,0(s0)
	mv	s2,a0
	bne	s0,zero,.L105
.L113:
	lw	ra,28(sp)
	lw	s0,24(sp)
	lw	s1,20(sp)
	lw	s3,12(sp)
	lw	s4,8(sp)
	lw	s5,4(sp)
	mv	a0,s2
	lw	s2,16(sp)
	addi	sp,sp,32
	jr	ra
.L102:
	lw	s3,0(s3)
	beq	s3,zero,.L99
.L98:
	lw	a5,4(s3)
	lbu	a5,0(a5)
	bne	s4,a5,.L102
	j	.L103
.L141:
	beq	s0,zero,.L84
	mv	a5,s0
	j	.L83
.L88:
	lw	a5,0(a5)
	beq	a5,zero,.L86
.L83:
	lw	a4,4(a5)
	lbu	a4,0(a4)
	bne	s4,a4,.L88
	j	.L86
.L142:
	lw	a5,0(s0)
	addi	t3,t3,1
	slli	t3,t3,16
	lw	a5,4(a5)
	srli	t3,t3,16
	lb	a5,1(a5)
	andi	a5,a5,1
	add	a5,a6,a5
	slli	a6,a5,16
	srli	a6,a6,16
	j	.L91
.L99:
	lw	s3,0(s0)
	beq	s3,zero,.L107
	lw	a5,4(s0)
	mv	a1,s2
	lh	a0,0(a5)
	call	crc16
	lw	s3,0(s3)
	mv	s2,a0
	bne	s3,zero,.L103
	j	.L143
.L108:
	li	s2,0
	li	s4,0
	j	.L81
.L84:
	lw	a5,0(zero)
	ebreak
	.size	core_bench_list, .-core_bench_list
	.section	.text.core_list_init,"ax",@progbits
	.align	1
	.globl	core_list_init
	.type	core_list_init, @function
core_list_init:
	li	a5,20
	divu	t3,a0,a5
	li	a5,-32768
	sw	zero,0(a1)
	addi	a4,a5,128
	addi	a3,a1,16
	mv	a0,a1
	addi	t1,a1,8
	addi	t3,t3,-2
	slli	t5,t3,3
	add	t5,a1,t5
	sw	t5,4(a1)
	slli	t6,t3,2
	sh	a4,0(t5)
	sh	zero,2(t5)
	add	t6,t5,t6
	addi	a4,t5,4
	bleu	t5,a3,.L155
	addi	a7,t5,8
	bleu	t6,a7,.L155
	sw	a4,12(a1)
	sw	zero,8(a1)
	sw	t1,0(a1)
	not	a5,a5
	li	a4,-1
	sh	a4,4(t5)
	sh	a5,6(t5)
.L145:
	beq	t3,zero,.L146
	slli	t0,a2,16
	li	t2,-32768
	srli	t0,t0,16
	li	a6,0
	xori	t2,t2,-1
.L148:
	slli	a4,a6,16
	srli	a4,a4,16
	xor	a5,t0,a4
	slli	a5,a5,3
	andi	a4,a4,7
	andi	a5,a5,120
	or	a5,a5,a4
	slli	a4,a5,8
	addi	a1,a3,8
	addi	a6,a6,1
	addi	t4,a7,4
	or	a4,a4,a5
	bleu	t5,a1,.L147
	bleu	t6,t4,.L147
	sw	t1,0(a3)
	sw	a3,0(a0)
	sw	a7,4(a3)
	sh	a4,0(a7)
	sh	t2,2(a7)
	mv	t1,a3
	mv	a7,t4
	mv	a3,a1
.L147:
	bne	t3,a6,.L148
.L146:
	lw	a6,0(t1)
	beq	a6,zero,.L153
	li	a5,5
	li	t4,16384
	divu	t3,t3,a5
	li	a4,512
	li	a3,1
	addi	t4,t4,-1
	j	.L152
.L161:
	slli	a5,a3,16
	lw	a7,0(a6)
	srai	a5,a5,16
	addi	a4,a4,256
	slli	a4,a4,16
	sh	a5,2(a1)
	mv	t1,a6
	addi	a3,a3,1
	srli	a4,a4,16
	beq	a7,zero,.L153
.L156:
	mv	a6,a7
.L152:
	xor	a1,a3,a2
	andi	a5,a4,1792
	or	a5,a5,a1
	and	a5,a5,t4
	lw	a1,4(t1)
	bgtu	t3,a3,.L161
	lw	a7,0(a6)
	slli	a5,a5,16
	srai	a5,a5,16
	addi	a4,a4,256
	slli	a4,a4,16
	sh	a5,2(a1)
	mv	t1,a6
	addi	a3,a3,1
	srli	a4,a4,16
	bne	a7,zero,.L156
.L153:
	li	a2,0
	lla	a1,cmp_idx
	tail	core_list_mergesort
.L155:
	mv	a3,t1
	mv	a7,a4
	li	t1,0
	j	.L145
	.size	core_list_init, .-core_list_init
	.ident	"GCC: (g2ee5e430018) 12.2.0"
