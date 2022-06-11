/*
 * Getting time-information (counter) for x86/Linux
 *
 *   * Read time-stamp counter twice
 */

        .intel_syntax noprefix
        .global main

main:
        sub     rsp, 8                  /* 16-byte alignment */


        /* 1st rdtsc */
        rdtsc                           /* read TSC into edx:eax */

        /* 1st printf */
        lea     rdi, [rip + fmt]        /* 1st argument for printf */
        mov     esi, edx                /* 2nd argument for printf */
        mov     edx, eax                /* 3rd argument for printf */
        mov     eax, 0                  /* the number of vector regsters */
        call    printf


        /* 2nd rdtsc */
        rdtsc                           /* read TSC into edx:eax */

        /* 2nd printf */
        lea     rdi, [rip + fmt]        /* 1st argument for printf */
        mov     esi, edx                /* 2nd argument for printf */
        mov     edx, eax                /* 3rd argument for printf */
        mov     eax, 0                  /* the number of vector regsters */
        call    printf


        /* return from main */
        add     rsp, 8                  /* 16-byte alignment */
        ret


        /* read-only data */
        .section .rodata
fmt:
        .string "edx = %08x; eax = %08x\n"
