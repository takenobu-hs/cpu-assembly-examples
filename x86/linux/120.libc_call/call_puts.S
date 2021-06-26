/*
 * C standard library call example for x86/Linux
 *
 *   * puts(3) standard-library
 *   * see: man 3 puts
 *   * see: x86-64 ABI (https://gitlab.com/x86-psABIs/x86-64-ABI)
 */

        .intel_syntax noprefix
        .global main

main:
        /* puts(3) library-call */
        lea     rdi, [rip + msg]        /* 1st argument */
        call    puts


        /* return from main */
        ret


        /* read-only data */
        .section .rodata
msg:
        .string "Hello world!"
