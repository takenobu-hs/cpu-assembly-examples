/*
 * Latency example for x86/Linux
 *
 *   * `load(mov)` instruction
 *
 */

        .intel_syntax noprefix
        .global main

main:
        sub     rsp, 8                  /* 16-byte alignment */


        /* loop */
        mov     ecx, 0                  /* loop variable   */
        mov     rbx, 10000000           /* loop max-number */

        lea     rdx, [rip + buf]

L_loop:
        // 10-times
        mov     rax, [rdx]
        add     rdx, rax                /* for sequencial issue */

        mov     rax, [rdx]
        add     rdx, rax

        mov     rax, [rdx]
        add     rdx, rax

        mov     rax, [rdx]
        add     rdx, rax

        mov     rax, [rdx]
        add     rdx, rax

        mov     rax, [rdx]
        add     rdx, rax

        mov     rax, [rdx]
        add     rdx, rax

        mov     rax, [rdx]
        add     rdx, rax

        mov     rax, [rdx]
        add     rdx, rax

        mov     rax, [rdx]
        add     rdx, rax


        // 10-times
        mov     rax, [rdx]
        add     rdx, rax

        mov     rax, [rdx]
        add     rdx, rax

        mov     rax, [rdx]
        add     rdx, rax

        mov     rax, [rdx]
        add     rdx, rax

        mov     rax, [rdx]
        add     rdx, rax

        mov     rax, [rdx]
        add     rdx, rax

        mov     rax, [rdx]
        add     rdx, rax

        mov     rax, [rdx]
        add     rdx, rax

        mov     rax, [rdx]
        add     rdx, rax

        mov     rax, [rdx]
        add     rdx, rax


        // 10-times
        mov     rax, [rdx]
        add     rdx, rax

        mov     rax, [rdx]
        add     rdx, rax

        mov     rax, [rdx]
        add     rdx, rax

        mov     rax, [rdx]
        add     rdx, rax

        mov     rax, [rdx]
        add     rdx, rax

        mov     rax, [rdx]
        add     rdx, rax

        mov     rax, [rdx]
        add     rdx, rax

        mov     rax, [rdx]
        add     rdx, rax

        mov     rax, [rdx]
        add     rdx, rax

        mov     rax, [rdx]
        add     rdx, rax


        // 10-times
        mov     rax, [rdx]
        add     rdx, rax

        mov     rax, [rdx]
        add     rdx, rax

        mov     rax, [rdx]
        add     rdx, rax

        mov     rax, [rdx]
        add     rdx, rax

        mov     rax, [rdx]
        add     rdx, rax

        mov     rax, [rdx]
        add     rdx, rax

        mov     rax, [rdx]
        add     rdx, rax

        mov     rax, [rdx]
        add     rdx, rax

        mov     rax, [rdx]
        add     rdx, rax

        mov     rax, [rdx]
        add     rdx, rax


        // 10-times
        mov     rax, [rdx]
        add     rdx, rax

        mov     rax, [rdx]
        add     rdx, rax

        mov     rax, [rdx]
        add     rdx, rax

        mov     rax, [rdx]
        add     rdx, rax

        mov     rax, [rdx]
        add     rdx, rax

        mov     rax, [rdx]
        add     rdx, rax

        mov     rax, [rdx]
        add     rdx, rax

        mov     rax, [rdx]
        add     rdx, rax

        mov     rax, [rdx]
        add     rdx, rax

        mov     rax, [rdx]
        add     rdx, rax


        // 10-times
        mov     rax, [rdx]
        add     rdx, rax

        mov     rax, [rdx]
        add     rdx, rax

        mov     rax, [rdx]
        add     rdx, rax

        mov     rax, [rdx]
        add     rdx, rax

        mov     rax, [rdx]
        add     rdx, rax

        mov     rax, [rdx]
        add     rdx, rax

        mov     rax, [rdx]
        add     rdx, rax

        mov     rax, [rdx]
        add     rdx, rax

        mov     rax, [rdx]
        add     rdx, rax

        mov     rax, [rdx]
        add     rdx, rax


        // 10-times
        mov     rax, [rdx]
        add     rdx, rax

        mov     rax, [rdx]
        add     rdx, rax

        mov     rax, [rdx]
        add     rdx, rax

        mov     rax, [rdx]
        add     rdx, rax

        mov     rax, [rdx]
        add     rdx, rax

        mov     rax, [rdx]
        add     rdx, rax

        mov     rax, [rdx]
        add     rdx, rax

        mov     rax, [rdx]
        add     rdx, rax

        mov     rax, [rdx]
        add     rdx, rax

        mov     rax, [rdx]
        add     rdx, rax


        // 10-times
        mov     rax, [rdx]
        add     rdx, rax

        mov     rax, [rdx]
        add     rdx, rax

        mov     rax, [rdx]
        add     rdx, rax

        mov     rax, [rdx]
        add     rdx, rax

        mov     rax, [rdx]
        add     rdx, rax

        mov     rax, [rdx]
        add     rdx, rax

        mov     rax, [rdx]
        add     rdx, rax

        mov     rax, [rdx]
        add     rdx, rax

        mov     rax, [rdx]
        add     rdx, rax

        mov     rax, [rdx]
        add     rdx, rax


        // 10-times
        mov     rax, [rdx]
        add     rdx, rax

        mov     rax, [rdx]
        add     rdx, rax

        mov     rax, [rdx]
        add     rdx, rax

        mov     rax, [rdx]
        add     rdx, rax

        mov     rax, [rdx]
        add     rdx, rax

        mov     rax, [rdx]
        add     rdx, rax

        mov     rax, [rdx]
        add     rdx, rax

        mov     rax, [rdx]
        add     rdx, rax

        mov     rax, [rdx]
        add     rdx, rax

        mov     rax, [rdx]
        add     rdx, rax


        // 10-times
        mov     rax, [rdx]
        add     rdx, rax

        mov     rax, [rdx]
        add     rdx, rax

        mov     rax, [rdx]
        add     rdx, rax

        mov     rax, [rdx]
        add     rdx, rax

        mov     rax, [rdx]
        add     rdx, rax

        mov     rax, [rdx]
        add     rdx, rax

        mov     rax, [rdx]
        add     rdx, rax

        mov     rax, [rdx]
        add     rdx, rax

        mov     rax, [rdx]
        add     rdx, rax

        mov     rax, [rdx]
        add     rdx, rax


        add     rcx, 1                  /* increment the loop-variable */
        cmp     rcx, rbx
        jl      L_loop


        /* printf for result-checking */
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
