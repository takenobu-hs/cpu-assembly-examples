/*
 * An atomic counter example for Arm(Armv8 aarch64)/Linux
 *
 *   * fetch-and-add instruction
 *
 *   * C-like pseudo-code:
 *         x1 = 1;
 *         *counter = *counter + x1;
 */

        .global main

main:
        /* save fp,lr registers for printf */
        stp     x29, x30, [sp, -16]!



        /* set the address of the counter */
        adr     x10, counter

        /* increment the counter with fetch-and-add */
        mov     x1,  1                  /* x1 = 1 */
        stadd   x1, [x10]               /* *counter = *counter + x1 */



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
        .string "x10 = %d\n"


        /* read-write initialized data */
        .data
        .balign 8
counter:
        .quad   10
