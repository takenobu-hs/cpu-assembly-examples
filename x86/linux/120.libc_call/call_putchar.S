/*
 * C standard library call example for x86/Linux
 *
 *   * putchar(3) standard-library
 *   * see: man 3 putchar
 *   * see: x86-64 ABI (https://gitlab.com/x86-psABIs/x86-64-ABI)
 */

        .intel_syntax noprefix
        .global main

main:
        /* putchar(3) library-call */
        mov     edi, 0x41               /* 'A' */
        call    putchar

        mov     edi, 0x42               /* 'B' */
        call    putchar

        mov     edi, 'C'
        call    putchar

        mov     edi, '\n'
        call    putchar


        /* return from main */
        ret
