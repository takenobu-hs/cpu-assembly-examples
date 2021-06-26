/*
 * C standard library call example for RISV-V(RV64)/Linux
 *
 *   * putchar(3) standard-library
 *   * see: man 3 putchar
 */

        .global main

main:
        /* save ra(return address) and sp(stack pointer) */
        addi    sp,sp,-16
        sd      ra,8(sp)
        sd      s0,0(sp)


        /* putchar(3) library-call */
        li      a0, 0x41                /* 'A' */
        jal     putchar

        li      a0, 0x42                /* 'B' */
        jal     putchar

        li      a0, 'C'
        jal     putchar

        li      a0, '\n'
        jal     putchar


        /* restore ra(return address) and sp(stack pointer) */
        ld      ra,8(sp)
        ld      s0,0(sp)
        addi    sp,sp,16

        /* return from main */
        ret
