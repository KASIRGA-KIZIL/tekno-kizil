	.file	"dhry_1.c"
	.option nopic
	.attribute arch, "rv32i2p0_m2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.section	.rodata.str1.4,"aMS",@progbits,1
	.align	2
.LC0:
	.string	"0123456789abcdefghijklmnopqrstuvwxyz"
	.align	2
.LC1:
	.string	"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	.section	.text.number,"ax",@progbits
	.align	2
	.type	number, @function
number:
	addi	sp,sp,-96
	sw	s0,92(sp)
	sw	s1,88(sp)
	andi	a7,a5,64
	mv	a6,a0
	lla	t5,.LC1
	bne	a7,zero,.L2
	lla	t5,.LC0
.L2:
	andi	t0,a5,16
	bne	t0,zero,.L3
	andi	a0,a5,1
	andi	s1,a5,17
	li	t6,48
	beq	a0,zero,.L5
	andi	a0,a5,2
	andi	t2,a5,32
	beq	a0,zero,.L59
.L119:
	blt	a1,zero,.L112
	andi	a0,a5,4
	bne	a0,zero,.L113
	andi	a5,a5,8
	li	s0,0
	beq	a5,zero,.L6
	addi	a3,a3,-1
	li	s0,32
.L6:
	beq	t2,zero,.L11
.L8:
	li	a5,16
	beq	a2,a5,.L114
	addi	a5,a2,-8
	seqz	a5,a5
	sub	a3,a3,a5
.L11:
	bne	a1,zero,.L9
	li	a5,48
	sb	a5,12(sp)
	li	a0,1
	addi	t1,sp,12
.L13:
	mv	t3,a0
	bge	a0,a4,.L15
	mv	t3,a4
.L15:
	sub	a3,a3,t3
	bne	s1,zero,.L16
	addi	t4,a3,-1
	ble	a3,zero,.L62
	neg	a4,a6
	li	a7,5
	andi	a5,a4,3
	bleu	t4,a7,.L63
	mv	t5,a6
	beq	a5,zero,.L18
	li	a7,32
	sb	a7,0(a6)
	andi	a4,a4,2
	addi	t5,a6,1
	addi	t4,a3,-2
	beq	a4,zero,.L18
	addi	a4,a6,-1
	sb	a7,1(a6)
	andi	a4,a4,3
	addi	t5,a6,2
	addi	t4,a3,-3
	bne	a4,zero,.L18
	addi	t5,a6,3
	sb	a7,2(a6)
	addi	t4,a3,-4
.L18:
	sub	s1,a3,a5
	andi	a7,s1,-4
	add	a5,a6,a5
	li	a4,538976256
	add	a7,a7,a5
	addi	a4,a4,32
.L22:
	sw	a4,0(a5)
	addi	a5,a5,4
	bne	a7,a5,.L22
	andi	a4,s1,-4
	andi	s1,s1,3
	add	a5,t5,a4
	sub	t4,t4,a4
	beq	s1,zero,.L24
.L17:
	li	a4,32
	sb	a4,0(a5)
	ble	t4,zero,.L24
	sb	a4,1(a5)
	li	a7,1
	beq	t4,a7,.L24
	sb	a4,2(a5)
	li	a7,2
	beq	t4,a7,.L24
	sb	a4,3(a5)
	li	a7,3
	beq	t4,a7,.L24
	sb	a4,4(a5)
	li	a7,4
	beq	t4,a7,.L24
	sb	a4,5(a5)
.L24:
	add	a6,a6,a3
	li	a3,-1
.L16:
	beq	s0,zero,.L25
	sb	s0,0(a6)
	addi	a6,a6,1
.L25:
	beq	t2,zero,.L26
	li	a5,8
	beq	a2,a5,.L115
	li	a5,16
	beq	a2,a5,.L116
.L26:
	bne	t0,zero,.L28
	addi	a7,a3,-1
	ble	a3,zero,.L65
	neg	a4,a6
	li	a2,5
	andi	a5,a4,3
	bleu	a7,a2,.L66
	mv	t4,a6
	beq	a5,zero,.L30
	sb	t6,0(a6)
	andi	a4,a4,2
	addi	t4,a6,1
	addi	a7,a3,-2
	beq	a4,zero,.L30
	addi	a4,a6,-1
	sb	t6,1(a6)
	andi	a4,a4,3
	addi	t4,a6,2
	addi	a7,a3,-3
	bne	a4,zero,.L30
	addi	t4,a6,3
	sb	t6,2(a6)
	addi	a7,a3,-4
.L30:
	slli	a4,t6,8
	sub	t5,a3,a5
	slli	a2,t6,16
	or	a4,t6,a4
	or	a4,a4,a2
	slli	t0,t6,24
	add	a5,a6,a5
	andi	a2,t5,-4
	or	a4,a4,t0
	add	a2,a2,a5
.L34:
	sw	a4,0(a5)
	addi	a5,a5,4
	bne	a5,a2,.L34
	andi	a4,t5,-4
	andi	t5,t5,3
	add	a5,t4,a4
	sub	a7,a7,a4
	beq	t5,zero,.L36
.L29:
	sb	t6,0(a5)
	ble	a7,zero,.L36
	sb	t6,1(a5)
	li	a4,1
	beq	a7,a4,.L36
	sb	t6,2(a5)
	li	a4,2
	beq	a7,a4,.L36
	sb	t6,3(a5)
	li	a4,3
	beq	a7,a4,.L36
	sb	t6,4(a5)
	li	a4,4
	beq	a7,a4,.L36
	sb	t6,5(a5)
.L36:
	add	a6,a6,a3
	li	a3,-1
.L28:
	addi	a7,t3,-1
	bge	a0,t3,.L44
	sub	t5,t3,a0
	neg	a4,a6
	addi	t4,t5,-1
	li	a2,5
	andi	a5,a4,3
	bleu	t4,a2,.L68
	mv	t4,a6
	beq	a5,zero,.L38
	li	a2,48
	sb	a2,0(a6)
	andi	a4,a4,2
	addi	t4,a6,1
	addi	a7,t3,-2
	beq	a4,zero,.L38
	addi	a4,a6,-1
	sb	a2,1(a6)
	andi	a4,a4,3
	addi	t4,a6,2
	addi	a7,t3,-3
	bne	a4,zero,.L38
	addi	t4,a6,3
	sb	a2,2(a6)
	addi	a7,t3,-4
.L38:
	sub	t3,t5,a5
	andi	a2,t3,-4
	add	a5,a6,a5
	li	a4,808464384
	add	a2,a2,a5
	addi	a4,a4,48
.L42:
	sw	a4,0(a5)
	addi	a5,a5,4
	bne	a2,a5,.L42
	andi	a5,t3,3
	beq	a5,zero,.L45
	andi	t3,t3,-4
	add	a5,t4,t3
	sub	a7,a7,t3
.L37:
	li	a4,48
	sb	a4,0(a5)
	addi	a2,a7,-1
	bge	a0,a7,.L45
	sb	a4,1(a5)
	addi	t3,a7,-2
	bge	a0,a2,.L45
	sb	a4,2(a5)
	addi	a2,a7,-3
	bge	a0,t3,.L45
	sb	a4,3(a5)
	addi	a7,a7,-4
	bge	a0,a2,.L45
	sb	a4,4(a5)
	bge	a0,a7,.L45
	sb	a4,5(a5)
.L45:
	add	a6,a6,t5
.L44:
	add	a5,t1,a1
	mv	a4,a6
.L47:
	lbu	a0,0(a5)
	mv	a2,a5
	addi	a4,a4,1
	sb	a0,-1(a4)
	addi	a5,a5,-1
	bne	t1,a2,.L47
	addi	a1,a1,1
	add	a0,a6,a1
	addi	a2,a3,-1
	ble	a3,zero,.L1
	neg	a4,a0
	li	a7,5
	andi	a5,a4,3
	bleu	a2,a7,.L70
	mv	a7,a0
	beq	a5,zero,.L50
	li	a2,32
	sb	a2,0(a0)
	andi	a4,a4,2
	beq	a4,zero,.L117
	addi	a4,a0,-1
	sb	a2,1(a0)
	andi	a4,a4,3
	bne	a4,zero,.L118
	sb	a2,2(a0)
	addi	a7,a0,3
	addi	a2,a3,-4
.L50:
	sub	t1,a3,a5
	add	a5,a5,a1
	add	a1,a6,a5
	andi	a4,t1,-4
	li	a5,538976256
	add	a4,a4,a1
	addi	a5,a5,32
.L54:
	sw	a5,0(a1)
	addi	a1,a1,4
	bne	a1,a4,.L54
	andi	a5,t1,3
	beq	a5,zero,.L56
	andi	t1,t1,-4
	add	a5,a7,t1
	sub	a2,a2,t1
.L49:
	li	a4,32
	sb	a4,0(a5)
	ble	a2,zero,.L56
	sb	a4,1(a5)
	li	a1,1
	beq	a2,a1,.L56
	sb	a4,2(a5)
	li	a1,2
	beq	a2,a1,.L56
	sb	a4,3(a5)
	li	a1,3
	beq	a2,a1,.L56
	sb	a4,4(a5)
	li	a1,4
	beq	a2,a1,.L56
	sb	a4,5(a5)
.L56:
	add	a0,a0,a3
.L1:
	lw	s0,92(sp)
	lw	s1,88(sp)
	addi	sp,sp,96
	jr	ra
.L59:
	li	s0,0
	j	.L6
.L3:
	andi	a5,a5,-2
	mv	s1,t0
.L5:
	andi	a0,a5,2
	li	t6,32
	andi	t2,a5,32
	beq	a0,zero,.L59
	j	.L119
.L112:
	neg	a1,a1
	addi	a3,a3,-1
	li	s0,45
	bne	t2,zero,.L8
.L9:
	mv	a5,a1
	li	a0,0
	addi	t1,sp,12
.L14:
	remu	a7,a5,a2
	mv	a1,a0
	addi	a0,a0,1
	add	t4,t1,a0
	mv	t3,a5
	add	a7,t5,a7
	lbu	a7,0(a7)
	divu	a5,a5,a2
	sb	a7,-1(t4)
	bgeu	t3,a2,.L14
	j	.L13
.L113:
	addi	a3,a3,-1
	li	s0,43
	j	.L6
.L116:
	li	a5,48
	sb	a5,0(a6)
	li	a5,120
	sb	a5,1(a6)
	addi	a6,a6,2
	j	.L26
.L117:
	addi	a7,a0,1
	addi	a2,a3,-2
	j	.L50
.L115:
	li	a5,48
	sb	a5,0(a6)
	addi	a6,a6,1
	j	.L26
.L114:
	addi	a3,a3,-2
	j	.L11
.L118:
	addi	a7,a0,2
	addi	a2,a3,-3
	j	.L50
