/*
 * System-call example for Arm(Armv8 aarch64)/Linux
 *
 *   * read(2) system-call
 *   * see: man 2 read
 *   * see: linux-kernel's include/uapi/asm-generic/unistd.h
 *   * see: man syscall (https://man7.org/linux/man-pages/man2/syscall.2.html)
 */

        .global main

main:
        /* read(2) system-call */
        mov     x8, 63                  /* system-call number: read() */
        mov     x0, 0                   /* fd: stdin */
        adr     x1, buf                 /* buf: */
        mov     x2, 3                   /* count: */
        svc     0                       /* system call */

        /* write(2) system-call */
        mov     x8, 64                  /* system-call number: write() */
        mov     x0, 1                   /* fd: stdout */
        adr     x1, buf                 /* buf: */
        mov     x2, 3                   /* count: */
        svc     0                       /* system call */

        /* return from main */
        ret


        /* read-write zero initialized data */
        .bss
buf:
        .space 10
