/*
 * System-call example for x86/Linux
 *
 *   * write(2) system-call
 *   * see: linux-kernel's arch/x86/entry/syscalls/syscall_64.tbl
 *   * see: x86-64 ABI (https://gitlab.com/x86-psABIs/x86-64-ABI)
 */

.intel_syntax noprefix

.global main

main:
        mov     rax, 1                  /* write() */
        mov     rdi, 1                  /* fd: stdout */
        lea     rsi, [rip + msg]        /* buf: */
        mov     rdx, 13                 /* count: */

        syscall
        ret

msg:
        .ascii "Hello world!\n"