.L70:
	mv	a5,a0
	j	.L49
.L68:
	mv	a5,a6
	j	.L37
.L62:
	mv	a3,t4
	j	.L16
.L65:
	mv	a3,a7
	j	.L28
.L66:
	mv	a5,a6
	j	.L29
.L63:
	mv	a5,a6
	j	.L17
	.size	number, .-number
	.section	.text.malloc,"ax",@progbits
	.align	2
	.globl	malloc
	.type	malloc, @function
malloc:
	lla	a3,heap_memory_used2
	lw	a4,0(a3)
	add	a5,a4,a0
	sw	a5,0(a3)
	lla	a0,.LANCHOR0
	li	a3,1024
	add	a0,a0,a4
	ble	a5,a3,.L120
 #APP
# 34 "ee_printf.h" 1
	ebreak
# 0 "" 2
 #NO_APP
.L120:
	ret
	.size	malloc, .-malloc
	.section	.text.strcpy,"ax",@progbits
	.align	2
	.globl	strcpy
	.type	strcpy, @function
strcpy:
	mv	a5,a0
	j	.L123
.L125:
	lbu	a4,0(a1)
	addi	a5,a5,1
	addi	a1,a1,1
	sb	a4,-1(a5)
	beq	a4,zero,.L127
.L123:
	or	a4,a5,a1
	andi	a4,a4,3
	bne	a4,zero,.L125
	lw	a3,0(a1)
	li	a7,-16842752
	addi	a7,a7,-257
	add	a4,a3,a7
	not	a2,a3
	li	a6,-2139062272
	and	a4,a4,a2
	addi	a6,a6,128
	and	a4,a4,a6
	bne	a4,zero,.L128
.L126:
	sw	a3,0(a5)
	lw	a3,4(a1)
	addi	a5,a5,4
	addi	a1,a1,4
	add	a4,a3,a7
	not	a2,a3
	and	a4,a4,a2
	and	a4,a4,a6
	beq	a4,zero,.L126
.L128:
	sb	a3,0(a5)
	andi	a4,a3,255
	beq	a4,zero,.L127
	srli	a4,a3,8
	sb	a4,1(a5)
	andi	a4,a4,255
	beq	a4,zero,.L127
	srli	a4,a3,16
	sb	a4,2(a5)
	andi	a4,a4,255
	bne	a4,zero,.L143
.L127:
	ret
.L143:
	srli	a3,a3,24
	sb	a3,3(a5)
	ret
	.size	strcpy, .-strcpy
	.section	.text.mytime,"ax",@progbits
	.align	2
	.globl	mytime
	.type	mytime, @function
mytime:
	li	a5,805306368
	lw	a0,0(a5)
	ret
	.size	mytime, .-mytime
	.section	.text.uart_txfull,"ax",@progbits
	.align	2
	.globl	uart_txfull
	.type	uart_txfull, @function
uart_txfull:
	li	a5,536870912
	lw	a0,4(a5)
	andi	a0,a0,1
	ret
	.size	uart_txfull, .-uart_txfull
	.section	.text.zputchar,"ax",@progbits
	.align	2
	.globl	zputchar
	.type	zputchar, @function
zputchar:
	li	a4,536870912
.L147:
	lw	a5,4(a4)
	andi	a5,a5,1
	bne	a5,zero,.L147
	li	a5,10
	beq	a0,a5,.L152
	li	a5,536870912
	sw	a0,12(a5)
	ret
.L152:
	li	a4,536870912
.L149:
	lw	a5,4(a4)
	andi	a5,a5,1
	bne	a5,zero,.L149
	li	a5,13
	sw	a5,12(a4)
	li	a5,536870912
	sw	a0,12(a5)
	ret
	.size	zputchar, .-zputchar
	.section	.text.uart_send_char,"ax",@progbits
	.align	2
	.globl	uart_send_char
	.type	uart_send_char, @function
uart_send_char:
	li	a4,536870912
.L154:
	lw	a5,4(a4)
	andi	a5,a5,1
	bne	a5,zero,.L154
	li	a5,10
	beq	a0,a5,.L159
	li	a5,536870912
	sw	a0,12(a5)
	ret
.L159:
	li	a4,536870912
.L156:
	lw	a5,4(a4)
	andi	a5,a5,1
	bne	a5,zero,.L156
	li	a5,13
	sw	a5,12(a4)
	li	a5,536870912
	sw	a0,12(a5)
	ret
	.size	uart_send_char, .-uart_send_char
	.section	.rodata.str1.4
	.align	2
.LC2:
	.string	"<NULL>"
	.section	.text.ee_printf,"ax",@progbits
	.align	2
	.globl	ee_printf
	.type	ee_printf, @function
ee_printf:
	addi	sp,sp,-1168
	sw	s2,1120(sp)
	sw	ra,1132(sp)
	sw	s0,1128(sp)
	sw	s1,1124(sp)
	sw	s3,1116(sp)
	sw	s4,1112(sp)
	sw	s5,1108(sp)
	sw	s6,1104(sp)
	sw	s7,1100(sp)
	sw	s8,1096(sp)
	sw	s9,1092(sp)
	sw	s10,1088(sp)
	sw	s11,1084(sp)
	sw	a1,1140(sp)
	sw	a2,1144(sp)
	sw	a3,1148(sp)
	sw	a4,1152(sp)
	sw	a5,1156(sp)
	sw	a6,1160(sp)
	sw	a7,1164(sp)
	lbu	a5,0(a0)
	addi	s2,sp,1140
	sw	s2,20(sp)
	beq	a5,zero,.L327
	addi	s4,sp,48
	mv	t1,a0
	li	s3,37
	mv	a0,s4
	li	s1,16
	lla	s0,.L166
	li	s8,9
	li	s7,46
	li	s6,76
	li	s5,55
.L318:
	beq	a5,s3,.L328
	sb	a5,0(a0)
	lbu	a5,1(t1)
	addi	a0,a0,1
	addi	t1,t1,1
	bne	a5,zero,.L318
.L161:
	sb	zero,0(a0)
	lbu	a3,48(sp)
	beq	a3,zero,.L352
	mv	a2,s4
	li	a4,536870912
	li	a1,10
	li	a0,13
.L320:
	lw	a5,4(a4)
	andi	a5,a5,1
	bne	a5,zero,.L320
	beq	a3,a1,.L322
	sw	a3,12(a4)
	lbu	a3,1(a2)
	addi	a5,a2,1
	beq	a3,zero,.L456
.L353:
	mv	a2,a5
	j	.L320
.L322:
	lw	a5,4(a4)
	andi	a5,a5,1
	bne	a5,zero,.L322
	sw	a0,12(a4)
	sw	a3,12(a4)
	lbu	a3,1(a2)
	addi	a5,a2,1
	bne	a3,zero,.L353
.L456:
	sub	a2,a2,s4
	addi	a0,a2,1
.L160:
	lw	ra,1132(sp)
	lw	s0,1128(sp)
	lw	s1,1124(sp)
	lw	s2,1120(sp)
	lw	s3,1116(sp)
	lw	s4,1112(sp)
	lw	s5,1108(sp)
	lw	s6,1104(sp)
	lw	s7,1100(sp)
	lw	s8,1096(sp)
	lw	s9,1092(sp)
	lw	s10,1088(sp)
	lw	s11,1084(sp)
	addi	sp,sp,1168
	jr	ra
.L328:
	li	a5,0
.L162:
	lbu	a1,1(t1)
	addi	a2,t1,1
	addi	a4,a1,-32
	andi	a4,a4,0xff
	bgtu	a4,s1,.L164
	slli	a4,a4,2
	add	a4,a4,s0
	lw	a4,0(a4)
	add	a4,a4,s0
	jr	a4
	.section	.rodata
	.align	2
	.align	2
.L166:
	.word	.L170-.L166
	.word	.L164-.L166
	.word	.L164-.L166
	.word	.L169-.L166
	.word	.L164-.L166
	.word	.L164-.L166
	.word	.L164-.L166
	.word	.L164-.L166
	.word	.L164-.L166
	.word	.L164-.L166
	.word	.L164-.L166
	.word	.L168-.L166
	.word	.L164-.L166
	.word	.L167-.L166
	.word	.L164-.L166
	.word	.L164-.L166
	.word	.L165-.L166
	.section	.text.ee_printf
.L164:
	addi	a4,a1,-48
	andi	a4,a4,0xff
	bleu	a4,s8,.L457
	li	a4,42
	li	a3,-1
	beq	a1,a4,.L458
.L174:
	li	a4,-1
	beq	a1,s7,.L459
.L175:
	andi	a6,a1,223
	beq	a6,s6,.L460
	addi	a6,a1,-65
	andi	a6,a6,0xff
	bgtu	a6,s5,.L354
	lla	a7,.L326
	slli	a6,a6,2
	add	a6,a6,a7
	lw	a6,0(a6)
	add	a6,a6,a7
	jr	a6
	.section	.rodata
	.align	2
	.align	2
.L326:
	.word	.L241-.L326
	.word	.L354-.L326
	.word	.L354-.L326
	.word	.L354-.L326
	.word	.L354-.L326
	.word	.L354-.L326
	.word	.L354-.L326
	.word	.L354-.L326
	.word	.L354-.L326
	.word	.L354-.L326
	.word	.L354-.L326
	.word	.L354-.L326
	.word	.L354-.L326
	.word	.L354-.L326
	.word	.L354-.L326
	.word	.L354-.L326
	.word	.L354-.L326
	.word	.L354-.L326
	.word	.L354-.L326
	.word	.L354-.L326
	.word	.L354-.L326
	.word	.L354-.L326
	.word	.L354-.L326
	.word	.L312-.L326
	.word	.L354-.L326
	.word	.L354-.L326
	.word	.L354-.L326
	.word	.L354-.L326
	.word	.L354-.L326
	.word	.L354-.L326
	.word	.L354-.L326
	.word	.L354-.L326
	.word	.L355-.L326
	.word	.L354-.L326
	.word	.L356-.L326
	.word	.L313-.L326
	.word	.L354-.L326
	.word	.L354-.L326
	.word	.L354-.L326
	.word	.L354-.L326
	.word	.L313-.L326
	.word	.L354-.L326
	.word	.L354-.L326
	.word	.L354-.L326
	.word	.L354-.L326
	.word	.L354-.L326
	.word	.L310-.L326
	.word	.L357-.L326
	.word	.L354-.L326
	.word	.L354-.L326
	.word	.L358-.L326
	.word	.L354-.L326
	.word	.L315-.L326
	.word	.L354-.L326
	.word	.L354-.L326
	.word	.L325-.L326
	.section	.text.ee_printf
.L165:
	ori	a5,a5,1
	mv	t1,a2
	j	.L162
