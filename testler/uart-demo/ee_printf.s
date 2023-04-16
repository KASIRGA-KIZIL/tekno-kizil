	.file	"ee_printf.c"
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
	.section	.text.zputchar,"ax",@progbits
	.align	2
	.globl	zputchar
	.type	zputchar, @function
zputchar:
	li	a4,536870912
.L70:
	lw	a5,4(a4)
	andi	a5,a5,1
	bne	a5,zero,.L70
	sb	a0,12(a4)
	ret
	.size	zputchar, .-zputchar
	.section	.text.print,"ax",@progbits
	.align	2
	.globl	print
	.type	print, @function
print:
	lbu	a3,0(a0)
	beq	a3,zero,.L72
	li	a4,536870912
.L75:
	addi	a0,a0,1
.L74:
	lw	a5,4(a4)
	andi	a5,a5,1
	bne	a5,zero,.L74
	sb	a3,12(a4)
	lbu	a3,0(a0)
	bne	a3,zero,.L75
.L72:
	ret
	.size	print, .-print
	.section	.text.uart_send_char,"ax",@progbits
	.align	2
	.globl	uart_send_char
	.type	uart_send_char, @function
uart_send_char:
	li	a4,536870912
.L82:
	lw	a5,4(a4)
	andi	a5,a5,1
	bne	a5,zero,.L82
	sb	a0,12(a4)
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
	beq	a5,zero,.L173
	addi	s3,sp,48
	mv	t1,a0
	mv	s4,a4
	mv	a0,s3
	li	s2,37
	li	s1,16
	lla	s0,.L90
	li	s11,9
	li	s9,46
	li	s10,76
	li	s8,55
.L162:
	beq	a5,s2,.L174
	sb	a5,0(a0)
	lbu	a5,1(t1)
	addi	a0,a0,1
	addi	t1,t1,1
	bne	a5,zero,.L162
.L85:
	sb	zero,0(a0)
	lbu	a2,48(sp)
	beq	a2,zero,.L189
.L236:
	mv	a3,s3
	li	a4,536870912
.L164:
	lw	a5,4(a4)
	andi	a5,a5,1
	bne	a5,zero,.L164
	sb	a2,12(a4)
	lbu	a2,1(a3)
	addi	a5,a3,1
	beq	a2,zero,.L231
	mv	a3,a5
	j	.L164
.L174:
	li	a5,0
.L86:
	lbu	a2,1(t1)
	addi	a1,t1,1
	addi	a4,a2,-32
	andi	a4,a4,0xff
	bgtu	a4,s1,.L88
	slli	a4,a4,2
	add	a4,a4,s0
	lw	a4,0(a4)
	add	a4,a4,s0
	jr	a4
	.section	.rodata
	.align	2
	.align	2
.L90:
	.word	.L94-.L90
	.word	.L88-.L90
	.word	.L88-.L90
	.word	.L93-.L90
	.word	.L88-.L90
	.word	.L88-.L90
	.word	.L88-.L90
	.word	.L88-.L90
	.word	.L88-.L90
	.word	.L88-.L90
	.word	.L88-.L90
	.word	.L92-.L90
	.word	.L88-.L90
	.word	.L91-.L90
	.word	.L88-.L90
	.word	.L88-.L90
	.word	.L89-.L90
	.section	.text.ee_printf
.L88:
	addi	a4,a2,-48
	andi	a4,a4,0xff
	bleu	a4,s11,.L232
	li	a4,42
	li	a3,-1
	beq	a2,a4,.L233
.L98:
	li	a4,-1
	beq	a2,s9,.L234
.L99:
	andi	a6,a2,223
	beq	a6,s10,.L235
	addi	a6,a2,-65
	andi	a6,a6,0xff
	bgtu	a6,s8,.L191
	lla	a7,.L169
	slli	a6,a6,2
	add	a6,a6,a7
	lw	a6,0(a6)
	add	a6,a6,a7
	jr	a6
	.section	.rodata
	.align	2
	.align	2
