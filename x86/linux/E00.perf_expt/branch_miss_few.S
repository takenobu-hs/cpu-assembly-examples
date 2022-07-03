/*
 * Branch prediction example for x86/Linux
 *
 *   * Branch conditions are always true.
 *   * FEW branch mispredictions occur.
 *
 *   * C-like pseudo-code:
 *
 *         for (i=0; i<10000000; i++) {
 *
 *             x = xorshift();                // generate a random number
 *
 *             if (x == x) goto L_br;         // branch-prediction test
 *             nop;
 *         L_br:
 *
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

        mov     rax, [rip + random]     /* initial number of xorshift(xor64) */

L_loop:
        /* generate a random number with the xorshift algorithm */
        mov     rdx, rax                /* x = x ^ (x << 13) */
        sal     rax, 13
        xor     rax, rdx

        mov     rdx, rax                /* x = x ^ (x >> 7) */
        sar     rax, 7
        xor     rax, rdx

        mov     rdx, rax                /* x = x ^ (x << 17) */
        sal     rax, 17
        xor     rax, rdx


        /* branch-prediction test */
        mov     r10, rax
        cmp     r10, r10                /* zero(eq) flag is always true   */
        jz      L_br                    /* branch-prediction test */
        nop
L_br:

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
random:
        .quad   88172645463325252       /* xorshift(xor64)'s initial value */

fmt:
        .string "loop-variable = %d\n"