.L167:
	ori	a5,a5,16
	mv	t1,a2
	j	.L162
.L168:
	ori	a5,a5,4
	mv	t1,a2
	j	.L162
.L169:
	ori	a5,a5,32
	mv	t1,a2
	j	.L162
.L170:
	ori	a5,a5,8
	mv	t1,a2
	j	.L162
.L354:
	mv	s9,a2
.L181:
	li	a5,37
	beq	a1,a5,.L314
	sb	a5,0(a0)
	lbu	a1,0(s9)
	addi	a0,a0,1
	beq	a1,zero,.L161
.L314:
	sb	a1,0(a0)
	lbu	a5,1(s9)
	addi	t1,s9,1
	addi	a0,a0,1
	bne	a5,zero,.L318
	j	.L161
.L460:
	mv	a7,a1
	lbu	a1,1(a2)
	addi	s9,a2,1
	addi	a6,a1,-65
	andi	a6,a6,0xff
	bgtu	a6,s5,.L181
	lla	t1,.L183
	slli	a6,a6,2
	add	a6,a6,t1
	lw	a6,0(a6)
	add	a6,a6,t1
	jr	a6
	.section	.rodata
	.align	2
	.align	2
.L183:
	.word	.L192-.L183
	.word	.L181-.L183
	.word	.L181-.L183
	.word	.L181-.L183
	.word	.L181-.L183
	.word	.L181-.L183
	.word	.L181-.L183
	.word	.L181-.L183
	.word	.L181-.L183
	.word	.L181-.L183
	.word	.L181-.L183
	.word	.L181-.L183
	.word	.L181-.L183
	.word	.L181-.L183
	.word	.L181-.L183
	.word	.L181-.L183
	.word	.L181-.L183
	.word	.L181-.L183
	.word	.L181-.L183
	.word	.L181-.L183
	.word	.L181-.L183
	.word	.L181-.L183
	.word	.L181-.L183
	.word	.L191-.L183
	.word	.L181-.L183
	.word	.L181-.L183
	.word	.L181-.L183
	.word	.L181-.L183
	.word	.L181-.L183
	.word	.L181-.L183
	.word	.L181-.L183
	.word	.L181-.L183
	.word	.L190-.L183
	.word	.L181-.L183
	.word	.L189-.L183
	.word	.L188-.L183
	.word	.L181-.L183
	.word	.L181-.L183
	.word	.L181-.L183
	.word	.L181-.L183
	.word	.L188-.L183
	.word	.L181-.L183
	.word	.L181-.L183
	.word	.L181-.L183
	.word	.L181-.L183
	.word	.L181-.L183
	.word	.L333-.L183
	.word	.L186-.L183
	.word	.L181-.L183
	.word	.L181-.L183
	.word	.L185-.L183
	.word	.L181-.L183
	.word	.L184-.L183
	.word	.L181-.L183
	.word	.L181-.L183
	.word	.L454-.L183
	.section	.text.ee_printf
.L459:
	lbu	a1,1(a2)
	li	a7,9
	addi	a6,a2,1
	addi	a4,a1,-48
	andi	a4,a4,0xff
	bleu	a4,a7,.L461
	li	a4,42
	beq	a1,a4,.L462
	mv	a2,a6
	li	a4,0
	j	.L175
.L457:
	li	a3,0
	li	a6,9
.L173:
	slli	a4,a3,2
	add	a4,a4,a3
	addi	a2,a2,1
	slli	a4,a4,1
	add	a4,a4,a1
	lbu	a1,0(a2)
	addi	a3,a4,-48
	addi	a4,a1,-48
	andi	a4,a4,0xff
	bleu	a4,a6,.L173
	j	.L174
.L458:
	lw	a3,0(s2)
	lbu	a1,2(t1)
	addi	a2,t1,2
	addi	s2,s2,4
	bge	a3,zero,.L174
	neg	a3,a3
	ori	a5,a5,16
	j	.L174
.L192:
	ori	a5,a5,64
.L190:
	li	a4,108
	beq	a7,a4,.L463
.L242:
	lw	a7,0(s2)
	addi	s2,s2,4
	lbu	a4,0(a7)
	bne	a4,zero,.L464
	li	a4,48
	li	a1,1
	sb	a4,24(sp)
	addi	a6,a1,1056
	addi	t1,sp,16
	lbu	a4,1(a7)
	add	t1,a6,t1
	li	a6,46
	sb	a6,-1048(t1)
	li	a2,2
	beq	a4,zero,.L269
.L483:
	li	a6,99
	ble	a4,a6,.L465
	li	t3,100
	rem	t5,a4,t3
	li	t4,10
	addi	a2,a2,1056
	addi	t6,sp,16
	add	t6,a2,t6
	addi	a2,a1,3
	lla	a6,.LC0
	div	a4,a4,t3
	div	a1,t5,t4
	add	a4,a6,a4
	lbu	a4,0(a4)
	sb	a4,-1048(t6)
	add	a4,a6,a1
	lbu	a1,0(a4)
	rem	a4,t5,t4
	sb	a1,-1046(t1)
.L273:
	add	a4,a6,a4
	lbu	a6,0(a4)
	addi	a1,sp,16
	addi	a4,a2,1056
	add	a1,a4,a1
	addi	a4,a2,1
	sb	a6,-1048(a1)
	lbu	a2,2(a7)
	addi	a1,a4,1056
	addi	a6,sp,16
	add	t1,a1,a6
	li	a1,46
	sb	a1,-1048(t1)
	addi	a1,a4,1
	beq	a2,zero,.L274
.L484:
	li	a6,99
	ble	a2,a6,.L466
	li	t3,100
	addi	a1,a1,1056
	addi	t6,sp,16
	add	t6,a1,t6
	addi	a1,a4,3
	li	t4,10
	lla	a6,.LC0
	rem	t5,a2,t3
	div	a4,a2,t3
	div	a2,t5,t4
	add	a4,a6,a4
	lbu	a4,0(a4)
	sb	a4,-1048(t6)
	add	a4,a6,a2
	rem	a2,t5,t4
	lbu	a4,0(a4)
	sb	a4,-1046(t1)
.L278:
	add	a2,a6,a2
	lbu	a6,0(a2)
	addi	a4,a1,1056
	addi	a2,sp,16
	add	a2,a4,a2
	addi	a4,a1,1
	sb	a6,-1048(a2)
	addi	a1,a4,1056
	lbu	a2,3(a7)
	addi	a6,sp,16
	add	a7,a1,a6
	li	a1,46
	sb	a1,-1048(a7)
	addi	a1,a4,1
	beq	a2,zero,.L279
.L485:
	li	a6,99
	ble	a2,a6,.L467
	li	t1,100
	addi	a1,a1,1056
	addi	t5,sp,16
	add	t5,a1,t5
	addi	a1,a4,3
	li	t3,10
	lla	a6,.LC0
	rem	t4,a2,t1
	div	a4,a2,t1
	div	a2,t4,t3
	add	a4,a6,a4
	lbu	a4,0(a4)
	sb	a4,-1048(t5)
	add	a4,a6,a2
	rem	a2,t4,t3
	lbu	a4,0(a4)
	sb	a4,-1046(a7)
.L283:
	add	a2,a6,a2
	lbu	a6,0(a2)
	addi	a4,a1,1056
	addi	a2,sp,16
	add	a2,a4,a2
	sb	a6,-1048(a2)
	addi	a4,a1,1
.L282:
	andi	a5,a5,16
	bne	a5,zero,.L293
	addi	a6,a3,-1
	ble	a3,a4,.L285
	sub	t1,a3,a4
	neg	a1,a0
	addi	a7,t1,-1
	li	a2,5
	andi	a5,a1,3
	bleu	a7,a2,.L348
	mv	a2,a0
	beq	a5,zero,.L287
	li	a6,32
	sb	a6,0(a0)
	andi	a1,a1,2
	beq	a1,zero,.L468
	addi	a2,a0,-1
	sb	a6,1(a0)
	andi	a2,a2,3
	bne	a2,zero,.L469
	sb	a6,2(a0)
	addi	a2,a0,3
	addi	a6,a3,-4
.L287:
	sub	a7,t1,a5
	andi	a1,a7,-4
	add	a5,a0,a5
	li	a3,538976256
	add	a1,a1,a5
	addi	a3,a3,32
.L291:
	sw	a3,0(a5)
	addi	a5,a5,4
	bne	a1,a5,.L291
	andi	a3,a7,-4
	andi	a7,a7,3
	add	a5,a2,a3
	sub	a6,a6,a3
	beq	a7,zero,.L294
.L286:
	li	a3,32
	sb	a3,0(a5)
	addi	a2,a6,-1
	bge	a4,a6,.L294
	sb	a3,1(a5)
	addi	a1,a6,-2
	bge	a4,a2,.L294
	sb	a3,2(a5)
	addi	a2,a6,-3
	bge	a4,a1,.L294
	sb	a3,3(a5)
	addi	a6,a6,-4
	bge	a4,a2,.L294
	sb	a3,4(a5)
	bge	a4,a6,.L294
	sb	a3,5(a5)
.L294:
	add	a0,a0,t1
	addi	a3,a4,-1
.L293:
	andi	a5,a0,3
	beq	a5,zero,.L470
	lbu	a5,30(sp)
	lbu	t3,24(sp)
	lbu	t1,25(sp)
	lbu	a7,26(sp)
	lbu	a6,27(sp)
	lbu	a1,28(sp)
	lbu	a2,29(sp)
	sb	a5,6(a0)
	sb	t3,0(a0)
	sb	t1,1(a0)
	sb	a7,2(a0)
	sb	a6,3(a0)
	sb	a1,4(a0)
	sb	a2,5(a0)
	li	a5,7
	beq	a4,a5,.L300
	lbu	a2,31(sp)
	li	a5,8
	sb	a2,7(a0)
	beq	a4,a5,.L300
	lbu	a2,32(sp)
	li	a5,9
	sb	a2,8(a0)
	beq	a4,a5,.L300
	lbu	a2,33(sp)
	li	a5,10
	sb	a2,9(a0)
	beq	a4,a5,.L300
	lbu	a2,34(sp)
	li	a5,11
	sb	a2,10(a0)
	beq	a4,a5,.L300
	lbu	a2,35(sp)
	li	a5,12
	sb	a2,11(a0)
	beq	a4,a5,.L300
	lbu	a2,36(sp)
	li	a5,13
	sb	a2,12(a0)
	beq	a4,a5,.L300
	lbu	a2,37(sp)
	li	a5,15
	sb	a2,13(a0)
	bne	a4,a5,.L300
	lbu	a5,38(sp)
	sb	a5,14(a0)
