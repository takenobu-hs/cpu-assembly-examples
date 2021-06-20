/*
 * Getting time-information (counter) for x86/Linux
 *
 *   * Read time-stamp counter twice, more quickly
 */

.intel_syntax noprefix

.global main

main:
        /* 1st rdtsc */
        rdtsc                           /* read time-stamp counter */
        mov     r12, rdx
        mov     r13, rax

        /* 2nd rdtsc */
        rdtsc                           /* read time-stamp counter */
        mov     r14, rdx
        mov     r15, rax


        /* 1st rdtsc */
        mov     rsi, r12
        mov     rdx, r13

        lea     rdi, [rip + fmt]        /* 1st argument for printf */
        mov     rax, 0                  /* the number of vector regsters */
        call    printf

        /* 2nd rdtsc */
        mov     rsi, r14
        mov     rdx, r15

        lea     rdi, [rip + fmt]        /* 1st argument for printf */
        mov     rax, 0                  /* the number of vector regsters */
        call    printf


        /* exit */
        ret

fmt:    .string "edx = %08x; eax = %08x\n"
