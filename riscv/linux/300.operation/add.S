/*
 * Operation example for RISC-V(RV64)/Linux
 *
 *   * add operation
 */

        .global main

main:
        /* save ra(return address) */
        addi    sp,sp,-8
        sd      ra,(sp)


        /* Add operation */
        li      t1, 1
        li      t2, 2
        add     t0, t1, t2              /* t0 <- t1 + t2 */


        /* printf for result-checking */
        la      a0, fmt                 /* 1st argument for printf*/
        mv      a1, t0                  /* 2nd argument for printf*/
        jal     printf    


        /* restore ra(return address) */
        ld      ra,(sp)
        addi    sp,sp,8

        /* return from main */
        ret


        /* read-only data */
        .section .rodata
fmt:
        .string "t1 + t2 = %x\n"
