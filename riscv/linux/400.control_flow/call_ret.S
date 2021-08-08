/*
 * Control-flow example for RISC-V(RV64)/Linux
 *
 *   * `call` and `ret` structure example
 *
 *   * C-like pseudo-code:
 *       void main() {
 *         func_inc(100);
 *       }
 *
 *       int func_inc(int a0) {
 *           return (a0++);
 *       }
 */

        .global main

main:
        /* save ra(return address) and sp(stack pointer) */
        addi    sp,sp,-16
        sd      ra,8(sp)
        sd      s0,0(sp)


        /* call */
        li      a0, 100                 /* passing 1st argument with x0 */
        jal     func_inc                /* call */
        mv      t0, a0                  /* preserve return value (x0) */


        /* printf for result-checking */
        la      a0, fmt                 /* 1st argument for printf */
        mv      a1, t0                  /* 2nd argument */
        jal     printf    

        /* restore ra(return address) and sp(stack pointer) */
        ld      ra,8(sp)
        ld      s0,0(sp)
        addi    sp,sp,16

        /* return from main */
        ret


        /* function declaration */
func_inc:
        add     a0, a0, 1               /* function body */
        ret                             /* return to caller */


        /* read-only data */
        .section .rodata
fmt:
        .string "a0 = %d\n"
