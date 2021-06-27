/*
 * Operation example for Arm(Armv8 aarch64)/Linux
 *
 *   * load operation
 */

        .global main

main:
        /* save fp,lr registers */
        stp     x29, x30, [sp, -16]!


        /* Load operation */
        adr     x10, byte_array
        ldr     x11, [x10]                      /* load (64 bits) */


        /* printf for result-checking */
        adr     x0, fmt                 /* 1st argument for printf*/
        mov     x1, x11                 /* 2nd argument for printf*/
        bl      printf    


        /* restore fp,lr registers and return from main*/
        ldp     x29, x30, [sp], 16
        ret


        /* read-only data */
        .section .rodata
        .balign 8
fmt:
        .string "byte_array = %llx\n"           /* %llx for long long hex */

byte_array:
        .quad   0xfedcba9876543210
