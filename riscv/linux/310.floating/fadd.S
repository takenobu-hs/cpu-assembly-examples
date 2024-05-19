/*
 * Floating-point example for RISC-V(RV64)/Linux
 *
 *   * Double-precision (64-bit)
 *   * Floating-point add operation
 */

        .global main

main:
        /* save ra(return address) */
        addi    sp,sp,-8
        sd      ra,(sp)


        /* Floating-point add operation */
        la      t0, value1
        fld     ft1, (t0)               /* ft1 <- 1.0       */
        la      t0, value2
        fld     ft2, (t0)               /* ft1 <- 2.0       */

        fadd.d  ft0, ft1, ft2           /* ft0 <- ft1 + ft2 */


        /* printf for result-checking */
        la      a0, fmt                 /* 1st argument for printf*/
        fmv.x.d a1, ft0                 /* 2nd argument for printf*/
        jal     printf    


        /* restore ra(return address) */
        ld      ra,(sp)
        addi    sp,sp,8

        /* return from main */
        ret


        /* read-only data */
        .section .rodata
value1:
        .double 1.0
value2:
        .double 2.0

fmt:
        .string "ft1 + ft2 = %f\n"
