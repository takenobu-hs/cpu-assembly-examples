
# x86 assembly examples on linux

## Examples
  * [simple main](./100.main)
  * [system call](./110.system_call)
  * [library call](./120.libc_call)
  * [getting time](./200.time)


## How to try

* Assemble

    ```sh
    $ make -f ../Makefile  <sample>
    ```
* Execute

    ```sh
    $ ./<sample>
    ```

* Disassemble

    ```sh
    $ make -f ../Makefile  <sample>.disasm
    ```


## References

* x86
  * [Intel 64 and IA-32 Architectures Software Developer's Manual Combined Volumes 2A, 2B, 2C, and 2D: Instruction Set Reference, A-Z](https://software.intel.com/content/www/us/en/develop/download/intel-64-and-ia-32-architectures-sdm-combined-volumes-2a-2b-2c-and-2d-instruction-set-reference-a-z.html)

* Linux
  * [Linux kernel; arch/x86](https://github.com/torvalds/linux/tree/master/arch/x86)

* glibc
  * [glibc](https://www.gnu.org/software/libc/libc.html)
    * sysdeps/unix/sysv/linux/x86_64

* x86-64 ABI
  * [x86-64 psABI](https://gitlab.com/x86-psABIs/x86-64-ABI)


## Further information

### Calling convention

* System call
  * rax, rdi, rsi, rdx, r10, r8, r9

* Funcation call
  * rdi, rsi, rdx, rcx, r8, r9, (rsp)

* see: glibc's sysdeps/unix/sysv/linux/x86_64/syscall.S

