/*
 * System-call example for Arm(Armv8 aarch64)/Linux
 *
 *   * exit(2) system-call
 */

.global main

main:
        mov     x8, 0x5d                /* exit() */
        mov     x0, 0                   /* status: success */
        svc     0
