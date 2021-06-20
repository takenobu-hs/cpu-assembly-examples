/*
 * System-call example for Arm(Armv8 aarch64)/Linux
 *
 *   * read(2) system-call
 *   * see: linux-kernel's include/uapi/asm-generic/unistd.h
 *   * see: man syscall (https://man7.org/linux/man-pages/man2/syscall.2.html)
 */

.global main

main:
        /* read() */
        mov     x8, 63                  /* read() */
        mov     x0, 0                   /* fd: stdin */
        adr     x1, buf                 /* buf: */
        mov     x2, 3                   /* count: */

        svc     0                       /* system call */


        /* write() for check */
        mov     x8, 64                  /* write() */
        mov     x0, 1                   /* fd: stdout */
        adr     x1, buf                 /* buf: */
        mov     x2, 3                   /* count: */

        svc     0                       /* system call */


        /* return */
        ret


.bss
buf:
        .space 10
