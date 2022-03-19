/*
 * An atomic counter example for Arm(Armv8 aarch64)/Linux
 *
 *   * swap instruction
 *
 */

        .global main

main:
        /* save fp,lr registers for printf */
        stp     x29, x30, [sp, -16]!



        /* set addresses of the lock and the counter */
        adr     x11, lock
        adr     x10, counter


        /* acquire the lock */
        mov     x2, 1
L_loop:
        swp     x2, x0, [x11]
        cbnz    x0, L_loop

        /* increment the counter */
        ldr     x1, [x10]
        add     x1, x1, 1
        str     x1, [x10]

        /* release the lock */
        mov     x1, 0
        str     x1, [x11]



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
        .string "x0 = %d\n"


        /* read-write initialized data */
        .data
        .balign 8
lock:
        .quad   0
counter:
        .quad   0
