	.file	"main.c"
	.option nopic
	.attribute arch, "rv32i2p0_m2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.section	.rodata.str1.4,"aMS",@progbits,1
	.align	2
.LC0:
	.string	"hello"
	.align	2
.LC1:
	.string	"done"
	.section	.text.startup.main,"ax",@progbits
	.align	2
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-16
	sw	ra,12(sp)
	call	init_uart
	lla	a0,.LC0
	call	ee_printf
	call	getchar
	call	getchar
	call	getchar
	call	getchar
	call	getchar
	lla	a0,.LC1
	call	ee_printf
.L2:
	j	.L2
	.size	main, .-main
	.ident	"GCC: (g2ee5e430018) 12.2.0"
