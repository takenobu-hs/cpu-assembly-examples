/*
 * System-call example for RISC-V(RV64)/Linux
 *
 *   * read(2) system-call
 *   * see: man 2 read
 *   * see: linux-kernel's include/uapi/asm-generic/unistd.h
 *   * see: man syscall (https://man7.org/linux/man-pages/man2/syscall.2.html)
 */

        .global main

main:
        /* read(2) system-call */
        li      a7, 63                  /* system-call number: read() */
        li      a0, 0                   /* fd: stdin */
        la      a1, buf                 /* buf: */
        li      a2, 3                   /* count: */
        ecall                           /* system call */


        /* write(2) system-call */
        li      a7, 64                  /* system-call number: write() */
        li      a0, 1                   /* fd: stdout */
        la      a1, buf                 /* buf: */
        li      a2, 3                   /* count: */
        ecall                           /* system call */


        /* return from main */
        ret


        /* read-write zero initialized data */
        .bss
buf:
        .space 10