.L169:
	.word	.L133-.L169
	.word	.L191-.L169
	.word	.L191-.L169
	.word	.L191-.L169
	.word	.L191-.L169
	.word	.L191-.L169
	.word	.L191-.L169
	.word	.L191-.L169
	.word	.L191-.L169
	.word	.L191-.L169
	.word	.L191-.L169
	.word	.L191-.L169
	.word	.L191-.L169
	.word	.L191-.L169
	.word	.L191-.L169
	.word	.L191-.L169
	.word	.L191-.L169
	.word	.L191-.L169
	.word	.L191-.L169
	.word	.L191-.L169
	.word	.L191-.L169
	.word	.L191-.L169
	.word	.L191-.L169
	.word	.L156-.L169
	.word	.L191-.L169
	.word	.L191-.L169
	.word	.L191-.L169
	.word	.L191-.L169
	.word	.L191-.L169
	.word	.L191-.L169
	.word	.L191-.L169
	.word	.L191-.L169
	.word	.L192-.L169
	.word	.L191-.L169
	.word	.L193-.L169
	.word	.L157-.L169
	.word	.L191-.L169
	.word	.L191-.L169
	.word	.L191-.L169
	.word	.L191-.L169
	.word	.L157-.L169
	.word	.L191-.L169
	.word	.L191-.L169
	.word	.L191-.L169
	.word	.L191-.L169
	.word	.L191-.L169
	.word	.L154-.L169
	.word	.L194-.L169
	.word	.L191-.L169
	.word	.L191-.L169
	.word	.L195-.L169
	.word	.L191-.L169
	.word	.L159-.L169
	.word	.L191-.L169
	.word	.L191-.L169
	.word	.L168-.L169
	.section	.text.ee_printf
.L89:
	ori	a5,a5,1
	mv	t1,a1
	j	.L86
.L91:
	ori	a5,a5,16
	mv	t1,a1
	j	.L86
.L92:
	ori	a5,a5,4
	mv	t1,a1
	j	.L86
.L93:
	ori	a5,a5,32
	mv	t1,a1
	j	.L86
.L94:
	ori	a5,a5,8
	mv	t1,a1
	j	.L86
.L191:
	mv	s5,a1
.L105:
	li	a5,37
	beq	a2,a5,.L158
	sb	a5,0(a0)
	lbu	a5,0(s5)
	addi	a0,a0,1
	bne	a5,zero,.L166
	sb	zero,0(a0)
	lbu	a2,48(sp)
	bne	a2,zero,.L236
.L189:
	li	a0,0
	j	.L84
.L235:
	mv	a7,a2
	lbu	a2,1(a1)
	addi	s5,a1,1
	addi	a6,a2,-65
	andi	a6,a6,0xff
	bgtu	a6,s8,.L105
	lla	t1,.L107
	slli	a6,a6,2
	add	a6,a6,t1
	lw	a6,0(a6)
	add	a6,a6,t1
	jr	a6
	.section	.rodata
	.align	2
	.align	2
.L107:
	.word	.L116-.L107
	.word	.L105-.L107
	.word	.L105-.L107
	.word	.L105-.L107
	.word	.L105-.L107
	.word	.L105-.L107
	.word	.L105-.L107
	.word	.L105-.L107
	.word	.L105-.L107
	.word	.L105-.L107
	.word	.L105-.L107
	.word	.L105-.L107
	.word	.L105-.L107
	.word	.L105-.L107
	.word	.L105-.L107
	.word	.L105-.L107
	.word	.L105-.L107
	.word	.L105-.L107
	.word	.L105-.L107
	.word	.L105-.L107
	.word	.L105-.L107
	.word	.L105-.L107
	.word	.L105-.L107
	.word	.L115-.L107
	.word	.L105-.L107
	.word	.L105-.L107
	.word	.L105-.L107
	.word	.L105-.L107
	.word	.L105-.L107
	.word	.L105-.L107
	.word	.L105-.L107
	.word	.L105-.L107
	.word	.L114-.L107
	.word	.L105-.L107
	.word	.L113-.L107
	.word	.L112-.L107
	.word	.L105-.L107
	.word	.L105-.L107
	.word	.L105-.L107
	.word	.L105-.L107
	.word	.L112-.L107
	.word	.L105-.L107
	.word	.L105-.L107
	.word	.L105-.L107
	.word	.L105-.L107
	.word	.L105-.L107
	.word	.L179-.L107
	.word	.L110-.L107
	.word	.L105-.L107
	.word	.L105-.L107
	.word	.L109-.L107
	.word	.L105-.L107
	.word	.L108-.L107
	.word	.L105-.L107
	.word	.L105-.L107
	.word	.L229-.L107
	.section	.text.ee_printf
