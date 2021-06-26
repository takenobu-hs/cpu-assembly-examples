/*
 * C standard library call example for Arm(Armv8 aarch64)/Linux
 *
 *   * printf(3) standard-library
 *   * variable argument call
 *   * see: man 3 printf
 */

        .global main

main:
        /* save fp,lr registers */
        stp     x29, x30, [sp, -16]!


        /* printf(3) library-call */
        adr     x0, msg                 /* 1st argument */
        bl      printf    


        /* restore fp,lr registers and return from main*/
        ldp     x29, x30, [sp], 16
        ret


        /* read-only data */
        .section .rodata
msg:
        .string "Hello world!\n"
