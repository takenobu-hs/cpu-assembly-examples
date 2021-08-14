/*
 * Atomic operation example for Arm(Armv8 aarch64)/Linux
 *
 *   * atomic operations with weak consistency (without release/acquire).
 *     * swap (swp)
 *     * compare and swap (cas)
 *     * fetch and add (ldadd)
 *
 *   * see: Arm Architecture Reference Manual Armv8, for Armv8-A
 *          architecture profile,
 *          Chapter B2 The AArch64 Application Level Memory Model
 *          Appendix K11 Barrier Litmus Tests
 */

        .global main

main:
        /* atomic operations */
        adr     x10, flag
        swp     x11, x12, [x10]         /* swap */

        cas     x11, x12, [x10]         /* compare and swap */

        ldadd   x11, x12, [x10]         /* fetch and add */


        /* return from main */
        ret


        /* read-write initialized data */
        .data
        .balign 8
flag:
        .quad   0
