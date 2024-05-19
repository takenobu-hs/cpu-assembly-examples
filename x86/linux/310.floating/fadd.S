/*
 * Floating-point example for x86/Linux
 *
 *   * Double-precision (64-bit)
 *   * Floating-point add operation
 */

        .intel_syntax noprefix
        .global main

main:
        sub     rsp, 8                  /* 16-byte alignment */


        /* Floating-point add operation */
        movsd   xmm0, [rip + value1]    /* xmm0 <- 1.0         */
        movsd   xmm1, [rip + value2]    /* xmm0 <- 2.0         */
        addsd   xmm0, xmm1              /* xmm0 <- xmm0 + xmm1 */


        /* printf for result-checking */
        lea     rdi, [rip + fmt]        /* 1st argument for printf */
//      mov     xmm0, xmm0              /* 2nd argument for printf */
        mov     eax, 1                  /* the number of vector regsters */
        call    printf


        /* return from main */
        add     rsp, 8                  /* 16-byte alignment */
        ret


        /* read-only data */
        .section .rodata
value1:
        .double 1.0
value2:
        .double 2.0

fmt:
        .string "xmm0 + xmm1 = %f\n"
