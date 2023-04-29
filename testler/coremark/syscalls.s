	.file	"syscalls.c"
	.option nopic
	.attribute arch, "rv32i2p0_m2p0_c2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.section	.rodata.str1.4,"aMS",@progbits,1
	.align	2
.LC0:
	.string	"(null)"
	.globl	__umoddi3
	.globl	__udivdi3
	.globl	__moddi3
	.section	.text.vprintfmt,"ax",@progbits
	.align	1
	.type	vprintfmt, @function
vprintfmt:
	addi	sp,sp,-336
	sw	s0,328(sp)
	sw	s2,320(sp)
	sw	s3,316(sp)
	sw	s4,312(sp)
	sw	ra,332(sp)
	sw	s1,324(sp)
	sw	s5,308(sp)
	sw	s6,304(sp)
	sw	s7,300(sp)
	sw	s8,296(sp)
	sw	s9,292(sp)
	sw	s10,288(sp)
	sw	s11,284(sp)
	mv	s3,a0
	mv	s2,a1
	mv	s0,a2
	sw	a3,12(sp)
	li	s4,37
	j	.L86
.L5:
	beq	a0,zero,.L81
	mv	a1,s2
	addi	s0,s0,1
	jalr	s3
.L86:
	lbu	a0,0(s0)
	bne	a0,s4,.L5
	lbu	a3,1(s0)
	addi	s5,s0,1
	li	a5,32
	mv	a4,s5
	sw	a5,8(sp)
	li	s1,-1
	li	s6,-1
	li	a1,0
.L6:
	addi	a5,a3,-35
	andi	a5,a5,0xff
	li	a2,85
	addi	s0,a4,1
	bgtu	a5,a2,.L7
.L92:
	lla	a2,.L9
	slli	a5,a5,2
	add	a5,a5,a2
	lw	a5,0(a5)
	add	a5,a5,a2
	jr	a5
	.section	.rodata
	.align	2
	.align	2
.L9:
	.word	.L23-.L9
	.word	.L7-.L9
	.word	.L22-.L9
	.word	.L7-.L9
	.word	.L7-.L9
	.word	.L7-.L9
	.word	.L7-.L9
	.word	.L21-.L9
	.word	.L7-.L9
	.word	.L7-.L9
	.word	.L18-.L9
	.word	.L19-.L9
	.word	.L7-.L9
	.word	.L18-.L9
	.word	.L17-.L9
	.word	.L17-.L9
	.word	.L17-.L9
	.word	.L17-.L9
	.word	.L17-.L9
	.word	.L17-.L9
	.word	.L17-.L9
	.word	.L17-.L9
	.word	.L17-.L9
	.word	.L7-.L9
	.word	.L7-.L9
	.word	.L7-.L9
	.word	.L7-.L9
	.word	.L7-.L9
	.word	.L7-.L9
	.word	.L7-.L9
	.word	.L7-.L9
	.word	.L7-.L9
	.word	.L7-.L9
	.word	.L7-.L9
	.word	.L7-.L9
	.word	.L7-.L9
	.word	.L7-.L9
	.word	.L7-.L9
	.word	.L7-.L9
	.word	.L7-.L9
	.word	.L7-.L9
	.word	.L7-.L9
	.word	.L7-.L9
	.word	.L7-.L9
	.word	.L7-.L9
	.word	.L7-.L9
	.word	.L7-.L9
	.word	.L7-.L9
	.word	.L7-.L9
	.word	.L7-.L9
	.word	.L7-.L9
	.word	.L7-.L9
	.word	.L7-.L9
	.word	.L7-.L9
	.word	.L7-.L9
	.word	.L7-.L9
	.word	.L7-.L9
	.word	.L7-.L9
	.word	.L7-.L9
	.word	.L7-.L9
	.word	.L7-.L9
	.word	.L7-.L9
	.word	.L7-.L9
	.word	.L7-.L9
	.word	.L16-.L9
	.word	.L15-.L9
	.word	.L7-.L9
	.word	.L7-.L9
	.word	.L7-.L9
	.word	.L7-.L9
	.word	.L7-.L9
	.word	.L7-.L9
	.word	.L7-.L9
	.word	.L14-.L9
	.word	.L7-.L9
	.word	.L7-.L9
	.word	.L13-.L9
	.word	.L12-.L9
	.word	.L7-.L9
	.word	.L7-.L9
	.word	.L11-.L9
	.word	.L7-.L9
	.word	.L64-.L9
	.word	.L7-.L9
	.word	.L7-.L9
	.word	.L8-.L9
	.section	.text.vprintfmt
