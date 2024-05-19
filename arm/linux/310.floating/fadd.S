/*
 * Floating-point example for Arm(Armv8 aarch64)/Linux
 *
 *   * Double-precision (64-bit)
 *   * Floating-point add operation
 */

        .global main

main:
        /* save fp,lr registers */
        stp     x29, x30, [sp, -16]!


        /* Floating-point add operation */
        adr     x10, value1
        ldr     d1 , [x10]              /* d1 <- 1.0     */
        adr     x10, value2
        ldr     d2 , [x10]              /* d2 <- 2.0     */

        fadd    d0, d1, d2              /* d0 <- d1 + d2 */


        /* printf for result-checking */
        adr     x0, fmt                 /* 1st argument for printf */
//      mov     d0, d0                  /* 2nd argument for printf */
        bl      printf    


        /* restore fp,lr registers and return from main*/
        ldp     x29, x30, [sp], 16
        ret


        /* read-only data */
        .section .rodata
value1:
        .double 1.0
value2:
        .double 2.0

fmt:
        .string "d1 + d2 = %f\n"
