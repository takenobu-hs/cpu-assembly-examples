/*
 * An atomic counter example for RISC-V(RV64)/Linux
 *
 *   * fetch-and-add instruction
 *
 *   * C-like pseudo-code:
 *         t1 = 1;
 *         *counter = *counter + t1;
 */

        .global main

main:
        /* save ra(return address) and sp(stack pointer) */
        addi    sp,sp,-16
        sd      ra,8(sp)
        sd      s0,0(sp)



        /* set the address of the counter */
        la      t0, counter

        /* increment the counter with fetch-and-add */
        li        t1, 1                 /* t1 = 1       */
        amoadd.d  x0, t1, (t0)          /* *counter = *counter + t1 */



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