.L300:
	add	a7,a0,a4
	addi	t1,a3,-1
	ble	a3,a4,.L350
	sub	a6,a3,a4
	neg	a2,a7
	addi	t3,a6,-1
	li	a1,5
	andi	a5,a2,3
	bleu	t3,a1,.L302
	beq	a5,zero,.L303
	li	a1,32
	sb	a1,0(a7)
	andi	a2,a2,2
	beq	a2,zero,.L471
	addi	a2,a7,-1
	sb	a1,1(a7)
	andi	a2,a2,3
	bne	a2,zero,.L472
	sb	a1,2(a7)
	addi	t1,a3,-4
	addi	a7,a7,3
.L303:
	sub	a6,a6,a5
	add	a5,a5,a4
	add	a5,a0,a5
	andi	a1,a6,-4
	li	a2,538976256
	add	a1,a1,a5
	addi	a2,a2,32
.L307:
	sw	a2,0(a5)
	addi	a5,a5,4
	bne	a5,a1,.L307
	andi	a5,a6,-4
	andi	a6,a6,3
	add	a7,a7,a5
	sub	t1,t1,a5
	beq	a6,zero,.L309
.L302:
	li	a2,32
	sb	a2,0(a7)
	addi	a1,t1,-1
	ble	t1,a4,.L309
	sb	a2,1(a7)
	addi	a5,t1,-2
	bge	a4,a1,.L309
	sb	a2,2(a7)
	addi	a1,t1,-3
	bge	a4,a5,.L309
	sb	a2,3(a7)
	addi	a5,t1,-4
	bge	a4,a1,.L309
	sb	a2,4(a7)
	bge	a4,a5,.L309
	sb	a2,5(a7)
.L309:
	add	a0,a0,a3
	j	.L455
.L191:
	ori	a5,a5,64
.L454:
	li	a2,16
.L187:
	addi	a6,s2,4
.L317:
	lw	a1,0(s2)
	mv	s2,a6
	call	number
.L455:
	lbu	a5,1(s9)
	addi	t1,s9,1
	bne	a5,zero,.L318
	j	.L161
.L356:
	mv	s9,a2
.L189:
	andi	a5,a5,16
	addi	a6,s2,4
	addi	t1,s9,1
	beq	a5,zero,.L473
	lw	a5,0(s2)
	addi	t3,a3,-1
	addi	a7,a0,1
	sb	a5,0(a0)
	ble	t3,zero,.L474
	neg	a4,a7
	addi	a2,a3,-2
	li	t4,5
	mv	a1,t3
	andi	a5,a4,3
	ble	a2,t4,.L205
	beq	a5,zero,.L206
	li	t3,32
	sb	t3,1(a0)
	andi	a4,a4,2
	beq	a4,zero,.L475
	sb	t3,2(a0)
	andi	a4,a0,3
	bne	a4,zero,.L476
	sb	t3,3(a0)
	addi	a7,a0,4
	addi	t3,a3,-4
.L206:
	sub	a1,a1,a5
	addi	a5,a5,1
	add	a5,a0,a5
	andi	a2,a1,-4
	li	a4,538976256
	add	a2,a2,a5
	addi	a4,a4,32
.L210:
	sw	a4,0(a5)
	addi	a5,a5,4
	bne	a5,a2,.L210
	andi	a5,a1,-4
	andi	a1,a1,3
	add	a7,a7,a5
	sub	t3,t3,a5
	beq	a1,zero,.L211
.L205:
	li	a5,32
	sb	a5,0(a7)
	li	a4,1
	ble	t3,a4,.L211
	sb	a5,1(a7)
	li	a4,2
	beq	t3,a4,.L211
	sb	a5,2(a7)
	li	a4,3
	beq	t3,a4,.L211
	sb	a5,3(a7)
	li	a4,4
	beq	t3,a4,.L211
	sb	a5,4(a7)
	li	a4,5
	beq	t3,a4,.L211
	sb	a5,5(a7)
.L211:
	lbu	a5,1(s9)
	add	a0,a0,a3
	mv	s2,a6
	bne	a5,zero,.L318
	j	.L161
.L358:
	mv	s9,a2
.L185:
	lw	a1,0(s2)
	addi	s2,s2,4
	beq	a1,zero,.L336
	lbu	a2,0(a1)
	beq	a2,zero,.L213
.L212:
	beq	a4,zero,.L213
	mv	a2,a1
	j	.L215
.L477:
	sub	a6,a2,a4
	beq	a6,a1,.L214
.L215:
	lbu	a6,1(a2)
	addi	a2,a2,1
	bne	a6,zero,.L477
.L214:
	andi	a5,a5,16
	sub	a2,a2,a1
	beq	a5,zero,.L324
.L216:
	ble	a2,zero,.L225
	addi	a5,a2,-1
	li	a4,6
	bleu	a5,a4,.L453
	or	a5,a1,a0
	andi	a5,a5,3
	bne	a5,zero,.L453
	addi	a5,a1,1
	sub	a4,a0,a5
	sltiu	a4,a4,3
	bne	a4,zero,.L226
	andi	a7,a2,-4
	mv	a5,a1
	mv	a4,a0
	add	a7,a7,a1
.L227:
	lw	a6,0(a5)
	addi	a5,a5,4
	addi	a4,a4,4
	sw	a6,-4(a4)
	bne	a7,a5,.L227
	andi	a5,a2,-4
	add	a1,a1,a5
	add	a4,a0,a5
	beq	a2,a5,.L231
	lbu	a7,0(a1)
	addi	a6,a5,1
	sb	a7,0(a4)
	ble	a2,a6,.L231
	lbu	a6,1(a1)
	addi	a5,a5,2
	sb	a6,1(a4)
	ble	a2,a5,.L231
	lbu	a5,2(a1)
	sb	a5,2(a4)
.L231:
	add	a0,a0,a2
.L225:
	addi	t3,a3,-1
	addi	t1,s9,1
	ble	a3,a2,.L478
	sub	a7,a3,a2
	neg	a4,a0
	addi	a6,a7,-1
	li	a1,5
	andi	a5,a4,3
	bleu	a6,a1,.L340
	mv	a6,a0
	beq	a5,zero,.L234
	li	a1,32
	sb	a1,0(a0)
	andi	a4,a4,2
	addi	a6,a0,1
	addi	t3,a3,-2
	beq	a4,zero,.L234
	addi	a4,a0,-1
	sb	a1,1(a0)
	andi	a4,a4,3
	addi	a6,a0,2
	addi	t3,a3,-3
	bne	a4,zero,.L234
	addi	a6,a0,3
	sb	a1,2(a0)
	addi	t3,a3,-4
.L234:
	sub	a1,a7,a5
	andi	a3,a1,-4
	add	a5,a0,a5
	li	a4,538976256
	add	a3,a3,a5
	addi	a4,a4,32
.L238:
	sw	a4,0(a5)
	addi	a5,a5,4
	bne	a5,a3,.L238
	andi	a4,a1,-4
	andi	a1,a1,3
	add	a5,a6,a4
	sub	t3,t3,a4
	beq	a1,zero,.L239
.L233:
	li	a3,32
	sb	a3,0(a5)
	addi	a1,t3,-1
	bge	a2,t3,.L239
	sb	a3,1(a5)
	addi	a4,t3,-2
	bge	a2,a1,.L239
	sb	a3,2(a5)
	addi	a1,t3,-3
	bge	a2,a4,.L239
	sb	a3,3(a5)
	addi	a4,t3,-4
	bge	a2,a1,.L239
	sb	a3,4(a5)
	bge	a2,a4,.L239
	sb	a3,5(a5)
.L239:
	lbu	a5,1(s9)
	add	a0,a0,a7
	bne	a5,zero,.L318
	j	.L161
.L357:
	mv	s9,a2
.L186:
	li	a2,-1
	beq	a3,a2,.L479
.L240:
	lw	a1,0(s2)
	li	a2,16
	addi	s2,s2,4
	call	number
	lbu	a5,1(s9)
	addi	t1,s9,1
	bne	a5,zero,.L318
	j	.L161
.L461:
	li	a4,0
	mv	t1,a4
.L177:
	slli	a4,t1,2
	add	a4,a4,t1
	addi	a6,a6,1
	slli	a4,a4,1
	add	a4,a4,a1
	lbu	a1,0(a6)
	addi	t1,a4,-48
	addi	a2,a1,-48
	andi	a2,a2,0xff
	bleu	a2,a7,.L177
	mv	a4,t1
	mv	a2,a6
	j	.L175
.L462:
	lw	a4,0(s2)
	lbu	a1,2(a2)
	addi	s2,s2,4
	not	a6,a4
	srai	a6,a6,31
	and	a4,a4,a6
	addi	a2,a2,2
	j	.L175
.L463:
	andi	a1,a5,64
	lla	a4,.LC0
	beq	a1,zero,.L243
	lla	a4,.LC1
.L243:
	lw	a6,0(s2)
	li	a1,58
	sb	a1,26(sp)
	lbu	a7,0(a6)
	lbu	t2,1(a6)
	lbu	t6,2(a6)
	lbu	t4,3(a6)
	lbu	t1,4(a6)
	andi	t3,a7,15
	lbu	a6,5(a6)
	add	t3,a4,t3
	srli	a7,a7,4
	lbu	s11,0(t3)
	add	a7,a4,a7
	srli	s9,t2,4
	srli	t0,t6,4
	srli	t5,t4,4
	srli	t3,t1,4
	andi	t2,t2,15
	andi	t6,t6,15
	andi	t4,t4,15
	andi	t1,t1,15
	lbu	s10,0(a7)
	add	s9,a4,s9
	add	t2,a4,t2
	add	t0,a4,t0
	add	t6,a4,t6
	add	t5,a4,t5
	add	t4,a4,t4
	add	t3,a4,t3
	add	t1,a4,t1
	srli	a7,a6,4
	lbu	s9,0(s9)
	lbu	t2,0(t2)
	lbu	t0,0(t0)
	lbu	t6,0(t6)
	lbu	t5,0(t5)
	lbu	t4,0(t4)
	lbu	t3,0(t3)
	lbu	t1,0(t1)
	add	a7,a4,a7
	lbu	a7,0(a7)
	slli	s11,s11,8
	or	s10,s10,s11
	andi	a6,a6,15
	sh	s10,24(sp)
	sb	s9,27(sp)
	sb	t2,28(sp)
	sb	a1,29(sp)
	sb	t0,30(sp)
	sb	t6,31(sp)
	sb	a1,32(sp)
	sb	t5,33(sp)
	sb	t4,34(sp)
	sb	a1,35(sp)
	sb	t3,36(sp)
	sb	t1,37(sp)
	sb	a1,38(sp)
	add	a4,a4,a6
	sb	a7,39(sp)
	lbu	a4,0(a4)
	andi	a5,a5,16
	sw	a4,12(sp)
	bne	a5,zero,.L244
	li	a5,17
	addi	a1,a3,-1
	ble	a3,a5,.L343
	neg	a6,a0
	addi	a4,a3,-18
	li	s11,5
	addi	s10,a3,-17
	andi	a5,a6,3
	bleu	a4,s11,.L344
	mv	a4,a0
	beq	a5,zero,.L246
	li	a1,32
	sb	a1,0(a0)
	andi	a6,a6,2
	beq	a6,zero,.L480
	addi	a4,a0,-1
	sb	a1,1(a0)
	andi	a4,a4,3
	bne	a4,zero,.L481
	sb	a1,2(a0)
	addi	a4,a0,3
	addi	a1,a3,-4
