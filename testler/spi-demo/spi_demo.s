	.file	"spi_demo.c"
	.option nopic
	.attribute arch, "rv32i2p0_m2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.section	.text.startup.main,"ax",@progbits
	.align	2
	.globl	main
	.type	main, @function
main:
	li	a5,536936448
	li	a4,152
	sw	a4,12(a5)
	li	a4,983040
	addi	a4,a4,1
	sw	a4,0(a5)
	li	a4,8192
	sw	a4,16(a5)
	li	a4,536936448
.L2:
	lw	a5,4(a4)
	andi	a5,a5,2
	beq	a5,zero,.L2
	li	a5,152
	sw	a5,12(a4)
	li	a5,983040
	addi	a5,a5,5
	sw	a5,0(a4)
	li	a5,8192
	sw	a5,16(a4)
	li	a4,536936448
.L3:
	lw	a5,4(a4)
	andi	a5,a5,2
	beq	a5,zero,.L3
	li	a5,152
	sw	a5,12(a4)
	li	a5,983040
	addi	a5,a5,9
	sw	a5,0(a4)
	li	a5,8192
	sw	a5,16(a4)
	li	a4,536936448
.L4:
	lw	a5,4(a4)
	andi	a5,a5,2
	beq	a5,zero,.L4
	li	a5,152
	sw	a5,12(a4)
	li	a5,983040
	addi	a5,a5,13
	sw	a5,0(a4)
	li	a5,8192
	sw	a5,16(a4)
.L5:
	j	.L5
	.size	main, .-main
	.ident	"GCC: (g2ee5e430018) 12.2.0"
