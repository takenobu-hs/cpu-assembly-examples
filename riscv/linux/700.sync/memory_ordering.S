/*
 * Memory ordeirng example for RISC-V(RV64)/Linux
 *
 *   * memory ordering operations.
 *     * load fence
 *     * store fence
 *     * load/store fence
 *
 *   * see: The RISC-V Instruction Set Manual Volume I: Unprivileged ISA
 *          Appendix A RVWMO Explanatory Material
 */

        .global main

main:
        /* memory fence */
        fence   r,r             /* load - load fence */

        fence   w,w             /* store - store fence */

        fence   rw,rw           /* load/store - load/store fence */


        /* return from main */
        ret
