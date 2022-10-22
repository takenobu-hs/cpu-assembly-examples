/*
 * Exception example for Arm(Armv8 aarch64)/Linux
 *
 *   * Page fault exception
 *
 */

        .global main

main:
        mov     x10, 0
        ldr     x1, [x10]               /* x1 = load(x10) */

        ret
