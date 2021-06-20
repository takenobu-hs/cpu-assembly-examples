/*
 * Getting time-information (counter) for x86/Linux
 *
 *   * Read time-stamp counter twice
 */

.intel_syntax noprefix

.global main

main:
        /* 1st rdtsc */
        rdtsc                           /* read time-stamp counter */
        mov     esi, edx
        mov     edx, eax

        lea     rdi, [rip + fmt]        /* 1st argument for printf */
        mov     rax, 0                  /* the number of vector regsters */
        call    printf


        /* 2nd rdtsc */
        rdtsc                           /* read time-stamp counter */
        mov     esi, edx
        mov     edx, eax

        lea     rdi, [rip + fmt]        /* 1st argument for printf */
        mov     rax, 0                  /* the number of vector regsters */
        call    printf


        /* exit */
        ret

fmt:    .string "edx = %08x; eax = %08x\n"