.L231:
	sub	a3,a3,s3
	addi	a0,a3,1
.L84:
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
.L234:
	lbu	a2,1(a1)
	li	a7,9
	addi	a6,a1,1
	addi	a4,a2,-48
	andi	a4,a4,0xff
	bleu	a4,a7,.L237
	li	a4,42
	beq	a2,a4,.L238
	mv	a1,a6
	li	a4,0
	j	.L99
.L232:
	li	a3,0
	li	a6,9
.L97:
	slli	a4,a3,2
	add	a4,a4,a3
	addi	a1,a1,1
	slli	a4,a4,1
	add	a4,a4,a2
	lbu	a2,0(a1)
	addi	a3,a4,-48
	addi	a4,a2,-48
	andi	a4,a4,0xff
	bleu	a4,a6,.L97
	j	.L98
.L233:
	lw	a3,0(s4)
	lbu	a2,2(t1)
	addi	a1,t1,2
	addi	s4,s4,4
	bge	a3,zero,.L98
	neg	a3,a3
	ori	a5,a5,16
	j	.L98
.L116:
	ori	a5,a5,64
.L114:
	li	a4,108
	beq	a7,a4,.L239
.L134:
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
	bne	a2,zero,.L143
.L240:
	addi	a5,a4,1056
	addi	a4,sp,16
	add	a4,a5,a4
	sb	t0,-1048(a4)
	addi	a1,a1,1
	beq	a1,t1,.L147
.L241:
	addi	a5,a6,1056
	addi	a4,sp,16
	add	a2,a5,a4
	sb	t5,-1048(a2)
	add	a2,t3,a1
	lbu	a2,0(a2)
	addi	a4,a6,1
	addi	a6,a4,1
	beq	a2,zero,.L240
.L143:
	ble	a2,t2,.L145
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
.L146:
	add	a7,a7,a2
	lbu	a2,0(a7)
	addi	a5,a4,1056
	addi	a4,sp,16
	add	a4,a5,a4
	sb	a2,-1048(a4)
	addi	a1,a1,1
	bne	a1,t1,.L241
.L147:
	lw	a5,8(sp)
	lw	a3,12(sp)
	andi	a5,a5,16
	bne	a5,zero,.L149
	addi	a2,a3,-1
	ble	a3,a6,.L186
	sub	a5,a3,a6
	add	a5,a0,a5
	li	a4,32
.L150:
	addi	a0,a0,1
	sb	a4,-1(a0)
	bne	a5,a0,.L150
	sub	a3,a6,a3
	add	a3,a3,a2
.L149:
	addi	a2,sp,24
	add	a5,a0,a6
	mv	a4,a0
.L151:
	lbu	a1,0(a2)
	addi	a4,a4,1
	addi	a2,a2,1
	sb	a1,-1(a4)
	bne	a5,a4,.L151
	bge	a6,a3,.L187
	add	a0,a0,a3
	li	a4,32
.L153:
	addi	a5,a5,1
	sb	a4,-1(a5)
	bne	a5,a0,.L153
.L152:
	lbu	a5,1(s5)
	addi	t1,s5,1
	mv	s4,t6
	bne	a5,zero,.L162
	j	.L85
.L115:
	ori	a5,a5,64
.L229:
	li	a2,16
.L111:
	addi	a6,s4,4
.L161:
	lw	a1,0(s4)
	mv	s4,a6
	call	number
	lbu	a5,1(s5)
	addi	t1,s5,1
	bne	a5,zero,.L162
	j	.L85
.L193:
	mv	s5,a1
.L113:
	andi	a5,a5,16
	addi	a2,s4,4
	addi	t1,s5,1
	beq	a5,zero,.L242
.L117:
	lw	a5,0(s4)
	li	a1,1
	addi	a4,a0,1
	sb	a5,0(a0)
	li	a5,32
	add	a0,a0,a3
	ble	a3,a1,.L243
