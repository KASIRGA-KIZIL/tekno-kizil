	.file	"core_main.c"
	.option nopic
	.attribute arch, "rv32i2p0_m2p0_c2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.section	.text.iterate,"ax",@progbits
	.align	1
	.globl	iterate
	.type	iterate, @function
iterate:
	addi	sp,sp,-16
	sw	s2,0(sp)
	lw	s2,28(a0)
	sw	ra,12(sp)
	sw	s0,8(sp)
	sw	s1,4(sp)
	sw	zero,56(a0)
	sw	zero,60(a0)
	beq	s2,zero,.L2
	mv	s0,a0
	li	s1,0
.L4:
	li	a1,1
	mv	a0,s0
	call	core_bench_list
	lhu	a1,56(s0)
	call	crcu16
	li	a1,-1
	sh	a0,56(s0)
	mv	a0,s0
	call	core_bench_list
	lhu	a1,56(s0)
	call	crcu16
	sh	a0,56(s0)
	bne	s1,zero,.L3
	sh	a0,58(s0)
.L3:
	addi	s1,s1,1
	bne	s2,s1,.L4
.L2:
	lw	ra,12(sp)
	lw	s0,8(sp)
	lw	s1,4(sp)
	lw	s2,0(sp)
	li	a0,0
	addi	sp,sp,16
	jr	ra
	.size	iterate, .-iterate
	.section	.rodata.str1.4,"aMS",@progbits,1
	.align	2
.LC0:
	.string	"pikachu\n"
	.align	2
.LC1:
	.string	"6k performance run parameters for coremark.\n"
	.align	2
.LC2:
	.string	"6k validation run parameters for coremark.\n"
	.align	2
.LC3:
	.string	"Profile generation run parameters for coremark.\n"
	.align	2
.LC4:
	.string	"2K performance run parameters for coremark.\n"
	.align	2
.LC5:
	.string	"2K validation run parameters for coremark.\n"
	.align	2
.LC6:
	.string	"[%u]ERROR! list crc 0x%04x - should be 0x%04x\n"
	.align	2
.LC7:
	.string	"[%u]ERROR! matrix crc 0x%04x - should be 0x%04x\n"
	.align	2
.LC8:
	.string	"[%u]ERROR! state crc 0x%04x - should be 0x%04x\n"
	.align	2
.LC9:
	.string	"CoreMark Size    : %lu\n"
	.align	2
.LC10:
	.string	"Total ticks      : %Lu\n"
	.align	2
.LC11:
	.string	"Total time (secs): %d\n"
	.align	2
.LC12:
	.string	"Iterations/Sec   : %d\n"
	.align	2
.LC13:
	.string	"ERROR! Must execute for at least 10 secs for a valid result!\n"
	.align	2
.LC14:
	.string	"Iterations       : %lu\n"
	.align	2
.LC15:
	.string	"GCC12.2.0"
	.align	2
.LC16:
	.string	"Compiler version : %s\n"
	.align	2
.LC17:
	.string	"-O2 -mcmodel=medany -static -std=gnu99 -fno-common -nostdlib -nostartfiles -fno-builtin -ffunction-sections -lm -lgcc -T riscv32-baremetal/linkdene.ld -DPERFORMANCE_RUN=1  "
	.align	2
.LC18:
	.string	"Compiler flags   : %s\n"
	.align	2
.LC19:
	.string	"STACK"
	.align	2
.LC20:
	.string	"Memory location  : %s\n"
	.align	2
.LC21:
	.string	"seedcrc          : 0x%04x\n"
	.align	2
.LC22:
	.string	"[%d]crclist       : 0x%04x\n"
	.align	2
.LC23:
	.string	"[%d]crcmatrix     : 0x%04x\n"
	.align	2
.LC24:
	.string	"[%d]crcstate      : 0x%04x\n"
	.align	2
.LC25:
	.string	"[%d]crcfinal      : 0x%04x\n"
	.align	2
.LC26:
	.string	"Correct operation validated. See README.md for run and reporting rules.\n"
	.align	2
.LC27:
	.string	"Cannot validate operation for these seed values, please compare with results on a known platform.\n"
	.align	2
.LC28:
	.string	"Errors detected\n"
	.section	.text.startup.main,"ax",@progbits
	.align	1
	.globl	main
	.type	main, @function
