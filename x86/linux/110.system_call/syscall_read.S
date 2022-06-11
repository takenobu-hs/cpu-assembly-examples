/*
 * System-call example for x86/Linux
 *
 *   * read(2) system-call
 *   * see: man 2 read
 *   * see: linux-kernel's arch/x86/entry/syscalls/syscall_64.tbl
 *   * see: x86-64 ABI (https://gitlab.com/x86-psABIs/x86-64-ABI)
 */

        .intel_syntax noprefix
        .global main

main:
        sub     rsp, 8                  /* 16-byte alignment */


        /* read(2) system-call */
        mov     eax, 0                  /* system-call number: read() */
        mov     edi, 0                  /* fd: stdin */
        lea     rsi, [rip + buf]        /* buf: */
        mov     edx, 3                  /* count: */
        syscall

        /* write(2) system-call */
        mov     eax, 1                  /* system-call number: write() */
        mov     edi, 1                  /* fd: stdout */
        lea     rsi, [rip + buf]        /* buf: */
        mov     edx, 3                  /* count: */
        syscall


        /* return from main */
        add     rsp, 8                  /* 16-byte alignment */
        ret


        /* read-write zero initialized data */
        .bss
buf:
        .space 10
