/*
 * Latency example for x86/Linux
 *
 *   * I/O-read instruction
 *
 *   * C-like pseudo-code:
 *
 *         for (i=0; i<1000000; i++) {
 *             I/O-read instruction
 *                   :                  // 100 times
 *         }
 *
 */

        .intel_syntax noprefix
        .global main

main:
        sub     rsp, 8                  /* 16-byte alignment */


        /* set io-port permissions with ioperm(2) */
        mov     edi, 0x0cf8
        mov     esi, 8
        mov     edx, 1
        call    ioperm                  /* see; man ioperm(2) */

        /* set the PCI-address */
        mov     eax, 0x80000000
        mov     dx, 0x0cf8              /* PCI register (CONFIG_ADDRESS) */
        out     dx, eax                 /* I/O-write */

        /* loop conditions */
        mov     ecx, 0                  /* loop variable   */
        mov     rbx, 1000000            /* loop max-number */

        /* set the address for I/O-read */
        mov     dx, 0x0cfc              /* PCI register (CONFIG_DATA) */

        /* loop body */
L_loop:
        in      eax, dx                 /* I/O-read */
        in      eax, dx
        in      eax, dx
        in      eax, dx
        in      eax, dx
        in      eax, dx
        in      eax, dx
        in      eax, dx
        in      eax, dx
        in      eax, dx

        in      eax, dx
        in      eax, dx
        in      eax, dx
        in      eax, dx
        in      eax, dx
        in      eax, dx
        in      eax, dx
        in      eax, dx
        in      eax, dx
        in      eax, dx

        in      eax, dx
        in      eax, dx
        in      eax, dx
        in      eax, dx
        in      eax, dx
        in      eax, dx
        in      eax, dx
        in      eax, dx
        in      eax, dx
        in      eax, dx

        in      eax, dx
        in      eax, dx
        in      eax, dx
        in      eax, dx
        in      eax, dx
        in      eax, dx
        in      eax, dx
        in      eax, dx
        in      eax, dx
        in      eax, dx

        in      eax, dx
        in      eax, dx
        in      eax, dx
        in      eax, dx
        in      eax, dx
        in      eax, dx
        in      eax, dx
        in      eax, dx
        in      eax, dx
        in      eax, dx

        in      eax, dx
        in      eax, dx
        in      eax, dx
        in      eax, dx
        in      eax, dx
        in      eax, dx
        in      eax, dx
        in      eax, dx
        in      eax, dx
        in      eax, dx

        in      eax, dx
        in      eax, dx
        in      eax, dx
        in      eax, dx
        in      eax, dx
        in      eax, dx
        in      eax, dx
        in      eax, dx
        in      eax, dx
        in      eax, dx

        in      eax, dx
        in      eax, dx
        in      eax, dx
        in      eax, dx
        in      eax, dx
        in      eax, dx
        in      eax, dx
        in      eax, dx
        in      eax, dx
        in      eax, dx

        in      eax, dx
        in      eax, dx
        in      eax, dx
        in      eax, dx
        in      eax, dx
        in      eax, dx
        in      eax, dx
        in      eax, dx
        in      eax, dx
        in      eax, dx

        in      eax, dx
        in      eax, dx
        in      eax, dx
        in      eax, dx
        in      eax, dx
        in      eax, dx
        in      eax, dx
        in      eax, dx
        in      eax, dx
        in      eax, dx

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
