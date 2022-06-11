/*
 * An atomic counter example for x86/Linux
 *
 *   * xchg(swap) instruction
 *
 *   * C-like pseudo-code:
           // acquire the lock
 *       L_loop:
 *         rax = 1;
 *         tmp = *lock;   // xchg(swap)
 *         *lock = rax;   // xchg(swap)
 *         rax = tmp;     // xchg(swap)
 *         if (rax != 0) goto L_loop;
 *
 *         // increment the counter
 *         rbx = 1;
 *         *counter = *counter + rbx;
 *
 *         // release the lock
 *         rax = 0;
 *         *lock = rax;
 *
 */

        .intel_syntax noprefix
        .global main

main:
        sub     rsp, 8                  /* 16-byte alignment */


        /* acquire the lock */
L_loop:
        mov     rax, 1                  /* rax = 1                   */
        xchg    [rip + lock], rax       /* swap lock and rax         */
        cmp     rax, 0
        jne     L_loop                  /* if (rax !=0) goto L_loop  */

        /* increment the counter */
        mov     rbx, 1                  /* rbx = 1                   */
        add     [rip + counter], rbx    /* *counter = *counter + rbx */

        /* release the lock */
        mov     rax, 0                  /* rax = 0                   */
        mov     [rip + lock], rax       /* *lock = rax               */



        /* printf for result-checking */
        lea     rdi, [rip + fmt]        /* 1st argument for printf */
        mov     rsi, [rip + counter]    /* 2nd argument for printf */
        mov     rax, 0                  /* the number of vector regsters */
        call    printf


        /* return from main */
        add     rsp, 8                  /* 16-byte alignment */
        ret


        /* read-only data */
        .section .rodata
fmt:
        .string "counter = %d\n"


        /* read-write initialized data */
        .data
        .balign 8
lock:
        .quad   0
counter:
        .quad   10
