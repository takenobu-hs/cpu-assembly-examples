/*
 * System-call example for Arm(Armv8 aarch64)/Linux
 *
 *   * write(2) system-call
 *   * see: man 2 write
 *   * see: linux-kernel's include/uapi/asm-generic/unistd.h
 *   * see: man syscall (https://man7.org/linux/man-pages/man2/syscall.2.html)
 */

        .global main

main:
        /* write(2) system-call */
        mov     x8, 64                  /* system-call number: write() */
        mov     x0, 1                   /* fd: stdout */
        adr     x1, msg                 /* buf: */
        mov     x2, 13                  /* count: */
        svc     0                       /* system call */


        /* return from main */
        ret


        /* read-only data */
        .section .rodata
msg:
        .string "hello, world\n"
