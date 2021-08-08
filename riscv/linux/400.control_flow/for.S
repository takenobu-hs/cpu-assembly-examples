/*
 * Control-flow example for RISC-V(RV64)/Linux
 *
 *   * `for`-structure example
 *
 *   * C-like pseudo-code:
 *       t2 = 0;
 *       for (t1 = 1; t1 <= 10; t1++) {
 *           t2 = t2 + t1;
 *       }
 */

        .global main

main:
        /* save ra(return address) and sp(stack pointer) */
        addi    sp,sp,-16
        sd      ra,8(sp)
        sd      s0,0(sp)


        /* accumulator for test */
        li      t2, 0                   /* t2 = 0 */


        /* `for`-structure */
        li      t1, 1                   /* t1 = 1 */

L_loop:
        add     t2, t2, t1              /* loop-body (t2 = t2 + t1) */

        add     t1, t1, 1               /* t1++ */
        li      t0, 10
        ble     t1, t0, L_loop          /* t1 <= 10 */


        /* printf for result-checking */
        la      a0, fmt                 /* 1st argument for printf */
        mv      a1, t2                  /* 2nd argument */
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
        .string "t2 = %d\n"
