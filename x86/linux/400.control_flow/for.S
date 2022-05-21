/*
 * Control-flow example for x86/Linux
 *
 *   * `for`-structure example
 *
 *   * C-like pseudo-code:
 *       rbx = 0;
 *       for (rax = 1; rax <= 10; rax++) {
 *           rbx = rbx + rax;
 *       }
 */

        .intel_syntax noprefix
        .global main

main:
        /* accumulator for test */
        mov     ebx, 0                  /* rbx = 0 */


        /* `for`-structure */
        mov     eax, 1                  /* rax = 1 */

L_loop:
        add     rbx, rax                /* loop-body (rbx = rbx + rax) */

        add     eax, 1                  /* rax++ */
        cmp     eax, 10                 /* rax <= 10 */
        jle     L_loop


        /* printf for result-checking */
        lea     rdi, [rip + fmt]        /* 1st argument for printf */
        mov     rsi, rbx                /* 2nd argument */
        mov     eax, 0                  /* the number of vector regsters */
        call    printf


        /* return from main */
        ret


        /* read-only data */
        .section .rodata
fmt:
        .string "rbx = %d\n"
