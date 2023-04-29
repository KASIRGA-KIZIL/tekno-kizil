	.file	"ee_printf.c"
	.option nopic
	.attribute arch, "rv32i2p0_m2p0_c2p0"
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
	.align	1
	.type	number, @function
number:
	addi	sp,sp,-96
	sw	s0,92(sp)
	sw	s1,88(sp)
	andi	a6,a5,64
	lla	t4,.LC1
	bne	a6,zero,.L2
	lla	t4,.LC0
.L2:
	andi	s0,a5,16
	bne	s0,zero,.L3
	andi	a6,a5,1
	andi	s1,a5,17
	li	t2,48
	beq	a6,zero,.L5
	andi	a6,a5,2
	andi	t5,a5,32
	beq	a6,zero,.L33
.L68:
	blt	a1,zero,.L60
	andi	a6,a5,4
	bne	a6,zero,.L61
	andi	a5,a5,8
	li	t6,0
	beq	a5,zero,.L6
	addi	a3,a3,-1
	li	t6,32
.L6:
	beq	t5,zero,.L11
.L8:
	li	a5,16
	beq	a2,a5,.L62
	addi	a5,a2,-8
	seqz	a5,a5
	sub	a3,a3,a5
.L11:
	bne	a1,zero,.L9
	li	a5,48
	sb	a5,12(sp)
	li	a6,1
	addi	t0,sp,12
.L13:
	mv	a7,a6
	bge	a6,a4,.L15
	mv	a7,a4
.L15:
	sub	a3,a3,a7
	bne	s1,zero,.L16
	add	a4,a0,a3
	li	a5,32
	ble	a3,zero,.L63
.L18:
	addi	a0,a0,1
	sb	a5,-1(a0)
	bne	a0,a4,.L18
	li	a3,-1
.L16:
	beq	t6,zero,.L19
	sb	t6,0(a0)
	addi	a0,a0,1
.L19:
	beq	t5,zero,.L20
	li	a5,8
	beq	a2,a5,.L64
	li	a5,16
	beq	a2,a5,.L65
.L20:
	bne	s0,zero,.L22
	add	a5,a0,a3
	ble	a3,zero,.L66
.L24:
	addi	a0,a0,1
	sb	t2,-1(a0)
	bne	a5,a0,.L24
	li	a3,-1
.L22:
	sub	a5,a7,a6
	add	a5,a0,a5
	li	a4,48
	bge	a6,a7,.L67
.L25:
	addi	a0,a0,1
	sb	a4,-1(a0)
	bne	a5,a0,.L25
.L26:
	add	a4,t0,a1
	mv	a2,a5
.L28:
	lbu	a6,0(a4)
	mv	a0,a4
	addi	a2,a2,1
	sb	a6,-1(a2)
	addi	a4,a4,-1
	bne	t0,a0,.L28
	addi	a1,a1,1
	add	a1,a5,a1
	ble	a3,zero,.L36
	add	a0,a1,a3
	li	a5,32
.L30:
	addi	a1,a1,1
	sb	a5,-1(a1)
	bne	a0,a1,.L30
.L1:
	lw	s0,92(sp)
	lw	s1,88(sp)
	addi	sp,sp,96
	jr	ra
.L33:
	li	t6,0
	j	.L6
.L3:
	andi	a5,a5,-2
	mv	s1,s0
.L5:
	andi	a6,a5,2
	li	t2,32
	andi	t5,a5,32
	beq	a6,zero,.L33
	j	.L68
.L60:
	neg	a1,a1
	addi	a3,a3,-1
	li	t6,45
	bne	t5,zero,.L8
.L9:
	mv	a5,a1
	li	a6,0
	addi	t0,sp,12
.L14:
	remu	a7,a5,a2
	mv	a1,a6
	addi	a6,a6,1
	add	t3,t0,a6
	mv	t1,a5
	add	a7,t4,a7
	lbu	a7,0(a7)
	divu	a5,a5,a2
	sb	a7,-1(t3)
	bgeu	t1,a2,.L14
	j	.L13
