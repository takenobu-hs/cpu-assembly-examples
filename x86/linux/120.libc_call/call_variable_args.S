/*
 * C standard library call example for x86/Linux
 *
 *   * printf(3) standard-library
 *   * variable argument call
 *   * see: x86-64 ABI (https://gitlab.com/x86-psABIs/x86-64-ABI)
 */

.intel_syntax noprefix

.global main

main:
        lea     rdi, [rip + msg]        /* 1st argument */
        mov     rax, 0                  /* the number of vector regsters */

        call    printf

        ret

msg:    .string "Hello world!\n"
