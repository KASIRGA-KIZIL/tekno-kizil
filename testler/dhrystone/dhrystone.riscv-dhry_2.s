	.file	"dhry_2.c"
	.option nopic
	.attribute arch, "rv32i2p0_m2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.section	.text.Proc_6,"ax",@progbits
	.align	2
	.globl	Proc_6
	.type	Proc_6, @function
Proc_6:
	li	a5,2
	beq	a0,a5,.L8
	li	a4,3
	sw	a4,0(a1)
	li	a4,1
	beq	a0,a4,.L4
	li	a4,4
	beq	a0,a4,.L5
	beq	a0,zero,.L6
.L3:
	ret
.L4:
	lw	a4,Int_Glob
	li	a5,100
	ble	a4,a5,.L3
.L6:
	sw	zero,0(a1)
	ret
.L5:
	sw	a5,0(a1)
	ret
.L8:
	li	a5,1
	sw	a5,0(a1)
	ret
	.size	Proc_6, .-Proc_6
	.section	.text.Proc_7,"ax",@progbits
	.align	2
	.globl	Proc_7
	.type	Proc_7, @function
Proc_7:
	addi	a0,a0,2
	add	a1,a0,a1
	sw	a1,0(a2)
	ret
	.size	Proc_7, .-Proc_7
	.section	.text.Proc_8,"ax",@progbits
	.align	2
	.globl	Proc_8
	.type	Proc_8, @function
Proc_8:
	addi	a4,a2,5
	li	a6,200
	mul	a6,a4,a6
	slli	a2,a2,2
	slli	a5,a4,2
	add	a0,a0,a5
	sw	a3,0(a0)
	sw	a4,120(a0)
	sw	a3,4(a0)
	add	a5,a6,a2
	add	a5,a1,a5
	lw	a3,16(a5)
	sw	a4,20(a5)
	sw	a4,24(a5)
	addi	a4,a3,1
	sw	a4,16(a5)
	lw	a4,0(a0)
	add	a1,a1,a6
	add	a1,a1,a2
	li	a5,4096
	add	a5,a5,a1
	sw	a4,-76(a5)
	li	a5,5
	sw	a5,Int_Glob,a4
	ret
	.size	Proc_8, .-Proc_8
	.section	.text.Func_1,"ax",@progbits
	.align	2
	.globl	Func_1
	.type	Func_1, @function
Func_1:
	andi	a0,a0,0xff
	andi	a1,a1,0xff
	beq	a0,a1,.L14
	li	a0,0
	ret
.L14:
	sb	a0,Ch_1_Glob,a5
	li	a0,1
	ret
	.size	Func_1, .-Func_1
	.section	.text.Func_2,"ax",@progbits
	.align	2
	.globl	Func_2
	.type	Func_2, @function
Func_2:
	addi	sp,sp,-16
	sw	ra,12(sp)
	lbu	a5,2(a0)
	lbu	a4,3(a1)
	li	a2,0
	li	a3,0
.L16:
	beq	a5,a4,.L19
	beq	a3,zero,.L17
	sb	a2,Ch_1_Glob,a5
.L17:
	call	strcmp
	li	a5,0
	ble	a0,zero,.L15
	li	a5,10
	sw	a5,Int_Glob,a4
	li	a5,1
.L15:
	lw	ra,12(sp)
	mv	a0,a5
	addi	sp,sp,16
	jr	ra
.L19:
	li	a3,1
	mv	a2,a5
	j	.L16
	.size	Func_2, .-Func_2
	.section	.text.Func_3,"ax",@progbits
	.align	2
	.globl	Func_3
	.type	Func_3, @function
Func_3:
	addi	a0,a0,-2
	seqz	a0,a0
	ret
	.size	Func_3, .-Func_3
	.ident	"GCC: () 12.2.0"
