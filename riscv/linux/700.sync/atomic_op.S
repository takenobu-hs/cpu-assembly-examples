/*
 * Memory ordeirng example for RISC-V(RV64)/Linux
 *
 *   * see: The RISC-V Instruction Set Manual Volume I: Unprivileged ISA
 *          Appendix A RVWMO Explanatory Material
 */

        .global main

main:
        /* atomic operations */
        la        t0, flag
        amoswap.d t1, t2, (t0)          /* swap */

        amoadd.d  t1, t2, (t0)          /* fetch and add */


        /* return from main */
        ret


        /* read-write initialized data */
        .data
        .balign 8
flag:
        .quad   0