.L81:
	lw	ra,332(sp)
	lw	s0,328(sp)
	lw	s1,324(sp)
	lw	s2,320(sp)
	lw	s3,316(sp)
	lw	s4,312(sp)
	lw	s5,308(sp)
	lw	s6,304(sp)
	lw	s7,300(sp)
	lw	s8,296(sp)
	lw	s9,292(sp)
	lw	s10,288(sp)
	lw	s11,284(sp)
	addi	sp,sp,336
	jr	ra
.L18:
	sw	a3,8(sp)
	lbu	a3,1(a4)
	li	a2,85
	mv	a4,s0
	addi	a5,a3,-35
	andi	a5,a5,0xff
	addi	s0,a4,1
	bleu	a5,a2,.L92
.L7:
	mv	a1,s2
	li	a0,37
	jalr	s3
	mv	s0,s5
	j	.L86
.L17:
	lbu	a2,1(a4)
	li	a5,9
	addi	s1,a3,-48
	addi	a4,a2,-48
	mv	a3,a2
	bgtu	a4,a5,.L65
	mv	a4,s0
	li	a0,9
.L26:
	slli	a5,s1,2
	add	a5,a5,s1
	addi	a4,a4,1
	slli	a5,a5,1
	add	a5,a5,a2
	lbu	a2,0(a4)
	addi	s1,a5,-48
	addi	a5,a2,-48
	mv	a3,a2
	bleu	a5,a0,.L26
.L25:
	bge	s6,zero,.L6
	mv	s6,s1
	li	s1,-1
	j	.L6
.L23:
	lbu	a3,1(a4)
	mv	a4,s0
	j	.L6
.L22:
	mv	a1,s2
	li	a0,37
	jalr	s3
	j	.L86
.L21:
	lw	a5,12(sp)
	lbu	a3,1(a4)
	mv	a4,s0
	lw	s1,0(a5)
	addi	a5,a5,4
	sw	a5,12(sp)
	j	.L25
.L12:
	li	a0,48
	mv	a1,s2
	jalr	s3
	mv	a1,s2
	li	a0,120
	jalr	s3
	lw	a5,12(sp)
	li	s5,16
	li	s11,0
	addi	a4,a5,4
.L53:
	lw	a5,12(sp)
	li	s8,0
	lw	s1,0(a5)
	sw	a4,12(sp)
.L50:
	mv	a2,s5
	li	a3,0
	mv	a0,s1
	mv	a1,s8
	call	__umoddi3
	sw	a0,16(sp)
	beq	s11,s8,.L93
.L54:
	addi	s7,sp,20
	li	s9,1
.L60:
	mv	a2,s5
	li	a3,0
	mv	a0,s1
	mv	a1,s8
	call	__udivdi3
	mv	a2,s5
	li	a3,0
	mv	s1,a0
	mv	s8,a1
	call	__umoddi3
	sw	a0,0(s7)
	mv	s10,s9
	addi	s7,s7,4
	addi	s9,s9,1
	bne	s11,s8,.L60
	bleu	s5,s1,.L60
.L58:
	addi	s5,s6,-1
	addi	s1,s9,-1
	ble	s6,s9,.L62
.L61:
	lw	a0,8(sp)
	addi	s5,s5,-1
	mv	a1,s2
	jalr	s3
	bne	s5,s1,.L61
.L62:
	slli	a5,s10,2
	addi	a5,a5,16
	add	s5,a5,sp
	li	s1,9
	j	.L57
.L68:
	mv	s10,a5
.L57:
	lw	a0,0(s5)
	mv	a1,s2
	addi	s5,s5,-4
	sgtu	a5,a0,s1
	neg	a5,a5
	andi	a5,a5,39
	addi	a5,a5,48
	add	a0,a0,a5
	jalr	s3
	addi	a5,s10,-1
	bne	s10,zero,.L68
	j	.L86
.L15:
	li	a5,1
	bgt	a1,a5,.L94
	lw	a5,12(sp)
	lw	s1,0(a5)
	addi	a5,a5,4
	sw	a5,12(sp)
	srai	s8,s1,31