.L246:
	sub	s11,s10,a5
	andi	a6,s11,-4
	add	a5,a0,a5
	li	a3,538976256
	add	a6,a6,a5
	addi	a3,a3,32
.L250:
	sw	a3,0(a5)
	addi	a5,a5,4
	bne	a6,a5,.L250
	andi	a5,s11,-4
	andi	s11,s11,3
	add	a4,a4,a5
	sub	a1,a1,a5
	beq	s11,zero,.L252
.L245:
	li	a5,32
	sb	a5,0(a4)
	li	a3,17
	ble	a1,a3,.L252
	sb	a5,1(a4)
	li	a3,18
	beq	a1,a3,.L252
	sb	a5,2(a4)
	li	a3,19
	beq	a1,a3,.L252
	sb	a5,3(a4)
	li	a3,20
	beq	a1,a3,.L252
	sb	a5,4(a4)
	li	a3,21
	beq	a1,a3,.L252
	sb	a5,5(a4)
.L252:
	add	a0,a0,s10
	li	a3,16
.L244:
	andi	a5,a0,3
	bne	a5,zero,.L253
	lw	a5,28(sp)
	sw	a5,4(a0)
	lw	a5,32(sp)
	sw	a5,8(a0)
	lw	a5,24(sp)
	sw	a5,0(a0)
	lw	a5,36(sp)
	sw	a5,12(a0)
.L254:
	lw	a5,12(sp)
	addi	a6,a0,17
	addi	a7,a3,-1
	sb	a5,16(a0)
	li	a5,17
	ble	a3,a5,.L346
	neg	a4,a6
	addi	a1,a3,-18
	li	t3,5
	addi	t1,a3,-17
	andi	a5,a4,3
	bleu	a1,t3,.L256
	beq	a5,zero,.L257
	li	a1,32
	sb	a1,17(a0)
	andi	a4,a4,2
	addi	a6,a0,18
	addi	a7,a3,-2
	beq	a4,zero,.L257
	sb	a1,18(a0)
	andi	a4,a0,3
	addi	a6,a0,19
	addi	a7,a3,-3
	bne	a4,zero,.L257
	addi	a6,a0,20
	sb	a1,19(a0)
	addi	a7,a3,-4
.L257:
	sub	t1,t1,a5
	addi	a5,a5,17
	add	a5,a0,a5
	andi	a1,t1,-4
	li	a4,538976256
	add	a1,a1,a5
	addi	a4,a4,32
.L261:
	sw	a4,0(a5)
	addi	a5,a5,4
	bne	a5,a1,.L261
	andi	a5,t1,-4
	andi	t1,t1,3
	add	a6,a6,a5
	sub	a7,a7,a5
	beq	t1,zero,.L263
.L256:
	li	a5,32
	sb	a5,0(a6)
	li	a4,17
	ble	a7,a4,.L263
	sb	a5,1(a6)
	li	a4,18
	beq	a7,a4,.L263
	sb	a5,2(a6)
	li	a4,19
	beq	a7,a4,.L263
	sb	a5,3(a6)
	li	a4,20
	beq	a7,a4,.L263
	sb	a5,4(a6)
	li	a4,21
	beq	a7,a4,.L263
	sb	a5,5(a6)
.L263:
	add	a0,a0,a3
.L255:
	lbu	a5,2(a2)
	addi	s2,s2,4
	addi	t1,a2,2
	bne	a5,zero,.L318
	j	.L161
.L464:
	li	a2,99
	ble	a4,a2,.L482
	li	t1,100
	rem	t6,a4,t1
	li	t5,10
	lla	a6,.LC0
	li	a2,4
	li	a1,3
	li	t3,2
	div	t4,t6,t5
	div	a4,a4,t1
	add	t1,a6,t4
	lbu	t4,0(t1)
	slli	t4,t4,8
	add	a4,a6,a4
	lbu	t1,0(a4)
	rem	a4,t6,t5
	or	t1,t1,t4
	sh	t1,24(sp)
.L268:
	add	a4,a6,a4
	lbu	a4,0(a4)
	addi	a6,t3,1056
	addi	t1,sp,16
	add	t3,a6,t1
	sb	a4,-1048(t3)
	addi	a6,a1,1056
	addi	t1,sp,16
	lbu	a4,1(a7)
	add	t1,a6,t1
	li	a6,46
	sb	a6,-1048(t1)
	bne	a4,zero,.L483
.L269:
	addi	a4,a2,1056
	addi	a2,sp,16
	add	a2,a4,a2
	addi	a4,a1,2
	li	a1,48
	sb	a1,-1048(a2)
	addi	a6,sp,16
	addi	a1,a4,1056
	lbu	a2,2(a7)
	add	t1,a1,a6
	li	a1,46
	sb	a1,-1048(t1)
	addi	a1,a4,1
	bne	a2,zero,.L484
.L274:
	addi	a2,a1,1056
	addi	a1,sp,16
	add	a2,a2,a1
	addi	a4,a4,2
	li	a1,48
	sb	a1,-1048(a2)
	addi	a6,sp,16
	addi	a1,a4,1056
	lbu	a2,3(a7)
	add	a7,a1,a6
	li	a1,46
	sb	a1,-1048(a7)
	addi	a1,a4,1
	bne	a2,zero,.L485
.L279:
	addi	a2,a1,1056
	addi	a1,sp,16
	add	a2,a2,a1
	li	a1,48
	addi	a4,a4,2
	sb	a1,-1048(a2)
	j	.L282
.L479:
	ori	a5,a5,1
	li	a3,8
	j	.L240
.L473:
	li	a5,1
	ble	a3,a5,.L194
	addi	a2,a3,-1
	neg	a1,a0
	addi	a7,a3,-2
	li	a4,5
	mv	t4,a2
	andi	a5,a1,3
	ble	a7,a4,.L334
	mv	a4,a0
	beq	a5,zero,.L196
	li	a2,32
	sb	a2,0(a0)
	andi	a1,a1,2
	beq	a1,zero,.L486
	addi	a4,a0,-1
	sb	a2,1(a0)
	andi	a4,a4,3
	bne	a4,zero,.L487
	sb	a2,2(a0)
	addi	a4,a0,3
	addi	a2,a3,-4
.L196:
	sub	a1,t4,a5
	andi	t3,a1,-4
	add	a5,a0,a5
	li	a7,538976256
	add	t3,t3,a5
	addi	a7,a7,32
.L200:
	sw	a7,0(a5)
	addi	a5,a5,4
	bne	t3,a5,.L200
	andi	a7,a1,-4
	andi	a1,a1,3
	add	a5,a4,a7
	sub	a2,a2,a7
	beq	a1,zero,.L203
.L195:
	li	a4,32
	sb	a4,0(a5)
	li	a1,1
	ble	a2,a1,.L203
	sb	a4,1(a5)
	li	a1,2
	beq	a2,a1,.L203
	sb	a4,2(a5)
	li	a1,3
	beq	a2,a1,.L203
	sb	a4,3(a5)
	li	a1,4
	beq	a2,a1,.L203
	sb	a4,4(a5)
	li	a1,5
	beq	a2,a1,.L203
	sb	a4,5(a5)
.L203:
	lw	a5,0(s2)
	add	t4,a0,t4
	add	a0,a0,a3
	sb	a5,0(t4)
.L202:
	lbu	a5,1(s9)
	mv	s2,a6
	bne	a5,zero,.L318
	j	.L161
.L336:
	lla	a1,.LC2
	j	.L212
.L324:
	addi	a4,a3,-1
	ble	a3,a2,.L337
	sub	t3,a3,a2
	neg	a7,a0
	addi	t1,t3,-1
	li	a6,5
	andi	a5,a7,3
	bleu	t1,a6,.L338
	mv	a6,a0
	beq	a5,zero,.L218
	li	t1,32
	sb	t1,0(a0)
	andi	a7,a7,2
	addi	a6,a0,1
	addi	a4,a3,-2
	beq	a7,zero,.L218
	addi	a4,a0,-1
	sb	t1,1(a0)
	andi	a4,a4,3
	bne	a4,zero,.L488
	addi	a6,a0,3
	sb	t1,2(a0)
	addi	a4,a3,-4
.L218:
	sub	a3,t3,a5
	andi	t1,a3,-4
	add	a5,a0,a5
	li	a7,538976256
	add	t1,t1,a5
	addi	a7,a7,32
.L222:
	sw	a7,0(a5)
	addi	a5,a5,4
	bne	t1,a5,.L222
	andi	a7,a3,-4
	andi	a3,a3,3
	add	a5,a6,a7
	sub	a4,a4,a7
	beq	a3,zero,.L224
.L217:
	li	a3,32
	sb	a3,0(a5)
	addi	a6,a4,-1
	bge	a2,a4,.L224
	sb	a3,1(a5)
	addi	a7,a4,-2
	bge	a2,a6,.L224
	sb	a3,2(a5)
	addi	a6,a4,-3
	bge	a2,a7,.L224
	sb	a3,3(a5)
	addi	a4,a4,-4
	bge	a2,a6,.L224
	sb	a3,4(a5)
	bge	a2,a4,.L224
	sb	a3,5(a5)
.L224:
	add	a0,a0,t3
	addi	a3,a2,-1
	j	.L216
.L188:
	ori	a5,a5,2
	li	a2,10
	j	.L187
.L453:
	addi	a5,a1,1
.L226:
	add	a1,a1,a2
	mv	a4,a0
	j	.L230
.L489:
	addi	a5,a5,1
.L230:
	lbu	a6,-1(a5)
	addi	a4,a4,1
	sb	a6,-1(a4)
	bne	a5,a1,.L489
	j	.L231
.L352:
	li	a0,0
	j	.L160
.L327:
	addi	s4,sp,48
	mv	a0,s4
	j	.L161
.L470:
	lw	a1,24(sp)
	srli	a5,a4,2
	li	a2,1
	sw	a1,0(a0)
	beq	a5,a2,.L490
	lw	a1,28(sp)
	li	a2,3
	sw	a1,4(a0)
	bne	a5,a2,.L298
	lw	a5,32(sp)
	sw	a5,8(a0)