main:
	li	a5,-4096
	li	a4,4096
	addi	sp,sp,-128
	addi	a5,a5,2012
	addi	a4,a4,-2000
	sw	ra,124(sp)
	add	a4,a4,a5
	sw	s0,120(sp)
	sw	s1,116(sp)
	sw	s2,112(sp)
	sw	s3,108(sp)
	sw	s4,104(sp)
	sw	s5,100(sp)
	sw	s6,96(sp)
	sw	s7,92(sp)
	sw	s8,88(sp)
	sw	s9,84(sp)
	sw	s10,80(sp)
	sw	s11,76(sp)
	addi	sp,sp,-2032
	mv	a2,a1
	sw	a0,12(sp)
	add	a1,a4,sp
	addi	a0,sp,94
	call	portable_init
	lla	a0,.LC0
	call	ee_printf
	li	a0,1
	call	get_seed_32
	mv	a5,a0
	li	a0,2
	sh	a5,28(sp)
	call	get_seed_32
	mv	a5,a0
	li	a0,3
	sh	a5,30(sp)
	call	get_seed_32
	mv	a5,a0
	li	a0,4
	sh	a5,32(sp)
	call	get_seed_32
	mv	a5,a0
	li	a0,5
	sw	a5,56(sp)
	call	get_seed_32
	bne	a0,zero,.L12
	li	a0,7
.L12:
	li	a4,4096
	li	a5,-4096
	addi	a4,a4,-2000
	add	a4,a4,a5
	add	a5,a4,sp
	sw	a5,8(sp)
	lw	a5,2028(a5)
	sw	a0,60(sp)
	bne	a5,zero,.L13
	lw	a5,8(sp)
	lh	a5,2032(a5)
	beq	a5,zero,.L105
.L14:
	li	a1,4096
	li	a3,-4096
	addi	a1,a1,-2000
	add	a1,a1,a3
	add	a3,a1,sp
	addi	a2,sp,96
	andi	a5,a0,2
	andi	a4,a0,1
	snez	a5,a5
	sw	a3,8(sp)
	sw	a2,2036(a3)
	sh	zero,92(sp)
	andi	a3,a0,4
	add	a4,a4,a5
	beq	a3,zero,.L16
	addi	a4,a4,1
	slli	a4,a4,16
	srli	a4,a4,16
.L16:
	li	a3,2000
	divu	a3,a3,a4
	li	a5,-4096
	li	a4,4096
	addi	a5,a5,2028
	addi	a4,a4,-2000
	add	a4,a4,a5
	add	a5,a4,sp
	li	a6,0
	li	a4,0
	li	t1,1
	li	a7,3
	sw	a3,52(sp)
.L18:
	sll	a1,t1,a4
	and	a1,a1,a0
	addi	a4,a4,1
	bne	a1,zero,.L106
.L17:
	addi	a5,a5,4
	bne	a4,a7,.L18
	li	a3,4096
	li	a4,-4096
	lw	a5,60(sp)
	addi	a3,a3,-2000
	add	a3,a3,a4
	add	a4,a3,sp
	sw	a4,8(sp)
	andi	a4,a5,1
	beq	a4,zero,.L58
	lw	a5,8(sp)
	lw	a0,52(sp)
	lh	a2,2028(a5)
	lw	a1,2040(a5)
	call	core_list_init
	lw	a5,60(sp)
	sw	a0,64(sp)
.L58:
	andi	a4,a5,2
	bne	a4,zero,.L107
.L20:
	andi	a5,a5,4
	beq	a5,zero,.L21
	li	a4,4096
	li	a5,-4096
	addi	a4,a4,-2000
	add	a4,a4,a5
	add	a5,a4,sp
	lw	a2,48(sp)
	lh	a1,2028(a5)
	lw	a0,52(sp)
	sw	a5,8(sp)
	call	core_init_state
.L21:
	lw	a5,56(sp)
	bne	a5,zero,.L22
	li	a5,1
	li	s0,-4096
	sw	a5,56(sp)
	li	a5,4096
	addi	s0,s0,2028
	addi	a5,a5,-2000
	add	a5,a5,s0
	add	s0,a5,sp
.L23:
	lw	a4,56(sp)
	slli	a5,a4,2
	add	a5,a5,a4
	slli	a5,a5,1
	sw	a5,56(sp)
	call	start_time
	mv	a0,s0
	call	iterate
	call	stop_time
	call	get_time
	call	time_in_secs
	beq	a0,zero,.L23
	li	a5,10
	divu	a5,a5,a0
	lw	a4,56(sp)
	addi	a5,a5,1
	mul	a5,a5,a4
	sw	a5,56(sp)
