/*
 * Out-of-order execution example for Arm(Armv8 aarch64)/Linux
 *
 *   * `load` instruction
 *
 *   * Reordering with a pending instruction
 *
 *         for (i=0; i<10000000; i++) {
 *             x14 = load(x14);
 *             x14 = x14 + x10;         // pendinig the load instruction
 *             x15 = x15 + x10;         // NO out-of-order execution
 *             x15 = x15 + x10;
 *             x15 = x15 + x10;
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

        adr     x14, buf                /* address for load instructions  */
        str     x14, [x14]              /* pre-store the address for load */

        mov     x10, 0


        /* loop body */
L_loop:
        ldr     x14, [x14]              /* x14 = load(x14) */
        add     x14, x14, x10           /* true data dependency with rdx */
        add     x15, x15, x10           /* NO true data dpendency with rdx */
        add     x15, x15, x10           /* NO true data dpendency with rdx */
        add     x15, x15, x10           /* NO true data dpendency with rdx */

        ldr     x14, [x14]
        add     x14, x14, x10
        add     x15, x15, x10
        add     x15, x15, x10
        add     x15, x15, x10

        ldr     x14, [x14]
        add     x14, x14, x10
        add     x15, x15, x10
        add     x15, x15, x10
        add     x15, x15, x10

        ldr     x14, [x14]
        add     x14, x14, x10
        add     x15, x15, x10
        add     x15, x15, x10
        add     x15, x15, x10

        ldr     x14, [x14]
        add     x14, x14, x10
        add     x15, x15, x10
        add     x15, x15, x10
        add     x15, x15, x10

        ldr     x14, [x14]
        add     x14, x14, x10
        add     x15, x15, x10
        add     x15, x15, x10
        add     x15, x15, x10

        ldr     x14, [x14]
        add     x14, x14, x10
        add     x15, x15, x10
        add     x15, x15, x10
        add     x15, x15, x10

        ldr     x14, [x14]
        add     x14, x14, x10
        add     x15, x15, x10
        add     x15, x15, x10
        add     x15, x15, x10

        ldr     x14, [x14]
        add     x14, x14, x10
        add     x15, x15, x10
        add     x15, x15, x10
        add     x15, x15, x10

        ldr     x14, [x14]
        add     x14, x14, x10
        add     x15, x15, x10
        add     x15, x15, x10
        add     x15, x15, x10

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


        /* read-write data */
        .data
buf:
        .quad   0
