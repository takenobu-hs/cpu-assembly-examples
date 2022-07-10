/*
 * Simultaneous-access example for Arm(Armv8 aarch64)/Linux
 *
 *   * without "false sharing"
 *   * Stores to different variables from two threads
 *   * DIFFERENT cache-line version (FAST)
 *
 *   * C-like pseudo-code:
 *
 *     * child1-thread:
 *         for (i=0; i<5000000; i++) {
 *             store to value1;
 *             memory_fence;            // flush store-buffers
 *             load from value1;
 *         }
 *
 *     * child2-thread:
 *         for (i=0; i<5000000; i++) {
 *             store to value2;
 *             memory_fence;            // flush store-buffers
 *             load from value2;
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
        adr     x0, fmtMain_finish
        bl      puts

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

        mov     x13, 1                  /* dummy-data for store */
        adr     x10, value1             /* access address */

L1_loop:
        /* cache access */
        str     x13, [x10]
        dmb     sy
        ldr     x14, [x10]              /* measure here */

        /* increment the loop-variable and loop-back */
        add     x11, x11, 1
        cmp     x11, x12
        blt     L1_loop


        /* puts for trace-log */
        adr     x0, fmtChild1_finish
        bl      puts

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

        mov     x13, 1                  /* dummy-data for store */
        adr     x10, value2             /* access address */

L2_loop:
        /* cache access */
        str     x13, [x10]
        dmb     sy
        ldr     x14, [x10]              /* measure here */

        /* increment the loop-variable and loop-back */
        add     x11, x11, 1
        cmp     x11, x12
        blt     L2_loop


        /* puts for trace-log */
        adr     x0, fmtChild2_finish
        bl      puts

        /* finish this thead */
        mov     x0, 0                   /* return value (not used) */
        ldp     x29, x30, [sp], 16
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

padding:
        .space 64               /* padding for different cache-lines */

value2:
        .quad   0