.L61:
	addi	a3,a3,-1
	li	t6,43
	j	.L6
.L65:
	li	a5,48
	sb	a5,0(a0)
	li	a5,120
	sb	a5,1(a0)
	addi	a0,a0,2
	j	.L20
.L64:
	li	a5,48
	sb	a5,0(a0)
	addi	a0,a0,1
	j	.L20
.L62:
	addi	a3,a3,-2
	j	.L11
.L36:
	mv	a0,a1
	j	.L1
.L67:
	mv	a5,a0
	j	.L26
.L63:
	addi	a3,a3,-1
	j	.L16
.L66:
	addi	a3,a3,-1
	j	.L22
	.size	number, .-number
	.section	.text.uart_txfull,"ax",@progbits
	.align	1
	.globl	uart_txfull
	.type	uart_txfull, @function
uart_txfull:
	li	a5,536870912
	lw	a0,4(a5)
	andi	a0,a0,1
	ret
	.size	uart_txfull, .-uart_txfull
	.section	.text.zputchar,"ax",@progbits
	.align	1
	.globl	zputchar
	.type	zputchar, @function
zputchar:
	li	a4,536870912
.L71:
	lw	a5,4(a4)
	andi	a5,a5,1
	bne	a5,zero,.L71
	sw	a0,12(a4)
	ret
	.size	zputchar, .-zputchar
	.section	.text.print,"ax",@progbits
	.align	1
	.globl	print
	.type	print, @function
print:
	lbu	a3,0(a0)
	beq	a3,zero,.L73
	li	a4,536870912
.L76:
	addi	a0,a0,1
.L75:
	lw	a5,4(a4)
	andi	a5,a5,1
	bne	a5,zero,.L75
	sw	a3,12(a4)
	lbu	a3,0(a0)
	bne	a3,zero,.L76
.L73:
	ret
	.size	print, .-print
	.section	.text.uart_send_char,"ax",@progbits
	.align	1
	.globl	uart_send_char
	.type	uart_send_char, @function
uart_send_char:
	li	a4,536870912
.L83:
	lw	a5,4(a4)
	andi	a5,a5,1
	bne	a5,zero,.L83
	sw	a0,12(a4)
	ret
	.size	uart_send_char, .-uart_send_char
	.section	.rodata.str1.4
	.align	2
.LC2:
	.string	"<NULL>"
	.section	.text.ee_printf,"ax",@progbits
	.align	1
	.globl	ee_printf
	.type	ee_printf, @function
ee_printf:
	addi	sp,sp,-1168
	sw	a4,1152(sp)
	sw	ra,1132(sp)
	sw	s0,1128(sp)
	sw	s1,1124(sp)
	sw	s2,1120(sp)
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
	sw	a5,1156(sp)
	sw	a6,1160(sp)
	sw	a7,1164(sp)
	lbu	a5,0(a0)
	addi	a4,sp,1140
	sw	a4,20(sp)
	beq	a5,zero,.L174
	addi	s3,sp,48
	mv	t1,a0
	mv	s4,a4
	mv	a0,s3
	li	s2,37
	li	s1,16
	lla	s0,.L91
	li	s11,9
	li	s9,46
	li	s10,76
	li	s8,55
.L163:
	beq	a5,s2,.L175
	sb	a5,0(a0)
	lbu	a5,1(t1)
	addi	a0,a0,1
	addi	t1,t1,1
	bne	a5,zero,.L163
.L86:
	sb	zero,0(a0)
	lbu	a2,48(sp)
	beq	a2,zero,.L190
.L237:
	mv	a3,s3
	li	a4,536870912
.L165:
	lw	a5,4(a4)
	andi	a5,a5,1
	bne	a5,zero,.L165
	sw	a2,12(a4)
	lbu	a2,1(a3)
	addi	a5,a3,1
	beq	a2,zero,.L232
	mv	a3,a5
	j	.L165
