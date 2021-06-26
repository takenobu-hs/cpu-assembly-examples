
RISC-V (RV64G) assembly examples on linux
=========================================

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
    $ qemu-riscv64 ./<sample>
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

* Step execution with qemu and gdb

    * on first terminal for qemu:

    ```
    $ qemu-riscv64 -g 1234 ./<sample>
    ```

    * on second terminal for gdb:

    ```
    $ riscv64-unknown-linux-gnu-gdb ./<sample>
    (gdb) layout asm
    (gdb) layout regs
    (gdb) target remote localhost:1234
    (gdb) break main
    (gdb) continue
    (gdb) stepi
      :
    (gdb) quit
    ```


## References

* RISC-V
  * [The RISC-V Instruction Set Manual Volume I: Unprivileged ISA](https://riscv.org/technical/specifications/)
  * [RISC-V Assembly Programmer's Manual](https://github.com/riscv/riscv-asm-manual/blob/master/riscv-asm.md)

* Linux
  * [Linux kernel; arch/riscv](https://github.com/torvalds/linux/tree/master/arch/riscv)

* glibc
  * [glibc](https://www.gnu.org/software/libc/libc.html)
    * sysdeps/unix/sysv/linux/riscv

* RISC-V ABI
  * [RISC-V ELF psABI specification](https://github.com/riscv/riscv-elf-psabi-doc/blob/master/riscv-elf.md)

* System call ABI
  * [syscall(2) - Linux manual page](https://man7.org/linux/man-pages/man2/syscall.2.html)

* GCC
  * [GCC online documentation](https://gcc.gnu.org/onlinedocs/)

* GNU assembler and linker
  * [Documentation for binutils](https://sourceware.org/binutils/docs/)


## Further information

### Calling convention

* System call
  * a7, a0, a1, a2, a3, a4, a5  ->  a0, a1

* Funcation call
  * a0, a1, a2, a3, a4, a5, a6, a7  ->  a0, a1

* see:
  * [RISC-V ELF psABI specification](https://github.com/riscv/riscv-elf-psabi-doc/blob/master/riscv-elf.md)
  * glibc's sysdeps/unix/sysv/linux/riscv/syscall.c

### Tool installation on ubuntu (x86)

* Cross assembler (RISC-V GNU Compiler Toolchain)

    Build with https://github.com/riscv/riscv-gnu-toolchain

* QEMU User space emulator

    ```
    apt install qemu-user
    ```
