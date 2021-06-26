/*
 * System-call example for x86/Linux
 *
 *   * exit(2) system-call
 *   * see: man 2 exit
 *   * see: linux-kernel's arch/x86/entry/syscalls/syscall_64.tbl
 *   * see: x86-64 ABI (https://gitlab.com/x86-psABIs/x86-64-ABI)
 */

        .intel_syntax noprefix
        .global main

main:
        /* exit(2) system-call */
        mov     rax, 60                 /* system-call number: exit() */
        mov     rdi, 0                  /* status: success */
        syscall