.L175:
	li	a5,0
.L87:
	lbu	a2,1(t1)
	addi	a1,t1,1
	addi	a4,a2,-32
	andi	a4,a4,0xff
	bgtu	a4,s1,.L89
	slli	a4,a4,2
	add	a4,a4,s0
	lw	a4,0(a4)
	add	a4,a4,s0
	jr	a4
	.section	.rodata
	.align	2
	.align	2
.L91:
	.word	.L95-.L91
	.word	.L89-.L91
	.word	.L89-.L91
	.word	.L94-.L91
	.word	.L89-.L91
	.word	.L89-.L91
	.word	.L89-.L91
	.word	.L89-.L91
	.word	.L89-.L91
	.word	.L89-.L91
	.word	.L89-.L91
	.word	.L93-.L91
	.word	.L89-.L91
	.word	.L92-.L91
	.word	.L89-.L91
	.word	.L89-.L91
	.word	.L90-.L91
	.section	.text.ee_printf
.L89:
	addi	a4,a2,-48
	andi	a4,a4,0xff
	bleu	a4,s11,.L233
	li	a4,42
	li	a3,-1
	beq	a2,a4,.L234
.L99:
	li	a4,-1
	beq	a2,s9,.L235
.L100:
	andi	a6,a2,223
	beq	a6,s10,.L236
	addi	a6,a2,-65
	andi	a6,a6,0xff
	bgtu	a6,s8,.L192
	lla	a7,.L170
	slli	a6,a6,2
	add	a6,a6,a7
	lw	a6,0(a6)
	add	a6,a6,a7
	jr	a6
	.section	.rodata
	.align	2
	.align	2
.L170:
	.word	.L134-.L170
	.word	.L192-.L170
	.word	.L192-.L170
	.word	.L192-.L170
	.word	.L192-.L170
	.word	.L192-.L170
	.word	.L192-.L170
	.word	.L192-.L170
	.word	.L192-.L170
	.word	.L192-.L170
	.word	.L192-.L170
	.word	.L192-.L170
	.word	.L192-.L170
	.word	.L192-.L170
	.word	.L192-.L170
	.word	.L192-.L170
	.word	.L192-.L170
	.word	.L192-.L170
	.word	.L192-.L170
	.word	.L192-.L170
	.word	.L192-.L170
	.word	.L192-.L170
	.word	.L192-.L170
	.word	.L157-.L170
	.word	.L192-.L170
	.word	.L192-.L170
	.word	.L192-.L170
	.word	.L192-.L170
	.word	.L192-.L170
	.word	.L192-.L170
	.word	.L192-.L170
	.word	.L192-.L170
	.word	.L193-.L170
	.word	.L192-.L170
	.word	.L194-.L170
	.word	.L158-.L170
	.word	.L192-.L170
	.word	.L192-.L170
	.word	.L192-.L170
	.word	.L192-.L170
	.word	.L158-.L170
	.word	.L192-.L170
	.word	.L192-.L170
	.word	.L192-.L170
	.word	.L192-.L170
	.word	.L192-.L170
	.word	.L155-.L170
	.word	.L195-.L170
	.word	.L192-.L170
	.word	.L192-.L170
	.word	.L196-.L170
	.word	.L192-.L170
	.word	.L160-.L170
	.word	.L192-.L170
	.word	.L192-.L170
	.word	.L169-.L170
	.section	.text.ee_printf
.L90:
	ori	a5,a5,1
	mv	t1,a1
	j	.L87
.L92:
	ori	a5,a5,16
	mv	t1,a1
	j	.L87
.L93:
	ori	a5,a5,4
	mv	t1,a1
	j	.L87
.L94:
	ori	a5,a5,32
	mv	t1,a1
	j	.L87
.L95:
	ori	a5,a5,8
	mv	t1,a1
	j	.L87
.L192:
	mv	s5,a1
