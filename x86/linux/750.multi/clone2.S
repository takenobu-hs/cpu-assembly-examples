/*
 * Clone (generating two threads) example for x86/Linux
 *
 *   * Threads
 *      * main:   a main thread
 *      * child1: 1st child thread (cloned from the main thread)
 *      * child2: 2nd child thread (cloned from the main thread)
 *
 *   * clone(2) system-call
 *   * see:
 *     * man 2 clone
 *     * linux-kernel's arch/x86/entry/syscalls/syscall_64.tbl
 *     * glibc's sysdeps/unix/sysv/linux/x86_64/clone.S
 *     * x86-64 ABI (https://gitlab.com/x86-psABIs/x86-64-ABI)
 *
 */

        .intel_syntax noprefix
        .globl  main

main:
        /* clone() for 1st child thread */
        lea     rdi, [rip + child1]         /* fn:          child1         */
        lea     rsi, [rip + stackChild1Top] /* child_stack: stackChild1Top */
        mov     edx, 0x11                   /* flags:       SIGCHLD        */
        mov     ecx, 0                      /* arg:         NULL           */
        mov     eax, 0                      /* the number of vector reg    */
        call    clone


        /* clone() for 2nd child thread */
        lea     rdi, [rip + child2]         /* fn:          child2         */
        lea     rsi, [rip + stackChild2Top] /* child_stack: stackChild2Top */
        mov     edx, 0x11                   /* flags:       SIGCHLD        */
        mov     ecx, 0                      /* arg:         NULL           */
        mov     eax, 0                      /* the number of vector reg    */
        call    clone


        /* wait() */
        mov     edi, 0                  /* wstatus:               */
        call    wait                    /* 1st wait for a thread  */

        mov     edi, 0                  /* wstatus:               */
        call    wait                    /* 2nd wait for a thread  */


        /* puts for trace-log */
        lea     rdi, [rip + fmtMain]
        call    puts

        /* return from main */
        mov     edi, 0                  /* status: */
        call    exit



        /* 1st child thread */
child1:
        /* puts for trace-log */
        lea     rdi, [rip + fmtChild1]
        call    puts

        /* sleep() */
        mov     edi, 3                  /* seconds: */
        call    sleep

        /* return to main-thread */
        mov     eax, 0
        ret



        /* 2nd child thread */
child2:
        /* puts for trace-log */
        lea     rdi, [rip + fmtChild2]
        call    puts

        /* sleep() */
        mov     edi, 3                  /* seconds: */
        call    sleep

        /* return to main-thread */
        mov     eax, 0
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
