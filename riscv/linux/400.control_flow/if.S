/*
 * Control-flow example for RISC-V(RV64)/Linux
 *
 *   * `if`-structure example
 *
 *   * C-like pseudo-code:
 *       if (t1 >= 0) {
 *           t2 = 1
 *       } else {
 *           t2 = -1
 *       }
 */

        .global main

main:
        /* save ra(return address) */
        addi    sp,sp,-8
        sd      ra,(sp)


        /* test data */
        li      t1, 10                  /* Change here */


        /* if (t1 >= 0) */
        bltz    t1, L_else

        /* then */
        li      t2, 1
        j       L_endif

        /* else */
L_else:
        li      t2, -1

        /* endif */
L_endif:


        /* printf for result-checking */
        la      a0, fmt                 /* 1st argument for printf */
        mv      a1, t1                  /* 2nd argument */
        mv      a2, t2                  /* 3rd argument */
        jal     printf    


        /* restore ra(return address) */
        ld      ra,(sp)
        addi    sp,sp,8

        /* return from main */
        ret


        /* read-only data */
        .section .rodata
fmt:
        .string "t1, t2 = %d, %d\n"