.L106:
	li	a5,37
	beq	a2,a5,.L159
	sb	a5,0(a0)
	lbu	a5,0(s5)
	addi	a0,a0,1
	bne	a5,zero,.L167
	sb	zero,0(a0)
	lbu	a2,48(sp)
	bne	a2,zero,.L237
.L190:
	li	a0,0
	j	.L85
.L236:
	mv	a7,a2
	lbu	a2,1(a1)
	addi	s5,a1,1
	addi	a6,a2,-65
	andi	a6,a6,0xff
	bgtu	a6,s8,.L106
	lla	t1,.L108
	slli	a6,a6,2
	add	a6,a6,t1
	lw	a6,0(a6)
	add	a6,a6,t1
	jr	a6
	.section	.rodata
	.align	2
	.align	2
.L108:
	.word	.L117-.L108
	.word	.L106-.L108
	.word	.L106-.L108
	.word	.L106-.L108
	.word	.L106-.L108
	.word	.L106-.L108
	.word	.L106-.L108
	.word	.L106-.L108
	.word	.L106-.L108
	.word	.L106-.L108
	.word	.L106-.L108
	.word	.L106-.L108
	.word	.L106-.L108
	.word	.L106-.L108
	.word	.L106-.L108
	.word	.L106-.L108
	.word	.L106-.L108
	.word	.L106-.L108
	.word	.L106-.L108
	.word	.L106-.L108
	.word	.L106-.L108
	.word	.L106-.L108
	.word	.L106-.L108
	.word	.L116-.L108
	.word	.L106-.L108
	.word	.L106-.L108
	.word	.L106-.L108
	.word	.L106-.L108
	.word	.L106-.L108
	.word	.L106-.L108
	.word	.L106-.L108
	.word	.L106-.L108
	.word	.L115-.L108
	.word	.L106-.L108
	.word	.L114-.L108
	.word	.L113-.L108
	.word	.L106-.L108
	.word	.L106-.L108
	.word	.L106-.L108
	.word	.L106-.L108
	.word	.L113-.L108
	.word	.L106-.L108
	.word	.L106-.L108
	.word	.L106-.L108
	.word	.L106-.L108
	.word	.L106-.L108
	.word	.L180-.L108
	.word	.L111-.L108
	.word	.L106-.L108
	.word	.L106-.L108
	.word	.L110-.L108
	.word	.L106-.L108
	.word	.L109-.L108
	.word	.L106-.L108
	.word	.L106-.L108
	.word	.L230-.L108
	.section	.text.ee_printf
.L232:
	sub	a3,a3,s3
	addi	a0,a3,1
.L85:
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
.L235:
	lbu	a2,1(a1)
	li	a7,9
	addi	a6,a1,1
	addi	a4,a2,-48
	andi	a4,a4,0xff
	bleu	a4,a7,.L238
	li	a4,42
	beq	a2,a4,.L239
	mv	a1,a6
	li	a4,0
	j	.L100
.L233:
	li	a3,0
	li	a6,9
.L98:
	slli	a4,a3,2
	add	a4,a4,a3
	addi	a1,a1,1
	slli	a4,a4,1
	add	a4,a4,a2
	lbu	a2,0(a1)
	addi	a3,a4,-48
	addi	a4,a2,-48
	andi	a4,a4,0xff
	bleu	a4,a6,.L98
	j	.L99
.L234:
	lw	a3,0(s4)
	lbu	a2,2(t1)
	addi	a1,t1,2
	addi	s4,s4,4
	bge	a3,zero,.L99
	neg	a3,a3
	ori	a5,a5,16
	j	.L99
.L117:
	ori	a5,a5,64
.L115:
	li	a4,108
	beq	a7,a4,.L240
.L135:
	lw	t3,0(s4)
	li	a1,0
	li	a4,0
	add	a2,t3,a1
	lbu	a2,0(a2)
	sw	a5,8(sp)
	sw	a3,12(sp)
	addi	t6,s4,4
	li	t2,99
	lla	t4,.LC0
	li	s6,100
	li	s7,10
	li	t0,48
	li	t1,4
	li	t5,46
	addi	a6,a4,1
	bne	a2,zero,.L144
