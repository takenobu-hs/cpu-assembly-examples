/*
 * Getting time-information (seconds since the Epoch) for x86/Linux
 *
 *   * time(2) system-call
 *   * see: man 2 time
 *   * see: linux-kernel's arch/x86/entry/syscalls/syscall_64.tbl
 *   * see: x86-64 ABI (https://gitlab.com/x86-psABIs/x86-64-ABI)
 */

        .intel_syntax noprefix
        .global main

main:
        /* time(2) system-call */
        mov     rax, 201                /* system-call number: time() */
        mov     rdi, 0                  /* tloc: null */
        syscall                         /* get seconds into rax */


        /* printf for result-checking */
        lea     rdi, [rip + fmt]        /* 1st argument for printf */
        mov     rsi, rax                /* 2nd argument for printf */
        mov     rax, 0                  /* the number of vector regsters */
        call    printf


        /* return from main */
        ret


        /* read-only data */
        .section .rodata
fmt:
        .string "seconds since the Epoch = %d\n"
