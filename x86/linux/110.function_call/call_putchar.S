
.intel_syntax noprefix

.global main

main:
        mov     rdi, 0x41               /* 'A' */
        call    putchar

        mov     rdi, 0x42               /* 'B' */
        call    putchar

        mov     rdi, 'C'
        call    putchar

        mov     rdi, '\n'
        call    putchar

        ret
 
