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
        /* read(2) system-call */
        mov     rax, 0                  /* system-call number: read() */
        mov     rdi, 0                  /* fd: stdin */
        lea     rsi, [rip + buf]        /* buf: */
        mov     rdx, 3                  /* count: */
        syscall

        /* write(2) system-call */
        mov     rax, 1                  /* system-call number: write() */
        mov     rdi, 1                  /* fd: stdout */
        lea     rsi, [rip + buf]        /* buf: */
        mov     rdx, 3                  /* count: */
        syscall


        /* return from main */
        ret


        /* read-write zero initialized data */
        .bss
buf:
        .space 10
