/*
 * Atomic operation example for x86/Linux
 *
 *   * atomic operations.
 *     * swap (xchg)
 *     * compare and swap (cmpxchg)
 *     * fetch and add (xadd)
 *
 *   * see: Intel 64 and IA-32 Architectures Software Developer’s Manual
 *          Volume 3: System Programming Guide:
 *          8.2 MEMORY ORDERING
 */

        .intel_syntax noprefix
        .global main

main:
        /* atomic operations */
        xchg    [rip + flag], rax       /* swap */

        lock cmpxchg [rip + flag], rax  /* compare and swap */

        lock xadd    [rip + flag], rax  /* fetch and add */


        /* return from main */
        ret


        /* read-write initialized data */
        .data
        .balign 8
flag:
        .quad   0
