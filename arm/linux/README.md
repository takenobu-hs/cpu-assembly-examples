
Arm (Armv8 aarch64) assembly examples on linux
==============================================

## Examples
  * [simple main](./100.main)
  * [system call](./110.system_call)
  * [library call](./120.libc_call)


## How to try

* Assemble

    ```sh
    $ make -f ../Makefile  <sample>
    ```
* Execute

    ```sh
    $ ./<sample>
    or
    $ qemu-aarch64 ./<sample>
    ```

* Disassemble

    ```sh
    $ make -f ../Makefile  <sample>.disasm
    ```


## References

* Arm (Armv8)
  * [Arm Architecture Reference Manual Armv8, for Armv8-A architecture profile](https://developer.arm.com/documentation/ddi0487/latest/)

* Linux
  * [Linux kernel; arch/arm64](https://github.com/torvalds/linux/tree/master/arch/arm64)

* glibc
  * [glibc](https://www.gnu.org/software/libc/libc.html)
    * sysdeps/unix/sysv/linux/aarch64

* ABI for the Arm 64-bit Architecture
  * [Application Binary Interface (ABI)](https://developer.arm.com/architectures/system-architectures/software-standards/abi)

* System call ABI
  * [syscall(2) - Linux manual page](https://man7.org/linux/man-pages/man2/syscall.2.html)


## Further information

### Calling convention

* System call
  * x8, x0, x1, x2, x3, x4, x5, x6

* Funcation call
  * x0, x1, x2, x3, x4, x5, x6, x7

* see:
  * [Application Binary Interface (ABI)](https://developer.arm.com/architectures/system-architectures/software-standards/abi)
  * glibc's sysdeps/unix/sysv/linux/aarch64/syscall.S