.L241:
	addi	a5,a4,1056
	addi	a4,sp,16
	add	a4,a5,a4
	sb	t0,-1048(a4)
	addi	a1,a1,1
	beq	a1,t1,.L148
.L242:
	addi	a5,a6,1056
	addi	a4,sp,16
	add	a2,a5,a4
	sb	t5,-1048(a2)
	add	a2,t3,a1
	lbu	a2,0(a2)
	addi	a4,a6,1
	addi	a6,a4,1
	beq	a2,zero,.L241
.L144:
	ble	a2,t2,.L146
	rem	a5,a2,s6
	addi	a3,a4,1056
	addi	a7,sp,16
	add	a7,a3,a7
	mv	a3,a7
	addi	a6,a6,1056
	addi	a7,sp,16
	add	a6,a6,a7
	sw	a6,4(sp)
	addi	a4,a4,2
	mv	a7,t4
	addi	a6,a4,1
	div	a2,a2,s6
	div	s4,a5,s7
	add	a2,t4,a2
	lbu	a2,0(a2)
	sb	a2,-1048(a3)
	add	s4,t4,s4
	rem	a2,a5,s7
	lbu	s4,0(s4)
	lw	a5,4(sp)
	sb	s4,-1048(a5)
.L147:
	add	a7,a7,a2
	lbu	a2,0(a7)
	addi	a5,a4,1056
	addi	a4,sp,16
	add	a4,a5,a4
	sb	a2,-1048(a4)
	addi	a1,a1,1
	bne	a1,t1,.L242
.L148:
	lw	a5,8(sp)
	lw	a3,12(sp)
	andi	a5,a5,16
	bne	a5,zero,.L150
	addi	a2,a3,-1
	ble	a3,a6,.L187
	sub	a5,a3,a6
	add	a5,a0,a5
	li	a4,32
.L151:
	addi	a0,a0,1
	sb	a4,-1(a0)
	bne	a5,a0,.L151
	sub	a3,a6,a3
	add	a3,a3,a2
.L150:
	addi	a2,sp,24
	add	a5,a0,a6
	mv	a4,a0
.L152:
	lbu	a1,0(a2)
	addi	a4,a4,1
	addi	a2,a2,1
	sb	a1,-1(a4)
	bne	a5,a4,.L152
	bge	a6,a3,.L188
	add	a0,a0,a3
	li	a4,32
.L154:
	addi	a5,a5,1
	sb	a4,-1(a5)
	bne	a0,a5,.L154
.L153:
	lbu	a5,1(s5)
	addi	t1,s5,1
	mv	s4,t6
	bne	a5,zero,.L163
	j	.L86
.L116:
	ori	a5,a5,64
.L230:
	li	a2,16
.L112:
	addi	a6,s4,4
.L162:
	lw	a1,0(s4)
	mv	s4,a6
	call	number
	lbu	a5,1(s5)
	addi	t1,s5,1
	bne	a5,zero,.L163
	j	.L86
.L194:
	mv	s5,a1
.L114:
	andi	a5,a5,16
	addi	a2,s4,4
	addi	t1,s5,1
	beq	a5,zero,.L243
.L118:
	lw	a5,0(s4)
	li	a1,1
	addi	a4,a0,1
	sb	a5,0(a0)
	li	a5,32
	add	a0,a0,a3
	ble	a3,a1,.L244
.L122:
	addi	a4,a4,1
	sb	a5,-1(a4)
	bne	a4,a0,.L122
	lbu	a5,1(s5)
	mv	s4,a2
	bne	a5,zero,.L163
	j	.L86
.L196:
	mv	s5,a1
.L110:
	lw	a2,0(s4)
	addi	s4,s4,4
	beq	a2,zero,.L181
	lbu	a1,0(a2)
	beq	a1,zero,.L124