.L47:
	bge	s8,zero,.L88
	mv	a1,s2
	li	a0,45
	jalr	s3
	snez	a4,s1
	neg	a5,s8
	neg	s1,s1
	sub	s8,a5,a4
.L88:
	li	s5,10
	li	s11,0
	j	.L50
.L14:
	lbu	a3,1(a4)
	addi	a1,a1,1
	mv	a4,s0
	j	.L6
.L8:
	li	s5,16
	li	s11,0
.L10:
	li	a5,1
	bgt	a1,a5,.L95
	lw	a5,12(sp)
	addi	a4,a5,4
	j	.L53
.L11:
	lw	a5,12(sp)
	lw	s5,0(a5)
	addi	s7,a5,4
	beq	s5,zero,.L29
	ble	s6,zero,.L82
	lw	a4,8(sp)
	li	a5,45
	bne	a4,a5,.L33
	lbu	a0,0(s5)
	beq	a0,zero,.L45
	li	s8,-1
.L42:
	blt	s1,zero,.L43
	addi	s1,s1,-1
	beq	s1,s8,.L44
.L43:
	mv	a1,s2
	addi	s5,s5,1
	jalr	s3
	lbu	a0,0(s5)
	addi	s6,s6,-1
	bne	a0,zero,.L42
.L44:
	ble	s6,zero,.L89
.L45:
	addi	s6,s6,-1
	mv	a1,s2
	li	a0,32
	jalr	s3
	bne	s6,zero,.L45
.L89:
	sw	s7,12(sp)
	j	.L86
.L70:
	lla	s5,.LC0
.L33:
	mv	a5,s5
	add	a3,s5,s1
	bne	s1,zero,.L35
	j	.L40
.L38:
	addi	a5,a5,1
	beq	a5,a3,.L87
.L35:
	lbu	a4,0(a5)
	bne	a4,zero,.L38
.L87:
	sub	a5,a5,s5
	sub	s6,s6,a5
	ble	s6,zero,.L82
.L40:
	lw	a0,8(sp)
	addi	s6,s6,-1
	mv	a1,s2
	jalr	s3
	bne	s6,zero,.L40
.L82:
	lbu	a0,0(s5)
	beq	a0,zero,.L89
	li	s8,-1
	j	.L42
.L19:
	not	a5,s6
	srai	a5,a5,31
	lbu	a3,1(a4)
	and	s6,s6,a5
	mv	a4,s0
	j	.L6
.L16:
	lw	a5,12(sp)
	mv	a1,s2
	lw	a0,0(a5)
	addi	s7,a5,4
	jalr	s3
	sw	s7,12(sp)
	j	.L86
.L95:
	lw	a5,12(sp)
	addi	s7,a5,7
	andi	s7,s7,-8
	addi	a5,s7,8
	lw	s1,0(s7)
	lw	s8,4(s7)
	sw	a5,12(sp)
	j	.L50
.L93:
	bleu	s5,s1,.L54
	li	s10,0
	li	s9,1
	j	.L58
.L94:
	lw	a5,12(sp)
	addi	s7,a5,7
	andi	s7,s7,-8
	addi	a5,s7,8
	lw	s1,0(s7)
	lw	s8,4(s7)
	sw	a5,12(sp)
	j	.L47
.L64:
	li	s5,10
	li	s11,0
	j	.L10
.L13:
	li	s5,8
	li	s11,0
	j	.L10
.L29:
	ble	s6,zero,.L69
	lw	a4,8(sp)
	li	a5,45
	bne	a4,a5,.L70
.L69:
	lla	s5,.LC0
	li	a0,40
	li	s8,-1
	j	.L42
.L65:
	mv	a4,s0
	j	.L25
	.size	vprintfmt, .-vprintfmt
	.section	.text.sprintf_putch.0,"ax",@progbits
	.align	1
	.type	sprintf_putch.0, @function
sprintf_putch.0:
	lw	a5,0(a1)
	sb	a0,0(a5)
	lw	a5,0(a1)
	addi	a5,a5,1
	sw	a5,0(a1)
	ret
	.size	sprintf_putch.0, .-sprintf_putch.0
	.section	.text.putchar,"ax",@progbits
	.align	1
	.globl	putchar
	.type	putchar, @function
