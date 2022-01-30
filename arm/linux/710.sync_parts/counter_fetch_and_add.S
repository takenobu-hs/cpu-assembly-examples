/*
 * An atomic counter example for Arm(Armv8 aarch64)/Linux
 *
 */

        .global main

main:
        /* save fp,lr registers */
        stp     x29, x30, [sp, -16]!


        adr     x10, counter

        mov     x1,  1
        stadd   x1, [x10]


        /* printf for result-checking */
        adr     x0, fmt                 /* 1st argument for printf */
        ldr     x1, [x10]               /* 2nd argument */
        bl      printf    


        /* restore fp,lr registers and return from main*/
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
