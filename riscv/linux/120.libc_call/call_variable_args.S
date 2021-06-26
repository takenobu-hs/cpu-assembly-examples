/*
 * C standard library call example for RISV-V(RV64)/Linux
 *
 *   * printf(3) standard-library
 *   * variable argument call
 *   * see: man 3 printf
 */

        .global main

main:
        /* save ra(return address) and sp(stack pointer) */
        addi    sp,sp,-16
        sd      ra,8(sp)
        sd      s0,0(sp)


        /* printf(3) library-call */
        la      a0, msg                 /* 1st argument */
        jal     printf    


        /* restore ra(return address) and sp(stack pointer) */
        ld      ra,8(sp)
        ld      s0,0(sp)
        addi    sp,sp,16

        /* return from main */
        ret


        /* read-only data */
        .section .rodata
msg:
        .string "Hello world!\n"
