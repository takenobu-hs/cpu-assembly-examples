/*
 * Control-flow example for x86/Linux
 *
 *   * `if`-structure example
 *
 *   * C-like pseudo-code:
 *       if (rax >= 0) {
 *           rbx = 1
 *       } else {
 *           rbx = -1
 *       }
 */

        .intel_syntax noprefix
        .global main

main:
        sub     rsp, 8                  /* 16-byte alignment */


        /* test data */
        mov     eax, 10                 /* Change here */


        /* if (rax >= 0) */
        cmp     eax, 0
        js      L_else

        /* then */
        mov     ebx, 1
        jmp     L_endif

        /* else */
L_else:
        mov     rbx, -1

        /* endif */
L_endif:


        /* printf for result-checking */
        lea     rdi, [rip + fmt]        /* 1st argument for printf */
        mov     rsi, rax                /* 2nd argument */
        mov     rdx, rbx                /* 3rd argument */
        mov     eax, 0                  /* the number of vector regsters */
        call    printf


        /* return from main */
        add     rsp, 8                  /* 16-byte alignment */
        ret


        /* read-only data */
        .section .rodata
fmt:
        .string "rax, rbx = %d, %d\n"