.L22:
	call	start_time
	li	s0,-4096
	li	s1,4096
	addi	a0,s0,2028
	addi	a5,s1,-2000
	add	a5,a5,a0
	add	a0,a5,sp
	call	iterate
	call	stop_time
	call	get_time
	addi	a5,s1,-2000
	add	a5,a5,s0
	add	a5,a5,sp
	mv	s3,a0
	lh	a0,2028(a5)
	mv	s4,a1
	li	a1,0
	sw	a5,8(sp)
	call	crc16
	lw	a5,8(sp)
	mv	a1,a0
	lh	a0,2030(a5)
	call	crc16
	lw	a5,8(sp)
	mv	a1,a0
	lh	a0,2032(a5)
	call	crc16
	mv	a1,a0
	lh	a0,52(sp)
	call	crc16
	li	a5,32768
	addi	a5,a5,-1275
	mv	s2,a0
	beq	a0,a5,.L24
	bgtu	a0,a5,.L25
	li	a5,8192
	addi	a5,a5,-1806
	beq	a0,a5,.L26
	li	a5,20480
	addi	a5,a5,-337
	bne	a0,a5,.L103
	lla	a0,.LC3
	call	ee_printf
	li	a5,2
.L31:
	lla	s8,default_num_contexts
	lw	a4,0(s8)
	beq	a4,zero,.L59
	li	a4,4096
	li	a3,-4096
	addi	a4,a4,-2000
	add	a4,a4,a3
	slli	a5,a5,1
	add	a4,a4,sp
	lla	s11,.LANCHOR0
	li	s5,0
	li	s9,0
	sw	a4,8(sp)
	li	s10,4096
	add	s11,s11,a5
	lla	s7,.LC6
	lla	s6,.LC7
	j	.L37
.L108:
	lw	a4,8(sp)
	add	a5,s0,s9
	slli	a5,a5,2
	add	a5,a4,a5
	add	a5,s10,a5
	lhu	a5,-2004(a5)
.L35:
	addi	s9,s9,1
	lw	a3,0(s8)
	add	a5,a5,s5
	slli	s9,s9,16
	slli	s1,a5,16
	slli	s5,a5,16
	srli	s9,s9,16
	srli	s1,s1,16
	srai	s5,s5,16
	bgeu	s9,a3,.L28
.L37:
	lw	a5,8(sp)
	slli	s0,s9,4
	add	s1,s0,s9
	slli	s1,s1,2
	add	s1,a5,s1
	add	s1,s10,s1
	lw	a5,-2036(s1)
	sh	zero,-2004(s1)
	andi	a3,a5,1
	beq	a3,zero,.L32
	lhu	a2,-2010(s1)
	lhu	a3,0(s11)
	beq	a2,a3,.L32
	mv	a1,s9
	mv	a0,s7
	call	ee_printf
	lhu	a3,-2004(s1)
	lw	a5,-2036(s1)
	addi	a3,a3,1
	sh	a3,-2004(s1)
.L32:
	andi	a3,a5,2
	beq	a3,zero,.L33
	lw	a4,8(sp)
	add	s1,s0,s9
	slli	s1,s1,2
	add	s1,a4,s1
	add	s1,s10,s1
	lhu	a2,-2008(s1)
	lhu	a3,12(s11)
	beq	a2,a3,.L33
	mv	a1,s9
	mv	a0,s6
	call	ee_printf
	lhu	a3,-2004(s1)
	lw	a5,-2036(s1)
	addi	a3,a3,1
	sh	a3,-2004(s1)
.L33:
	andi	a5,a5,4
	beq	a5,zero,.L108
	lw	a5,8(sp)
	add	s0,s0,s9
	slli	s0,s0,2
	add	s0,a5,s0
	add	s0,s10,s0
	lhu	a2,-2006(s0)
	lhu	a3,24(s11)
	bne	a2,a3,.L36
	lhu	a5,-2004(s0)
	j	.L35
.L107:
	li	a4,4096
	li	a5,-4096
	addi	a4,a4,-2000
	add	a4,a4,a5
	add	a5,a4,sp
	sw	a5,8(sp)
	lw	a4,8(sp)
	lh	a5,2030(a5)
	lw	a0,52(sp)
	lh	a2,2028(a4)
	lw	a1,2044(a4)
	slli	a5,a5,16
	or	a2,a5,a2
	addi	a3,sp,68
	call	core_init_matrix
	lw	a5,60(sp)
	j	.L20
.L36:
	mv	a1,s9
	lla	a0,.LC8
	call	ee_printf
	lhu	a5,-2004(s0)
	addi	a5,a5,1
	slli	a5,a5,16
	srli	a5,a5,16
	sh	a5,-2004(s0)
	j	.L35
.L25:
	li	a5,36864
	addi	a5,a5,-1534
	beq	a0,a5,.L29
	li	a5,61440
	addi	a5,a5,-1547
	bne	a0,a5,.L103
	lla	a0,.LC4
	call	ee_printf
	li	a5,3
	j	.L31
.L59:
	li	s1,0
