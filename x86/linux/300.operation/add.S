/*
 * Operation example for x86/Linux
 *
 *   * add operation
 */

        .intel_syntax noprefix
        .global main

main:
        /* Add operation */
        mov     eax, 1
        mov     ebx, 2
        add     rax, rbx                /* rax <- rax + rbx */


        /* printf for result-checking */
        lea     rdi, [rip + fmt]        /* 1st argument for printf */
        mov     rsi, rax                /* 2nd argument for printf */
        mov     eax, 0                  /* the number of vector regsters */
        call    printf


        /* return from main */
        ret


        /* read-only data */
        .section .rodata
fmt:
        .string "rax + rbx = %x\n"