.L123:
	beq	a4,zero,.L124
	mv	a1,a2
	j	.L126
.L245:
	sub	a6,a1,a4
	beq	a6,a2,.L125
.L126:
	lbu	a6,1(a1)
	addi	a1,a1,1
	bne	a6,zero,.L245
.L125:
	andi	a4,a5,16
	sub	a5,a1,a2
	beq	a4,zero,.L246
.L127:
	ble	a5,zero,.L183
	add	a6,a2,a5
	mv	a4,a0
.L130:
	lbu	a1,0(a2)
	addi	a2,a2,1
	addi	a4,a4,1
	sb	a1,-1(a4)
	bne	a2,a6,.L130
	add	a4,a0,a5
.L129:
	sub	a0,a3,a5
	addi	t1,s5,1
	add	a0,a4,a0
	li	a2,32
	ble	a3,a5,.L171
.L132:
	addi	a4,a4,1
	sb	a2,-1(a4)
	bne	a4,a0,.L132
	lbu	a5,1(s5)
	bne	a5,zero,.L163
	j	.L86
.L195:
	mv	s5,a1
.L111:
	li	a2,-1
	beq	a3,a2,.L247
.L133:
	lw	a1,0(s4)
	li	a2,16
	addi	s4,s4,4
	call	number
	lbu	a5,1(s5)
	addi	t1,s5,1
	bne	a5,zero,.L163
	j	.L86
.L146:
	li	a5,9
	mv	a7,t4
	ble	a2,a5,.L147
	li	s4,10
	div	a5,a2,s4
	lla	a7,.LC0
	addi	a4,a4,1056
	addi	a3,sp,16
	add	a3,a4,a3
	mv	a4,a6
	addi	a6,a6,1
	rem	a2,a2,s4
	add	s4,a7,a5
	lbu	s4,0(s4)
	sb	s4,-1048(a3)
	j	.L147
.L238:
	li	a4,0
	mv	t1,a4
.L102:
	slli	a4,t1,2
	add	a4,a4,t1
	addi	a6,a6,1
	slli	a4,a4,1
	add	a4,a4,a2
	lbu	a2,0(a6)
	addi	t1,a4,-48
	addi	a1,a2,-48
	andi	a1,a1,0xff
	bleu	a1,a7,.L102
	mv	a4,t1
	mv	a1,a6
	j	.L100
.L239:
	lw	a4,0(s4)
	addi	a6,a1,2
	lbu	a2,2(a1)
	not	a1,a4
	srai	a1,a1,31
	and	a4,a4,a1
	addi	s4,s4,4
	mv	a1,a6
	j	.L100
.L240:
	andi	a4,a5,64
	lla	t1,.LC0
	beq	a4,zero,.L136
	lla	t1,.LC1
.L136:
	lw	t4,0(s4)
	li	a2,0
	li	a7,0
	li	t3,6
	li	t5,58
	j	.L138
.L248:
	addi	a4,a7,1058
	add	a6,a4,t2
	addi	a7,a7,3
	sb	t5,-1048(a6)
.L138:
	add	a4,t4,a2
	lbu	a4,0(a4)
	addi	t2,sp,16
	addi	a2,a2,1
	srli	a6,a4,4
	andi	a4,a4,15
	add	a4,t1,a4
	add	a6,t1,a6
	lbu	t6,0(a4)
	lbu	t0,0(a6)
	addi	a4,a7,1056
	add	a4,a4,t2
	sb	t0,-1048(a4)
	sb	t6,-1047(a4)
	bne	a2,t3,.L248
	andi	a5,a5,16
	bne	a5,zero,.L139
	li	a5,17
	addi	a2,a3,-1
	ble	a3,a5,.L185
	addi	a5,a3,-17
	add	a5,a0,a5
	li	a4,32
.L140:
	addi	a0,a0,1
	sb	a4,-1(a0)
	bne	a0,a5,.L140
	sub	a2,a2,a3
	addi	a3,a2,17
