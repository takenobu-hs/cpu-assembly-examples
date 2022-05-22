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


        /* printf(3) library-call */
        la      a0, msg                 /* 1st argument */
        jal     printf    


        /* restore ra(return address) */
        ld      ra,(sp)
        addi    sp,sp,8

        /* return from main */
        ret


        /* read-only data */
        .section .rodata
msg:
        .string "Hello world!\n"
