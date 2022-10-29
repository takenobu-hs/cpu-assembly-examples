/*
 * Weak-memory-ordering example for Arm(Armv8 aarch64)/Linux
 *
 *   * Access to two varialbes (req and info)
 *   * Without memory-ordering instruction version
 *
 *   * C-like pseudo-code:
 *
 *     * child1-thread:
 *         for (i=0; i<50000000; i++) {
 *             info = 0xcafe;
 *             req  = 1;
 *
 *             // 1st-sync to prepare next loop
 *             req  = 0;
 *             info = 0xbad;
 *             // 2nd-sync to prepare next loop
 *         }
 *
 *     * child2-thread:
 *         for (i=0; i<50000000; i++) {
 *             load req;
 *             load info;
 *             if (req == 1 && info != 0xcafe) goto error;
 *
 *             // 1st-sync to prepare next loop
 *             // 2nd-sync to prepare next loop
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
        ldr     x12, =50000000          /* loop max-number */

        mov     x0, 0                   /* valid-value for req */
        mov     x1, 1                   /* invalid-value for req */
        mov     x2, 0xcafe              /* valid-data for info */
        mov     x3, 0xbad               /* invalid-data for info */
        adr     x13, req                /* req        */
        adr     x14, info               /* infomation */


L1_loop:
        /* artificial wait for x14 */
        sdiv    x4, x0, x4
        add     x14, x14, x4            /* data dependency with next str */

        /* store to two addresses (req and info) */
        str     x2, [x14]               /* info = 0xcafe */
        str     x1, [x13]               /* req = 1       */


        /* 1st sync (wait until sync_counter % 4 == 2) */
        adr     x10, sync_counter
L1_loop_counter1:
        ldxr    x5, [x10]
        add     x5, x5, 1
        stxr    w6, x5, [x10]           /* sync_counter++ */
        cbnz    w6, L1_loop_counter1

L1_loop_sync1:
        adr     x6, is_error
        ldr     x5, [x6]
        cmp     x5, 1
        beq     L1_finish               /* if (child2_error) goto L1_finish */

        ldr     x5, [x10]
        and     x5, x5, 2
        cbz     x5, L1_loop_sync1

        /* re-initialize */
        str     x0, [x13]               /* req = 0       */
        str     x3, [x14]               /* info = 0xbad  */
        dmb     sy

        /* 2nd sync (wait until sync_counter % 4 == 0) */
        adr     x10, sync_counter
L1_loop_counter2:
        ldxr    x5, [x10]
        add     x5, x5, 1
        stxr    w6, x5, [x10]           /* sync_counter++ */
        cbnz    w6, L1_loop_counter2

L1_loop_sync2:
        ldr     x5, [x10]
        and     x5, x5, 2
        cbnz    x5, L1_loop_sync2

        /* increment the loop-variable and loop-back */
        add     x11, x11, 1
        cmp     x11, x12
        blt     L1_loop


        /* print the last loop-variable */
        adr     x0, fmtChild1_finish
        mov     x1, x11
        bl      printf

L1_finish:
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
        ldr     x12, =50000000          /* loop max-number */

        mov     x0, 0                   /* zero */
        mov     x2, 0xcafe              /* valid-data for info */
        adr     x13, req                /* req         */
        adr     x14, info               /* infomation  */


L2_loop:
        /* artificial wait for x13 */
        sdiv    x4, x0, x4
        add     x13, x13, x4            /* data dependency with next ldr */

        /* load from two addresses (req and info) */
        ldr     x9,  [x13]              /* load the req */
        ldr     x10, [x14]              /* load the info */

        /* if (req != 1) continue */
        cmp     x9, 1
        bne     L2_continue

        /* if (req == 1 && info != 0xcafe) goto L2_error */
        cmp     x10, x2
        bne     L2_error

L2_continue:

        /* 1st sync (wait until sync_counter % 4 == 2) */
        adr     x10, sync_counter
L2_loop_counter1:
        ldxr    x5, [x10]
        add     x5, x5, 1
        stxr    w6, x5, [x10]           /* sync_counter++ */
        cbnz    w6, L2_loop_counter1

L2_loop_sync1:
        ldr     x5, [x10]
        and     x5, x5, 2
        cbz     x5, L2_loop_sync1


        /* 2nd sync (wait until sync_counter % 4 == 0) */
        adr     x10, sync_counter
L2_loop_counter2:
        ldxr    x5, [x10]
        add     x5, x5, 1
        stxr    w6, x5, [x10]           /* sync_counter++ */
        cbnz    w6, L2_loop_counter2

L2_loop_sync2:
        ldr     x5, [x10]
        and     x5, x5, 2
        cbnz    x5, L2_loop_sync2

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


        /* error due to condition (req == 1 && info != 0xcafe) */
L2_error:
        adr     x0, fmtChild2_error
        mov     x1, x9
        mov     x2, x10
        mov     x3, x11
        bl      printf

        /* set error condition to finish child1 */
        mov     x1, 1
        adr     x10, is_error
        str     x1, [x10]               /* is_error = 1 */

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

fmtChild2_start:
        .string "child2(): start"
fmtChild2_finish:
        .string "child2(): finish: loop-variable = %d\n"
fmtChild2_error:
        .string "child2(): UNEXPECTED!: req = 0x%x, info = 0x%x,  loop-variable = %d\n"



        /* read-write data */
        .data
        .balign 8
tid1:
        .quad   0
tid2:
        .quad   0


        .balign 64
info:
        .quad   0xbad
        .space 64-8             /* padding for different cache-lines */

req:
        .quad   0
        .space 64-8             /* padding for different cache-lines */


sync_counter:
        .quad   0
        .space 64-8             /* padding for different cache-lines */

is_error:
        .quad   0

