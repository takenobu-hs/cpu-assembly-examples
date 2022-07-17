/*
 * TLB-miss example for Arm(Armv8 aarch64)/Linux
 *
 *   * Memory accesses within 64Kbyte (16 pages)
 *   * FEW cache-miss occur.
 *
 *   * C-like pseudo-code:
 *
 *         stride = 4096;        // 4096 byte (page size)
 *         wrap   = 0x0f;        // 16 times (pages) - 1
 *
 *         for (i=0; i<100000000; i++) {
 *             load(address);
 *             address = address + ((i & wrap) * stride)
 *         }
 *
 */

        .global main

main:
        /* save fp,lr registers */
        stp     x29, x30, [sp, -16]!


        /* access parameters */
        mov     x13, 4096               /* stride is 4Kbyte (page size) */
        mov     x14, 0x0f               /* wrap for 16 times            */


        /* loop conditions */
        mov     x11, 0                  /* loop variable   */
        ldr     x12, =100000000         /* loop max-number */

L_loop:
        /* calc address */
        and     x0, x11, x14            /*  i & wrap           */
        mul     x0, x0, x13             /* (i % wrap) x stride */

        adr     x10, work_area
        add     x10, x10, x0

        /* cache access (simple load) */
        ldr     x1, [x10]               /* x1 = load(x10) */

        /* increment the loop-variable and loop-back */
        add     x11, x11, 1
        cmp     x11, x12
        blt     L_loop


        /* print the last loop-variable */
        adr     x0, fmt                 /* 1st argument for printf */
        mov     x1, x11                 /* 2nd argument */
        bl      printf



        /* restore fp,lr registers and return from main*/
        ldp     x29, x30, [sp], 16
        ret


        /* read-only data */
        .section .rodata
fmt:
        .string "loop-variable = %d\n"


        .balign 8
work_area:
        .skip 0x8000000

dummy_tail:
        .quad   0