.L121:
	addi	a4,a4,1
	sb	a5,-1(a4)
	bne	a4,a0,.L121
	lbu	a5,1(s5)
	mv	s4,a2
	bne	a5,zero,.L162
	j	.L85
.L195:
	mv	s5,a1
.L109:
	lw	a2,0(s4)
	addi	s4,s4,4
	beq	a2,zero,.L180
	lbu	a1,0(a2)
	beq	a1,zero,.L123
.L122:
	beq	a4,zero,.L123
	mv	a1,a2
	j	.L125
.L244:
	sub	a6,a1,a4
	beq	a6,a2,.L124
.L125:
	lbu	a6,1(a1)
	addi	a1,a1,1
	bne	a6,zero,.L244
.L124:
	andi	a4,a5,16
	sub	a5,a1,a2
	beq	a4,zero,.L245
.L126:
	ble	a5,zero,.L182
	add	a6,a2,a5
	mv	a4,a0
.L129:
	lbu	a1,0(a2)
	addi	a2,a2,1
	addi	a4,a4,1
	sb	a1,-1(a4)
	bne	a2,a6,.L129
	add	a4,a0,a5
.L128:
	sub	a0,a3,a5
	addi	t1,s5,1
	add	a0,a4,a0
	li	a2,32
	bge	a5,a3,.L170
.L131:
	addi	a4,a4,1
	sb	a2,-1(a4)
	bne	a4,a0,.L131
	lbu	a5,1(s5)
	bne	a5,zero,.L162
	j	.L85
.L194:
	mv	s5,a1
.L110:
	li	a2,-1
	beq	a3,a2,.L246
.L132:
	lw	a1,0(s4)
	li	a2,16
	addi	s4,s4,4
	call	number
	lbu	a5,1(s5)
	addi	t1,s5,1
	bne	a5,zero,.L162
	j	.L85
.L145:
	li	a5,9
	mv	a7,t4
	ble	a2,a5,.L146
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
	j	.L146
.L237:
	li	a4,0
	mv	t1,a4
.L101:
	slli	a4,t1,2
	add	a4,a4,t1
	addi	a6,a6,1
	slli	a4,a4,1
	add	a4,a4,a2
	lbu	a2,0(a6)
	addi	t1,a4,-48
	addi	a1,a2,-48
	andi	a1,a1,0xff
	bleu	a1,a7,.L101
	mv	a4,t1
	mv	a1,a6
	j	.L99
.L238:
	lw	a4,0(s4)
	addi	a6,a1,2
	lbu	a2,2(a1)
	not	a1,a4
	srai	a1,a1,31
	and	a4,a4,a1
	addi	s4,s4,4
	mv	a1,a6
	j	.L99
.L239:
	andi	a4,a5,64
	lla	t1,.LC0
	beq	a4,zero,.L135
	lla	t1,.LC1
.L135:
	lw	t4,0(s4)
	li	a2,0
	li	a7,0
	li	t3,6
	li	t5,58
	j	.L137
.L247:
	addi	a4,a7,1058
	add	a6,a4,t2
	addi	a7,a7,3
	sb	t5,-1048(a6)
.L137:
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
	bne	a2,t3,.L247
	andi	a5,a5,16
	bne	a5,zero,.L138
	li	a5,17
	addi	a2,a3,-1
	ble	a3,a5,.L184
	addi	a5,a3,-17
	add	a5,a0,a5
	li	a4,32
.L139:
	addi	a0,a0,1
	sb	a4,-1(a0)
	bne	a5,a0,.L139
	sub	a2,a2,a3
	addi	a3,a2,17
.L138:
	addi	a2,sp,24
	addi	a5,a0,17
	mv	a4,a0
.L140:
	lbu	a6,0(a2)
	addi	a4,a4,1
	addi	a2,a2,1
	sb	a6,-1(a4)
	bne	a4,a5,.L140
	li	a2,17
	ble	a3,a2,.L185
	add	a0,a0,a3
	li	a4,32
.L142:
	addi	a5,a5,1
	sb	a4,-1(a5)
	bne	a0,a5,.L142
.L141:
	lbu	a5,2(a1)
	addi	s4,s4,4
	addi	t1,a1,2
	bne	a5,zero,.L162
	j	.L85
