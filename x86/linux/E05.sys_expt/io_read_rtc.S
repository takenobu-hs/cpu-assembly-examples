/*
 * I/O access example for x86/Linux
 *
 *   * Cannot execute this under kernel lockdown!
 *
 *   * Read real-time clock(RTC) with io-port 70,71
 *   * RTS is coded with BCD(binary-coded decimal)
 *   * Execute with sudo for ioperm
 *   * see: linux-kernel's arch/x86/kernel/rtc.c
 */

        .intel_syntax noprefix
        .global main

main:
        sub     rsp, 8                  /* 16-byte alignment */


        /* set io-port permissions with ioperm(2) */
        mov     edi, 0x70
        mov     esi, 2
        mov     edx, 1
        call    ioperm                  /* see; man ioperm(2) */


        /* read real-time clock(RTC) */
        mov     al, 0                   /* RTC_SECONDS */
        out     0x70, al                /* write rtc */
        in      al, 0x71                /* read rtc */


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
        .string "rtc seconds = %02x\n"
