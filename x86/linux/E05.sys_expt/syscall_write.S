/*
 * System-call example for x86/Linux
 *
 *   * write(2) system-call
 *   * see: man 2 write
 *   * see: linux-kernel's arch/x86/entry/syscalls/syscall_64.tbl
 *   * see: x86-64 ABI (https://gitlab.com/x86-psABIs/x86-64-ABI)
 */

        .intel_syntax noprefix
        .global main

main:
        sub     rsp, 8                  /* 16-byte alignment */


        /* write(2) system-call */
        mov     eax, 1                  /* system-call number: write() */
        mov     edi, 1                  /* fd: stdout */
        lea     rsi, [rip + msg]        /* buf: */
        mov     edx, 13                 /* count: */
        syscall


        /* return from main */
        add     rsp, 8                  /* 16-byte alignment */
        ret


        /* read-only data */
        .section .rodata
msg:
        .string "hello, world\n"
