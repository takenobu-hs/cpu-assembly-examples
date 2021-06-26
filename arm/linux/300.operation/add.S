/*
 * Operation example for Arm(Armv8 aarch64)/Linux
 *
 *   * add operation
 */

        .global main

main:
        /* save fp,lr registers */
        stp     x29, x30, [sp, -16]!


        /* Add operation */
        mov     x11, 1
        mov     x12, 2
        add     x10, x11, x12           /* rx10 <- x11 + x12 */


        /* printf for result-checking */
        adr     x0, fmt                 /* 1st argument for printf*/
        mov     x1, x10                 /* 2nd argument for printf*/
        bl      printf    


        /* restore fp,lr registers and return from main*/
        ldp     x29, x30, [sp], 16
        ret


        /* read-only data */
        .section .rodata
fmt:
        .string "x11 + x12 = %x\n"