.L28:
	call	check_data_types
	lw	a1,52(sp)
	add	s1,a0,s1
	lla	a0,.LC9
	call	ee_printf
	mv	a1,s3
	lla	a0,.LC10
	call	ee_printf
	mv	a1,s4
	mv	a0,s3
	call	time_in_secs
	mv	a1,a0
	lla	a0,.LC11
	call	ee_printf
	slli	s1,s1,16
	mv	a0,s3
	mv	a1,s4
	srli	s1,s1,16
	call	time_in_secs
	bne	a0,zero,.L109
.L38:
	mv	a0,s3
	mv	a1,s4
	call	time_in_secs
	li	a5,9
	bleu	a0,a5,.L39
.L104:
	lw	a5,0(s8)
	lw	a1,56(sp)
	lla	a0,.LC14
	slli	s1,s1,16
	mul	a1,a1,a5
	srai	s1,s1,16
	call	ee_printf
	lla	a1,.LC15
	lla	a0,.LC16
	call	ee_printf
	lla	a1,.LC17
	lla	a0,.LC18
	call	ee_printf
	lla	a1,.LC19
	lla	a0,.LC20
	call	ee_printf
	mv	a1,s2
	lla	a0,.LC21
	call	ee_printf
	lw	a5,60(sp)
	andi	a4,a5,1
	beq	a4,zero,.L44
	lw	a4,0(s8)
	beq	a4,zero,.L44
	li	a4,4096
	li	a5,-4096
	addi	a4,a4,-2000
	add	a4,a4,a5
	add	a5,a4,sp
	li	s0,0
	sw	a5,8(sp)
	li	s3,4096
	lla	s2,.LC22
.L45:
	lw	a4,8(sp)
	slli	a5,s0,4
	add	a5,a5,s0
	slli	a5,a5,2
	add	a5,a4,a5
	add	a5,s3,a5
	lhu	a2,-2010(a5)
	mv	a1,s0
	mv	a0,s2
	call	ee_printf
	addi	s0,s0,1
	lw	a5,0(s8)
	slli	s0,s0,16
	srli	s0,s0,16
	bltu	s0,a5,.L45
	lw	a5,60(sp)
.L44:
	andi	a4,a5,2
	beq	a4,zero,.L43
	lw	a4,0(s8)
	beq	a4,zero,.L48
	li	a4,4096
	li	a5,-4096
	addi	a4,a4,-2000
	add	a4,a4,a5
	add	a5,a4,sp
	li	s0,0
	sw	a5,8(sp)
	li	s3,4096
	lla	s2,.LC23
.L49:
	lw	a4,8(sp)
	slli	a5,s0,4
	add	a5,a5,s0
	slli	a5,a5,2
	add	a5,a4,a5
	add	a5,s3,a5
	lhu	a2,-2008(a5)
	mv	a1,s0
	mv	a0,s2
	call	ee_printf
	addi	s0,s0,1
	lw	a5,0(s8)
	slli	s0,s0,16
	srli	s0,s0,16
	bltu	s0,a5,.L49
	lw	a5,60(sp)
.L43:
	andi	a5,a5,4
	lw	a4,0(s8)
	beq	a5,zero,.L47
	li	s0,0
	beq	a4,zero,.L51
	li	a4,4096
	li	a5,-4096
	addi	a4,a4,-2000
	add	a4,a4,a5
	add	a5,a4,sp
	sw	a5,8(sp)
	li	s3,4096
	lla	s2,.LC24
.L52:
	lw	a4,8(sp)
	slli	a5,s0,4
	add	a5,a5,s0
	slli	a5,a5,2
	add	a5,a4,a5
	add	a5,s3,a5
	lhu	a2,-2006(a5)
	mv	a1,s0
	mv	a0,s2
	call	ee_printf
	addi	s0,s0,1
	lw	a5,0(s8)
	slli	s0,s0,16
	srli	s0,s0,16
	bltu	s0,a5,.L52
.L47:
	lw	a5,0(s8)
	li	s0,0
	beq	a5,zero,.L51
	li	a4,4096
	li	a5,-4096
	addi	a4,a4,-2000
	add	a4,a4,a5
	add	a5,a4,sp
	sw	a5,8(sp)
	li	s3,4096
	lla	s2,.LC25
.L50:
	lw	a4,8(sp)
	slli	a5,s0,4
	add	a5,a5,s0
	slli	a5,a5,2
	add	a5,a4,a5
	add	a5,s3,a5
	lhu	a2,-2012(a5)
	mv	a1,s0
	mv	a0,s2
	call	ee_printf
	addi	s0,s0,1
	lw	a5,0(s8)
	slli	s0,s0,16
	srli	s0,s0,16
	bltu	s0,a5,.L50
.L51:
	beq	s1,zero,.L110
	bgt	s1,zero,.L56
	lla	a0,.LC27
	call	ee_printf
