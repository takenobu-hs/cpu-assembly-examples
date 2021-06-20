/*
 * C standard library call example for x86/Linux
 *
 *   * putchar(3) standard-library
 *   * see: x86-64 ABI (https://gitlab.com/x86-psABIs/x86-64-ABI)
 */

.intel_syntax noprefix

.global main

main:
        mov     rdi, 0x41               /* 'A' */
        call    putchar

        mov     rdi, 0x42               /* 'B' */
        call    putchar

        mov     rdi, 'C'
        call    putchar

        mov     rdi, '\n'
        call    putchar

        ret
