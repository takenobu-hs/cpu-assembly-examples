/*
 * Control-flow example for Arm(Armv8 aarch64)/Linux
 *
 *   * `for`-structure example
 *
 *   * C-like pseudo-code:
 *       x12 = 0;
 *       for (x11 = 1; x11 <= 10; x11++) {
 *           x12 = x12 + x11;
 *       }
 */

        .global main

main:
        /* save fp,lr registers */
        stp     x29, x30, [sp, -16]!


        /* accumulator for test */
        mov     x12, 0                  /* x12 = 0 */


        /* `for`-structure */
        mov     x11, 1                  /* x11 = 1 */

L_loop:
        add     x12, x12, x11           /* loop-body (x12 = x12 + x11) */

        add     x11, x11, 1             /* x11++ */
        cmp     x11, 10                 /* x11 <= 10 */
        ble     L_loop


        /* printf for result-checking */
        adr     x0, fmt                 /* 1st argument for printf */
        mov     x1, x12                 /* 2nd argument */
        bl      printf    


        /* restore fp,lr registers and return from main*/
        ldp     x29, x30, [sp], 16
        ret


        /* read-only data */
        .section .rodata
fmt:
        .string "x12 = %d\n"
