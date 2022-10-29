/*
 * Memory-ordering example for x86/Linux
 *
 *   * Store and load to different variables on two threads
 *   * With memory-ordering instruction version
 *
 *   * C-like pseudo-code:
 *
 *     * child1-thread:
 *         for (i=0; i<5000000; i++) {
 *             value_x    = 1;
 *             memory_fence;            // FORCE ORDERING
 *             result_r14 = value_y;
 *
 *             error check for (result_r14 == 0) && (result_r15 == 0);
 *             value_y = 0;
 *         }
 *
 *     * child2-thread:
 *         for (i=0; i<5000000; i++) {
 *             value_y    = 1;
 *             memory_fence;            // FORCE ORDERING
 *             result_r15 = value_x;
 *
 *             error check for (result_r14 == 0) && (result_r15 == 0);
 *             value_x = 0;
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

        /* loop conditions */
        mov     ecx, 0                  /* loop variable   */
        mov     rbx, 5000000            /* loop max-number */


L1_loop:
        /* store and load accesses */
        mov     rax, 1
        mov     [rip + value_x], rax    /* value_x = 1   */
        mfence                          /* FORCE ORDERING */
        mov     r14, [rip + value_y]    /* r14 = value_y */


        /* store r14 for error check */
        mov     [rip + result_r14], r14

        /* 1st sync (wait until sync_counter % 4 == 2) */
        mov       rax, 0x1
        lock xadd [rip + sync_counter], rax     /* sync_counter++ */
L1_loop_sync1:
        mov     rdx, [rip + sync_counter]
        and     rdx, 2
        jz      L1_loop_sync1

        /* error check */
        mfence
        mov     rdx, [rip + result_r15]
        or      r14, rdx
        jz      L1_error                /* if (r14 == 0 && r15 == 0) error */

        /* re-initialize */
        mov     rax, 0
        mov     [rip + value_x], rax    /* value_x = 0   */
        mfence

        /* 2nd sync (wait until sync_counter % 4 == 0) */
        mov       rax, 0x1
        lock xadd [rip + sync_counter], rax     /* sync_counter++ */
L1_loop_sync2:
        mov     rdx, [rip + sync_counter]
        and     rdx, 2
        jnz     L1_loop_sync2

        /* increment the loop-variable and loop-back */
        add     rcx, 1
        cmp     rcx, rbx
        jl      L1_loop


        /* print the last loop-variable */
        lea     rdi, [rip + fmtChild1_finish]
        mov     rsi, rcx
        mov     eax, 0
        call    printf

        /* finish this thead */
        mov     eax, 0                  /* return value (not used) */
        add     rsp, 8
        ret


L1_error:
        /* print the last loop-variable */
        lea     rdi, [rip + fmtChild1_error]
        mov     rsi, rcx
        mov     eax, 0
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
        /* store and load accesses */
        mov     rax, 1
        mov     [rip + value_y], rax    /* value_y = 1   */
        mfence                          /* FORCE ORDERING */
        mov     r15, [rip + value_x]    /* r15 = value_x */


        /* store r15 for error check */
        mov     [rip + result_r15], r15

        /* 1st sync (wait until sync_counter % 4 == 2) */
        mov       rax, 0x1
        lock xadd [rip + sync_counter], rax     /* sync_counter++ */
L2_loop_sync1:
        mov     rdx, [rip + sync_counter]
        and     rdx, 2
        jz      L2_loop_sync1

        /* error check */
        mfence
        mov     rdx, [rip + result_r14]
        or      r15, rdx
        jz      L2_error                /* if (r14 == 0 && r15 == 0) error */

        /* re-initialize */
        mov     rax, 0
        mov     [rip + value_y], rax    /* value_y = 0   */
        mfence

        /* 2nd sync (wait until sync_counter % 4 == 0) */
        mov       rax, 0x1
        lock xadd [rip + sync_counter], rax     /* sync_counter++ */
L2_loop_sync2:
        mov     rdx, [rip + sync_counter]
        and     rdx, 2
        jnz     L2_loop_sync2

        /* increment the loop-variable and loop-back */
        add     rcx, 1
        cmp     rcx, rbx
        jl      L2_loop


        /* print the last loop-variable */
        lea     rdi, [rip + fmtChild2_finish]
        mov     rsi, rcx
        mov     eax, 0
        call    printf

        /* finish this thead */
        mov     eax, 0                  /* return value (not used) */
        add     rsp, 8
        ret


L2_error:
        /* print the last loop-variable */
        lea     rdi, [rip + fmtChild2_error]
        mov     rsi, rcx
        mov     eax, 0
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
        .string "main(): finish"

fmtChild1_start:
        .string "child1(): start"
fmtChild1_finish:
        .string "child1(): finish: loop-variable = %d\n"
fmtChild1_error:
        .string "child1(): UNEXPECTED!: r14 == 0 && r15 == 0; loop-variable = %d\n"

fmtChild2_start:
        .string "child2(): start"
fmtChild2_finish:
        .string "child2(): finish: loop-variable = %d\n"
fmtChild2_error:
        .string "child2(): UNEXPECTED!: r14 == 0 && r15 == 0; loop-variable = %d\n"



        /* read-write data */
        .data
        .balign 8
tid1:
        .quad   0
tid2:
        .quad   0


        .balign 64
value_x:
        .quad   0
        .space 64-8             /* padding for different cache-lines */

value_y:
        .quad   0
        .space 64-8             /* padding for different cache-lines */

result_r14:
        .quad   1
        .space 64-8             /* padding for different cache-lines */

result_r15:
        .quad   1
        .space 64-8             /* padding for different cache-lines */

sync_counter:
        .quad   0

