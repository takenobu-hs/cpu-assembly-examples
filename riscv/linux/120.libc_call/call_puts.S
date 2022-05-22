/*
 * C standard library call example for RISC-V(RV64)/Linux
 *
 *   * puts(3) standard-library
 *   * see: man 3 puts
 */

        .global main

main:
        /* save ra(return address) */
        addi    sp,sp,-8
        sd      ra,(sp)


        /* puts(3) library-call */
        la      a0, msg                 /* 1st argument */
        jal     puts    


        /* restore ra(return address) */
        ld      ra,(sp)
        addi    sp,sp,8

        /* return from main */
        ret


        /* read-only data */
        .section .rodata
msg:
        .string "Hello world!"
