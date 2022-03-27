/*
 * Clone (generating a thread) example for x86/Linux
 *
 *   * Threads
 *      * main:  a main thread
 *      * child: a child thread (cloned from the main thread)
 *
 *   * clone(2) system-call
 *   * see:
 *     * man 2 clone
 *     * linux-kernel's arch/x86/entry/syscalls/syscall_64.tbl
 *     * glibc's sysdeps/unix/sysv/linux/x86_64/clone.S
 *     * x86-64 ABI (https://gitlab.com/x86-psABIs/x86-64-ABI)
 */

        .intel_syntax noprefix
        .globl  main

main:
        /* clone() */
        lea     rdi, child[rip]         /* fn:          child         */
        lea     rsi, stackChildTop[rip] /* child_stack: stackChildTop */
        mov     edx, 0x11               /* flags:       SIGCHLD       */
        mov     ecx, 0                  /* arg:         NULL          */
        mov     eax, 0                  /* the number of vector reg   */
        call    clone


        /* waitpid() */
        mov     edi, eax                /* pid:     */
        mov     esi, 0                  /* wstatus: */
        mov     edx, 0                  /* options: */
        call    waitpid


        /* puts for trace-log */
        lea     rdi, fmtMain[rip]
        call    puts

        /* return from main */
        mov     edi, 0                  /* status: */
        call    exit



        /* a child thread */
child:
        /* puts for trace-log */
        lea     rdi, fmtChild[rip]
        call    puts

        /* sleep() */
        mov     edi, 1                  /* seconds: */
        call    sleep

        /* return to main-thread */
        mov     eax, 0
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
