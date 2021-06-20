/*
 * C standard library call example for Arm(Armv8 aarch64)/Linux
 *
 *   * printf(3) standard-library
 *   * variable argument call
 */

.global main

main:
        /* save fp,lr registers */
        stp     x29, x30, [sp, -16]!


        /* call printf() */
        adr     x0, msg                 /* 1st argument */
        bl      printf    


        /* restore fp,lr registers */
        ldp     x29, x30, [sp], 16
        ret


msg:    .string "Hello world!\n"
