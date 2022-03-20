/*
 * An atomic counter example for Arm(Armv8 aarch64)/Linux
 *
 *   * swap instruction
 *
 *   * C-like pseudo-code:
           // acquire the lock
 *         x2 = 1;
 *       L_loop:
 *         x0 = *lock;
 *         *lock = x2;
 *         if (x0 != 0) goto L_loop;
 *
 *         // increment the counter
 *         x1 = *counter;
 *         x1 = x1 + 1;
 *         *counter = x1;
 *
 *         // release the lock
 *         x1 = 0;
 *         *lock = x1;

 */

        .global main

main:
        /* save fp,lr registers for printf */
        stp     x29, x30, [sp, -16]!



        /* set addresses of the lock and the counter */
        adr     x11, lock
        adr     x10, counter


        /* acquire the lock */
        mov     x2, 1                           /* x2 = 1                  */
L_loop:
        swp     x2, x0, [x11]                   /* x0 = *lock; *lock = x2  */
        cbnz    x0, L_loop                      /* if (x0 !=0) goto L_loop */

        /* increment the counter */
        ldr     x1, [x10]                       /* x1 = *counter           */
        add     x1, x1, 1                       /* x1 = x1 + 1             */
        str     x1, [x10]                       /* *counter = x1           */

        /* release the lock */
        mov     x1, 0                           /* x1 = 0                  */
        str     x1, [x11]                       /* *lock = x1              */



        /* printf for result-checking */
        adr     x0, fmt                 /* 1st argument for printf */
        ldr     x1, [x10]               /* 2nd argument */
        bl      printf    


        /* restore fp,lr registers and return from main */
        ldp     x29, x30, [sp], 16
        ret


        /* read-only data */
        .section .rodata
fmt:
        .string "x0 = %d\n"


        /* read-write initialized data */
        .data
        .balign 8
lock:
        .quad   0
counter:
        .quad   0
