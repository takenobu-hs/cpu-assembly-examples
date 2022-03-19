/*
 * An atomic counter example for Arm(Armv8 aarch64)/Linux
 *
 *   * cas instruction
 *
 */

        .global main

main:
        /* save fp,lr registers for printf */
        stp     x29, x30, [sp, -16]!



        /* set the address of the counter */
        adr     x10, counter


        /* increment the counter with cas loop */
L_loop:
        ldr     x1, [x10]               /* x1 = *counter        */
        mov     x2, x1                  /* save current counter */
        add     x5, x1, 1               /* increment            */

        cas     x1, x5, [x10]           /* cas instruction      */

        cmp     x1, x2                  /* check result of cas  */
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
        .string "x10 = %d\n"


        /* read-write initialized data */
        .data
        .balign 8
counter:
        .quad   10
