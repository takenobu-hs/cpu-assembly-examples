/*
 * Latency example for x86/Linux
 *
 *   * `fadd` instruction
 *
 *   * C-like pseudo-code:
 *
 *         for (i=0; i<10000000; i++) {
 *             fadd instruction
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

        movsd   xmm0, [rip + value1]    /* 1st operand for add instructions */
        movsd   xmm1, [rip + value1]    /* 2nd operand for add instructions */


        /* loop body */
L_loop:
        addsd   xmm0, xmm1              /* xmm0 = xmm0 + xmm1 */
        addsd   xmm0, xmm1
        addsd   xmm0, xmm1
        addsd   xmm0, xmm1
        addsd   xmm0, xmm1
        addsd   xmm0, xmm1
        addsd   xmm0, xmm1
        addsd   xmm0, xmm1
        addsd   xmm0, xmm1
        addsd   xmm0, xmm1

        addsd   xmm0, xmm1
        addsd   xmm0, xmm1
        addsd   xmm0, xmm1
        addsd   xmm0, xmm1
        addsd   xmm0, xmm1
        addsd   xmm0, xmm1
        addsd   xmm0, xmm1
        addsd   xmm0, xmm1
        addsd   xmm0, xmm1
        addsd   xmm0, xmm1

        addsd   xmm0, xmm1
        addsd   xmm0, xmm1
        addsd   xmm0, xmm1
        addsd   xmm0, xmm1
        addsd   xmm0, xmm1
        addsd   xmm0, xmm1
        addsd   xmm0, xmm1
        addsd   xmm0, xmm1
        addsd   xmm0, xmm1
        addsd   xmm0, xmm1

        addsd   xmm0, xmm1
        addsd   xmm0, xmm1
        addsd   xmm0, xmm1
        addsd   xmm0, xmm1
        addsd   xmm0, xmm1
        addsd   xmm0, xmm1
        addsd   xmm0, xmm1
        addsd   xmm0, xmm1
        addsd   xmm0, xmm1
        addsd   xmm0, xmm1

        addsd   xmm0, xmm1
        addsd   xmm0, xmm1
        addsd   xmm0, xmm1
        addsd   xmm0, xmm1
        addsd   xmm0, xmm1
        addsd   xmm0, xmm1
        addsd   xmm0, xmm1
        addsd   xmm0, xmm1
        addsd   xmm0, xmm1
        addsd   xmm0, xmm1

        addsd   xmm0, xmm1
        addsd   xmm0, xmm1
        addsd   xmm0, xmm1
        addsd   xmm0, xmm1
        addsd   xmm0, xmm1
        addsd   xmm0, xmm1
        addsd   xmm0, xmm1
        addsd   xmm0, xmm1
        addsd   xmm0, xmm1
        addsd   xmm0, xmm1

        addsd   xmm0, xmm1
        addsd   xmm0, xmm1
        addsd   xmm0, xmm1
        addsd   xmm0, xmm1
        addsd   xmm0, xmm1
        addsd   xmm0, xmm1
        addsd   xmm0, xmm1
        addsd   xmm0, xmm1
        addsd   xmm0, xmm1
        addsd   xmm0, xmm1

        addsd   xmm0, xmm1
        addsd   xmm0, xmm1
        addsd   xmm0, xmm1
        addsd   xmm0, xmm1
        addsd   xmm0, xmm1
        addsd   xmm0, xmm1
        addsd   xmm0, xmm1
        addsd   xmm0, xmm1
        addsd   xmm0, xmm1
        addsd   xmm0, xmm1

        addsd   xmm0, xmm1
        addsd   xmm0, xmm1
        addsd   xmm0, xmm1
        addsd   xmm0, xmm1
        addsd   xmm0, xmm1
        addsd   xmm0, xmm1
        addsd   xmm0, xmm1
        addsd   xmm0, xmm1
        addsd   xmm0, xmm1
        addsd   xmm0, xmm1

        addsd   xmm0, xmm1
        addsd   xmm0, xmm1
        addsd   xmm0, xmm1
        addsd   xmm0, xmm1
        addsd   xmm0, xmm1
        addsd   xmm0, xmm1
        addsd   xmm0, xmm1
        addsd   xmm0, xmm1
        addsd   xmm0, xmm1
        addsd   xmm0, xmm1


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
value1:
        .double 1.0

fmt:
        .string "loop-variable = %d\n"
