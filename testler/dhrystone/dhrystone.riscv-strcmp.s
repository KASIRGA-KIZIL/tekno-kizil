# 0 "strcmp.S"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "strcmp.S"
# 30 "strcmp.S"
.text
.globl strcmp
.type strcmp, @function
strcmp:
  or a4, a0, a1
  li t2, -1
  and a4, a4, 4 -1
  bnez a4, .Lmisaligned


  li a5, 0x7f7f7f7f




  .macro check_one_word i n
    lw a2, \i*4(a0)
    lw a3, \i*4(a1)

    and t0, a2, a5
    or t1, a2, a5
    add t0, t0, a5
    or t0, t0, t1

    bne t0, t2, .Lnull\i
    .if \i+1-\n
      bne a2, a3, .Lmismatch
    .else
      add a0, a0, \n*4
      add a1, a1, \n*4
      beq a2, a3, .Lloop
      # fall through to .Lmismatch
    .endif
  .endm

  .macro foundnull i n
    .ifne \i
      .Lnull\i:
      add a0, a0, \i*4
      add a1, a1, \i*4
      .ifeq \i-1
        .Lnull0:
      .endif
      bne a2, a3, .Lmisaligned
      li a0, 0
      ret
    .endif
  .endm

.Lloop:
  # examine full words at a time, favoring strings of a couple dozen chars

  check_one_word 0 5
  check_one_word 1 5
  check_one_word 2 5
  check_one_word 3 5
  check_one_word 4 5





  # backwards branch to .Lloop contained above

.Lmismatch:
  # words don't match, but a2 has no null byte.
# 104 "strcmp.S"
  sll a4, a2, 16
  sll a5, a3, 16
  bne a4, a5, .Lmismatch_upper

  srl a4, a2, 8*4 -16
  srl a5, a3, 8*4 -16
  sub a0, a4, a5
  and a1, a0, 0xff
  bnez a1, 1f
  ret

.Lmismatch_upper:
  srl a4, a4, 8*4 -16
  srl a5, a5, 8*4 -16
  sub a0, a4, a5
  and a1, a0, 0xff
  bnez a1, 1f
  ret

1:and a4, a4, 0xff
  and a5, a5, 0xff
  sub a0, a4, a5
  ret

.Lmisaligned:
  # misaligned
  lbu a2, 0(a0)
  lbu a3, 0(a1)
  add a0, a0, 1
  add a1, a1, 1
  bne a2, a3, 1f
  bnez a2, .Lmisaligned

1:
  sub a0, a2, a3
  ret

  # cases in which a null byte was detected

  foundnull 0 5
  foundnull 1 5
  foundnull 2 5
  foundnull 3 5
  foundnull 4 5





.size strcmp, .-strcmp
