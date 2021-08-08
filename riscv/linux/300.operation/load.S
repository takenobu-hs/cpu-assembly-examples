/*
 * Operation example for RISC-V(RV64)/Linux
 *
 *   * load operation
 */

        .global main

main:
        /* save ra(return address) and sp(stack pointer) */
        addi    sp,sp,-16
        sd      ra,8(sp)
        sd      s0,0(sp)


        /* Load operation */
        la      t0, byte_array
        ld      t1, (t0)                        /* load (64 bits) */


        /* printf for result-checking */
        la      a0, fmt                 /* 1st argument for printf*/
        mv      a1, t1                  /* 2nd argument for printf*/
        jal     printf    


        /* restore ra(return address) and sp(stack pointer) */
        ld      ra,8(sp)
        ld      s0,0(sp)
        addi    sp,sp,16

        /* return from main */
        ret


        /* read-only data */
        .section .rodata
        .balign 8
fmt:
        .string "byte_array = %llx\n"           /* %llx for long long hex */

byte_array:
        .quad   0xfedcba9876543210