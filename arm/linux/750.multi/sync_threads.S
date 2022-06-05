/*
 * Sync threads example for Arm(Armv8 aarch64)/Linux
 *
 *   * Threads
 *      * main:  a main thread
 *      * child1: 1st child thread (set the sync_flag for 2nd thread)
 *      * child2: 2nd child thread (wait 1st thread via the sync_flag)
 *
 *   * see:
 *     * man pthread_create
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
        bl    exit




        /* 1st child thread */
child1:
        stp     x29, x30, [sp, -16]!

        /* puts for trace-log */
        adr     x0, fmtChild1_start
        bl      puts

        /* wait your key-in */
        adr     x0, fmtChild1_prompt
        bl      puts
        bl      getchar


        /* set the sync-flag to 1 */
        mov     x0, 1
        adr     x10, sync_flag
        str     x0, [x10]


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


        /* wait 1st thread via the sync_flag */
L_loop:
        adr     x10, sync_flag
        ldr     x0, [x10]
        cbz     x0, L_loop


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
fmtChild1_prompt:
        .string "child1(): enter key:"
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

sync_flag:
        .quad   0