putchar:
	lui	a1,%tprel_hi(buflen.1)
	add	a3,a1,tp,%tprel_add(buflen.1)
	lw	a6,%tprel_lo(buflen.1)(a3)
	lui	a2,%tprel_hi(.LANCHOR0)
	add	a5,a2,tp,%tprel_add(.LANCHOR0)
	addi	a5,a5,%tprel_lo(.LANCHOR0)
	add	a5,a5,a6
	addi	sp,sp,-128
	addi	a4,a6,1
	sw	a4,%tprel_lo(buflen.1)(a3)
	sb	a0,0(a5)
	addi	a3,sp,63
	li	a5,10
	andi	a3,a3,-64
	beq	a0,a5,.L98
	li	a5,64
	beq	a4,a5,.L98
	li	a0,0
	addi	sp,sp,128
	jr	ra
.L98:
	li	a6,64
	sw	a6,0(a3)
	li	a7,0
	sw	a7,4(a3)
	li	t3,1
	sw	t3,8(a3)
	add	a2,a2,tp,%tprel_add(.LANCHOR0)
	li	t4,0
	sw	t4,12(a3)
	addi	t1,a2,%tprel_lo(.LANCHOR0)
	sw	t1,16(a3)
	li	t2,0
	sw	t2,20(a3)
	sw	a4,24(a3)
	srai	a7,a4,31
	sw	a7,28(a3)
	fence	iorw,iorw
	lla	a2,tohost
	sw	a3,0(a2)
	li	a5,0
	sw	a5,4(a2)
	lla	a2,fromhost
.L100:
	lw	a4,0(a2)
	lw	a5,4(a2)
	or	a4,a4,a5
	beq	a4,zero,.L100
	li	a5,0
	sw	a5,0(a2)
	li	a6,0
	sw	a6,4(a2)
	fence	iorw,iorw
	add	a1,a1,tp,%tprel_add(buflen.1)
	sw	zero,%tprel_lo(buflen.1)(a1)
	lw	a4,0(a3)
	li	a0,0
	lw	a5,4(a3)
	addi	sp,sp,128
	jr	ra
	.size	putchar, .-putchar
	.section	.rodata.str1.4
	.align	2
.LC1:
	.string	"mcycle"
	.align	2
.LC2:
	.string	"minstret"
	.section	.text.setStats,"ax",@progbits
	.align	1
	.globl	setStats
	.type	setStats, @function
setStats:
 #APP
# 50 "riscv32-baremetal/syscalls.c" 1
	csrr a4, mcycle
# 0 "" 2
 #NO_APP
	lla	a5,counters
	beq	a0,zero,.L106
	sw	a4,0(a5)
 #APP
# 51 "riscv32-baremetal/syscalls.c" 1
	csrr a4, minstret
# 0 "" 2
 #NO_APP
	sw	a4,4(a5)
	ret
.L106:
	lw	a2,0(a5)
	lla	a3,counter_names
	sub	a4,a4,a2
	lla	a2,.LC1
	sw	a2,0(a3)
	sw	a4,0(a5)
 #APP
# 51 "riscv32-baremetal/syscalls.c" 1
	csrr a4, minstret
# 0 "" 2
 #NO_APP
	lw	a2,4(a5)
	lla	a1,.LC2
	sw	a1,4(a3)
	sub	a4,a4,a2
	sw	a4,4(a5)
	ret
	.size	setStats, .-setStats
	.section	.text.tohost_exit,"ax",@progbits
	.align	1
	.globl	tohost_exit
	.type	tohost_exit, @function
tohost_exit:
	slli	a3,a0,1
	ori	a4,a3,1
	lla	a3,tohost
	li	a5,0
	sw	a4,0(a3)
	sw	a5,4(a3)
.L109:
	j	.L109
	.size	tohost_exit, .-tohost_exit
	.section	.text.handle_trap,"ax",@progbits
	.align	1
	.weak	handle_trap
	.type	handle_trap, @function
handle_trap:
	li	a2,4096
	lla	a5,tohost
	addi	a2,a2,-1421
	li	a3,0
	sw	a2,0(a5)
	sw	a3,4(a5)
.L111:
	j	.L111
	.size	handle_trap, .-handle_trap
	.section	.text.exit,"ax",@progbits
	.align	1
	.globl	exit
	.type	exit, @function
