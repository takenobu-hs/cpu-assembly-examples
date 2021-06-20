/*
 * C standard library call example for Arm(Armv8 aarch64)/Linux
 *
 *   * putchar(3) standard-library
 */

.global main

main:
        /* save fp,lr registers */
        stp     x29, x30, [sp, -16]!


        /* call putchar() */
        mov     x0, 0x41                /* 'A' */
        bl      putchar

        mov     x0, 0x42                /* 'B' */
        bl      putchar

        mov     x0, 'C'
        bl      putchar

        mov     x0, '\n'
        bl      putchar


        /* restore fp,lr registers */
        ldp     x29, x30, [sp], 16
        ret