.L139:
	addi	a2,sp,24
	addi	a5,a0,17
	mv	a4,a0
.L141:
	lbu	a6,0(a2)
	addi	a4,a4,1
	addi	a2,a2,1
	sb	a6,-1(a4)
	bne	a4,a5,.L141
	li	a2,17
	ble	a3,a2,.L186
	add	a0,a0,a3
	li	a4,32
.L143:
	addi	a5,a5,1
	sb	a4,-1(a5)
	bne	a0,a5,.L143
.L142:
	lbu	a5,2(a1)
	addi	s4,s4,4
	addi	t1,a1,2
	bne	a5,zero,.L163
	j	.L86
.L159:
	lbu	a5,0(s5)
.L167:
	sb	a5,0(a0)
	lbu	a5,1(s5)
	addi	a0,a0,1
	addi	t1,s5,1
	bne	a5,zero,.L163
	j	.L86
.L247:
	ori	a5,a5,1
	li	a3,8
	j	.L133
.L181:
	lla	a2,.LC2
	j	.L123
.L243:
	li	a5,1
	ble	a3,a5,.L119
	addi	a5,a3,-1
	add	a5,a0,a5
	li	a4,32
.L120:
	addi	a0,a0,1
	sb	a4,-1(a0)
	bne	a0,a5,.L120
	li	a3,0
	j	.L118
.L113:
	ori	a5,a5,2
	li	a2,10
	j	.L112
.L174:
	addi	s3,sp,48
	mv	a0,s3
	j	.L86
.L246:
	addi	a6,a3,-1
	bge	a5,a3,.L182
.L172:
	sub	a4,a3,a5
	add	a4,a0,a4
	li	a1,32
.L128:
	addi	a0,a0,1
	sb	a1,-1(a0)
	bne	a0,a4,.L128
	sub	a3,a5,a3
	add	a3,a3,a6
	j	.L127
.L158:
	ori	a5,a5,2
	addi	a6,s4,4
	mv	s5,a1
	li	a2,10
	j	.L162
.L180:
	li	a2,8
	j	.L112
.L109:
	li	a2,10
	j	.L112
.L193:
	mv	s5,a1
	j	.L135
.L124:
	andi	a5,a5,16
	beq	a5,zero,.L168
	mv	a4,a0
	li	a5,0
	j	.L129
.L134:
	ori	a5,a5,64
	mv	s5,a1
	j	.L135
.L160:
	addi	a6,s4,4
	mv	s5,a1
	li	a2,10
	j	.L162
.L157:
	ori	a5,a5,64
	addi	a6,s4,4
	mv	s5,a1
	li	a2,16
	j	.L162
.L169:
	addi	a6,s4,4
	mv	s5,a1
	li	a2,16
	j	.L162
.L155:
	addi	a6,s4,4
	mv	s5,a1
	li	a2,8
	j	.L162
.L119:
	lw	a5,0(s4)
	addi	a0,a0,1
	mv	s4,a2
	sb	a5,-1(a0)
	lbu	a5,1(s5)
	bne	a5,zero,.L163
	j	.L86
.L188:
	mv	a0,a5
	j	.L153
.L168:
	addi	a6,a3,-1
	bgt	a3,zero,.L172
	addi	t1,s5,1
	mv	a4,a0
.L171:
	lbu	a5,1(s5)
	mv	a0,a4
	bne	a5,zero,.L163
	j	.L86
.L187:
	mv	a3,a2
	j	.L150
.L186:
	mv	a0,a4
	j	.L142
.L244:
	lbu	a5,1(s5)
	mv	s4,a2
	mv	a0,a4
	bne	a5,zero,.L163
	j	.L86
.L183:
	mv	a4,a0
	j	.L129
.L182:
	mv	a3,a6
	j	.L127
.L185:
	mv	a3,a2
	j	.L139
	.size	ee_printf, .-ee_printf
	.ident	"GCC: (g2ee5e430018) 12.2.0"
