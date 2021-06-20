/*
 * C standard library call example for x86/Linux
 *
 *   * puts(3) standard-library
 *   * see: x86-64 ABI (https://gitlab.com/x86-psABIs/x86-64-ABI)
 */

.intel_syntax noprefix

.global main

main:
        lea     rdi, [rip + msg]        /* 1st argument */
        call    puts

        ret


msg:    .string "Hello world!\n"
