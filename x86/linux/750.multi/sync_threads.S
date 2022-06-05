/*
 * Sync threads example for x86/Linux
 *
 *   * Threads
 *      * main:   a main thread
 *      * child1: 1st child thread (set the sync_flag for 2nd thread)
 *      * child2: 2nd child thread (wait 1st thread via the sync_flag)
 *
 *   * see:
 *     * man pthread_create
 *     * x86-64 ABI (https://gitlab.com/x86-psABIs/x86-64-ABI)
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

        /* wait your key-in */
        lea     rdi, [rip + fmtChild1_prompt]
        call    puts
        call    getchar


        /* set the sync-flag to 1 */
        mov     eax, 1
        mov     [rip + sync_flag], rax


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


        /* wait 1st thread via the sync_flag */
loop:
        mov     rax, [rip + sync_flag]
        cmp     rax, 0
        je      loop


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
