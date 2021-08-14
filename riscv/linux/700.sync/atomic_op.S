/*
 * Atomic operation example for RISC-V(RV64)/Linux
 *
 *   * atomic operations with weak consistency (without release/acquire).
 *     * swap (amoswap)
 *     * fetch and add (amoadd)
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
