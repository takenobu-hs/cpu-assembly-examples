/*
 * Operation example for RISC-V(RV64)/Linux
 *
 *   * load operation
 */

        .global main

main:
        /* save ra(return address) */
        addi    sp,sp,-8
        sd      ra,(sp)


        /* Load operation */
        la      t0, byte_array
        ld      t1, (t0)                        /* load (64 bits) */


        /* printf for result-checking */
        la      a0, fmt                 /* 1st argument for printf*/
        mv      a1, t1                  /* 2nd argument for printf*/
        jal     printf    


        /* restore ra(return address) */
        ld      ra,(sp)
        addi    sp,sp,8

        /* return from main */
        ret


        /* read-only data */
        .section .rodata
        .balign 8
fmt:
        .string "byte_array = %llx\n"           /* %llx for long long hex */

byte_array:
        .quad   0xfedcba9876543210
