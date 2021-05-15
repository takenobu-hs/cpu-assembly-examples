/*
 * read real-time clock with io-port 70,71
 *
 *   * Run on sudo for ioperm
 *   * rts is coded with BCD(binary-coded decimal)
 *   * see: linux-kernel's arch/x86/kernel/rtc.c
 *
 */


.intel_syntax noprefix

.global main

main:

        /* ioperm */
        mov     rdi, 0x70
        mov     rsi, 2
        mov     rdx, 1
        call    ioperm                  /* see; man 2 ioperm() */


        /* read rtc */
        mov     al, 0                   /* RTC_SECONDS */
        out     0x70, al                /* write rtc */
  	in      al, 0x71                /* read rtc */
        mov     rsi, rax

        lea     rdi, [rip + fmt]        /* 1st argument for printf */
  	mov	rax, 0                  /* the number of vector regsters */
        call    printf

        ret
 
fmt:	.string "rtc seconds = %02x\n"
