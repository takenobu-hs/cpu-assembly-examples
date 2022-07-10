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

        .globl  main

main:
        /* puts for trace-log */
        adr     x0, fmtMain_start
        bl      puts


        /* pthread_create() */

        /* for 1st child thread */
        adr     x0, tid1                /* pthread_t: &tid1       */
        mov     x1, 0                   /* pthread_attr_t: NULL   */
        adr     x2, child1              /* start_routine: &child1 */
        mov     x3, 0                   /* arg: NULL              */
        bl      pthread_create

        /* for 2nd child thread */
        adr     x0, tid2                /* pthread_t: &tid2       */
        mov     x1, 0                   /* pthread_attr_t: NULL   */
        adr     x2, child2              /* start_routine: &child2 */
        mov     x3, 0                   /* arg: NULL              */
        bl      pthread_create


        /* pthread_join() */

        /* for 1st child thread */
        adr     x10, tid1
        ldr     x0, [x10]               /* pthread_t: tid1 */
        mov     x1, 0                   /* retval: NULL    */
        bl      pthread_join

        /* for 2nd child thread */
        adr     x10, tid2
        ldr     x0, [x10]               /* pthread_t: tid2 */
        mov     x1, 0                   /* retval: NULL    */
        bl      pthread_join


        /* puts for trace-log */
        adr     x0, fmtMain_finish      /* 1st argument for printf */
        adr     x10, counter
        ldr     x1, [x10]               /* 2nd argument */
        bl      printf

        /* exit from main */
        mov     x0, 0                   /* status: EXIT_SUCCESS */
        bl      exit



        /* 1st child thread */
child1:
        stp     x29, x30, [sp, -16]!

        /* puts for trace-log */
        adr     x0, fmtChild1_start
        bl      puts


        /* loop conditions */
        mov     x11, 0                  /* loop variable   */
        ldr     x12, =5000000           /* loop max-number */

        adr     x10, counter            /* access address */

L1_loop:
        /* increment the shared-counter */
        ldxr    x14, [x10]
        add     x14, x14, 1
        stxr    w2, x14, [x10]
        dmb     sy                      /* to read from cache (not store-buf) */
        cbnz    w2, L1_loop

        /* increment the loop-variable and loop-back */
        add     x11, x11, 1
        cmp     x11, x12
        blt     L1_loop


        /* puts for trace-log */
        adr     x0, fmtChild1_finish    /* 1st argument for printf */
        mov     x1, x11                 /* 2nd argument */
        bl      printf

        /* finish this thead */
        mov     x0, 0                   /* return value (not used) */
        ldp     x29, x30, [sp], 16
        ret



        /* 2nd child thread */
child2:
        stp     x29, x30, [sp, -16]!

        /* puts for trace-log */
        adr     x0, fmtChild2_start
        bl      puts


        /* loop conditions */
        mov     x11, 0                  /* loop variable   */
        ldr     x12, =5000000           /* loop max-number */

        adr     x10, counter            /* access address */

L2_loop:
        /* increment the shared-counter */
        ldxr    x14, [x10]
        add     x14, x14, 1
        stxr    w2, x14, [x10]
        dmb     sy                      /* to read from cache (not store-buf) */
        cbnz    w2, L2_loop

        /* increment the loop-variable and loop-back */
        add     x11, x11, 1
        cmp     x11, x12
        blt     L2_loop


        /* puts for trace-log */
        adr     x0, fmtChild2_finish    /* 1st argument for printf */
        mov     x1, x11                 /* 2nd argument */
        bl      printf

        /* finish this thead */
        mov     x0, 0                   /* return value (not used) */
        ldp     x29, x30, [sp], 16
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
