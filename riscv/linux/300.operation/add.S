/*
 * Operation example for RISV-V(RV64)/Linux
 *
 *   * add operation
 */

        .global main

main:
        /* save ra(return address) and sp(stack pointer) */
        addi    sp,sp,-16
        sd      ra,8(sp)
        sd      s0,0(sp)


        /* Add operation */
        li      t1, 1
        li      t2, 2
        add     t0, t1, t2              /* t0 <- t1 + t2 */


        /* printf for result-checking */
        la      a0, fmt                 /* 1st argument for printf*/
        mv      a1, t0                  /* 2nd argument for printf*/
        jal     printf    


        /* restore ra(return address) and sp(stack pointer) */
        ld      ra,8(sp)
        ld      s0,0(sp)
        addi    sp,sp,16

        /* return from main */
        ret


        /* read-only data */
        .section .rodata
fmt:
        .string "t1 + t2 = %x\n"
