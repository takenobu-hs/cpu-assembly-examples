/*
 * I/O access example for x86/Linux
 *
 *   * Cannot execute this under kernel lockdown!
 *
 *   * Read PCI configuration with io-port 0x0cf8, 0x0cfc
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

        /* set the address for I/O-read */
        mov     eax, 0
        mov     dx, 0x0cfc              /* PCI register (CONFIG_DATA) */
        in      ax, dx                  /* I/O-read */



        /* printf for result-checking */
        lea     rdi, [rip + fmt]        /* 1st argument for printf */
        mov     rsi, rax                /* 2nd argument for printf */
        mov     eax, 0                  /* the number of vector regsters */
        call    printf


        /* return from main */
        add     rsp, 8                  /* 16-byte alignment */
        ret


        /* read-only data */
        .section .rodata
fmt:
        .string "Vendor ID = %x\n"