.L55:
	addi	a0,sp,94
	call	portable_fini
	addi	sp,sp,2032
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
	lw	s9,84(sp)
	lw	s10,80(sp)
	lw	s11,76(sp)
	li	a0,0
	addi	sp,sp,128
	jr	ra
.L106:
	mul	a1,a6,a3
	addi	a6,a6,1
	slli	a6,a6,16
	srli	a6,a6,16
	add	a1,a2,a1
	sw	a1,12(a5)
	j	.L17
.L13:
	li	a4,1
	bne	a5,a4,.L14
	lw	a5,8(sp)
	lh	a5,2032(a5)
	bne	a5,zero,.L14
	lw	a4,8(sp)
	li	a5,873803776
	addi	a5,a5,1045
	sw	a5,2028(a4)
	li	a5,102
	sh	a5,2032(a4)
	j	.L14
.L56:
	lla	a0,.LC28
	call	ee_printf
	j	.L55
.L105:
	lw	a4,8(sp)
	li	a5,102
	sh	a5,2032(a4)
	j	.L14
.L110:
	lla	a0,.LC26
	call	ee_printf
	j	.L55
.L39:
	lla	a0,.LC13
	call	ee_printf
	addi	s1,s1,1
	j	.L104
.L109:
	lw	a5,0(s8)
	lw	s0,56(sp)
	mv	a1,s4
	mv	a0,s3
	mul	s0,s0,a5
	call	time_in_secs
	mv	a1,a0
	lla	a0,.LC12
	divu	a1,s0,a1
	call	ee_printf
	j	.L38
.L48:
	andi	a5,a5,4
	beq	a5,zero,.L47
	j	.L51
.L24:
	lla	a0,.LC2
	call	ee_printf
	li	a5,1
	j	.L31
.L29:
	lla	a0,.LC1
	call	ee_printf
	li	a5,0
	j	.L31
.L26:
	lla	a0,.LC5
	call	ee_printf
	li	a5,4
	j	.L31
.L103:
	li	s0,65536
	addi	s1,s0,-1
	lla	s8,default_num_contexts
	j	.L28
	.size	main, .-main
	.globl	mem_name
	.section	.rodata.str1.4
	.align	2
.LC29:
	.string	"Static"
	.align	2
.LC30:
	.string	"Heap"
	.align	2
.LC31:
	.string	"Stack"
	.globl	logo
	.section	.rodata
	.align	2
	.set	.LANCHOR0,. + 0
	.type	list_known_crc, @object
	.size	list_known_crc, 10
list_known_crc:
	.half	-11088
	.half	13120
	.half	27257
	.half	-6380
	.half	-7231
	.zero	2
	.type	matrix_known_crc, @object
	.size	matrix_known_crc, 10
matrix_known_crc:
	.half	-16814
	.half	4505
	.half	22024
	.half	8151
	.half	1863
	.zero	2
	.type	state_known_crc, @object
	.size	state_known_crc, 10
state_known_crc:
	.half	24135
	.half	14783
	.half	-6748
	.half	-29126
	.half	-29308
	.data
	.align	2
	.type	mem_name, @object
	.size	mem_name, 12
mem_name:
	.word	.LC29
	.word	.LC30
	.word	.LC31
	.type	logo, @object
	.size	logo, 11860
