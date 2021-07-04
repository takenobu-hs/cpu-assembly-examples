/*
 * Control-flow example for Arm(Armv8 aarch64)/Linux
 *
 *   * `call` and `ret` structure example
 *
 *   * C-like pseudo-code:
 *       void main() {
 *         func_inc(100);
 *       }
 *
 *       int func_inc(int x0) {
 *           return (x0++);
 *       }
 */

        .global main

main:
        /* save fp,lr registers */
        stp     x29, x30, [sp, -16]!


        /* call */
        mov     x0, 100                 /* passing 1st argument with x0 */
        bl      func_inc                /* call */
        mov     x11, x0                 /* preserve return value (x0) */


        /* printf for result-checking */
        adr     x0, fmt                 /* 1st argument for printf */
        mov     x1, x11                 /* 2nd argument */
        bl      printf    

        /* restore fp,lr registers and return from main*/
        ldp     x29, x30, [sp], 16
        ret


        /* function declaration */
func_inc:
        add     x0, x0, 1               /* function body */
        ret                             /* return to caller */


        /* read-only data */
        .section .rodata
fmt:
        .string "x0 = %d\n"
