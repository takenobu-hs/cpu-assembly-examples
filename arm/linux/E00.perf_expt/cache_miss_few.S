/*
 * Cache-miss example for Arm(Armv8 aarch64)/Linux
 *
 *   * Cache accesses with 64-byte (line-size) stride.
 *   * FEW cache-miss occur.
 *
 *   * C-like pseudo-code:
 *
 *         stride = 64;
 *         wrap   = 0x1f;  // 32times - 1
 *
 *         for (i=0; i<10000000; i++) {
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
        mov     x13, 64         /* stride is 64byte (cache-line size)   */
        mov     x14, 0x1f       /* wrap for 32 times                    */


        /* loop conditions */
        mov     x11, 0                  /* loop variable   */
        ldr     x12, =10000000          /* loop max-number */

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
        .skip 0x40000

dummy_tail:
        .quad   0
