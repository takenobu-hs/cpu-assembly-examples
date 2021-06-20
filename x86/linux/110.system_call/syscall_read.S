/*
 * System-call example for x86/Linux
 *
 *   * read(2) system-call
 *   * see: linux-kernel's arch/x86/entry/syscalls/syscall_64.tbl
 *   * see: x86-64 ABI (https://gitlab.com/x86-psABIs/x86-64-ABI)
 */

.intel_syntax noprefix

.global main

main:
        mov     rax, 0                  /* read() */
        mov     rdi, 0                  /* fd: stdin */
        lea     rsi, [rip + buf]        /* buf: */
        mov     rdx, 3                  /* count: */
        syscall

        mov     rax, 1                  /* write() */
        mov     rdi, 1                  /* fd: stdout */
        lea     rsi, [rip + buf]        /* buf: */
        mov     rdx, 3                  /* count: */
        syscall

        ret

.bss
buf:
        .space 10
