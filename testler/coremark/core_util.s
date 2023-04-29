	.file	"core_util.c"
	.option nopic
	.attribute arch, "rv32i2p0_m2p0_c2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.section	.text.get_seed_32,"ax",@progbits
	.align	1
	.globl	get_seed_32
	.type	get_seed_32, @function
get_seed_32:
	li	a5,5
	bgtu	a0,a5,.L9
	lla	a4,.L4
	slli	a0,a0,2
	add	a0,a0,a4
	lw	a5,0(a0)
	add	a5,a5,a4
	jr	a5
	.section	.rodata
	.align	2
	.align	2
.L4:
	.word	.L9-.L4
	.word	.L8-.L4
	.word	.L7-.L4
	.word	.L6-.L4
	.word	.L5-.L4
	.word	.L3-.L4
	.section	.text.get_seed_32
.L3:
	lw	a0,seed5_volatile
	ret
.L8:
	lw	a0,seed1_volatile
	ret
.L7:
	lw	a0,seed2_volatile
	ret
.L6:
	lw	a0,seed3_volatile
	ret
.L5:
	lw	a0,seed4_volatile
	ret
.L9:
	li	a0,0
	ret
	.size	get_seed_32, .-get_seed_32
	.section	.text.crcu8,"ax",@progbits
	.align	1
	.globl	crcu8
	.type	crcu8, @function
crcu8:
	mv	a3,a0
	mv	a0,a1
	li	a1,-24576
	li	a5,8
	addi	a1,a1,1
.L13:
	xor	a4,a3,a0
	addi	a5,a5,-1
	srli	a0,a0,1
	andi	a4,a4,1
	andi	a5,a5,0xff
	xor	a2,a0,a1
	srli	a3,a3,1
	beq	a4,zero,.L12
	slli	a0,a2,16
	srli	a0,a0,16
.L12:
	bne	a5,zero,.L13
	ret
	.size	crcu8, .-crcu8
	.section	.text.crcu16,"ax",@progbits
	.align	1
	.globl	crcu16
	.type	crcu16, @function
crcu16:
	mv	a3,a0
	li	a6,-24576
	mv	a0,a1
	andi	a2,a3,0xff
	li	a5,8
	addi	a6,a6,1
.L20:
	xor	a4,a2,a0
	addi	a5,a5,-1
	srli	a0,a0,1
	andi	a4,a4,1
	andi	a5,a5,0xff
	xor	a1,a0,a6
	srli	a2,a2,1
	beq	a4,zero,.L19
	slli	a0,a1,16
	srli	a0,a0,16
.L19:
	bne	a5,zero,.L20
	li	a1,-24576
	srli	a3,a3,8
	li	a5,8
	addi	a1,a1,1
.L22:
	xor	a4,a3,a0
	addi	a5,a5,-1
	srli	a0,a0,1
	andi	a4,a4,1
	andi	a5,a5,0xff
	xor	a2,a0,a1
	srli	a3,a3,1
	beq	a4,zero,.L21
	slli	a0,a2,16
	srli	a0,a0,16
.L21:
	bne	a5,zero,.L22
	ret
	.size	crcu16, .-crcu16
	.section	.text.crcu32,"ax",@progbits
	.align	1
	.globl	crcu32
	.type	crcu32, @function
crcu32:
	mv	a4,a0
	slli	a2,a4,16
	li	a7,-24576
	mv	a0,a1
	srli	a2,a2,16
	andi	a1,a4,0xff
	li	a5,8
	addi	a7,a7,1
.L33:
	xor	a3,a1,a0
	addi	a5,a5,-1
	srli	a0,a0,1
	andi	a3,a3,1
	andi	a5,a5,0xff
	xor	a6,a0,a7
	srli	a1,a1,1
	beq	a3,zero,.L32
	slli	a0,a6,16
	srli	a0,a0,16
.L32:
	bne	a5,zero,.L33
	li	a6,-24576
	srli	a2,a2,8
	li	a5,8
	addi	a6,a6,1
.L35:
	xor	a3,a2,a0
	addi	a5,a5,-1
	srli	a0,a0,1
	andi	a3,a3,1
	andi	a5,a5,0xff
	xor	a1,a0,a6
	srli	a2,a2,1
	beq	a3,zero,.L34
	slli	a0,a1,16
	srli	a0,a0,16
.L34:
	bne	a5,zero,.L35
	srli	a2,a4,16
	li	a6,-24576
	mv	a4,a2
	li	a5,8
	andi	a2,a2,0xff
	addi	a6,a6,1
.L37:
	xor	a3,a2,a0
	addi	a5,a5,-1
	srli	a0,a0,1
	andi	a3,a3,1
	andi	a5,a5,0xff
	xor	a1,a0,a6
	srli	a2,a2,1
	beq	a3,zero,.L36
	slli	a0,a1,16
	srli	a0,a0,16
.L36:
	bne	a5,zero,.L37
	li	a1,-24576
	srli	a4,a4,8
	li	a5,8
	addi	a1,a1,1
.L39:
	xor	a3,a4,a0
	addi	a5,a5,-1
	srli	a0,a0,1
	andi	a3,a3,1
	andi	a5,a5,0xff
	xor	a2,a0,a1
	srli	a4,a4,1
	beq	a3,zero,.L38
	slli	a0,a2,16
	srli	a0,a0,16
.L38:
	bne	a5,zero,.L39
	ret
	.size	crcu32, .-crcu32
	.section	.text.crc16,"ax",@progbits
	.align	1
	.globl	crc16
	.type	crc16, @function
crc16:
	mv	a3,a0
	slli	a2,a3,16
	li	a6,-24576
	mv	a0,a1
	srli	a2,a2,16
	andi	a3,a3,0xff
	li	a5,8
	addi	a6,a6,1
.L58:
	xor	a4,a3,a0
	addi	a5,a5,-1
	srli	a0,a0,1
	andi	a4,a4,1
	andi	a5,a5,0xff
	xor	a1,a0,a6
	srli	a3,a3,1
	beq	a4,zero,.L57
	slli	a0,a1,16
	srli	a0,a0,16
.L57:
	bne	a5,zero,.L58
	li	a1,-24576
	srli	a3,a2,8
	li	a5,8
	addi	a1,a1,1
.L60:
	xor	a4,a3,a0
	addi	a5,a5,-1
	srli	a0,a0,1
	andi	a4,a4,1
	andi	a5,a5,0xff
	xor	a2,a0,a1
	srli	a3,a3,1
	beq	a4,zero,.L59
	slli	a0,a2,16
	srli	a0,a0,16
.L59:
	bne	a5,zero,.L60
	ret
	.size	crc16, .-crc16
	.section	.text.check_data_types,"ax",@progbits
	.align	1
	.globl	check_data_types
	.type	check_data_types, @function
check_data_types:
	li	a0,0
	ret
	.size	check_data_types, .-check_data_types
	.ident	"GCC: (g2ee5e430018) 12.2.0"
