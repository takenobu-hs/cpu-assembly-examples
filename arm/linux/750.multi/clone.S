/*
 * Clone (generating a thread) example for Arm(Armv8 aarch64)/Linux
 *
 *   * Threads
 *      * main:  a main thread
 *      * child: a child thread (cloned from the main thread)
 *
 *   * clone(2) system-call
 *   * see:
 *     * man 2 clone
 *     * linux-kernel's include/uapi/asm-generic/unistd.h
 *     * glibc's sysdeps/unix/sysv/linux/aarch64/syscall.S
 */

        .globl  main

main:
        /* clone() */
        adr     x0, child               /* fn:          child         */
        adrp    x1, stackChildTop       /* child_stack: stackChildTop */
        add     x1, x1, :lo12:stackChildTop
        mov     x2, 0x11                /* flags:       SIGCHLD       */
        mov     x3, 0                   /* arg:         NULL          */
        mov     x4, 0                   /* the number of vector reg   */
        bl      clone


        /* waitpid() */
                                        /* pid: x0 by above clone  */
        mov     x1, 0                   /* wstatus: */
        mov     x2, 0                   /* options: */
        bl      waitpid


        /* puts for trace-log */
        adr     x0, fmtMain
        bl      puts

        /* exit from main */
        mov     x0, 0                   /* status: */
        bl      exit



        /* a child thread */
child:
        stp     x29, x30, [sp, -16]!

        /* puts for trace-log */
        adr     x0, fmtChild
        bl      puts

        /* sleep() */
        mov     x0, 1                   /* seconds: */
        bl      sleep

        /* return to main-thread */
        mov     x0, 0
        ldp     x29, x30, [sp], 16
        ret



        /* read-only data */
        .section .rodata
fmtMain:
        .string "main()"
fmtChild:
        .string "child()"



        /* read-write data */
        .data
        .balign 8
stackChild:
        .space  1024*1024
stackChildTop:
