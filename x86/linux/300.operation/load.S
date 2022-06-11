/*
 * Operation example for x86/Linux
 *
 *   * load operation
 */

        .intel_syntax noprefix
        .global main

main:
        sub     rsp, 8                  /* 16-byte alignment */


        /* Load operation */
        mov     rbx, [rip + byte_array]         /* load (64 bits) */


        /* printf for result-checking */
        lea     rdi, [rip + fmt]        /* 1st argument for printf */
        mov     rsi, rbx                /* 2nd argument for printf */
        mov     eax, 0                  /* the number of vector regsters */
        call    printf


        /* return from main */
        add     rsp, 8                  /* 16-byte alignment */
        ret


        /* read-only data */
        .section .rodata
        .balign 8
fmt:
        .string "byte_array = %llx\n"           /* %llx for long long hex */

byte_array:
        .quad   0xfedcba9876543210
