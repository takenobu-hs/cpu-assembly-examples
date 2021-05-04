
.intel_syntax noprefix

.global main

main:
        lea     rdi, [rip + msg]        /* 1st argument */
  	mov	rax, 0                  /* the number of vector regsters */

        call    printf

        ret
 
msg:	.string "Hello world!\n"
