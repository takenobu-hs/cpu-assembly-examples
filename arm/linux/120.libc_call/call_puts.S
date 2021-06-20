/*
 * C standard library call example for Arm(Armv8 aarch64)/Linux
 *
 *   * puts(3) standard-library
 */

.global main

main:
        /* save fp,lr registers */
        stp     x29, x30, [sp, -16]!


        /* call puts() */
        adr     x0, msg                 /* 1st argument */
        bl      puts    


        /* restore fp,lr registers */
        ldp     x29, x30, [sp], 16
        ret


msg:    .string "Hello world!\n"
