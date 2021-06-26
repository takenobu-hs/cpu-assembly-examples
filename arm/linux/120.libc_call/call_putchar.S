/*
 * C standard library call example for Arm(Armv8 aarch64)/Linux
 *
 *   * putchar(3) standard-library
 *   * see: man 3 putchar
 */

        .global main

main:
        /* save fp,lr registers */
        stp     x29, x30, [sp, -16]!


        /* putchar(3) library-call */
        mov     x0, 0x41                /* 'A' */
        bl      putchar

        mov     x0, 0x42                /* 'B' */
        bl      putchar

        mov     x0, 'C'
        bl      putchar

        mov     x0, '\n'
        bl      putchar


        /* restore fp,lr registers and return from main*/
        ldp     x29, x30, [sp], 16
        ret
