/*
 * System-call example for RISV-V(RV64)/Linux
 *
 *   * write(2) system-call
 *   * see: man 2 write
 *   * see: linux-kernel's include/uapi/asm-generic/unistd.h
 *   * see: man syscall (https://man7.org/linux/man-pages/man2/syscall.2.html)
 */

        .global main

main:
        /* write(2) system-call */
        li      a7, 64                  /* system-call number: write() */
        li      a0, 1                   /* fd: stdout */
        la      a1, msg                 /* buf: */
        li      a2, 13                  /* count: */
        ecall                           /* system call */


        /* return from main */
        ret


        /* read-only data */
        .section .rodata
msg:
        .string "Hello world!\n"
