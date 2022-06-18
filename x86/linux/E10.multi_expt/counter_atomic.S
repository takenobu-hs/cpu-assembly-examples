/*
 * Simultaneous-access example for x86/Linux
 *
 *   * Access to the shared variable from two threads
 *   * ATOMIC version (the counter will be correct)
 *
 *   * C-like pseudo-code for each thread:
 *
 *         for (i=0; i<5000000; i++) {
 *             counter = counter + 1;
 *         }
 *
 */

        .intel_syntax noprefix
        .globl  main

main:
        sub     rsp, 8                  /* 16-byte alignment */

        /* puts for trace-log */
        lea     rdi, [rip + fmtMain_start]
        call    puts


        /* pthread_create() */

        /* for 1st child thread */
        lea     rdi, [rip + tid1]       /* pthread_t: &tid1       */
        mov     esi, 0                  /* pthread_attr_t: NULL   */
        lea     rdx, [rip + child1]     /* start_routine: &child1 */
        mov     ecx, 0                  /* arg: NULL              */
        call    pthread_create

        /* for 2st child thread */
        lea     rdi, [rip + tid2]       /* pthread_t: &tid2       */
        mov     esi, 0                  /* pthread_attr_t: NULL   */
        lea     rdx, [rip + child2]     /* start_routine: &child2 */
        mov     ecx, 0                  /* arg: NULL              */
        call    pthread_create


        /* pthread_join() */

        /* for 1st child thread */
        mov     rdi, [rip + tid1]       /* pthread_t: tid1 */
        mov     esi, 0                  /* retval: NULL    */
        call    pthread_join

        /* for 2nd child thread */
        mov     rdi, [rip + tid2]       /* pthread_t: tid2 */
        mov     esi, 0                  /* retval: NULL    */
        call    pthread_join


        /* printf for result-checking */
        lea     rdi, [rip + fmtMain_finish] /* 1st argument for printf */
        mov     rsi, [rip + counter]        /* 2nd argument */
        mov     eax, 0                      /* the number of vector regsters */
        call    printf


        /* exit from main */
        mov     edi, 0                  /* status: EXIT_SUCCESS */
        call    exit



        /* 1st child thread */
child1:
        sub     rsp, 8                  /* 16-byte alignment */

        /* puts for trace-log */
        lea     rdi, [rip + fmtChild1_start]
        call    puts


        /* loop conditions */
        mov     ecx, 0                  /* loop variable   */
        mov     rbx, 5000000            /* loop max-number */

L1_loop:
        /* increment the shared-counter */
        mov     rax, 1
        lock xadd [rip + counter], rax

        /* increment the loop-variable and loop-back */
        add     rcx, 1
        cmp     rcx, rbx
        jl      L1_loop


        /* puts for trace-log */
        lea     rdi, [rip + fmtChild1_finish]   /* 1st argument for printf   */
        mov     rsi, rcx                        /* 2nd argument              */
        mov     eax, 0                          /* the number of vector regs */
        call    printf

        /* finish this thead */
        mov     eax, 0                  /* return value (not used) */
        add     rsp, 8
        ret



        /* 2nd child thread */
child2:
        sub     rsp, 8                  /* 16-byte alignment */

        /* puts for trace-log */
        lea     rdi, [rip + fmtChild2_start]
        call    puts


        /* loop conditions */
        mov     ecx, 0                  /* loop variable   */
        mov     rbx, 5000000            /* loop max-number */

L2_loop:
        /* increment the shared-counter */
        mov     rax, 1
        lock xadd [rip + counter], rax

        /* increment the loop-variable and loop-back */
        add     rcx, 1
        cmp     rcx, rbx
        jl      L2_loop


        /* puts for trace-log */
        lea     rdi, [rip + fmtChild2_finish]   /* 1st argument for printf   */
        mov     rsi, rcx                        /* 2nd argument              */
        mov     eax, 0                          /* the number of vector regs */
        call    printf

        /* finish this thead */
        mov     eax, 0                  /* return value (not used) */
        add     rsp, 8
        ret



        /* read-only data */
        .section .rodata
fmtMain_start:
        .string "main(): start"
fmtMain_finish:
        .string "main(): finish: counter = %d\n"

fmtChild1_start:
        .string "child1(): start"
fmtChild1_finish:
        .string "child1(): finish: loop-variable = %d\n"

fmtChild2_start:
        .string "child2(): start"
fmtChild2_finish:
        .string "child2(): finish: loop-variable = %d\n"



        /* read-write data */
        .data
        .balign 8
tid1:
        .quad   0
tid2:
        .quad   0

counter:
        .quad   0
