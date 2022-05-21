/*
 * Operation example for x86/Linux
 *
 *   * store operation
 */

        .intel_syntax noprefix
        .global main

main:
        /* Store operation */
        mov     rax, 0xfedcba9876543210
        mov     [rip + memory_buf], rax         /* store (64 bits) */


        /* Load operation for result-checking*/
        mov     rbx, [rip + memory_buf]         /* load (64 bits) */

        /* printf for result-checking */
        lea     rdi, [rip + fmt]        /* 1st argument for printf */
        mov     rsi, rbx                /* 2nd argument for printf */
        mov     eax, 0                  /* the number of vector regsters */
        call    printf


        /* return from main */
        ret


        /* read-only data */
        .section .rodata
fmt:
        .string "memory_buf = %016llx\n"        /* %llx for long long hex */


        /* read-write initialized data */
        .data
        .balign 8
memory_buf:
        .quad   0
