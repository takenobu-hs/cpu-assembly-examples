/*
 * Operation example for RISC-V(RV64)/Linux
 *
 *   * load operations for each size with zero extension
 *
 *   * 64-bit load with ld instruction
 *   * 32-bit load with lw instruction
 *   * 16-bit load with lh instruction
 *   * 8-bit  load with lb instruction
 */

        .global main

main:
        /* save ra(return address) */
        addi    sp,sp,-8
        sd      ra,(sp)


        /* Load operation */
        la      t0, byte_array
        ld      t1, (t0)                        /* load (64 bits) */
        lw      t2, (t0)                        /* load (32 bits) */
        lh      t3, (t0)                        /* load (16 bits) */
        lb      t4, (t0)                        /* load (8 bits) */


        /* printf for result-checking */
        la      a0, fmt                 /* 1st argument for printf */
        mv      a1, t1                  /* 2nd argument */
        mv      a2, t2                  /* 3rd argument */
        mv      a3, t3                  /* 4th argument */
        mv      a4, t4                  /* 5th argument */
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
        .string "t1, t2, t3, t4 = \n%016llx\n%016llx\n%016llx\n%016llx\n"

byte_array:
        .quad   0xfedcba9876543210
