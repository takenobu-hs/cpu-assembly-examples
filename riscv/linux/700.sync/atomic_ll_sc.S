/*
 * Atomic operation example for RISC-V(RV64)/Linux
 *
 *   * atomic operations with load-linked / store-conditional.
 *     operations with weak consistency (without release/acquire).
 *
 *   * see: The RISC-V Instruction Set Manual Volume I: Unprivileged ISA
 *          Appendix A RVWMO Explanatory Material
 */

        .global main

main:
        /* load-linked (load-reserved) - store-conditional */
        la      t0, flag
        lr.d    t1, (t0)                /* load-linked (load-reserved) */

        sc.d    t2, t1, (t0)            /* store-conditional */


        /* return from main */
        ret


        /* read-write initialized data */
        .data
        .balign 8
flag:
        .quad   0