logo:
	.ascii	"                                                            "
	.ascii	"                                                            "
	.ascii	"                                                            "
	.ascii	"                    \n                                      "
	.ascii	"                                                            "
	.ascii	"                                                            "
	.ascii	"                                          \n              OO"
	.ascii	"OOOOOOO             GGGGGGGGGGGGGUUUUUUUU     UUUUUUUUZZZZZZ"
	.ascii	"ZZZZZZZZZZZZZ     EEEEEEEEEEEEEEEEEEEEEERRRRRRRRRRRRRRRRR   "
	.ascii	"        GGGGGGGGGGGGGIIIIIIIIIINNNNNNNN        NNNNNNNN     "
	.ascii	"    \n            OO:::::::::OO        GGG::::::::::::GU::::"
	.ascii	"::U     U::::::UZ:::::::::::::::::Z     E:::::::::::::::::::"
	.ascii	":ER::::::::::::::::R       GGG::::::::::::GI::::::::IN::::::"
	.ascii	":N       N::::::N         \n          OO:::::::::::::OO    G"
	.ascii	"G:::::::::::::::GU::::::U     U::::::UZ:::::::::::::::::Z   "
	.ascii	"  E::::::::::::::::::::ER::::::RRRRRR:::::R    GG:::::::::::"
	.ascii	"::::GI::::::::IN::::::::N      N::::::N         \n         O"
	.ascii	":::::::OOO:::::::O  G:::::GGGGGGGG::::GUU:::::U     U:::::UU"
	.ascii	"Z:::ZZZZZZZZ:::::Z      EE::::::EEEEEEEEE::::ERR:::::R     R"
	.ascii	":::::R  G:::::GGGGGGGG::::GII::::::IIN:::::::::N     N::::::"
	.ascii	"N         \n         O::::::O   O::::::O G:::::G       GGGGG"
	.ascii	"G U:::::U     U:::::U ZZZZZ     Z:::::Z         E:::::E     "
	.ascii	"  EEEEEE  R::::R     R:::::R G:::::G       GGGGGG  I::::I  N"
	.ascii	"::::::::::N    N::::::N         \n         O:::::O     O::::"
	.ascii	":OG:::::G               U:::::D     D:::::U         Z:::::Z "
	.ascii	"          E:::::E               R::::R     R:::::RG:::::G   "
	.ascii	"             I::::I  N:::::::::::N   N::::::N         \n    "
	.ascii	"     O:::::O     O:::::OG:::::G               U:::::D     D:"
	.ascii	"::::U        Z:::::Z            E::::::EEEEEEEEEE     R::::R"
	.ascii	"RRRRR:::::R G:::::G                I::::I  N:::::::N::::N  N"
	.ascii	"::::::N         \n         O:::::O     O:::::OG:::::G    GGG"
	.ascii	"GGGGGGG U:::::D     D:::::U       Z:::::Z             E:::::"
	.ascii	"::::::::::E     R:::::::::::::RR  G:::::G    GGGGGGGGGG  I::"
	.ascii	"::I  N::::::N N::::N N::::::N"
	.ascii	"         \n         O:::::O     O:::::OG:::::G    G::::::::G"
	.ascii	" U:::::D     D:::::U      Z:::::Z              E::::::::::::"
	.ascii	":::E     R::::RRRRRR:::::R G:::::G    G::::::::G  I::::I  N:"
	.ascii	":::::N  N::::N:::::::N         \n         O:::::O     O:::::"
	.ascii	"OG:::::G    GGGGG::::G U:::::D     D:::::U     Z:::::Z      "
	.ascii	"         E::::::EEEEEEEEEE     R::::R     R:::::RG:::::G    "
	.ascii	"GGGGG::::G  I::::I  N::::::N   N:::::::::::N         \n     "
	.ascii	"    O:::::O     O:::::OG:::::G        G::::G U:::::D     D::"
	.ascii	":::U    Z:::::Z                E:::::E               R::::R "
	.ascii	"    R:::::RG:::::G        G::::G  I::::I  N::::::N    N:::::"
	.ascii	":::::N         \n         O::::::O   O::::::O G:::::G       "
	.ascii	"G::::G U::::::U   U::::::U ZZZ:::::Z     ZZZZZ       E:::::E"
	.ascii	"       EEEEEE  R::::R     R:::::R G:::::G       G::::G  I:::"
	.ascii	":I  N::::::N     N:::::::::N         \n         O:::::::OOO:"
	.ascii	"::::::O  G:::::GGGGGGGG::::G U:::::::UUU:::::::U Z::::::ZZZZ"
	.ascii	"ZZZZ:::Z     EE::::::EEEEEEEE:::::ERR:::::R     R:::::R  G::"
	.ascii	":::GGGGGGGG::::GII::::::IIN::::::N      N::::::::N         \n"
	.ascii	"          OO:::::::::::::OO    GG:::::::::::::::G  UU:::::::"
	.ascii	"::::::UU  Z:::::::::::::::::Z     E::::::::::::::::::::ER:::"
	.ascii	":::R     R:::::R   GG:::::::::::::::GI::::::::IN::::::N     "
	.ascii	"  N:::::::N         \n            OO:::::::::OO        GGG::"
	.ascii	"::::GGG:::G    UU:::::::::UU    Z:::::::::::::::::Z     E:::"
	.ascii	":::::::::::::::::ER::::::R     R:::::R     GGG::::::GGG:::GI"
	.ascii	"::::::::IN::::::N        N::::::N         \n              OO"
	.ascii	"OOOOOOO             GGGGGG   GGGG      UUUUUUUUU      ZZZZZZ"
	.ascii	"ZZZZZZZZZZZZZ     EEEEEEEEEEEEEEEEEEEEEERRRRRRRR     RRRRRRR"
	.ascii	"        GGGGGG   GGGGIIIIIIIIIINNNNNNNN         NNNNNNN     "
	.ascii	"    \n                                                      "
	.ascii	"                                                            "
	.ascii	"                                                            "
	.ascii	"                          \n                                "
	.ascii	"                                                            "
	.ascii	"                  .*.,./,,./*,**                            "
	.ascii	"                             "
	.ascii	"                   \n                                       "
	.ascii	"                                                            "
	.ascii	"        ,*(/*,#####%%%%%&&&&%##*.                           "
	.ascii	"                                         \n                 "
	.ascii	"                                                            "
	.ascii	"                           (%%%&&%(*************//#%%%%%(#, "
	.ascii	"                                                            "
	.ascii	"   \n                                                       "
	.ascii	"                                              /&&&(***,,,,,*"
	.ascii	",*,,,,,,,,,,,,,,*/%%%%,                                     "
	.ascii	"                         \n                                 "
	.ascii	"                                                            "
	.ascii	"     *&%,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,*(%##%,           "
	.ascii	"                                               \n           "
	.ascii	"                                      .,*//////*,           "
	.ascii	"                        ,%%,,,,,,,,,,,,,,,,,,,,......,.,,,,,"
	.ascii	",,,,,,,(%&##%                                               "
	.ascii	"         \n                                      .(#%%%%%%##"
	.ascii	"##((((####%%%%%%%#*                          #(,,,,,,,,,,,,,"
	.ascii	",,,,,,............,..,,,,,.,,,*(&&%&(                       "
	.ascii	"                               \n                           "
	.ascii	"     ,#%%%#*.                        ,#%%%%,                "
	.ascii	"     /(***,,,,,,,,,,,,,,.,,,..................,..,,,,,/#&&&&"
	.ascii	"                                                     \n     "
	.ascii	"              ,        /%%#,                                "
	.ascii	"  *%%%        #           *******,,,,,,,,,,,,,,,,..........."
	.ascii	"...........,..,,*/#%%&&%                                    "
	.ascii	"               \n               .#        /%#.              "
	.ascii	"                         #%/       ##           /******,,,,,"
	.ascii	",,,,,,,,,,..............,........,.,,,,*(#(%%%#             "
	.ascii	"                                     \n             #%      "
	.ascii	"  /%,    ..                             *     *#.      ,%%  "
	.ascii	"         /*******,,,,,,,,,.,,,,,,....................,,.,,,,"
	.ascii	",,/(##%%#(                    "
	.ascii	"                             \n           #%%        ,/    ."
	.ascii	"/.                           **     .*       (%%*           "
	.ascii	" ,,***,,*,,,,,,,,,,...,.,,,,...................,,,,,,*//((#%"
	.ascii	"%(                                                 \n       "
	.ascii	"   %%%/              **/.                     ,**,          "
	.ascii	"   .#%%%.              ,***/((((#(((/**,,,,*,,,*********,,,."
	.ascii	"......,,,,,,,,**/((#####                                    "
	.ascii	"             \n         (%%%%                ,//*//*,,,,,,,*"
	.ascii	"*///*,               .#%%%%,                 */##((((((((((/"
	.ascii	"/********////(((####//***,,,,,,,,,,,,,((((###(              "
	.ascii	"                                   \n         ,%%%%%%       "
	.ascii	"                                      *#%%%%%*              "
	.ascii	"       *((/////((##(###(/*,,,*/(((((/**,*,,,,*///**,,,,,,,,,"
	.ascii	"*((((#%/                                                 \n "
	.ascii	"          %%%%%%%%(.                                ./%%%%%%"
	.ascii	"%%/                         ,*//%&&%%&&@@&%%%#*,...,**(##%(("
	.ascii	"((/(%(/***/(***,,,,,,,*(//((#,                              "
	.ascii	"                   \n             ,%%%%%%%%%%%%%#(/,,,.....,"
	.ascii	",*/(#%%%%%%%%%%%%#*                               *//((((///"
	.ascii	"//(((//*,,...,,,,**/////(///(%&#******,,,,,,*/(((##         "
	.ascii	"                                         \n                 "
	.ascii	"  /%%%%%%%%%%%%%%%%%%%%%%%%%%%#,                            "
	.ascii	"            ******/***********,,..,,,.,,,,//(##(((//*,****,,"
	.ascii	",,,,,,*/(/((,                                               "
	.ascii	"   \n                                                       "
	.ascii	"                                  ******,,,,,,,*/*,,....,,,,"
	.ascii	"......,,,,,,,,,,,,,,,,,,,,,,//**,//(/                       "
	.ascii	"                         \n                                 "
	.ascii	"                                                        ****"
	.ascii	",,,,,,,*/,*,,.....,,,*/*,,........,,,,,,,,,,**********,,,** "
	.ascii	"                                               \n     ...   "
	.ascii	"                                                            "
	.ascii	"                  ***,,,,,,*(#**//*,,**,,...,/(/,,.........,"
	.ascii	",,,,,*****,,,/%/,,,,,         "
	.ascii	"                                       \n     %%%           "
	.ascii	"                                                            "
	.ascii	"         .*****,**/(//#%&&#(((%%&@%(//*((*,.......,,,,,,,*,*"
	.ascii	",,,,,*((*,,,                                                "
	.ascii	" \n     %%%     ...     .,,.         .*,      ...    ..   ,,"
	.ascii	"     **,   ..       ,,,        ********/**/##%&&&&&%%%//***,"
	.ascii	".,,(/*,,,,,,,,,,,,,,,,,,,,,,.,,.,,                          "
	.ascii	"                       \n     %%%   %%%/    %%%%%%%%(   (%%%"
	.ascii	"*(%%/   %%%   ,%%/%%%(  %%%%#(%%%%%,   (%%%%%%%%.    *******"
	.ascii	"/#%&%%#%%##%/%&%#%#(/(*,,.//*,,,,,,,,,,,,,,,,,,,,...,*.     "
	.ascii	"                                             \n     %%% #%%*"
	.ascii	"            *%%.  %%%/        %%%   ,%%%.    %%%.     #%%,  "
	.ascii	"        %%%    ******/##%%#%%%%%%%%%%%##(/((#*/*,//*,,,,,,,,"
	.ascii	",,,,,,,,,,......                                            "
	.ascii	"       \n     %%%%%%%(     %%%%//#%%%,    /%%%%%    %%%   ,%"
	.ascii	"%*     %%%      (%%,  ,%%%(/(%%%%    ******##(#(/**,*,,,,.,,"
	.ascii	",**//#%%((/,,,,,,,,,,,,,,,,,,,,,,,,,                        "
	.ascii	"                             \n     %%%. .%%%   /%%,    *%%,"
	.ascii	"        *%%.  %%%   ,%%*     ,%%%/  .%%%%,  %%#     %%%    ,"
	.ascii	"/***/((**//(%##(/(/((((/,,,,*#%#(,,,,,,,,,,,,,,,,,,,,**     "
	.ascii	"                                                   \n     %%"
	.ascii	"%    %%%*  %%%%%%%#%%, ,%%%%%%%%(   %%%   ,%%*       .#%%%( "
	.ascii	"(%%,  ,%%%%%%%%%%     *///(#(///////(#((##(*/*/,*,,,/(**,,,,"
	.ascii	",,,,,,,,**,,,,,,                                            "
	.ascii	"             \n                                             "
	.ascii	"              ((     #%%#                    ,*/(#/******/*/"
	.ascii	"*,,,,,.,,*,..,,*/*****,**********,*,,,                      "
	.ascii	"                                   \n                       "
	.ascii	"                                    .(#%%%%#,               "
	.ascii	"         (#(((/*/,//((///(/*,,**/*,*,*********////********.."
	.ascii	"..                                                       \n "
	.ascii	"                                                            "
	.ascii	"                                 ####(///#%####/(((/(///////"
	.ascii	"******/////**//(*,,,,,,,      "
	.ascii	"                                                 \n         "
	.ascii	"                                                            "
	.ascii	"                          /%%(((#%%%(%%%(##%%%(##(((/**/////"
	.ascii	"/*///,,,***,**,,                                            "
	.ascii	"           \n                                               "
	.ascii	"                                                 *##%&/&&&%%"
	.ascii	"&(@%&&#&%%%%((((/////(/,,,,/*/**,,,.....,.                  "
	.ascii	"                                 \n                         "
	.ascii	"                                                            "
	.ascii	"               %%&#%#&%&&%&&&&&&%%#(((##(//(////(/**,.,,.,,."
	.ascii	"..,...                                                 \n   "
	.ascii	"                                                            "
	.ascii	"                                    ,*/(#%&&%&&&&&%%%%%#%#(("
	.ascii	"(////#(//*,,,,,,...............                             "
	.ascii	"                 \n                                         "
	.ascii	"                                                          //"
	.ascii	"%%((#####%%%&%(/*/((((((##(/*.,.,..,..,.................... "
	.ascii	"                                       \n                   "
	.ascii	"                                                            "
	.ascii	"                 .(#///(/(((/(#(((((((###((/******,....,...."
	.ascii	"..........................                                  "
	.ascii	" \n                                                         "
	.ascii	"           .,***,**/////************/#%%%%#//((((##(########"
	.ascii	"###/*,,,,.,...,..............................,..,....       "
	.ascii	"                       \n                                   "
	.ascii	"                               *,**,,******************/(#%%"
	.ascii	"%%#///*/(((((((((((#/(((/,,,...,,.................."
	.string	".,...,,,...................                           \n                                                                ,*,*,,**/*,,,***********/(###%#(((///////((((((//****,*..,..,..............,,,,,..............................,                         \n"
	.ident	"GCC: (g2ee5e430018) 12.2.0"
