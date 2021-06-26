
Arm (Armv8 aarch64) assembly examples on linux
==============================================

## Examples
  * [simple main](./100.main)  (./100.main)
  * [system call](./110.system_call) (./110.system_call)
  * [library call](./120.libc_call) (./120.libc_call)
  * [basic operations](./300.operation) (./300.operation)


## How to try

* Assemble (generate binary)

    ```
    $ make -f ../Makefile  <sample>
    ```

* Execute

    ```
    $ ./<sample>
    or
    $ qemu-aarch64 ./<sample>
    ```

* Disassemble (for full object)

    ```
    $ make -f ../Makefile  <sample>.disasm  | less
    (search "main>" in `less` command)
    ```

* Disassemble (for .S only)

    ```
    $ make -f ../Makefile  <sample>.o.disasm
    ```

* Step execution with gdb

    ```
    $ make -f ../Makefile  <sample>
    $ gdb ./<sample>
    (gdb) layout asm
    (gdb) layout regs
    (gdb) break main
    (gdb) run
    (gdb) stepi
      :
    (gdb) quit
    ```

* Step execution with qemu and gdb

    * on first terminal for qemu:

    ```
    $ qemu-aarch64 -g 1234 ./<sample>
    ```

    * on second terminal for gdb:

    ```
    $ gdb-multiarch -ex "target remote localhost:1234" ./<sample>
    (gdb) layout asm
    (gdb) layout regs
    (gdb) break main
    (gdb) continue
    (gdb) stepi
      :
    (gdb) quit
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

* GCC
  * [GCC online documentation](https://gcc.gnu.org/onlinedocs/)

* GNU assembler and linker
  * [Documentation for binutils](https://sourceware.org/binutils/docs/)

* GDB
  * [GDB Documentation](https://www.gnu.org/software/gdb/documentation/)

* QEMU
  * [QEMU User space emulator](https://qemu-project.gitlab.io/qemu/user/main.html)


## Further information

### Calling convention

* System call
  * x8, x0, x1, x2, x3, x4, x5  ->  x0, x1

* Funcation call
  * x0, x1, x2, x3, x4, x5, x6, x7  ->  x0, x1

* see:
  * [Application Binary Interface (ABI)](https://developer.arm.com/architectures/system-architectures/software-standards/abi)
  * glibc's sysdeps/unix/sysv/linux/aarch64/syscall.S

### Tool installation on ubuntu (x86)

* Cross assembler (GNU Compiler Toolchain)

    ```
    apt install g++-aarch64-linux-gnu
    ```

* QEMU User space emulator

    ```
    apt install qemu-user
    ```

* Cross debugger

    ```
    apt install gdb-multiarch
    ```
