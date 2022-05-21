/*
 * Getting time-information (counter) for x86/Linux
 *
 *   * Read time-stamp counter twice, more quickly
 */

        .intel_syntax noprefix
        .global main

main:
        /* 1st rdtsc */
        rdtsc                           /* read TSC into edx:eax */
        mov     r12, rdx                /* preserve edx */
        mov     r13, rax                /* preserve eax */

        /* 2nd rdtsc */
        rdtsc                           /* read TSC into edx:eax */
        mov     r14, rdx                /* preserve edx */
        mov     r15, rax                /* preserve eax */


        /* printf for 1st rdtsc */
        lea     rdi, [rip + fmt]        /* 1st argument for printf */
        mov     rsi, r12                /* 2nd argument for printf */
        mov     rdx, r13                /* 3rd argument for printf */
        mov     eax, 0                  /* the number of vector regsters */
        call    printf

        /* printf for 2nd rdtsc */
        lea     rdi, [rip + fmt]        /* 1st argument for printf */
        mov     rsi, r14                /* 2nd argument for printf */
        mov     rdx, r15                /* 3rd argument for printf */
        mov     eax, 0                  /* the number of vector regsters */
        call    printf


        /* return from main */
        ret


        /* read-only data */
        .section .rodata
fmt:
        .string "edx = %08x; eax = %08x\n"
