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
        sub     rsp, 8                  /* 16-byte alignment */


        /* atomic operations */
        xchg    [rip + flag], rax       /* swap */

        lock cmpxchg [rip + flag], rbx  /* compare and swap */

        lock xadd    [rip + flag], rax  /* fetch and add */


        /* return from main */
        add     rsp, 8                  /* 16-byte alignment */
        ret


        /* read-write initialized data */
        .data
        .balign 8
flag:
        .quad   0
