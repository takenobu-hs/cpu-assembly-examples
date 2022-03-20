/*
 * An atomic counter example for Arm(Armv8 aarch64)/Linux
 *
 *   * ll/sc instruction
 *
 *   * C-like pseudo-code:
 *       L_loop:
 *         x1 = *counter;
 *         x1 = x1 + 1;
 *         if (not-conflict) *counter = x1;
 *         if (fail) goto L_loop;
 */

        .global main

main:
        /* save fp,lr registers for printf */
        stp     x29, x30, [sp, -16]!



        /* set the address of the counter */
        adr     x10, counter


        /* increment the counter with ll/sc loop */
L_loop:
        ldxr    x1, [x10]               /* x1 = *counter                   */
        add     x1, x1, 1               /* x1 = x1 + 1                     */
        stxr    w2, x1, [x10]           /* if (not-conflict) *counter = x1 */
        cbnz    w2, L_loop              /* if (fail) goto L_loop           */



        /* printf for result-checking */
        adr     x0, fmt                 /* 1st argument for printf */
        ldr     x1, [x10]               /* 2nd argument */
        bl      printf    


        /* restore fp,lr registers and return from main */
        ldp     x29, x30, [sp], 16
        ret


        /* read-only data */
        .section .rodata
fmt:
        .string "counter = %d\n"


        /* read-write initialized data */
        .data
        .balign 8
counter:
        .quad   10
