/*
 * Operation example for x86/Linux
 *
 *   * load operation
 */

        .intel_syntax noprefix
        .global main

main:
        /* Load operation */
        mov     rbx, [rip + byte_array]         /* load (64 bits) */


        /* printf for result-checking */
        lea     rdi, [rip + fmt]        /* 1st argument for printf */
        mov     rsi, rbx                /* 2nd argument for printf */
        mov     rax, 0                  /* the number of vector regsters */
        call    printf


        /* return from main */
        ret


        /* read-only data */
        .section .rodata
        .balign 8
fmt:
        .string "byte_array = %llx\n"           /* %llx for long long hex */

byte_array:
        .quad   0xfedcba9876543210
