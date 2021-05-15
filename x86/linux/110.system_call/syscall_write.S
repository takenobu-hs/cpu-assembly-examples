
.intel_syntax noprefix

.global main

main:
        mov     rax, 1                  /* write() */
        mov     rdi, 1                  /* fd: stdout */
        lea     rsi, [rip + msg]        /* buf: */
        mov     rdx, 13                 /* count: */

        syscall
        ret
 
msg:
        .ascii "Hello world!\n"