.L158:
	lbu	a5,0(s5)
.L166:
	sb	a5,0(a0)
	lbu	a5,1(s5)
	addi	a0,a0,1
	addi	t1,s5,1
	bne	a5,zero,.L162
	j	.L85
.L246:
	ori	a5,a5,1
	li	a3,8
	j	.L132
.L180:
	lla	a2,.LC2
	j	.L122
.L242:
	li	a5,1
	ble	a3,a5,.L118
	addi	a5,a3,-1
	add	a5,a0,a5
	li	a4,32
.L119:
	addi	a0,a0,1
	sb	a4,-1(a0)
	bne	a0,a5,.L119
	li	a3,0
	j	.L117
.L112:
	ori	a5,a5,2
	li	a2,10
	j	.L111
.L173:
	addi	s3,sp,48
	mv	a0,s3
	j	.L85
.L245:
	addi	a6,a3,-1
	bge	a5,a3,.L181
.L171:
	sub	a4,a3,a5
	add	a4,a0,a4
	li	a1,32
.L127:
	addi	a0,a0,1
	sb	a1,-1(a0)
	bne	a0,a4,.L127
	sub	a3,a5,a3
	add	a3,a3,a6
	j	.L126
.L157:
	ori	a5,a5,2
	addi	a6,s4,4
	mv	s5,a1
	li	a2,10
	j	.L161
.L179:
	li	a2,8
	j	.L111
.L108:
	li	a2,10
	j	.L111
.L192:
	mv	s5,a1
	j	.L134
.L123:
	andi	a5,a5,16
	beq	a5,zero,.L167
	mv	a4,a0
	li	a5,0
	j	.L128
.L133:
	ori	a5,a5,64
	mv	s5,a1
	j	.L134
.L159:
	addi	a6,s4,4
	mv	s5,a1
	li	a2,10
	j	.L161
.L156:
	ori	a5,a5,64
	addi	a6,s4,4
	mv	s5,a1
	li	a2,16
	j	.L161
.L168:
	addi	a6,s4,4
	mv	s5,a1
	li	a2,16
	j	.L161
.L154:
	addi	a6,s4,4
	mv	s5,a1
	li	a2,8
	j	.L161
.L118:
	lw	a5,0(s4)
	addi	a0,a0,1
	mv	s4,a2
	sb	a5,-1(a0)
	lbu	a5,1(s5)
	bne	a5,zero,.L162
	j	.L85
.L187:
	mv	a0,a5
	j	.L152
.L167:
	addi	a6,a3,-1
	bgt	a3,zero,.L171
	addi	t1,s5,1
	mv	a4,a0
.L170:
	lbu	a5,1(s5)
	mv	a0,a4
	bne	a5,zero,.L162
	j	.L85
.L186:
	mv	a3,a2
	j	.L149
.L185:
	mv	a0,a4
	j	.L141
.L243:
	lbu	a5,1(s5)
	mv	s4,a2
	mv	a0,a4
	bne	a5,zero,.L162
	j	.L85
.L182:
	mv	a4,a0
	j	.L128
.L181:
	mv	a3,a6
	j	.L126
.L184:
	mv	a3,a2
	j	.L138
	.size	ee_printf, .-ee_printf
	.section	.text.init_uart,"ax",@progbits
	.align	2
	.globl	init_uart
	.type	init_uart, @function
init_uart:
	li	a5,536870912
	lw	a4,0(a5)
	ori	a4,a4,1
	sw	a4,0(a5)
	lw	a4,0(a5)
	ori	a4,a4,2
	sw	a4,0(a5)
	li	a4,1085
	sh	a4,2(a5)
	ret
	.size	init_uart, .-init_uart
	.section	.text.getchar,"ax",@progbits
	.align	2
	.globl	getchar
	.type	getchar, @function
getchar:
	li	a4,536870912
.L250:
	lw	a5,4(a4)
	srli	a5,a5,3
	andi	a5,a5,1
	bne	a5,zero,.L250
	lbu	a0,8(a4)
	ret
	.size	getchar, .-getchar
	.ident	"GCC: (g2ee5e430018) 12.2.0"
