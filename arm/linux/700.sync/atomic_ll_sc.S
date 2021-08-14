/*
 * Memory ordeirng example for Arm(Armv8 aarch64)/Linux
 *
 *   * see: Arm Architecture Reference Manual Armv8, for Armv8-A
 *          architecture profile,
 *          Chapter B2 The AArch64 Application Level Memory Model
 *          Appendix K11 Barrier Litmus Tests
 */

        .global main

main:
        /* load-linked - store-conditional */
        adr     x10, flag
        ldxr    x11, [x10]              /* load-linked */

        stxr    w12, x11, [x10]         /* store-conditional */


        /* return from main */
        ret


        /* read-write initialized data */
        .data
        .balign 8
flag:
        .quad   0
