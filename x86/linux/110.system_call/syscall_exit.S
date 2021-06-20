/*
 * System-call example for x86/Linux
 *
 *   * exit(2) system-call
 *   * see: linux-kernel's arch/x86/entry/syscalls/syscall_64.tbl
 *   * see: x86-64 ABI (https://gitlab.com/x86-psABIs/x86-64-ABI)
 */

.intel_syntax noprefix

.global main

main:
        mov     rax, 60                 /* exit() */
        mov     rdi, 0                  /* status: success */
        syscall
