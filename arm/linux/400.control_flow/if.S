/*
 * Control-flow example for Arm(Armv8 aarch64)/Linux
 *
 *   * `if`-structure example
 *
 *   * C-like pseudo-code:
 *       if (r11 >= 0) {
 *           r12 = 1
 *       } else {
 *           r12 = -1
 *       }
 */

        .global main

main:
        /* save fp,lr registers */
        stp     x29, x30, [sp, -16]!


        /* test data */
        mov     x11, 10                 /* Change here */


        /* if (x11 >= 0) */
        cmp     x11, 0
        b.lt    L_else

        /* then */
        mov     x12, 1
        b       L_endif

        /* else */
L_else:
        mov     x12, -1

        /* endif */
L_endif:


        /* printf for result-checking */
        adr     x0, fmt                 /* 1st argument for printf */
        mov     x1, x11                 /* 2nd argument */
        mov     x2, x12                 /* 3rd argument */
        bl      printf    


        /* restore fp,lr registers and return from main*/
        ldp     x29, x30, [sp], 16
        ret


        /* read-only data */
        .section .rodata
fmt:
        .string "r11, r12 = %d, %d\n"
