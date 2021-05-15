/*
 * read time-stamp counter with rdtsc instruction
 *
 */

.intel_syntax noprefix

.global main

main:
        rdtsc                           /* read time-stamp counter */
        mov     esi, edx
        mov     edx, eax

        lea     rdi, [rip + fmt]        /* 1st argument for printf */
        mov     rax, 0                  /* the number of vector regsters */
        call    printf

        ret
 
fmt:    .string "edx = %08x; eax = %08x\n"
