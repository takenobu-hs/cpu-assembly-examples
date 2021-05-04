
.intel_syntax noprefix

.global main

main:
        lea     rdi, [rip + msg]        /* 1st argument */
        call    puts

        ret
 

msg:	.string "Hello world!\n"
