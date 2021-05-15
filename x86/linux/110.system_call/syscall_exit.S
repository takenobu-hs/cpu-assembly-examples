
.intel_syntax noprefix

.global main

main:
        mov     rax, 60                 /* exit() */
        mov     rdi, 0                  /* status: success */
        syscall
 
