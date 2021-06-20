/*
 * Getting time-information (year, month, day, hour, min, sec) for x86/Linux
 *
 *   * Read real-time clock(RTC) with io-port 70,71
 *   * Execute with sudo for ioperm
 *   * RTS is coded with BCD(binary-coded decimal)
 *   * see: linux-kernel's arch/x86/kernel/rtc.c
 */

.intel_syntax noprefix

.global main

main:

        /* ioperm */
        mov     rdi, 0x70
        mov     rsi, 2
        mov     rdx, 1
        call    ioperm                  /* see; man ioperm(2) */


        /* read rtc for date */
        mov     al, 9                   /* RTC_YEAR */
        out     0x70, al                /* write rtc */
  	in      al, 0x71                /* read rtc */
        mov     rsi, rax                /* 2nd arg for printf */

        mov     al, 8                   /* RTC_MONTH */
        out     0x70, al                /* write rtc */
  	in      al, 0x71                /* read rtc */
        mov     rdx, rax                /* 3rd arg for printf */

        mov     al, 7                   /* RTC_DAY_OF_MONTH */
        out     0x70, al                /* write rtc */
  	in      al, 0x71                /* read rtc */
        mov     rcx, rax                /* 4th arg for printf */

        /* print */
        lea     rdi, [rip + fmt_date]   /* 1st argument for printf */
  	mov	rax, 0                  /* the number of vector regsters */
        call    printf


        /* read rtc for time */
        mov     al, 4                   /* RTC_HOURS */
        out     0x70, al                /* write rtc */
  	in      al, 0x71                /* read rtc */
        mov     rsi, rax                /* 2nd arg for printf */

        mov     al, 2                   /* RTC_MINUTES */
        out     0x70, al                /* write rtc */
  	in      al, 0x71                /* read rtc */
        mov     rdx, rax                /* 3rd arg for printf */

        mov     al, 0                   /* RTC_SECONDS */
        out     0x70, al                /* write rtc */
  	in      al, 0x71                /* read rtc */
        mov     rcx, rax                /* 4th arg for printf */

        /* print */
        lea     rdi, [rip + fmt_time]   /* 1st argument for printf */
  	mov	rax, 0                  /* the number of vector regsters */
        call    printf


        /* exit */
        ret


fmt_date:
        .string "year-month-day = %02x - %02x - %02x\n"

fmt_time:
        .string "hour:min:sec   = %02x : %02x : %02x\n"
