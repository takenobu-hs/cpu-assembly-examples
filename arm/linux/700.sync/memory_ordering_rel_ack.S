/*
 * Memory ordeirng example for Arm(Armv8 aarch64)/Linux
 *
 *   * memory ordering operations with release/aquire consistency.
 *
 *   * see: Arm Architecture Reference Manual Armv8, for Armv8-A
 *          architecture profile,
 *          Chapter B2 The AArch64 Application Level Memory Model
 *          Appendix K11 Barrier Litmus Tests
 */

        .global main

main:
        /* release - acquire */
        adr     x10, flag
        stlr    x0, [x10]               /* release */


        ldar    x0, [x10]               /* aqcuire */


        /* return from main */
        ret


        /* read-write initialized data */
        .data
        .balign 8
flag:
        .quad   0
