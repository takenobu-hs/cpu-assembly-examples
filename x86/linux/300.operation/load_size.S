/*
 * Operation example for x86/Linux
 *
 *   * load operations for each size with zero extension
 *
 *   * 64-bit load with mov instruction
 *   * 32-bit load with mov instruction and `d`word-register
 *   * 16-bit load with movzx instruction and `word ptr`
 *   * 8-bit  load with movzx instruction and `byte ptr`
 */

        .intel_syntax noprefix
        .global main

main:
        sub     rsp, 8                  /* 16-byte alignment */


        /* Load operation */
        mov     r11,  [rip + byte_array]                /* load (64 bits) */
        mov     r12d, [rip + byte_array]                /* load (32 bits) */
        movzx   r13 , word ptr [rip + byte_array]       /* load (16 bits) */
        movzx   r14 , byte ptr [rip + byte_array]       /* load (8 bits) */


        /* printf for result-checking */
        lea     rdi, [rip + fmt]        /* 1st argument for printf */
        mov     rsi, r11                /* 2nd argument */
        mov     rdx, r12                /* 3nd argument */
        mov     rcx, r13                /* 4nd argument */
        mov     r8 , r14                /* 5nd argument */
        mov     eax, 0                  /* the number of vector regsters */
        call    printf


        /* return from main */
        add     rsp, 8                  /* 16-byte alignment */
        ret


        /* read-only data */
        .section .rodata
        .balign 8
fmt:
        .string "r11, r12, r13, r14 = \n%016llx\n%016llx\n%016llx\n%016llx\n"

byte_array:
        .quad   0xfedcba9876543210
