/*
 * Clone (generating a thread) example for x86/Linux
 *
 *   * Threads
 *      * main:  a main thread
 *      * child: a child thread (cloned from the main thread)
 *
 *   * NOTE:
 *     * This is a simple example for clone with CLONE_VM.
 *     * You should be careful for handling stack and clone-arguments.
 *
 *   * see:
 *     * man 2 clone
 *     * linux-kernel's arch/x86/entry/syscalls/syscall_64.tbl
 *     * glibc's sysdeps/unix/sysv/linux/x86_64/clone.S
 *     * x86-64 ABI (https://gitlab.com/x86-psABIs/x86-64-ABI)
 */

        .intel_syntax noprefix
        .globl  main

main:
        sub     rsp, 8                  /* 16-byte alignment */


        /* clone() */
        lea     rdi, [rip + child]         /* fn: &child                  */
        lea     rsi, [rip + stackChildTop] /* child_stack: &stackChildTop */
        mov     edx, 0x111                 /* flags: CLONE_VM | SIGCHLD   */
        mov     ecx, 0                     /* arg: NULL                   */
        mov     eax, 0                     /* the number of vector reg    */
        call    clone


        /* waitpid() */
        mov     edi, eax                /* pid: (from clone) */
        mov     esi, 0                  /* wstatus: NULL     */
        mov     edx, 0                  /* options: 0        */
        call    waitpid


        /* puts for trace-log */
        lea     rdi, [rip + fmtMain]
        call    puts

        /* exit from main */
        mov     edi, 0                  /* status: EXIT_SUCCESS */
        call    exit



        /* a child thread */
child:
        sub     rsp, 8                  /* 16-byte alignment */


        /* puts for trace-log */
        lea     rdi, [rip + fmtChild]
        call    puts

        /* sleep() */
        mov     edi, 1                  /* seconds: 1sec */
        call    sleep

        /* return to main-thread */
        mov     eax, 0
        add     rsp, 8                  /* 16-byte alignment */
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
