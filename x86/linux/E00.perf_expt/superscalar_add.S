/*
 * Superscalar-issue example for x86/Linux
 *
 *   * `add` instructions without true-data-dependencies
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

        mov     rdx, 0                  /* 2nd operand for add instructions */


        /* loop body */
L_loop:
        add     rdi, rdx                /* rdi = rdi + rdx */
        add     rsi, rdx                /* NO true data dependency */
        add     r8,  rdx                /* NO true data dependency */
        add     r9,  rdx                /* NO true data dependency */
        add     r10, rdx                /* NO true data dependency */
        add     r11, rdx                /* NO true data dependency */
        add     r12, rdx                /* NO true data dependency */
        add     r13, rdx                /* NO true data dependency */
        add     r14, rdx                /* NO true data dependency */
        add     r15, rdx                /* NO true data dependency */

        add     rdi, rdx
        add     rsi, rdx
        add     r8,  rdx
        add     r9,  rdx
        add     r10, rdx
        add     r11, rdx
        add     r12, rdx
        add     r13, rdx
        add     r14, rdx
        add     r15, rdx

        add     rdi, rdx
        add     rsi, rdx
        add     r8,  rdx
        add     r9,  rdx
        add     r10, rdx
        add     r11, rdx
        add     r12, rdx
        add     r13, rdx
        add     r14, rdx
        add     r15, rdx

        add     rdi, rdx
        add     rsi, rdx
        add     r8,  rdx
        add     r9,  rdx
        add     r10, rdx
        add     r11, rdx
        add     r12, rdx
        add     r13, rdx
        add     r14, rdx
        add     r15, rdx

        add     rdi, rdx
        add     rsi, rdx
        add     r8,  rdx
        add     r9,  rdx
        add     r10, rdx
        add     r11, rdx
        add     r12, rdx
        add     r13, rdx
        add     r14, rdx
        add     r15, rdx

        add     rdi, rdx
        add     rsi, rdx
        add     r8,  rdx
        add     r9,  rdx
        add     r10, rdx
        add     r11, rdx
        add     r12, rdx
        add     r13, rdx
        add     r14, rdx
        add     r15, rdx

        add     rdi, rdx
        add     rsi, rdx
        add     r8,  rdx
        add     r9,  rdx
        add     r10, rdx
        add     r11, rdx
        add     r12, rdx
        add     r13, rdx
        add     r14, rdx
        add     r15, rdx

        add     rdi, rdx
        add     rsi, rdx
        add     r8,  rdx
        add     r9,  rdx
        add     r10, rdx
        add     r11, rdx
        add     r12, rdx
        add     r13, rdx
        add     r14, rdx
        add     r15, rdx

        add     rdi, rdx
        add     rsi, rdx
        add     r8,  rdx
        add     r9,  rdx
        add     r10, rdx
        add     r11, rdx
        add     r12, rdx
        add     r13, rdx
        add     r14, rdx
        add     r15, rdx

        add     rdi, rdx
        add     rsi, rdx
        add     r8,  rdx
        add     r9,  rdx
        add     r10, rdx
        add     r11, rdx
        add     r12, rdx
        add     r13, rdx
        add     r14, rdx
        add     r15, rdx

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
