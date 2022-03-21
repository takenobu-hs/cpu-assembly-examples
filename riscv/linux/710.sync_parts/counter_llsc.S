/*
 * An atomic counter example for RISC-V(RV64)/Linux
 *
 *   * ll/sc instruction
 *
 *   * C-like pseudo-code:
 *       L_loop:
 *         t1 = *counter;
 *         t1 = t1 + 1;
 *         if (not-conflict) *counter = t1;
 *         if (fail) goto L_loop;
 */

        .global main

main:
        /* save ra(return address) and sp(stack pointer) */
        addi    sp,sp,-16
        sd      ra,8(sp)
        sd      s0,0(sp)



        /* set the address of the counter */
        la      t0, counter

        /* increment the counter with ll/sc loop */
L_loop:
        lr.d    t1, (t0)                /* t1 = *counter                   */
        addi    t1, t1, 1               /* t1 = t1 + 1                     */
        sc.d    t2, t1, (t0)            /* if (not-conflict) *counter = t1 */
        bnez    t2, L_loop              /* if (fail) goto L_loop           */



        /* printf for result-checking */
        la      a0, fmt                 /* 1st argument for printf*/
        ld      a1, (t0)                /* 2nd argument for printf*/
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
        .string "counter = %d\n"


        /* read-write initialized data */
        .data
        .balign 8
counter:
        .quad   10
