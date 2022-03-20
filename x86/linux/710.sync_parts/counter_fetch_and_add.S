/*
 * An atomic counter example for x86/Linux
 *
 *   * fetch-and-add instruction
 *
 *   * C-like pseudo-code:
 *         ra = 1;
 *         *counter = *counter + ra;
 *
 */

        .intel_syntax noprefix
        .global main

main:

        /* increment the counter with fetch-and-add */
        mov       rax, 0x1                      /* rax = 1 */
        lock xadd [rip + counter], rax          /* *counter = *counter + rax */


        /* printf for result-checking */
        lea     rdi, [rip + fmt]        /* 1st argument for printf */
        mov     rsi, [rip + counter]    /* 2nd argument for printf */
        mov     rax, 0                  /* the number of vector regsters */
        call    printf


        /* return from main */
        ret


        /* read-only data */
        .section .rodata
fmt:
        .string "counter = %d\n"


        /* read-write initialized data */
        .data
        .balign 8
counter:
        .quad   10
