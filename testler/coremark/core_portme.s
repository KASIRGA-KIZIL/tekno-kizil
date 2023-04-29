	.file	"core_portme.c"
	.option nopic
	.attribute arch, "rv32i2p0_m2p0_c2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.section	.text.init_uart,"ax",@progbits
	.align	1
	.globl	init_uart
	.type	init_uart, @function
init_uart:
	li	a5,34078720
	addi	a5,a5,1
	li	a4,536870912
	sw	a5,0(a4)
	ret
	.size	init_uart, .-init_uart
	.section	.text.get_timer_low,"ax",@progbits
	.align	1
	.globl	get_timer_low
	.type	get_timer_low, @function
get_timer_low:
	li	a5,805306368
	lw	a0,0(a5)
	ret
	.size	get_timer_low, .-get_timer_low
	.section	.text.get_timer_high,"ax",@progbits
	.align	1
	.globl	get_timer_high
	.type	get_timer_high, @function
get_timer_high:
	li	a5,805306368
	lw	a0,4(a5)
	li	a1,0
	ret
	.size	get_timer_high, .-get_timer_high
	.section	.text.get_timer,"ax",@progbits
	.align	1
	.globl	get_timer
	.type	get_timer, @function
get_timer:
	li	a5,805306368
	lw	a0,0(a5)
	ret
	.size	get_timer, .-get_timer
	.section	.text.barebones_clock,"ax",@progbits
	.align	1
	.globl	barebones_clock
	.type	barebones_clock, @function
barebones_clock:
	li	a5,805306368
	lw	a1,4(a5)
	lw	a0,0(a5)
	ret
	.size	barebones_clock, .-barebones_clock
	.section	.text.start_time,"ax",@progbits
	.align	1
	.globl	start_time
	.type	start_time, @function
start_time:
	li	a5,805306368
	lw	a3,4(a5)
	lw	a4,0(a5)
	lla	a5,start_time_val
	sw	a3,4(a5)
	sw	a4,0(a5)
	ret
	.size	start_time, .-start_time
	.section	.text.stop_time,"ax",@progbits
	.align	1
	.globl	stop_time
	.type	stop_time, @function
stop_time:
	li	a5,805306368
	lw	a3,4(a5)
	lw	a4,0(a5)
	lla	a5,stop_time_val
	sw	a3,4(a5)
	sw	a4,0(a5)
	ret
	.size	stop_time, .-stop_time
	.section	.text.get_time,"ax",@progbits
	.align	1
	.globl	get_time
	.type	get_time, @function
get_time:
	lla	a3,stop_time_val
	lla	a4,start_time_val
	lw	a5,0(a3)
	lw	a0,0(a4)
	lw	a1,4(a3)
	lw	a4,4(a4)
	sub	a0,a5,a0
	sgtu	a5,a0,a5
	sub	a1,a1,a4
	sub	a1,a1,a5
	ret
	.size	get_time, .-get_time
	.section	.text.time_in_secs,"ax",@progbits
	.align	1
	.globl	time_in_secs
	.type	time_in_secs, @function
time_in_secs:
	li	a5,59998208
	addi	a5,a5,1792
	divu	a0,a0,a5
	ret
	.size	time_in_secs, .-time_in_secs
	.section	.text.portable_init,"ax",@progbits
	.align	1
	.globl	portable_init
	.type	portable_init, @function
portable_init:
	li	a5,34078720
	addi	a5,a5,1
	li	a4,536870912
	sw	a5,0(a4)
	li	a5,1
	sb	a5,0(a0)
	ret
	.size	portable_init, .-portable_init
	.section	.text.portable_fini,"ax",@progbits
	.align	1
	.globl	portable_fini
	.type	portable_fini, @function
portable_fini:
	sb	zero,0(a0)
	ret
	.size	portable_fini, .-portable_fini
	.globl	default_num_contexts
	.globl	seed5_volatile
	.globl	seed4_volatile
	.globl	seed3_volatile
	.globl	seed2_volatile
	.globl	seed1_volatile
	.section	.sbss,"aw",@nobits
	.align	3
	.type	stop_time_val, @object
	.size	stop_time_val, 8
stop_time_val:
	.zero	8
	.type	start_time_val, @object
	.size	start_time_val, 8
start_time_val:
	.zero	8
	.type	seed5_volatile, @object
	.size	seed5_volatile, 4
seed5_volatile:
	.zero	4
	.type	seed2_volatile, @object
	.size	seed2_volatile, 4
seed2_volatile:
	.zero	4
	.type	seed1_volatile, @object
	.size	seed1_volatile, 4
seed1_volatile:
	.zero	4
	.section	.sdata,"aw"
	.align	2
	.type	default_num_contexts, @object
	.size	default_num_contexts, 4
default_num_contexts:
	.word	1
	.type	seed4_volatile, @object
	.size	seed4_volatile, 4
seed4_volatile:
	.word	2000
	.type	seed3_volatile, @object
	.size	seed3_volatile, 4
seed3_volatile:
	.word	102
	.ident	"GCC: (g2ee5e430018) 12.2.0"
