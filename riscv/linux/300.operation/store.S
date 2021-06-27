/*
 * Operation example for RISV-V(RV64)/Linux
 *
 *   * store operation
 */

        .global main

main:
        /* save ra(return address) and sp(stack pointer) */
        addi    sp,sp,-16
        sd      ra,8(sp)
        sd      s0,0(sp)


        /* Store operation */
        la      t0, memory_buf
        li      t1, 0xfedcba9876543210
        sd      t1, (t0)                        /* store (64 bits) */


        /* Load operation for result-checking*/
        ld      t2, (t0)                        /* load (64 bits) */

        /* printf for result-checking */
        la      a0, fmt                 /* 1st argument for printf*/
        mv      a1, t2                  /* 2nd argument for printf*/
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
        .string "memory_buf = %016llx\n"        /* %llx for long long hex */


        /* read-write initialized data */
        .data
        .balign 8
memory_buf:
        .quad   0