exit:
	addi	sp,sp,-16
	sw	ra,12(sp)
	call	tohost_exit
	.size	exit, .-exit
	.section	.text.abort,"ax",@progbits
	.align	1
	.globl	abort
	.type	abort, @function
abort:
	lla	a5,tohost
	li	a2,269
	li	a3,0
	sw	a2,0(a5)
	sw	a3,4(a5)
.L115:
	j	.L115
	.size	abort, .-abort
	.section	.text.printstr,"ax",@progbits
	.align	1
	.globl	printstr
	.type	printstr, @function
printstr:
	lbu	a5,0(a0)
	addi	sp,sp,-128
	addi	a2,sp,63
	mv	a6,a0
	andi	a2,a2,-64
	li	a7,0
	beq	a5,zero,.L121
	mv	a5,a0
.L118:
	lbu	a4,1(a5)
	addi	a5,a5,1
	bne	a4,zero,.L118
	sub	t1,a5,a0
	li	t2,0
.L117:
	li	a4,64
	sw	a4,0(a2)
	li	a5,0
	sw	a5,4(a2)
	li	a4,1
	sw	a4,8(a2)
	li	a5,0
	sw	a5,12(a2)
	sw	a6,16(a2)
	sw	a7,20(a2)
	sw	t1,24(a2)
	sw	t2,28(a2)
	fence	iorw,iorw
	lla	a3,tohost
	sw	a2,0(a3)
	li	a5,0
	sw	a5,4(a3)
	lla	a3,fromhost
.L119:
	lw	a4,0(a3)
	lw	a5,4(a3)
	or	a4,a4,a5
	beq	a4,zero,.L119
	li	a5,0
	sw	a5,0(a3)
	li	a6,0
	sw	a6,4(a3)
	fence	iorw,iorw
	lw	a4,0(a2)
	lw	a5,4(a2)
	addi	sp,sp,128
	jr	ra
.L121:
	li	t1,0
	li	t2,0
	j	.L117
	.size	printstr, .-printstr
	.section	.text.thread_entry,"ax",@progbits
	.align	1
	.weak	thread_entry
	.type	thread_entry, @function
thread_entry:
.L127:
	bne	a0,zero,.L127
	ret
	.size	thread_entry, .-thread_entry
	.section	.rodata.str1.4
	.align	2
.LC3:
	.string	"Implement main(), foo!\n"
	.section	.text.startup.main,"ax",@progbits
	.align	1
	.weak	main
	.type	main, @function
main:
	addi	sp,sp,-16
	lla	a0,.LC3
	sw	ra,12(sp)
	call	printstr
	lw	ra,12(sp)
	li	a0,-1
	addi	sp,sp,16
	jr	ra
	.size	main, .-main
	.section	.text.printhex,"ax",@progbits
	.align	1
	.globl	printhex
	.type	printhex, @function
printhex:
	addi	sp,sp,-48
	mv	a4,a0
	sw	ra,44(sp)
	addi	a0,sp,12
	addi	a3,sp,27
	li	a6,9
	j	.L134
.L136:
	mv	a3,a5
.L134:
	andi	a5,a4,15
	sgtu	a5,a5,a6
	neg	a5,a5
	andi	a5,a5,39
	andi	a2,a4,15
	addi	a5,a5,48
	add	a5,a2,a5
	sb	a5,0(a3)
	slli	a2,a1,28
	srli	a4,a4,4
	addi	a5,a3,-1
	or	a4,a2,a4
	srli	a1,a1,4
	bne	a0,a3,.L136
	sb	zero,28(sp)
	call	printstr
	lw	ra,44(sp)
	addi	sp,sp,48
	jr	ra
	.size	printhex, .-printhex
	.section	.text.printf,"ax",@progbits
	.align	1
	.globl	printf
	.type	printf, @function
printf:
	addi	sp,sp,-64
	addi	t1,sp,36
	mv	t3,a0
	sw	a1,36(sp)
	sw	a2,40(sp)
	sw	a3,44(sp)
	lla	a0,putchar
	mv	a3,t1
	mv	a2,t3
	li	a1,0
	sw	ra,28(sp)
	sw	a4,48(sp)
	sw	a5,52(sp)
	sw	a6,56(sp)
	sw	a7,60(sp)
	sw	t1,12(sp)
	call	vprintfmt
	lw	ra,28(sp)
	li	a0,0
	addi	sp,sp,64
	jr	ra
	.size	printf, .-printf
	.section	.text.sprintf,"ax",@progbits
	.align	1
	.globl	sprintf
	.type	sprintf, @function
