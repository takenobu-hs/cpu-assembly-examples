/*
 * C standard library call example for RISC-V(RV64)/Linux
 *
 *   * printf(3) standard-library
 *   * variable argument call
 *   * see: man 3 printf
 */

        .global main

main:
        /* save ra(return address) */
        addi    sp,sp,-8
        sd      ra,(sp)

        li      x6, 100                 /* test data */


        /* printf(3) library-call */
        la      a0, msg                 /* 1st argument */
        mv      a1, x6                  /* 2nd argument */
        jal     printf    


        /* restore ra(return address) */
        ld      ra,(sp)
        addi    sp,sp,8

        /* return from main */
        ret


        /* read-only data */
        .section .rodata
msg:
        .string "x6 = %d\n"
