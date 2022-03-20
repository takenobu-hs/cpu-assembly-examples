/*
 * An atomic counter example for Arm(Armv8 aarch64)/Linux
 *
 *   * cas instruction
 *
 *   * C-like pseudo-code:
 *       L_loop:
 *         x1 = *counter;                       // read counter
 *         x2 = x1;                             // save current cunter
 *         x5 = x1 + 1;                         // increment
 *
 *         // cas instruction
 *         tmp = *counter;                      // read counter
 *         if (x1 == tmp) *counter = x5;        // swap if unchanged
 *         x1 = tmp;
 *
 *         // check
 *         if (x1 != x2) goto L_loop;           // loop if fail
 */

        .global main

main:
        /* save fp,lr registers for printf */
        stp     x29, x30, [sp, -16]!



        /* set the address of the counter */
        adr     x10, counter


        /* increment the counter with cas loop */
L_loop:
        ldr     x1, [x10]               /* x1 = *counter           */
        mov     x2, x1                  /* save current counter    */
        add     x5, x1, 1               /* increment               */

        cas     x1, x5, [x10]           /* cas instruction         */

        cmp     x1, x2                  /* check the result of cas */
        bne     L_loop



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
