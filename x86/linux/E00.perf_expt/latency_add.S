/*
 * Latency example for x86/Linux
 *
 *   * `add` instruction
 *
 *   * C-like pseudo-code:
 *
 *         for (i=0; i<10000000; i++) {
 *             add instruction
 *                   :                  // 100 times
 *         }
 *
 */

        .intel_syntax noprefix
        .global main

main:
        sub     rsp, 8                  /* 16-byte alignment */


        /* loop conditions */
        mov     ecx, 0                  /* loop variable   */
        mov     rbx, 10000000           /* loop max-number */

        mov     rax, 1                  /* 1st operand for add instructions */
        mov     rdx, 1                  /* 2nd operand for add instructions */


        /* loop body */
L_loop:
        add     rax, rdx                /* rax = rax + rdx */
        add     rax, rdx
        add     rax, rdx
        add     rax, rdx
        add     rax, rdx
        add     rax, rdx
        add     rax, rdx
        add     rax, rdx
        add     rax, rdx
        add     rax, rdx

        add     rax, rdx
        add     rax, rdx
        add     rax, rdx
        add     rax, rdx
        add     rax, rdx
        add     rax, rdx
        add     rax, rdx
        add     rax, rdx
        add     rax, rdx
        add     rax, rdx

        add     rax, rdx
        add     rax, rdx
        add     rax, rdx
        add     rax, rdx
        add     rax, rdx
        add     rax, rdx
        add     rax, rdx
        add     rax, rdx
        add     rax, rdx
        add     rax, rdx

        add     rax, rdx
        add     rax, rdx
        add     rax, rdx
        add     rax, rdx
        add     rax, rdx
        add     rax, rdx
        add     rax, rdx
        add     rax, rdx
        add     rax, rdx
        add     rax, rdx

        add     rax, rdx
        add     rax, rdx
        add     rax, rdx
        add     rax, rdx
        add     rax, rdx
        add     rax, rdx
        add     rax, rdx
        add     rax, rdx
        add     rax, rdx
        add     rax, rdx

        add     rax, rdx
        add     rax, rdx
        add     rax, rdx
        add     rax, rdx
        add     rax, rdx
        add     rax, rdx
        add     rax, rdx
        add     rax, rdx
        add     rax, rdx
        add     rax, rdx

        add     rax, rdx
        add     rax, rdx
        add     rax, rdx
        add     rax, rdx
        add     rax, rdx
        add     rax, rdx
        add     rax, rdx
        add     rax, rdx
        add     rax, rdx
        add     rax, rdx

        add     rax, rdx
        add     rax, rdx
        add     rax, rdx
        add     rax, rdx
        add     rax, rdx
        add     rax, rdx
        add     rax, rdx
        add     rax, rdx
        add     rax, rdx
        add     rax, rdx

        add     rax, rdx
        add     rax, rdx
        add     rax, rdx
        add     rax, rdx
        add     rax, rdx
        add     rax, rdx
        add     rax, rdx
        add     rax, rdx
        add     rax, rdx
        add     rax, rdx

        add     rax, rdx
        add     rax, rdx
        add     rax, rdx
        add     rax, rdx
        add     rax, rdx
        add     rax, rdx
        add     rax, rdx
        add     rax, rdx
        add     rax, rdx
        add     rax, rdx

        /* increment the loop-variable and loop-back */
        add     rcx, 1
        cmp     rcx, rbx
        jl      L_loop


        /* print the last loop-variable */
        lea     rdi, [rip + fmt]        /* 1st argument for printf */
        mov     rsi, rcx                /* 2nd argument */
        mov     eax, 0                  /* the number of vector regsters */
        call    printf


        /* return from main */
        add     rsp, 8                  /* 16-byte alignment */
        ret


        /* read-only data */
        .section .rodata
fmt:
        .string "loop-variable = %d\n"
