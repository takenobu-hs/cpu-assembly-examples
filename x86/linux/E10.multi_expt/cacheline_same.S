/*
 * Simultaneous-access example for x86/Linux
 *
 *   * Stores to different variables from two threads
 *   * SAME cache-line version (SLOW)
 *
 *   * C-like pseudo-code:
 *
 *     * child1-thread:
 *         for (i=0; i<5000000; i++) {
 *             store to value1;
 *             memory_fence;
 *             load from value1;
 *         }
 *
 *     * child2-thread:
 *         for (i=0; i<5000000; i++) {
 *             store to value2;
 *             memory_fence;
 *             load from value2;
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


        /* puts for trace-log */
        lea     rdi, [rip + fmtMain_finish]
        call    puts


        /* exit from main */
        mov     edi, 0                  /* status: EXIT_SUCCESS */
        call    exit



        /* 1st child thread */
child1:
        sub     rsp, 8                  /* 16-byte alignment */

        /* puts for trace-log */
        lea     rdi, [rip + fmtChild1_start]
        call    puts



        /* increment loop for shared-counter */
        mov     eax, 0                  /* loop variable   */
        mov     rbx, 5000000            /* loop max-number */
        mov     rcx, 1

L1_loop:
        mov     [rip + value1], rcx     /* store */
        mfence                          /* flush store-buffers */
        mov     rdx, [rip + value1]     /* load */

        add     eax, 1                  /* increment the loop-variable */
        cmp     rax, rbx
        jl      L1_loop



        /* puts for trace-log */
        lea     rdi, [rip + fmtChild1_finish]
        call    puts  

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



        /* increment loop for shared-counter */
        mov     eax, 0                  /* loop variable   */
        mov     rbx, 5000000            /* loop max-number */
        mov     rcx, 1

L2_loop:
        mov     [rip + value2], rcx     /* store */
        mfence                          /* flush store-buffers */
        mov     rdx, [rip + value2]     /* load */

        add     eax, 1                  /* increment the loop-variable */
        cmp     rax, rbx
        jl      L2_loop



        /* puts for trace-log */
        lea     rdi, [rip + fmtChild2_finish]
        call    puts   

        /* finish this thead */
        mov     eax, 0                  /* return value (not used) */
        add     rsp, 8
        ret



        /* read-only data */
        .section .rodata
fmtMain_start:
        .string "main(): start"
fmtMain_finish:
        .string "main(): finish"

fmtChild1_start:
        .string "child1(): start"
fmtChild1_finish:
        .string "child1(): finish"

fmtChild2_start:
        .string "child2(): start"
fmtChild2_finish:
        .string "child2(): finish"



        /* read-write data */
        .data
        .balign 8
tid1:
        .quad   0
tid2:
        .quad   0


        .balign 64
value1:
        .quad   0

//padding:
//      .space 64               /* padding for different cache-lines */

value2:
        .quad   0
