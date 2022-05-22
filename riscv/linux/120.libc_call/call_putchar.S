/*
 * C standard library call example for RISC-V(RV64)/Linux
 *
 *   * putchar(3) standard-library
 *   * see: man 3 putchar
 */

        .global main

main:
        /* save ra(return address) */
        addi    sp,sp,-8
        sd      ra,(sp)


        /* putchar(3) library-call */
        li      a0, 0x41                /* 'A' */
        jal     putchar

        li      a0, 0x42                /* 'B' */
        jal     putchar

        li      a0, 'C'
        jal     putchar

        li      a0, '\n'
        jal     putchar


        /* restore ra(return address) */
        ld      ra,(sp)
        addi    sp,sp,8

        /* return from main */
        ret
