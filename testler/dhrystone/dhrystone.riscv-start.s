# 0 "start.S"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "start.S"
# See LICENSE for license details.
# 13 "start.S"
# .section ".text.init"
# .globl _start
  .text
  .global _start
  .type _start, @function
_start:
  li x1, 0
# x2 (sp) is initialized by reset
  li x3, 0
  li x4, 0
  li x5, 0
  li x6, 0
  li x7, 0
  li x8, 0
  li x9, 0
  li x10,0
  li x11,0
  li x12,0
  li x13,0
  li x14,0
  li x15,0
  li x16,0
  li x17,0
  li x18,0
  li x19,0
  li x20,0
  li x21,0
  li x22,0
  li x23,0
  li x24,0
  li x25,0
  li x26,0
  li x27,0
  li x28,0
  li x29,0
  li x30,0
  li x31,0

  # initialize global pointer
.option push
.option norelax
la gp, __global_pointer$
.option pop

  la tp, _end + 63
  and tp, tp, -64

  # get core id
  #csrr a0, 1
  li a0, 0
  # for now, assume only 1 core
  li a1, 1
1:bgeu a0, a1, 1b

  # give each core 16KB of stack + TLS

  addi sp, a0, 1
  sll sp, sp, 14
  add sp, sp, tp
  sll a2, a0, 14
  add tp, tp, a2

call main
2:
j 2b
#j _init

  .align 2



.section ".tdata.begin"
.globl _tdata_begin
_tdata_begin:

.section ".tdata.end"
.globl _tdata_end
_tdata_end:

.section ".tbss.end"
.globl _tbss_end
_tbss_end:

.section ".tohost","aw",@progbits
.align 6
.globl tohost
tohost: .dword 0
.align 6
.globl fromhost
fromhost: .dword 0
