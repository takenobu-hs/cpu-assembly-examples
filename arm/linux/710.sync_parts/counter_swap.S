/*
 * An atomic counter example for Arm(Armv8 aarch64)/Linux
 *
 */

        .global main

main:
        /* save fp,lr registers */
        stp     x29, x30, [sp, -16]!


        adr     x11, lock
        adr     x10, counter

L_loop:
        ldr     x0, [x11]
        cbnz    x0, L_loop

        ldr     x1, [x10]
        add     x1, x1, 1
        str     x1, [x10]

        mov     x1, 0
        str     x1, [x11]

        
        mov     x13, x0         /* save value */

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
        .string "x0 = %d\n"


        /* read-write initialized data */
        .data
        .balign 8
lock:
        .quad   0
counter:
        .quad   0
