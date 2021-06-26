/*
 * C standard library call example for Arm(Armv8 aarch64)/Linux
 *
 *   * puts(3) standard-library
 *   * see: man 3 puts
 */

        .global main

main:
        /* save fp,lr registers */
        stp     x29, x30, [sp, -16]!


        /* puts(3) library-call */
        adr     x0, msg                 /* 1st argument */
        bl      puts    


        /* restore fp,lr registers and return from main*/
        ldp     x29, x30, [sp], 16
        ret


        /* read-only data */
        .section .rodata
msg:
        .string "Hello world!"
