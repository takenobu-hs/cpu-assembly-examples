/*
 * Clone (generating two threads) example for RISC-V(RV64)/Linux
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
 *     * glibc's sysdeps/unix/sysv/linux/riscv/clone.S
 *
 */

        .globl  main

main:
        /* clone() for 1st child thread */
        la      a0, child1              /* fn:          child1         */
        la      a1, stackChild1Top      /* child_stack: stackChild1Top */
        li      a2, 0x11                /* flags:       SIGCHLD        */
        li      a3, 0                   /* arg:         NULL           */
        li      a4, 0                   /* the number of vector reg    */
        jal     clone

        /* clone() for 2nd child thread */
        la      a0, child2              /* fn:          child2         */
        la      a1, stackChild2Top      /* child_stack: stackChild2Top */
        li      a2, 0x11                /* flags:       SIGCHLD        */
        li      a3, 0                   /* arg:         NULL           */
        li      a4, 0                   /* the number of vector reg    */
        jal     clone


        /* wait() */
        li      a0, 0                   /* wstatus: */
        jal     wait                    /* 1st wait for a thread  */

        li      a0, 0                   /* wstatus: */
        jal     wait                    /* 2nd wait for a thread  */


        /* puts for trace-log */
        la      a0, fmtMain
        jal     puts


        /* exit from main */
        li      a0, 0                   /* status: */
        jal     exit



        /* 1st child thread */
child1:
        addi    sp,sp,-8
        sd      ra,(sp)

        /* puts for trace-log */
        la      a0, fmtChild1
        jal     puts

        /* sleep() */
        li      a0, 3                   /* seconds: */
        jal     sleep

        /* return to main-thread */
        li      a0, 0
        ld      ra,(sp)
        addi    sp,sp,8
        ret



        /* 2nd child thread */
child2:
        addi    sp,sp,-8
        sd      ra,(sp)

        /* puts for trace-log */
        la      a0, fmtChild2
        jal     puts

        /* sleep() */
        li      a0, 3                   /* seconds: */
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
