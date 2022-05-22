/*
 * Clone (generating a thread) example for RISC-V(RV64)/Linux
 *
 *   * Threads
 *      * main:  a main thread
 *      * child: a child thread (cloned from the main thread)
 *
 *   * clone(2) system-call
 *   * see:
 *     * man 2 clone
 *     * linux-kernel's include/uapi/asm-generic/unistd.h
 *     * glibc's sysdeps/unix/sysv/linux/riscv/clone.S
 */

        .globl  main

main:
        /* clone() */
        la      a0, child               /* fn:          child         */
        la      a1, stackChildTop       /* child_stack: stackChildTop */
        li      a2, 0x11                /* flags:       SIGCHLD       */
        li      a3, 0                   /* arg:         NULL          */
        li      a4, 0                   /* the number of vector reg   */
        jal     clone


        /* waitpid() */
                                        /* pid: a0 by above clone  */
        li      a1, 0                   /* wstatus: */
        li      a2, 0                   /* options: */
        jal     waitpid


        /* puts for trace-log */
        la      a0, fmtMain
        Jal     puts

        /* exit from main */
        li      a0, 0                   /* status: */
        jal     exit



        /* a child thread */
child:
        addi    sp,sp,-8
        sd      ra,(sp)

        /* puts for trace-log */
        la      a0, fmtChild
        jal     puts

        /* sleep() */
        li      a0, 1                   /* seconds: */
        jal     sleep

        /* return to main-thread */
        li      a0, 0
        ld      ra,(sp)
        addi    sp,sp,8
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
