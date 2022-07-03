/*
 * Superscalar-issue example for Arm(Armv8 aarch64)/Linux
 *
 *   * `add` instructions without true-data-dependencies
 *
 *   * C-like pseudo-code:
 *
 *         for (i=0; i<10000000; i++) {
 *             add instruction
 *                   :                  // 100 times
 *         }
 *
 */

        .global main

main:
        /* save fp,lr registers */
        stp     x29, x30, [sp, -16]!

        /* loop conditions */
        mov     x11, 0                  /* loop variable   */
        ldr     x12, =10000000          /* loop max-number */

        mov     x14, 0                  /* 2nd operand for add instructions */


        /* loop body */
L_loop:
        add     x1, x1, x14             /* x1 = x1 + x14 */
        add     x2, x2, x14
        add     x3, x3, x14
        add     x4, x4, x14
        add     x5, x5, x14
        add     x6, x6, x14
        add     x7, x7, x14
        add     x8, x8, x14
        add     x9, x9, x14
        add     x10, x10, x14

        add     x1, x1, x14
        add     x2, x2, x14
        add     x3, x3, x14
        add     x4, x4, x14
        add     x5, x5, x14
        add     x6, x6, x14
        add     x7, x7, x14
        add     x8, x8, x14
        add     x9, x9, x14
        add     x10, x10, x14

        add     x1, x1, x14
        add     x2, x2, x14
        add     x3, x3, x14
        add     x4, x4, x14
        add     x5, x5, x14
        add     x6, x6, x14
        add     x7, x7, x14
        add     x8, x8, x14
        add     x9, x9, x14
        add     x10, x10, x14

        add     x1, x1, x14
        add     x2, x2, x14
        add     x3, x3, x14
        add     x4, x4, x14
        add     x5, x5, x14
        add     x6, x6, x14
        add     x7, x7, x14
        add     x8, x8, x14
        add     x9, x9, x14
        add     x10, x10, x14

        add     x1, x1, x14
        add     x2, x2, x14
        add     x3, x3, x14
        add     x4, x4, x14
        add     x5, x5, x14
        add     x6, x6, x14
        add     x7, x7, x14
        add     x8, x8, x14
        add     x9, x9, x14
        add     x10, x10, x14

        add     x1, x1, x14
        add     x2, x2, x14
        add     x3, x3, x14
        add     x4, x4, x14
        add     x5, x5, x14
        add     x6, x6, x14
        add     x7, x7, x14
        add     x8, x8, x14
        add     x9, x9, x14
        add     x10, x10, x14

        add     x1, x1, x14
        add     x2, x2, x14
        add     x3, x3, x14
        add     x4, x4, x14
        add     x5, x5, x14
        add     x6, x6, x14
        add     x7, x7, x14
        add     x8, x8, x14
        add     x9, x9, x14
        add     x10, x10, x14

        add     x1, x1, x14
        add     x2, x2, x14
        add     x3, x3, x14
        add     x4, x4, x14
        add     x5, x5, x14
        add     x6, x6, x14
        add     x7, x7, x14
        add     x8, x8, x14
        add     x9, x9, x14
        add     x10, x10, x14

        add     x1, x1, x14
        add     x2, x2, x14
        add     x3, x3, x14
        add     x4, x4, x14
        add     x5, x5, x14
        add     x6, x6, x14
        add     x7, x7, x14
        add     x8, x8, x14
        add     x9, x9, x14
        add     x10, x10, x14

        add     x1, x1, x14
        add     x2, x2, x14
        add     x3, x3, x14
        add     x4, x4, x14
        add     x5, x5, x14
        add     x6, x6, x14
        add     x7, x7, x14
        add     x8, x8, x14
        add     x9, x9, x14
        add     x10, x10, x14


        /* increment the loop-variable and loop-back */
        add     x11, x11, 1
        cmp     x11, x12
        blt     L_loop


        /* print the last loop-variable */
        adr     x0, fmt                 /* 1st argument for printf */
        mov     x1, x11                 /* 2nd argument */
        bl      printf


        /* restore fp,lr registers and return from main*/
        ldp     x29, x30, [sp], 16
        ret


        /* read-only data */
        .section .rodata
fmt:
        .string "loop-variable = %d\n"
