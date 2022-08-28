/*
 * Exception example for x86/Linux
 *
 *   * Divide error exception
 *
 */

        .intel_syntax noprefix
        .global main

main:
        mov     rbx, 0
        div     rbx                     /* rdx:rax / rbx */

        ret
