/*
 * Clone (generating two threads) example for Arm(Armv8 aarch64)/Linux
 *
 *   * Threads
 *      * main:   a main thread
 *      * child1: 1st child thread (cloned from the main thread)
 *      * child2: 2nd child thread (cloned from the main thread)
 *
 *   * clone(2) system-call
 *   * see:
 *     * man 2 clone
 *     * linux-kernel's include/uapi/asm-generic/unistd.h
 *     * glibc's sysdeps/unix/sysv/linux/aarch64/syscall.S
 *
 */

        .globl  main

main:
        /* clone() for 1st child thread */
        adr     x0, child1              /* fn:          child1         */
        adrp    x1, stackChild1Top      /* child_stack: stackChild1Top */
        add     x1, x1, :lo12:stackChild1Top
        mov     x2, 0x11                /* flags:       SIGCHLD        */
        mov     x3, 0                   /* arg:         NULL           */
        mov     x4, 0                   /* the number of vector reg    */
        bl      clone

        /* clone() for 2nd child thread */
        adr     x0, child2              /* fn:          child2         */
        adrp    x1, stackChild2Top      /* child_stack: stackChild2Top */
        add     x1, x1, :lo12:stackChild2Top
        mov     x2, 0x11                /* flags:       SIGCHLD        */
        mov     x3, 0                   /* arg:         NULL           */
        mov     x4, 0                   /* the number of vector reg    */
        bl      clone


        /* wait() */
        mov     x0, 0                   /* wstatus: */
        bl      wait                    /* 1st wait for a thread  */

        mov     x0, 0                   /* wstatus: */
        bl      wait                    /* 2nd wait for a thread  */


        /* puts for trace-log */
        adr     x0, fmtMain
        bl      puts


        /* exit from main */
        mov     x0, 0                   /* status: */
        bl      exit



        /* 1st child thread */
child1:
        stp     x29, x30, [sp, -16]!

        /* puts for trace-log */
        adr     x0, fmtChild1
        bl      puts

        /* sleep() */
        mov     x0, 3                   /* seconds: */
        bl      sleep

        /* return to main-thread */
        mov     x0, 0
        ldp     x29, x30, [sp], 16
        ret



        /* 2nd child thread */
child2:
        stp     x29, x30, [sp, -16]!

        /* puts for trace-log */
        adr     x0, fmtChild2
        bl      puts

        /* sleep() */
        mov     x0, 3                   /* seconds: */
        bl      sleep

        /* return to main-thread */
        mov     x0, 0
        ldp     x29, x30, [sp], 16
        ret



        /* read-only data */
        .section .rodata
fmtMain:
        .string "main()"
fmtChild1:
        .string "child1()"
fmtChild2:
        .string "child2()"



        /* read-write data */
        .data
        .balign 8
stackChild1:
        .space  1024*1024
stackChild1Top:

stackChild2:
        .space  1024*1024
stackChild2Top:
