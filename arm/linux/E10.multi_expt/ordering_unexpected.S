/*
 * Memory-ordering example for Arm(Armv8 aarch64)/Linux
 *
 *   * Store and load to different variables on two threads
 *   * Without memory-ordering instruction version
 *
 *   * C-like pseudo-code:
 *
 *     * child1-thread:
 *         for (i=0; i<5000000; i++) {
 *             value_x    = 1;
 *             result_x14 = value_y;
 *
 *             error check for (result_x14 == 0) && (result_x15 == 0);
 *             value_y = 0;
 *         }
 *
 *     * child2-thread:
 *         for (i=0; i<5000000; i++) {
 *             value_y    = 1;
 *             result_x15 = value_x;
 *
 *             error check for (result_x14 == 0) && (result_x15 == 0);
 *             value_x = 0;
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


L1_loop:
        /* store and load accesses */
        mov     x0, 1
        adr     x10, value_x
        str     x0, [x10]               /* value_x = 1   */
        adr     x10, value_y
        ldr     x14, [x10]              /* x14 = value_y */


        /* store x14 for error check */
        adr     x10, result_x14
        str     x14, [x10]

        /* 1st sync (wait until sync_counter % 4 == 2) */
        adr     x10, sync_counter
L1_loop_counter1:
        ldxr    x1, [x10]
        add     x1, x1, 1
        stxr    w2, x1, [x10]                   /* sync_counter++ */
        cbnz    w2, L1_loop_counter1

L1_loop_sync1:
        ldr     x3, [x10]
        and     x3, x3, 2
        cbz     x3, L1_loop_sync1

        /* error check */
        dmb     sy
        adr     x10, result_x15
        ldr     x0, [x10]
        orr     x14, x14, x0
        cbz     x14, L1_error           /* if (x14 == 0 && x15 == 0) error */

        /* re-initialize */
        mov     x0, 0
        adr     x10, value_x
        str     x0, [x10]               /* value_x = 0   */
        dmb     sy

        /* 2nd sync (wait until sync_counter % 4 == 0) */
        adr     x10, sync_counter
L1_loop_counter2:
        ldxr    x1, [x10]
        add     x1, x1, 1
        stxr    w2, x1, [x10]                   /* sync_counter++ */
        cbnz    w2, L1_loop_counter2

L1_loop_sync2:
        ldr     x3, [x10]
        and     x3, x3, 2
        cbnz    x3, L1_loop_sync2

        /* increment the loop-variable and loop-back */
        add     x11, x11, 1
        cmp     x11, x12
        blt     L1_loop


        /* print the last loop-variable */
        adr     x0, fmtChild1_finish
        mov     x1, x11
        bl      printf

        /* finish this thead */
        mov     x0, 0                   /* return value (not used) */
        ldp     x29, x30, [sp], 16
        ret


L1_error:
        /* print the last loop-variable */
        adr     x0, fmtChild1_error
        mov     x1, x11
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


L2_loop:
        /* store and load accesses */
        mov     x0, 1
        adr     x10, value_y
        str     x0, [x10]               /* value_y = 1   */
        adr     x10, value_x
        ldr     x15, [x10]              /* x15 = value_x */


        /* store x15 for error check */
        adr     x10, result_x15
        str     x15, [x10]

        /* 1st sync (wait until sync_counter % 4 == 2) */
        adr     x10, sync_counter
L2_loop_counter1:
        ldxr    x1, [x10]
        add     x1, x1, 1
        stxr    w2, x1, [x10]                   /* sync_counter++ */
        cbnz    w2, L2_loop_counter1

L2_loop_sync1:
        ldr     x3, [x10]
        and     x3, x3, 2
        cbz     x3, L2_loop_sync1

        /* error check */
        dmb     sy
        adr     x10, result_x14
        ldr     x0, [x10]
        orr     x15, x15, x0
        cbz     x15, L2_error           /* if (x14 == 0 && x15 == 0) error */

        /* re-initialize */
        mov     x0, 0
        adr     x10, value_y
        str     x0, [x10]               /* value_y = 0   */
        dmb     sy

        /* 2nd sync (wait until sync_counter % 4 == 0) */
        adr     x10, sync_counter
L2_loop_counter2:
        ldxr    x1, [x10]
        add     x1, x1, 1
        stxr    w2, x1, [x10]                   /* sync_counter++ */
        cbnz    w2, L2_loop_counter2

L2_loop_sync2:
        ldr     x3, [x10]
        and     x3, x3, 2
        cbnz    x3, L2_loop_sync2

        /* increment the loop-variable and loop-back */
        add     x11, x11, 1
        cmp     x11, x12
        blt     L2_loop


        /* print the last loop-variable */
        adr     x0, fmtChild2_finish
        mov     x1, x11
        bl      printf

        /* finish this thead */
        mov     x0, 0                   /* return value (not used) */
        ldp     x29, x30, [sp], 16
        ret


L2_error:
        /* print the last loop-variable */
        adr     x0, fmtChild2_error
        mov     x1, x11
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
        .string "main(): finish"

fmtChild1_start:
        .string "child1(): start"
fmtChild1_finish:
        .string "child1(): finish: loop-variable = %d\n"
fmtChild1_error:
        .string "child1(): UNEXPECTED!: x14 == 0 && x15 == 0; loop-variable = %d\n"

fmtChild2_start:
        .string "child2(): start"
fmtChild2_finish:
        .string "child2(): finish: loop-variable = %d\n"
fmtChild2_error:
        .string "child2(): UNEXPECTED!: x14 == 0 && x15 == 0; loop-variable = %d\n"



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

result_x14:
        .quad   1
        .space 64-8             /* padding for different cache-lines */

result_x15:
        .quad   1
        .space 64-8             /* padding for different cache-lines */

sync_counter:
        .quad   0