sprintf:
	addi	sp,sp,-80
	addi	t1,sp,56
	sw	s0,40(sp)
	sw	a0,12(sp)
	sw	a2,56(sp)
	sw	a3,60(sp)
	mv	s0,a0
	mv	a2,a1
	lla	a0,sprintf_putch.0
	addi	a1,sp,12
	mv	a3,t1
	sw	ra,44(sp)
	sw	a5,68(sp)
	sw	a4,64(sp)
	sw	a6,72(sp)
	sw	a7,76(sp)
	sw	t1,28(sp)
	call	vprintfmt
	lw	a5,12(sp)
	sb	zero,0(a5)
	lw	a0,12(sp)
	lw	ra,44(sp)
	sub	a0,a0,s0
	lw	s0,40(sp)
	addi	sp,sp,80
	jr	ra
	.size	sprintf, .-sprintf
	.section	.text.memcpy,"ax",@progbits
	.align	1
	.globl	memcpy
	.type	memcpy, @function
memcpy:
	or	a5,a0,a1
	or	a5,a5,a2
	andi	a5,a5,3
	add	a3,a0,a2
	beq	a5,zero,.L144
	add	a2,a1,a2
	mv	a5,a0
	bleu	a3,a0,.L153
.L148:
	lbu	a4,0(a1)
	addi	a1,a1,1
	addi	a5,a5,1
	sb	a4,-1(a5)
	bne	a2,a1,.L148
.L149:
	ret
.L144:
	bleu	a3,a0,.L149
	mv	a5,a0
.L147:
	lw	a4,0(a1)
	addi	a5,a5,4
	addi	a1,a1,4
	sw	a4,-4(a5)
	bgtu	a3,a5,.L147
	ret
.L153:
	ret
	.size	memcpy, .-memcpy
	.section	.text.memset,"ax",@progbits
	.align	1
	.globl	memset
	.type	memset, @function
memset:
	or	a5,a0,a2
	andi	a5,a5,3
	add	a2,a0,a2
	beq	a5,zero,.L155
	andi	a1,a1,0xff
	mv	a5,a0
	bgeu	a0,a2,.L164
.L159:
	addi	a5,a5,1
	sb	a1,-1(a5)
	bne	a5,a2,.L159
.L160:
	ret
.L155:
	andi	a1,a1,255
	slli	a4,a1,8
	add	a4,a4,a1
	slli	a5,a4,16
	add	a4,a4,a5
	bgeu	a0,a2,.L160
	mv	a5,a0
.L158:
	addi	a5,a5,4
	sw	a4,-4(a5)
	bltu	a5,a2,.L158
	ret
.L164:
	ret
	.size	memset, .-memset
	.section	.rodata.str1.4
	.align	2
.LC4:
	.string	"%s = %d\n"
	.section	.text._init,"ax",@progbits
	.align	1
	.globl	_init
	.type	_init, @function
_init:
	addi	sp,sp,-160
	lla	a5,_tdata_begin
	sw	s4,136(sp)
	lla	s4,_tdata_end
	sw	s3,140(sp)
	sub	s3,s4,a5
	sw	s1,148(sp)
	sw	s2,144(sp)
	mv	s1,a0
	mv	s2,a1
	mv	a0,tp
	mv	a1,a5
	mv	a2,s3
	sw	ra,156(sp)
	sw	s0,152(sp)
	sw	s5,132(sp)
	mv	s5,tp
	call	memcpy
	lla	a2,_tbss_end
	sub	a2,a2,s4
	li	a1,0
	add	a0,s5,s3
	call	memset
	mv	a1,s2
	mv	a0,s1
	call	thread_entry
	li	a1,0
	li	a0,0
	call	main
	lla	s2,counters
	lw	a3,0(s2)
	addi	s0,sp,63
	andi	s0,s0,-64
	mv	s1,a0
	bne	a3,zero,.L177
	lw	a3,4(s2)
	bne	a3,zero,.L178
.L169:
	mv	a0,s1
	call	tohost_exit
.L178:
	mv	s2,s0
	lla	s3,counter_names
.L170:
	lw	a2,4(s3)
	mv	a0,s2
	lla	a1,.LC4
	call	sprintf
	add	s2,s2,a0