.L298:
	andi	a5,a4,3
	beq	a5,zero,.L300
	andi	a5,a4,-4
	add	a2,a0,a5
.L297:
	addi	a6,sp,16
	addi	a1,a5,1056
	add	a1,a1,a6
	lbu	a6,-1048(a1)
	addi	a1,a5,1
	sb	a6,0(a2)
	ble	a4,a1,.L300
	addi	a1,a5,1057
	addi	a6,sp,16
	add	a1,a1,a6
	lbu	a1,-1048(a1)
	addi	a5,a5,2
	sb	a1,1(a2)
	ble	a4,a5,.L300
	addi	a5,a5,1056
	add	a5,a5,a6
	lbu	a5,-1048(a5)
	sb	a5,2(a2)
	j	.L300
.L482:
	li	a2,9
	ble	a4,a2,.L347
	li	t4,10
	div	t1,a4,t4
	lla	a6,.LC0
	li	a2,3
	li	a1,2
	li	t3,1
	add	t1,a6,t1
	lbu	t1,0(t1)
	rem	a4,a4,t4
	sb	t1,24(sp)
	j	.L268
.L467:
	li	a7,9
	lla	a6,.LC0
	ble	a2,a7,.L283
	li	t1,10
	div	a7,a2,t1
	addi	a1,a1,1056
	addi	t3,sp,16
	add	t3,a1,t3
	addi	a1,a4,2
	add	a4,a6,a7
	lbu	a4,0(a4)
	rem	a2,a2,t1
	sb	a4,-1048(t3)
	j	.L283
.L466:
	li	t1,9
	lla	a6,.LC0
	ble	a2,t1,.L278
	li	t3,10
	div	t1,a2,t3
	addi	a1,a1,1056
	addi	t4,sp,16
	add	t4,a1,t4
	addi	a1,a4,2
	add	a4,a6,t1
	lbu	a4,0(a4)
	rem	a2,a2,t3
	sb	a4,-1048(t4)
	j	.L278
.L465:
	li	t1,9
	lla	a6,.LC0
	ble	a4,t1,.L273
	li	t3,10
	div	t1,a4,t3
	addi	a2,a2,1056
	addi	t4,sp,16
	add	t4,a2,t4
	addi	a2,a1,2
	add	a1,a6,t1
	lbu	a1,0(a1)
	rem	a4,a4,t3
	sb	a1,-1048(t4)
	j	.L273
.L471:
	addi	a7,a7,1
	addi	t1,a3,-2
	j	.L303
.L313:
	mv	s9,a2
	ori	a5,a5,2
	addi	a6,s2,4
	li	a2,10
	j	.L317
.L347:
	li	a2,2
	li	a1,1
	li	t3,0
	lla	a6,.LC0
	j	.L268
.L333:
	li	a2,8
	j	.L187
.L184:
	li	a2,10
	j	.L187
.L355:
	mv	s9,a2
	j	.L242
.L213:
	andi	a2,a5,16
	beq	a2,zero,.L324
	li	a2,0
	j	.L225
.L310:
	mv	s9,a2
	addi	a6,s2,4
	li	a2,8
	j	.L317
.L312:
	mv	s9,a2
	ori	a5,a5,64
	addi	a6,s2,4
	li	a2,16
	j	.L317
.L325:
	mv	s9,a2
	addi	a6,s2,4
	li	a2,16
	j	.L317
.L241:
	ori	a5,a5,64
	mv	s9,a2
	j	.L242
.L469:
	addi	a2,a0,2
	addi	a6,a3,-3
	j	.L287
.L315:
	mv	s9,a2
	addi	a6,s2,4
	li	a2,10
	j	.L317
.L337:
	mv	a3,a4
	j	.L216
.L194:
	lw	a5,0(s2)
	addi	a0,a0,1
	mv	s2,a6
	sb	a5,-1(a0)
	lbu	a5,1(s9)
	bne	a5,zero,.L318
	j	.L161
.L475:
	addi	a7,a0,2
	mv	t3,a2
	j	.L206
.L472:
	addi	a7,a7,2
	addi	t1,a3,-3
	j	.L303
.L476:
	addi	a7,a0,3
	addi	t3,a3,-3
	j	.L206
.L350:
	mv	a0,a7
	j	.L455
.L490:
	addi	a2,a0,4
	li	a5,4
	j	.L297
.L468:
	addi	a2,a0,1
	addi	a6,a3,-2
	j	.L287
.L253:
	lbu	a1,24(sp)
	lbu	a4,25(sp)
	li	a5,58
	sb	a1,0(a0)
	sb	a4,1(a0)
	sb	a5,2(a0)
	sb	s9,3(a0)
	sb	t2,4(a0)
	sb	a5,5(a0)
	sb	t0,6(a0)
	sb	t6,7(a0)
	sb	a5,8(a0)
	sb	t5,9(a0)
	sb	t4,10(a0)
	sb	a5,11(a0)
	sb	t3,12(a0)
	sb	t1,13(a0)
	sb	a5,14(a0)
	sb	a7,15(a0)
	j	.L254
.L478:
	lbu	a5,1(s9)
	bne	a5,zero,.L318
	j	.L161
.L285:
	mv	a3,a6
	j	.L293
.L346:
	mv	a0,a6
	j	.L255
.L348:
	mv	a5,a0
	j	.L286
.L340:
	mv	a5,a0
	j	.L233
.L480:
	addi	a4,a0,1
	addi	a1,a3,-2
	j	.L246
.L486:
	addi	a4,a0,1
	mv	a2,a7
	j	.L196
.L481:
	addi	a4,a0,2
	addi	a1,a3,-3
	j	.L246
.L487:
	addi	a4,a0,2
	addi	a2,a3,-3
	j	.L196
.L334:
	mv	a5,a0
	j	.L195
.L338:
	mv	a5,a0
	j	.L217
.L344:
	mv	a4,a0
	j	.L245
.L343:
	mv	a3,a1
	j	.L244
.L488:
	addi	a6,a0,2
	addi	a4,a3,-3
	j	.L218
.L474:
	mv	a0,a7
	j	.L202
	.size	ee_printf, .-ee_printf
	.section	.text.init_uart,"ax",@progbits
	.align	2
	.globl	init_uart
	.type	init_uart, @function
init_uart:
	li	a5,34078720
	addi	a5,a5,1
	li	a4,536870912
	sw	a5,0(a4)
	ret
	.size	init_uart, .-init_uart
	.section	.text.start_time,"ax",@progbits
	.align	2
	.globl	start_time
	.type	start_time, @function
start_time:
	li	a5,805306368
	lw	a5,0(a5)
	sw	a5,start_time_val,a4
	ret
	.size	start_time, .-start_time
	.section	.text.stop_time,"ax",@progbits
	.align	2
	.globl	stop_time
	.type	stop_time, @function
stop_time:
	li	a5,805306368
	lw	a5,0(a5)
	sw	a5,stop_time_val,a4
	ret
	.size	stop_time, .-stop_time
	.section	.text.get_time,"ax",@progbits
	.align	2
	.globl	get_time
	.type	get_time, @function
get_time:
	lw	a0,stop_time_val
	lw	a5,start_time_val
	sub	a0,a0,a5
	ret
	.size	get_time, .-get_time
	.globl	__floatunsidf
	.globl	__divdf3
	.section	.text.time_in_secs,"ax",@progbits
	.align	2
	.globl	time_in_secs
	.type	time_in_secs, @function
time_in_secs:
	addi	sp,sp,-16
	sw	ra,12(sp)
	call	__floatunsidf
	lla	a5,.LC3
	lw	a2,0(a5)
	lw	a3,4(a5)
	call	__divdf3
	lw	ra,12(sp)
	addi	sp,sp,16
	jr	ra
	.size	time_in_secs, .-time_in_secs
	.section	.text.Proc_1,"ax",@progbits
	.align	2
	.globl	Proc_1
	.type	Proc_1, @function
Proc_1:
	addi	sp,sp,-16
	sw	s2,0(sp)
	lla	s2,Ptr_Glob
	lw	a5,0(s2)
	sw	s0,8(sp)
	lw	s0,0(a0)
	lw	a3,0(a5)
	lw	t5,4(a5)
	lw	t4,8(a5)
	lw	t3,16(a5)
	lw	t1,20(a5)
	lw	a7,24(a5)
	lw	a6,28(a5)
	lw	a1,36(a5)
	lw	a2,40(a5)
	lw	a4,44(a5)
	sw	ra,12(sp)
	sw	s1,4(sp)
	mv	s1,a0
	lw	a0,32(a5)
	sw	a3,0(s0)
	lw	a3,0(s1)
	sw	t5,4(s0)
	sw	t4,8(s0)
	sw	t3,16(s0)
	sw	t1,20(s0)
	sw	a7,24(s0)
	sw	a6,28(s0)
	sw	a0,32(s0)
	sw	a1,36(s0)
	sw	a2,40(s0)
	sw	a4,44(s0)
	li	a4,5
	sw	a4,12(s1)
	sw	a3,0(s0)
	lw	a5,0(a5)
	sw	a4,12(s0)
	lw	a1,Int_Glob
	sw	a5,0(s0)
	lw	a2,0(s2)
	li	a0,10
	addi	a2,a2,12
	call	Proc_7
	lw	a5,4(s0)
	beq	a5,zero,.L500
	lw	a5,0(s1)
	lw	ra,12(sp)
	lw	s0,8(sp)
	lw	t6,0(a5)
	lw	t5,4(a5)
	lw	t4,8(a5)
	lw	t3,12(a5)
	lw	t1,16(a5)
	lw	a7,20(a5)
	lw	a6,24(a5)
	lw	a1,28(a5)
	lw	a2,32(a5)
	lw	a3,36(a5)
	lw	a4,40(a5)
	lw	a5,44(a5)
	sw	t6,0(s1)
	sw	t5,4(s1)
	sw	t4,8(s1)
	sw	t3,12(s1)
	sw	t1,16(s1)
	sw	a7,20(s1)
	sw	a6,24(s1)
	sw	a1,28(s1)
	sw	a2,32(s1)
	sw	a3,36(s1)
	sw	a4,40(s1)
	sw	a5,44(s1)
	lw	s2,0(sp)
	lw	s1,4(sp)
	addi	sp,sp,16
	jr	ra
.L500:
	lw	a0,8(s1)
	li	a5,6
	addi	a1,s0,8
	sw	a5,12(s0)
	call	Proc_6
	lw	a5,0(s2)
	lw	a0,12(s0)
	addi	a2,s0,12
	lw	a5,0(a5)
	lw	ra,12(sp)
	lw	s1,4(sp)
	sw	a5,0(s0)
	lw	s0,8(sp)
	lw	s2,0(sp)
	li	a1,10
	addi	sp,sp,16
	tail	Proc_7
	.size	Proc_1, .-Proc_1
	.section	.rodata.str1.4
	.align	2
