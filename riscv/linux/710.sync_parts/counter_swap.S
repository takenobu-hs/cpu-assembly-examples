/*
 * An atomic counter example for RISC-V(RV64)/Linux
 *
 *   * swap instruction
 *
 *   * C-like pseudo-code:
           // acquire the lock
 *         t2 = 1;
 *       L_loop:
 *         t3 = *lock;
 *         *lock = t2;
 *         if (t3 != 0) goto L_loop;
 *
 *         // increment the counter
 *         t2 = *counter;
 *         t2 = t2 + 1;
 *         *counter = t2;
 *
 *         // release the lock
 *         *lock = 0;
 */

        .global main

main:
        /* save ra(return address) and sp(stack pointer) */
        addi    sp,sp,-16
        sd      ra,8(sp)
        sd      s0,0(sp)



        /* set addresses of the lock and the counter */
        la      t1, lock
        la      t0, counter


        /* acquire the lock */
        li      t2, 1
L_loop:
        amoswap.d t3, t2, (t1)          /* swap */
        bne       t3, x0, L_loop        /* if (t3 !=0) goto L_loop */

        /* increment the counter */
        ld      t2, (t0)                /* t2 = *counter */
        addi    t2, t2, 1               /* t2 = t2 + 1   */
        sd      t2, (t0)                /* *counter = t2 */

        /* release the lock */
        sd      x0, (t1)                /* *lock = 0     */



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
lock:
        .quad   0
counter:
        .quad   10
