/*
 * Operation example for Arm(Armv8 aarch64)/Linux
 *
 *   * load operations for each size with zero extension
 *
 *   * 64-bit load with ldr instruction and `x`-register
 *   * 32-bit load with ldr instruction and `w`-register
 *   * 16-bit load with ldrh instruction and `w`-register
 *   * 8-bit  load with ldrb instruction and `w`-register
 */

        .global main

main:
        /* save fp,lr registers */
        stp     x29, x30, [sp, -16]!


        /* Load operation */
        adr     x10, byte_array
        ldr     x11, [x10]                      /* load (64 bits) */
        ldr     w12, [x10]                      /* load (32 bits) */
        ldrh    w13, [x10]                      /* load (16 bits) */
        ldrb    w14, [x10]                      /* load (8 bits) */


        /* printf for result-checking */
        adr     x0, fmt                 /* 1st argument for printf */
        mov     x1, x11                 /* 2nd argument */
        mov     x2, x12                 /* 3rd argument */
        mov     x3, x13                 /* 4th argument */
        mov     x4, x14                 /* 5th argument */
        bl      printf    


        /* restore fp,lr registers and return from main*/
        ldp     x29, x30, [sp], 16
        ret


        /* read-only data */
        .section .rodata
        .balign 8
fmt:
        .string "x11, x12, x13, x14 = \n%016llx\n%016llx\n%016llx\n%016llx\n"

byte_array:
        .quad   0xfedcba9876543210