.LC4:
	.string	"DHRYSTONE PROGRAM, 2'ND STRING"
	.align	2
.LC5:
	.string	"DHRYSTONE PROGRAM, 3'RD STRING"
	.align	2
.LC6:
	.string	"Dhrystone Benchmark"
	.align	2
.LC7:
	.string	"DHRYSTONE PROGRAM, SOME STRING"
	.align	2
.LC8:
	.string	"DHRYSTONE PROGRAM, 1'ST STRING"
	.align	2
.LC9:
	.string	"\n"
	.align	2
.LC10:
	.string	"Dhrystone Benchmark, Version 2.1 (Language: C)\n"
	.align	2
.LC11:
	.string	"Program compiled with 'register' attribute\n"
	.align	2
.LC12:
	.string	"Program compiled without 'register' attribute\n"
	.align	2
.LC13:
	.string	"Execution starts, %d runs through Dhrystone\n"
	.align	2
.LC14:
	.string	"Execution ends\n"
	.align	2
.LC15:
	.string	"Final values of the variables used in the benchmark:\n"
	.align	2
.LC16:
	.string	"Int_Glob:            %d\n"
	.align	2
.LC17:
	.string	"        should be:   %d\n"
	.align	2
.LC18:
	.string	"Bool_Glob:           %d\n"
	.align	2
.LC19:
	.string	"Ch_1_Glob:           %c\n"
	.align	2
.LC20:
	.string	"        should be:   %c\n"
	.align	2
.LC21:
	.string	"Ch_2_Glob:           %c\n"
	.align	2
.LC22:
	.string	"Arr_1_Glob[8]:       %d\n"
	.align	2
.LC23:
	.string	"Arr_2_Glob[8][7]:    %d\n"
	.align	2
.LC24:
	.string	"        should be:   Number_Of_Runs + 10\n"
	.align	2
.LC25:
	.string	"Ptr_Glob->\n"
	.align	2
.LC26:
	.string	"  Ptr_Comp:          %d\n"
	.align	2
.LC27:
	.string	"        should be:   (implementation-dependent)\n"
	.align	2
.LC28:
	.string	"  Discr:             %d\n"
	.align	2
.LC29:
	.string	"  Enum_Comp:         %d\n"
	.align	2
.LC30:
	.string	"  Int_Comp:          %d\n"
	.align	2
.LC31:
	.string	"  Str_Comp:          %s\n"
	.align	2
.LC32:
	.string	"        should be:   DHRYSTONE PROGRAM, SOME STRING\n"
	.align	2
.LC33:
	.string	"Next_Ptr_Glob->\n"
	.align	2
.LC34:
	.string	"        should be:   (implementation-dependent), same as above\n"
	.align	2
.LC35:
	.string	"Int_1_Loc:           %d\n"
	.align	2
.LC36:
	.string	"Int_2_Loc:           %d\n"
	.align	2
.LC37:
	.string	"Int_3_Loc:           %d\n"
	.align	2
.LC38:
	.string	"Enum_Loc:            %d\n"
	.align	2
.LC39:
	.string	"Str_1_Loc:           %s\n"
	.align	2
.LC40:
	.string	"        should be:   DHRYSTONE PROGRAM, 1'ST STRING\n"
	.align	2
.LC41:
	.string	"Str_2_Loc:           %s\n"
	.align	2
.LC42:
	.string	"        should be:   DHRYSTONE PROGRAM, 2'ND STRING\n"
	.align	2
.LC43:
	.string	"Measured time too small to obtain meaningful results\n"
	.align	2
.LC44:
	.string	"Please increase number of runs\n"
	.globl	__floatsisf
	.globl	__mulsf3
	.globl	__divsf3
	.align	2
.LC47:
	.string	"Microseconds for one run through Dhrystone: "
	.globl	__fixsfsi
	.align	2
.LC48:
	.string	"%d \n"
	.align	2
.LC49:
	.string	"Dhrystones per Second:                      "
	.section	.text.startup.main,"ax",@progbits
	.align	2
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-160
	li	a5,34078720
	addi	a5,a5,1
	li	a4,536870912
	sw	ra,156(sp)
	sw	s0,152(sp)
	sw	s1,148(sp)
	sw	s2,144(sp)
	sw	s3,140(sp)
	sw	s4,136(sp)
	sw	s5,132(sp)
	sw	s6,128(sp)
	sw	s7,124(sp)
	sw	s8,120(sp)
	sw	s9,116(sp)
	sw	s10,112(sp)
	sw	s11,108(sp)
	sw	a5,0(a4)
	lla	a0,.LC6
	call	ee_printf
	lla	a4,heap_memory_used2
	lw	a5,0(a4)
	lla	a3,.LANCHOR0
	li	a1,1024
	addi	a2,a5,48
	sw	a2,0(a4)
	add	a3,a3,a5
	ble	a2,a1,.L502
 #APP
# 34 "ee_printf.h" 1
	ebreak
# 0 "" 2
 #NO_APP
.L502:
	lw	a5,0(a4)
	lla	s10,Next_Ptr_Glob
	sw	a3,0(s10)
	addi	a3,a5,48
	sw	a3,0(a4)
	lla	a2,.LANCHOR0
	li	a4,1024
	add	a5,a2,a5
	ble	a3,a4,.L503
 #APP
# 34 "ee_printf.h" 1
	ebreak
# 0 "" 2
 #NO_APP
.L503:
	lw	a4,0(s10)
	addi	a0,a5,16
	sw	zero,4(a5)
	sw	a4,0(a5)
	li	a4,2
	sw	a4,8(a5)
	li	a4,40
	sw	a4,12(a5)
	lla	a1,.LC7
	lla	s9,Ptr_Glob
	sw	a5,0(s9)
	call	strcpy
	lla	a1,.LC8
	addi	a0,sp,32
	call	strcpy
	li	a5,10
	lla	a4,Arr_2_Glob
	lla	a0,.LC9
	sw	a5,1628(a4)
	call	ee_printf
	lla	a0,.LC10
	call	ee_printf
	lla	a0,.LC9
	call	ee_printf
	lw	a5,Reg
	beq	a5,zero,.L504
	lla	a0,.LC11
	call	ee_printf
	lla	a0,.LC9
	call	ee_printf
.L505:
	li	a1,1998848
	addi	a1,a1,1152
	lla	a0,.LC13
	li	s5,1498566656
	li	s1,-16842752
	li	s0,-2139062272
	call	ee_printf
	li	s3,1
	lla	s6,Ch_1_Glob
	lla	s7,Bool_Glob
	lla	s2,Ch_2_Glob
	lla	s8,Int_Glob
	addi	s5,s5,-1980
	addi	s1,s1,-257
	addi	s0,s0,128
.L518:
	li	a5,65
	sb	a5,0(s6)
	li	a5,1
	sw	a5,0(s7)
	li	a5,66
	sb	a5,0(s2)
	addi	a3,sp,64
	mv	a4,s5
	lla	a2,.LC4
.L506:
	addi	a2,a2,4
	sw	a4,0(a3)
	lw	a4,0(a2)
	addi	a3,a3,4
	add	a5,a4,s1
	not	a1,a4
	and	a5,a5,a1
	and	a5,a5,s0
	beq	a5,zero,.L506
	sb	a4,0(a3)
	andi	a5,a4,255
	beq	a5,zero,.L508
	srli	a5,a4,8
	sb	a5,1(a3)
	andi	a5,a5,255
	beq	a5,zero,.L508
	srli	a5,a4,16
	sb	a5,2(a3)
	andi	a5,a5,255
	beq	a5,zero,.L508
	srli	a4,a4,24
	sb	a4,3(a3)
.L508:
	li	a5,1
	addi	a1,sp,64
	addi	a0,sp,32
	sw	a5,28(sp)
	call	Func_2
	seqz	a5,a0
	addi	a2,sp,24
	li	a1,3
	sw	a5,0(s7)
	li	a0,2
	li	a5,7
	sw	a5,24(sp)
	call	Proc_7
	lw	a3,24(sp)
	li	a2,3
	lla	a1,Arr_2_Glob
	lla	a0,.LANCHOR0+1024
	call	Proc_8
	lw	a0,0(s9)
	call	Proc_1
	lbu	a4,0(s2)
	li	a5,64
	bleu	a4,a5,.L521
	li	s11,65
	li	s4,3
	j	.L516
.L511:
	lbu	a4,0(s2)
	addi	a5,s11,1
	andi	s11,a5,0xff
	bltu	a4,s11,.L544
.L516:
	li	a1,67
	mv	a0,s11
	call	Func_1
	lw	a4,28(sp)
	bne	a0,a4,.L511
	addi	a1,sp,28
	li	a0,0
	call	Proc_6
	addi	a2,sp,64
	mv	a3,s5
	lla	a1,.LC5
.L512:
	addi	a1,a1,4
	sw	a3,0(a2)
	lw	a3,0(a1)
	addi	a2,a2,4
	add	a4,a3,s1
	not	a0,a3
	and	a4,a4,a0
	and	a4,a4,s0
	beq	a4,zero,.L512
	sb	a3,0(a2)
	andi	a4,a3,255
	beq	a4,zero,.L514
	srli	a4,a3,8
	sb	a4,1(a2)
	andi	a4,a4,255
	beq	a4,zero,.L514
	srli	a4,a3,16
	sb	a4,2(a2)
	andi	a4,a4,255
	beq	a4,zero,.L514
	srli	a3,a3,24
	sb	a3,3(a2)
.L514:
	lbu	a4,0(s2)
	addi	a5,s11,1
	sw	s3,0(s8)
	andi	s11,a5,0xff
	mv	s4,s3
	bgeu	a4,s11,.L516
.L544:
	slli	a5,s4,1
	add	s4,a5,s4
.L510:
	lw	a6,24(sp)
	lbu	a3,0(s6)
	li	a5,65
	div	a2,s4,a6
	mv	a4,a2
	bne	a3,a5,.L517
	lw	a5,0(s8)
	addi	a4,a2,9
	sub	a4,a4,a5
