/*
 * Latency example for Arm(Armv8 aarch64)/Linux
 *
 *   * `fadd` instruction
 *
 *   * C-like pseudo-code:
 *
 *         for (i=0; i<10000000; i++) {
 *             fadd instruction
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

        adr     x10, value1
        ldr     d1 , [x10]              /* 1st operand for add instructions */
        ldr     d2 , [x10]              /* 2nd operand for add instructions */


        /* loop body */
L_loop:
        fadd    d1, d1, d2              /* d1 <- d1 + d2 */
        fadd    d1, d1, d2
        fadd    d1, d1, d2
        fadd    d1, d1, d2
        fadd    d1, d1, d2
        fadd    d1, d1, d2
        fadd    d1, d1, d2
        fadd    d1, d1, d2
        fadd    d1, d1, d2
        fadd    d1, d1, d2

        fadd    d1, d1, d2
        fadd    d1, d1, d2
        fadd    d1, d1, d2
        fadd    d1, d1, d2
        fadd    d1, d1, d2
        fadd    d1, d1, d2
        fadd    d1, d1, d2
        fadd    d1, d1, d2
        fadd    d1, d1, d2
        fadd    d1, d1, d2

        fadd    d1, d1, d2
        fadd    d1, d1, d2
        fadd    d1, d1, d2
        fadd    d1, d1, d2
        fadd    d1, d1, d2
        fadd    d1, d1, d2
        fadd    d1, d1, d2
        fadd    d1, d1, d2
        fadd    d1, d1, d2
        fadd    d1, d1, d2

        fadd    d1, d1, d2
        fadd    d1, d1, d2
        fadd    d1, d1, d2
        fadd    d1, d1, d2
        fadd    d1, d1, d2
        fadd    d1, d1, d2
        fadd    d1, d1, d2
        fadd    d1, d1, d2
        fadd    d1, d1, d2
        fadd    d1, d1, d2

        fadd    d1, d1, d2
        fadd    d1, d1, d2
        fadd    d1, d1, d2
        fadd    d1, d1, d2
        fadd    d1, d1, d2
        fadd    d1, d1, d2
        fadd    d1, d1, d2
        fadd    d1, d1, d2
        fadd    d1, d1, d2
        fadd    d1, d1, d2

        fadd    d1, d1, d2
        fadd    d1, d1, d2
        fadd    d1, d1, d2
        fadd    d1, d1, d2
        fadd    d1, d1, d2
        fadd    d1, d1, d2
        fadd    d1, d1, d2
        fadd    d1, d1, d2
        fadd    d1, d1, d2
        fadd    d1, d1, d2

        fadd    d1, d1, d2
        fadd    d1, d1, d2
        fadd    d1, d1, d2
        fadd    d1, d1, d2
        fadd    d1, d1, d2
        fadd    d1, d1, d2
        fadd    d1, d1, d2
        fadd    d1, d1, d2
        fadd    d1, d1, d2
        fadd    d1, d1, d2

        fadd    d1, d1, d2
        fadd    d1, d1, d2
        fadd    d1, d1, d2
        fadd    d1, d1, d2
        fadd    d1, d1, d2
        fadd    d1, d1, d2
        fadd    d1, d1, d2
        fadd    d1, d1, d2
        fadd    d1, d1, d2
        fadd    d1, d1, d2

        fadd    d1, d1, d2
        fadd    d1, d1, d2
        fadd    d1, d1, d2
        fadd    d1, d1, d2
        fadd    d1, d1, d2
        fadd    d1, d1, d2
        fadd    d1, d1, d2
        fadd    d1, d1, d2
        fadd    d1, d1, d2
        fadd    d1, d1, d2

        fadd    d1, d1, d2
        fadd    d1, d1, d2
        fadd    d1, d1, d2
        fadd    d1, d1, d2
        fadd    d1, d1, d2
        fadd    d1, d1, d2
        fadd    d1, d1, d2
        fadd    d1, d1, d2
        fadd    d1, d1, d2
        fadd    d1, d1, d2

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
value1:
        .double 1.0

fmt:
        .string "loop-variable = %d\n"
