/*
 * Branch prediction example for Arm(Armv8 aarch64)/Linux
 *
 *   * Branch conditions are always true.
 *   * FEW branch mispredictions occur.
 *
 *   * C-like pseudo-code:
 *
 *         for (i=0; i<10000000; i++) {
 *
 *             x = xorshift();                // generate a random number
 *
 *             if (x == x) goto L_br;         // branch-prediction test
 *             nop;
 *         L_br:
 *
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

        adr     x10, random
        ldr     x0, [x10]               /* initial number of xorshift(xor64) */

L_loop:
        /* generate a random number with the xorshift algorithm */
        lsl     x1, x0, 13              /* x = x ^ (x << 13) */
        eor     x0, x0, x1

        asr     x1, x0, 7               /* x = x ^ (x >> 7) */
        eor     x0, x0, x1

        lsl     x1, x0, 17              /* x = x ^ (x << 17) */
        eor     x0, x0, x1


        /* branch-prediction test */
        and     x2, x0, 1
        cmp     x2, x2                  /* zero(eq) flag is always true */
        beq     L_br                    /* branch-prediction test */
        nop
L_br:

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
random:
        .quad   88172645463325252       /* xorshift(xor64)'s initial value */

fmt:
        .string "loop-variable = %d\n"
