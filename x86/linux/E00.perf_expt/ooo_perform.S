/*
 * Out-of-order execution example for x86/Linux
 *
 *   * Reordering with a pending instruction
 *
 *   * C-like pseudo-code:
 *
 *         for (i=0; i<10000000; i++) {
 *             rdx = load(rdx);
 *             rdx = rdx + r10;         // pendinig the load instruction
 *             r12 = r12 + r10;         // OUT-OF-ORDER execution
 *             r12 = r12 + r10;
 *             r12 = r12 + r10;
 *
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

        lea     rdx, [rip + buf]        /* address for load instructions  */
        mov     [rdx], rdx              /* pre-store the address for load */

        mov     r10, 0


        /* loop body */
L_loop:
        mov     rdx, [rdx]              /* rdx = load(rdx) */
        add     rdx, r10                /* true data dependency with rdx */
        add     r12, r10                /* NO true data dpendency with rdx */
        add     r12, r10                /* NO true data dpendency with rdx */
        add     r12, r10                /* NO true data dpendency with rdx */

        mov     rdx, [rdx]
        add     rdx, r10
        add     r12, r10
        add     r12, r10
        add     r12, r10

        mov     rdx, [rdx]
        add     rdx, r10
        add     r12, r10
        add     r12, r10
        add     r12, r10

        mov     rdx, [rdx]
        add     rdx, r10
        add     r12, r10
        add     r12, r10
        add     r12, r10

        mov     rdx, [rdx]
        add     rdx, r10
        add     r12, r10
        add     r12, r10
        add     r12, r10

        mov     rdx, [rdx]
        add     rdx, r10
        add     r12, r10
        add     r12, r10
        add     r12, r10

        mov     rdx, [rdx]
        add     rdx, r10
        add     r12, r10
        add     r12, r10
        add     r12, r10

        mov     rdx, [rdx]
        add     rdx, r10
        add     r12, r10
        add     r12, r10
        add     r12, r10

        mov     rdx, [rdx]
        add     rdx, r10
        add     r12, r10
        add     r12, r10
        add     r12, r10

        mov     rdx, [rdx]
        add     rdx, r10
        add     r12, r10
        add     r12, r10
        add     r12, r10

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


        /* read-write data */
        .data
buf:
        .quad   0
