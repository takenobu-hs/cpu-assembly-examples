/*
 * Latency example for Arm(Armv8 aarch64)/Linux
 *
 *   * `mul` instruction
 *
 *   * C-like pseudo-code:
 *
 *         for (i=0; i<10000000; i++) {
 *             mul instruction
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

        mov     x13, 1                  /* 1st operand for mul instructions */
        mov     x14, 1                  /* 2nd operand for mul instructions */


        /* loop body */
L_loop:
        mul     x13, x13, x14           /* x13 = x13 * x14 */
        mul     x13, x13, x14
        mul     x13, x13, x14
        mul     x13, x13, x14
        mul     x13, x13, x14
        mul     x13, x13, x14
        mul     x13, x13, x14
        mul     x13, x13, x14
        mul     x13, x13, x14
        mul     x13, x13, x14

        mul     x13, x13, x14
        mul     x13, x13, x14
        mul     x13, x13, x14
        mul     x13, x13, x14
        mul     x13, x13, x14
        mul     x13, x13, x14
        mul     x13, x13, x14
        mul     x13, x13, x14
        mul     x13, x13, x14
        mul     x13, x13, x14

        mul     x13, x13, x14
        mul     x13, x13, x14
        mul     x13, x13, x14
        mul     x13, x13, x14
        mul     x13, x13, x14
        mul     x13, x13, x14
        mul     x13, x13, x14
        mul     x13, x13, x14
        mul     x13, x13, x14
        mul     x13, x13, x14

        mul     x13, x13, x14
        mul     x13, x13, x14
        mul     x13, x13, x14
        mul     x13, x13, x14
        mul     x13, x13, x14
        mul     x13, x13, x14
        mul     x13, x13, x14
        mul     x13, x13, x14
        mul     x13, x13, x14
        mul     x13, x13, x14

        mul     x13, x13, x14
        mul     x13, x13, x14
        mul     x13, x13, x14
        mul     x13, x13, x14
        mul     x13, x13, x14
        mul     x13, x13, x14
        mul     x13, x13, x14
        mul     x13, x13, x14
        mul     x13, x13, x14
        mul     x13, x13, x14

        mul     x13, x13, x14
        mul     x13, x13, x14
        mul     x13, x13, x14
        mul     x13, x13, x14
        mul     x13, x13, x14
        mul     x13, x13, x14
        mul     x13, x13, x14
        mul     x13, x13, x14
        mul     x13, x13, x14
        mul     x13, x13, x14

        mul     x13, x13, x14
        mul     x13, x13, x14
        mul     x13, x13, x14
        mul     x13, x13, x14
        mul     x13, x13, x14
        mul     x13, x13, x14
        mul     x13, x13, x14
        mul     x13, x13, x14
        mul     x13, x13, x14
        mul     x13, x13, x14

        mul     x13, x13, x14
        mul     x13, x13, x14
        mul     x13, x13, x14
        mul     x13, x13, x14
        mul     x13, x13, x14
        mul     x13, x13, x14
        mul     x13, x13, x14
        mul     x13, x13, x14
        mul     x13, x13, x14
        mul     x13, x13, x14

        mul     x13, x13, x14
        mul     x13, x13, x14
        mul     x13, x13, x14
        mul     x13, x13, x14
        mul     x13, x13, x14
        mul     x13, x13, x14
        mul     x13, x13, x14
        mul     x13, x13, x14
        mul     x13, x13, x14
        mul     x13, x13, x14

        mul     x13, x13, x14
        mul     x13, x13, x14
        mul     x13, x13, x14
        mul     x13, x13, x14
        mul     x13, x13, x14
        mul     x13, x13, x14
        mul     x13, x13, x14
        mul     x13, x13, x14
        mul     x13, x13, x14
        mul     x13, x13, x14

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