.L517:
	li	a5,1998848
	addi	s3,s3,1
	addi	a5,a5,1153
	bne	s3,a5,.L518
	li	a5,805306368
	lw	a5,0(a5)
	lw	s0,start_time_val
	lla	a0,.LC14
	sub	s0,a5,s0
	sw	a4,12(sp)
	sw	a2,8(sp)
	sw	a6,4(sp)
	sw	a5,stop_time_val,a3
	sw	s0,End_Time,a5
	call	ee_printf
	lla	a0,.LC9
	call	ee_printf
	lla	a0,.LC15
	call	ee_printf
	lla	a0,.LC9
	call	ee_printf
	lw	a1,0(s8)
	lla	a0,.LC16
	call	ee_printf
	li	a1,5
	lla	a0,.LC17
	call	ee_printf
	lw	a1,0(s7)
	lla	a0,.LC18
	call	ee_printf
	li	a1,1
	lla	a0,.LC17
	call	ee_printf
	lbu	a1,0(s6)
	lla	a0,.LC19
	call	ee_printf
	li	a1,65
	lla	a0,.LC20
	call	ee_printf
	lbu	a1,0(s2)
	lla	a0,.LC21
	call	ee_printf
	li	a1,66
	lla	a0,.LC20
	call	ee_printf
	lla	a5,.LANCHOR0
	lw	a1,1056(a5)
	lla	a0,.LC22
	call	ee_printf
	li	a1,7
	lla	a0,.LC17
	call	ee_printf
	lla	a5,Arr_2_Glob
	lw	a1,1628(a5)
	lla	a0,.LC23
	call	ee_printf
	lla	a0,.LC24
	call	ee_printf
	lla	a0,.LC25
	call	ee_printf
	lw	a5,0(s9)
	lla	a0,.LC26
	lw	a1,0(a5)
	call	ee_printf
	lla	a0,.LC27
	call	ee_printf
	lw	a5,0(s9)
	lla	a0,.LC28
	lw	a1,4(a5)
	call	ee_printf
	li	a1,0
	lla	a0,.LC17
	call	ee_printf
	lw	a5,0(s9)
	lla	a0,.LC29
	lw	a1,8(a5)
	call	ee_printf
	li	a1,2
	lla	a0,.LC17
	call	ee_printf
	lw	a5,0(s9)
	lla	a0,.LC30
	lw	a1,12(a5)
	call	ee_printf
	li	a1,17
	lla	a0,.LC17
	call	ee_printf
	lw	a1,0(s9)
	lla	a0,.LC31
	addi	a1,a1,16
	call	ee_printf
	lla	a0,.LC32
	call	ee_printf
	lla	a0,.LC33
	call	ee_printf
	lw	a5,0(s10)
	lla	a0,.LC26
	lw	a1,0(a5)
	call	ee_printf
	lla	a0,.LC34
	call	ee_printf
	lw	a5,0(s10)
	lla	a0,.LC28
	lw	a1,4(a5)
	call	ee_printf
	li	a1,0
	lla	a0,.LC17
	call	ee_printf
	lw	a5,0(s10)
	lla	a0,.LC29
	lw	a1,8(a5)
	call	ee_printf
	li	a1,1
	lla	a0,.LC17
	call	ee_printf
	lw	a5,0(s10)
	lla	a0,.LC30
	lw	a1,12(a5)
	call	ee_printf
	li	a1,18
	lla	a0,.LC17
	call	ee_printf
	lw	a1,0(s10)
	lla	a0,.LC31
	addi	a1,a1,16
	call	ee_printf
	lla	a0,.LC32
	call	ee_printf
	lw	a4,12(sp)
	lla	a0,.LC35
	mv	a1,a4
	call	ee_printf
	li	a1,5
	lla	a0,.LC17
	call	ee_printf
	lw	a6,4(sp)
	lw	a2,8(sp)
	lla	a0,.LC36
	sub	s4,s4,a6
	slli	a1,s4,3
	sub	a1,a1,s4
	sub	a1,a1,a2
	call	ee_printf
	li	a1,13
	lla	a0,.LC17
	call	ee_printf
	lw	a1,24(sp)
	lla	a0,.LC37
	call	ee_printf
	li	a1,7
	lla	a0,.LC17
	call	ee_printf
	lw	a1,28(sp)
	lla	a0,.LC38
	call	ee_printf
	li	a1,1
	lla	a0,.LC17
	call	ee_printf
	addi	a1,sp,32
	lla	a0,.LC39
	call	ee_printf
	lla	a0,.LC40
	call	ee_printf
	addi	a1,sp,64
	lla	a0,.LC41
	call	ee_printf
	lla	a0,.LC42
	call	ee_printf
	lla	a0,.LC9
	call	ee_printf
	sw	s0,User_Time,a5
	li	a5,1
	ble	s0,a5,.L545
	mv	a0,s0
	call	__floatsisf
	lw	a1,.LC45
	mv	s0,a0
	call	__mulsf3
	lw	a1,.LC46
	call	__divsf3
	mv	a5,a0
	lla	s1,Microseconds
	mv	a1,s0
	lw	a0,.LC46
	sw	a5,0(s1)
	call	__divsf3
	mv	a5,a0
	lla	s0,Dhrystones_Per_Second
	lla	a0,.LC47
	sw	a5,0(s0)
	call	ee_printf
	lw	a0,0(s1)
	call	__fixsfsi
	mv	a1,a0
	lla	a0,.LC48
	call	ee_printf
	lla	a0,.LC49
	call	ee_printf
	lw	a0,0(s0)
	call	__fixsfsi
	mv	a1,a0
	lla	a0,.LC48
	call	ee_printf
	lla	a0,.LC9
	call	ee_printf
.L520:
	lw	ra,156(sp)
	lw	s0,152(sp)
	lw	s1,148(sp)
	lw	s2,144(sp)
	lw	s3,140(sp)
	lw	s4,136(sp)
	lw	s5,132(sp)
	lw	s6,128(sp)
	lw	s7,124(sp)
	lw	s8,120(sp)
	lw	s9,116(sp)
	lw	s10,112(sp)
	lw	s11,108(sp)
	addi	sp,sp,160
	jr	ra
.L521:
	li	s4,9
	j	.L510
.L545:
	lla	a0,.LC43
	call	ee_printf
	lla	a0,.LC44
	call	ee_printf
	lla	a0,.LC9
	call	ee_printf
	j	.L520
.L504:
	lla	a0,.LC12
	call	ee_printf
	lla	a0,.LC9
	call	ee_printf
	j	.L505
	.size	main, .-main
	.section	.text.Proc_2,"ax",@progbits
	.align	2
	.globl	Proc_2
	.type	Proc_2, @function
Proc_2:
	lbu	a4,Ch_1_Glob
	li	a5,65
	beq	a4,a5,.L548
	ret
.L548:
	lw	a5,0(a0)
	lw	a4,Int_Glob
	addi	a5,a5,9
	sub	a5,a5,a4
	sw	a5,0(a0)
	ret
	.size	Proc_2, .-Proc_2
	.section	.text.Proc_3,"ax",@progbits
	.align	2
	.globl	Proc_3
	.type	Proc_3, @function
Proc_3:
	lla	a5,Ptr_Glob
	lw	a2,0(a5)
	beq	a2,zero,.L550
	lw	a4,0(a2)
	sw	a4,0(a0)
	lw	a2,0(a5)
.L550:
	addi	a2,a2,12
	lw	a1,Int_Glob
	li	a0,10
	tail	Proc_7
	.size	Proc_3, .-Proc_3
	.section	.text.Proc_4,"ax",@progbits
	.align	2
	.globl	Proc_4
	.type	Proc_4, @function
Proc_4:
	lla	a4,Bool_Glob
	lw	a3,0(a4)
	lbu	a5,Ch_1_Glob
	addi	a5,a5,-65
	seqz	a5,a5
	or	a5,a5,a3
	sw	a5,0(a4)
	li	a5,66
	sb	a5,Ch_2_Glob,a4
	ret
	.size	Proc_4, .-Proc_4
	.section	.text.Proc_5,"ax",@progbits
	.align	2
	.globl	Proc_5
	.type	Proc_5, @function
Proc_5:
	li	a5,65
	sb	a5,Ch_1_Glob,a4
	sw	zero,Bool_Glob,a5
	ret
	.size	Proc_5, .-Proc_5
	.globl	Dhrystones_Per_Second
	.globl	Microseconds
	.globl	User_Time
	.globl	End_Time
	.globl	Begin_Time
	.globl	Reg
	.globl	Arr_2_Glob
	.globl	Arr_1_Glob
	.globl	Ch_2_Glob
	.globl	Ch_1_Glob
	.globl	Bool_Glob
	.globl	Int_Glob
	.globl	Next_Ptr_Glob
	.globl	Ptr_Glob
	.globl	heap_memory_used2
	.globl	heap_memory2
	.section	.srodata.cst8,"aM",@progbits,8
	.align	3
.LC3:
	.word	0
	.word	1099734072
	.section	.srodata.cst4,"aM",@progbits,4
	.align	2
.LC45:
	.word	1232348160
	.align	2
.LC46:
	.word	1457145691
	.bss
	.align	2
	.set	.LANCHOR0,. + 0
	.type	heap_memory2, @object
	.size	heap_memory2, 1024
heap_memory2:
	.zero	1024
	.type	Arr_1_Glob, @object
	.size	Arr_1_Glob, 200
Arr_1_Glob:
	.zero	200
	.type	Arr_2_Glob, @object
	.size	Arr_2_Glob, 10000
Arr_2_Glob:
	.zero	10000
	.section	.sbss,"aw",@nobits
	.align	2
	.type	Dhrystones_Per_Second, @object
	.size	Dhrystones_Per_Second, 4
Dhrystones_Per_Second:
	.zero	4
	.type	Microseconds, @object
	.size	Microseconds, 4
Microseconds:
	.zero	4
	.type	User_Time, @object
	.size	User_Time, 4
User_Time:
	.zero	4
	.type	End_Time, @object
	.size	End_Time, 4
End_Time:
	.zero	4
	.type	Begin_Time, @object
	.size	Begin_Time, 4
Begin_Time:
	.zero	4
	.type	Reg, @object
	.size	Reg, 4
Reg:
	.zero	4
	.type	Ch_2_Glob, @object
	.size	Ch_2_Glob, 1
Ch_2_Glob:
	.zero	1
	.type	Ch_1_Glob, @object
	.size	Ch_1_Glob, 1
Ch_1_Glob:
	.zero	1
	.zero	2
	.type	Bool_Glob, @object
	.size	Bool_Glob, 4
Bool_Glob:
	.zero	4
	.type	Int_Glob, @object
	.size	Int_Glob, 4
Int_Glob:
	.zero	4
	.type	Next_Ptr_Glob, @object
	.size	Next_Ptr_Glob, 4
Next_Ptr_Glob:
	.zero	4
	.type	Ptr_Glob, @object
	.size	Ptr_Glob, 4
Ptr_Glob:
	.zero	4
	.type	stop_time_val, @object
	.size	stop_time_val, 4
stop_time_val:
	.zero	4
	.type	start_time_val, @object
	.size	start_time_val, 4
start_time_val:
	.zero	4
	.type	heap_memory_used2, @object
	.size	heap_memory_used2, 4
heap_memory_used2:
	.zero	4
	.ident	"GCC: () 12.2.0"
