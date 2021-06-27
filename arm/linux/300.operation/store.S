/*
 * Operation example for Arm(Armv8 aarch64)/Linux
 *
 *   * store operation
 */

        .global main

main:
        /* save fp,lr registers */
        stp     x29, x30, [sp, -16]!


        /* Store operation */
        adr     x10, memory_buf
        mov     x11, 0x3210                     /* set 64-bit immediate */
        movk    x11, 0x7654, lsl 16
        movk    x11, 0xba98, lsl 32
        movk    x11, 0xfedc, lsl 48
        str     x11, [x10]                      /* store (64 bits) */


        /* Load operation for result-checking*/
        ldr     x12, [x10]                      /* load (64 bits) */

        /* printf for result-checking */
        adr     x0, fmt                 /* 1st argument for printf*/
        mov     x1, x12                 /* 2nd argument for printf*/
        bl      printf    


        /* restore fp,lr registers and return from main*/
        ldp     x29, x30, [sp], 16
        ret


        /* read-only data */
        .section .rodata
fmt:
        .string "memory_buf = %016llx\n"        /* %llx for long long hex */


        /* read-write initialized data */
        .data
        .balign 8
memory_buf:
        .quad   0
