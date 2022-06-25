/*
 * C standard library call example for x86/Linux
 *
 *   * printf(3) standard-library
 *   * variable argument call
 *   * see: man 3 printf
 *   * see: x86-64 ABI (https://gitlab.com/x86-psABIs/x86-64-ABI)
 */

        .intel_syntax noprefix
        .global main

main:
        sub     rsp, 8                  /* 16-byte alignment */

        mov     rcx, 100                /* test data */


        /* printf(3) library-call */
        lea     rdi, [rip + msg]        /* 1st argument */
        mov     rsi, rcx                /* 2nd argument */
        mov     eax, 0                  /* the number of vector regsters */
        call    printf


        /* return from main */
        add     rsp, 8                  /* 16-byte alignment */
        ret


        /* read-only data */
        .section .rodata
msg:
        .string "rcx = %d\n"