.L167:
	beq	s0,s2,.L169
	mv	a0,s0
	call	printstr
	j	.L169
.L177:
	lla	s3,counter_names
	lw	a2,0(s3)
	lla	a1,.LC4
	mv	a0,s0
	call	sprintf
	lw	a3,4(s2)
	add	s2,s0,a0
	beq	a3,zero,.L167
	j	.L170
	.size	_init, .-_init
	.section	.text.strlen,"ax",@progbits
	.align	1
	.globl	strlen
	.type	strlen, @function
strlen:
	lbu	a5,0(a0)
	beq	a5,zero,.L182
	mv	a5,a0
.L181:
	lbu	a4,1(a5)
	addi	a5,a5,1
	bne	a4,zero,.L181
	sub	a0,a5,a0
	ret
.L182:
	li	a0,0
	ret
	.size	strlen, .-strlen
	.section	.text.strnlen,"ax",@progbits
	.align	1
	.globl	strnlen
	.type	strnlen, @function
strnlen:
	add	a3,a0,a1
	mv	a5,a0
	bne	a1,zero,.L187
	j	.L191
.L188:
	addi	a5,a5,1
	beq	a3,a5,.L192
.L187:
	lbu	a4,0(a5)
	bne	a4,zero,.L188
	sub	a0,a5,a0
	ret
.L192:
	sub	a0,a3,a0
	ret
.L191:
	li	a0,0
	ret
	.size	strnlen, .-strnlen
	.section	.text.strcmp,"ax",@progbits
	.align	1
	.globl	strcmp
	.type	strcmp, @function
strcmp:
.L195:
	lbu	a5,0(a0)
	addi	a1,a1,1
	addi	a0,a0,1
	lbu	a4,-1(a1)
	beq	a5,zero,.L196
	beq	a5,a4,.L195
.L194:
	sub	a0,a5,a4
	ret
.L196:
	li	a5,0
	j	.L194
	.size	strcmp, .-strcmp
	.section	.text.strcpy,"ax",@progbits
	.align	1
	.globl	strcpy
	.type	strcpy, @function
strcpy:
	mv	a5,a0
.L199:
	lbu	a4,0(a1)
	addi	a5,a5,1
	addi	a1,a1,1
	sb	a4,-1(a5)
	bne	a4,zero,.L199
	ret
	.size	strcpy, .-strcpy
	.section	.text.atol,"ax",@progbits
	.align	1
	.globl	atol
	.type	atol, @function
atol:
	lbu	a4,0(a0)
	li	a3,32
	mv	a5,a0
	bne	a4,a3,.L202
.L203:
	lbu	a4,1(a5)
	addi	a5,a5,1
	beq	a4,a3,.L203
.L202:
	li	a3,45
	beq	a4,a3,.L204
	li	a3,43
	beq	a4,a3,.L223
	lbu	a3,0(a5)
	li	a1,0
	beq	a3,zero,.L222
.L209:
	li	a0,0
.L207:
	addi	a5,a5,1
	slli	a4,a0,2
	addi	a2,a3,-48
	lbu	a3,0(a5)
	add	a4,a4,a0
	slli	a4,a4,1
	add	a0,a2,a4
	bne	a3,zero,.L207
	beq	a1,zero,.L201
	neg	a0,a0
	ret
.L223:
	lbu	a3,1(a5)
	li	a1,0
	addi	a5,a5,1
	bne	a3,zero,.L209
.L222:
	li	a0,0
.L201:
	ret
.L204:
	lbu	a3,1(a5)
	li	a1,1
	addi	a5,a5,1
	bne	a3,zero,.L209
	li	a0,0
	j	.L201
	.size	atol, .-atol
	.section	.sbss,"aw",@nobits
	.align	2
	.type	counter_names, @object
	.size	counter_names, 8
counter_names:
	.zero	8
	.type	counters, @object
	.size	counters, 8
counters:
	.zero	8
	.section	.tbss,"awT",@nobits
	.align	6
	.set	.LANCHOR0,. + 0
	.type	buf.2, @object
	.size	buf.2, 64
buf.2:
	.zero	64
	.type	buflen.1, @object
	.size	buflen.1, 4
buflen.1:
	.zero	4
	.ident	"GCC: (g2ee5e430018) 12.2.0"
