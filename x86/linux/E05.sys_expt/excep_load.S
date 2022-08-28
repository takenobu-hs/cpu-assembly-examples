/*
 * Exception example for x86/Linux
 *
 *   * Page fault exception
 *
 */

        .intel_syntax noprefix
        .global main

main:
        mov     rdx, 0
        mov     rax, [rdx]              /* rdx = load(rdx) */

        ret
