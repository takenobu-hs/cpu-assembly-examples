/*
 * Memory ordeirng example for Arm(Armv8 aarch64)/Linux
 *
 *   * memory ordering operations.
 *     * data memory barrier (dmb)
 *     * data synchronization barrier (dsb)
 *     * instruction synchronization barrier (isb)
 *
 *   * see: Arm Architecture Reference Manual Armv8, for Armv8-A
 *          architecture profile,
 *          Chapter B2 The AArch64 Application Level Memory Model
 *          Appendix K11 Barrier Litmus Tests
 */

        .global main

main:
        /* data memory barrier */
        dmb     ld      /* load barrier */

        dmb     st      /* store barrier */

        dmb     sy      /* load/store barrier */


        /* data synchronization barrier */
        dsb     sy


        /* instruction synchronization barrier  */
        isb


        /* return from main */
        ret
