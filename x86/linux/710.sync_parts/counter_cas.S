/*
 * An atomic counter example for x86/Linux
 *
 *   * cmpxchg(compare-and-swap) instruction
 *
 *   * C-like pseudo-code:
 *       L_loop:
 *         rax = *counter;                       // read counter
 *         rbx = rax;
 *         rbx = rbx + 1;                        // increment
 *
 *         // cmpare-and-swap instruction
 *         tmp = *counter;                      // read counter
 *         if (rax == tmp) *counter = rbx;      // swap if unchanged
 *         rax = tmp;
 *
 *         // check
 *         if (zero_flag != 1) goto L_loop;     // loop if fail
 *
 */

        .intel_syntax noprefix
        .global main

main:

        /* increment the counter with cmpare-and-swap loop */
L_loop:
        mov     rax, [rip + counter]            /* rax = *counter   */
        mov     rbx, rax                        /* rbx = rax        */
        add     rbx, 1                          /* rbx = rbx + 1    */

        lock cmpxchg [rip + counter], rbx       /* compare-and-swap */

        jne     L_loop                          /* loop if fail     */


        /* printf for result-checking */
        lea     rdi, [rip + fmt]        /* 1st argument for printf */
        mov     rsi, [rip + counter]    /* 2nd argument for printf */
        mov     rax, 0                  /* the number of vector regsters */
        call    printf


        /* return from main */
        ret


        /* read-only data */
        .section .rodata
fmt:
        .string "counter = %d\n"


        /* read-write initialized data */
        .data
        .balign 8
counter:
        .quad   10
