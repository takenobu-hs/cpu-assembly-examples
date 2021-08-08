/*
 * System-call example for RISC-V(RV64)/Linux
 *
 *   * exit(2) system-call
 *   * see: man 2 exit
 *   * see: linux-kernel's include/uapi/asm-generic/unistd.h
 *   * see: man syscall (https://man7.org/linux/man-pages/man2/syscall.2.html)
 */

        .global main

main:
        /* exit(2) system-call */
        li      a7, 93                  /* system-call number: exit() */
        li      a0, 0                   /* status: success */
        ecall                           /* system call */
