/*
 * Control-flow example for x86/Linux
 *
 *   * `call` and `ret` structure example
 *
 *   * C-like pseudo-code:
 *       void main() {
 *         func_inc(100);
 *       }
 *
 *       int func_inc(int rax) {
 *           return (rax++);
 *       }
 */

        .intel_syntax noprefix
        .global main

main:
        /* call */
        mov     rax, 100                /* passing 1st argument with rax */
        call    func_inc                /* return value into rax */


        /* printf for result-checking */
        lea     rdi, [rip + fmt]        /* 1st argument for printf */
        mov     rsi, rax                /* 2nd argument */
        mov     rax, 0                  /* the number of vector regsters */
        call    printf

        /* return from main */
        ret


        /* function declaration */
func_inc:
        add     rax, 1                  /* function body */
        ret                             /* return to caller */


        /* read-only data */
        .section .rodata
fmt:
        .string "rax = %d\n"
