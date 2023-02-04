
x86 assembly examples on linux
==============================

## Examples
  * [simple main](./100.main)  (./100.main)
  * [system call](./110.system_call) (./110.system_call)
  * [library call](./120.libc_call) (./120.libc_call)
  * [getting time](./200.time) (./200.time)
  * [basic operations](./300.operation) (./300.operation)
  * [control flow](./400.control_flow) (./400.control_flow)
  * [sync](./700.sync) (./700.sync), [sync_parts](./710.sync_parts) (./710.sync_parts)
  * [multi-threads](./750.multi) (./750.multi)


## Experiments
  * [data-dependency, branch, cache, virtual-memory](./E00.perf_expt) (./E00.perf_expt)
  * [i/o, syscall/exception](./E05.sys_expt) (./E05.sys_expt)
  * [coherence, memory-ordering, atomic](./E10.multi_expt) (./E10.multi_expt)


## How to try

* Assemble (generate binary)

    ```
    $ make -f ../Makefile  <sample>
    ```

* Execute

    ```
    $ ./<sample>
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
    (gdb) set disassembly-flavor intel
    (gdb) layout asm
    (gdb) layout regs
    (gdb) break main
    (gdb) run
    (gdb) stepi
      :
    (gdb) quit
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

* GCC
  * [GCC online documentation](https://gcc.gnu.org/onlinedocs/)

* GNU assembler and linker
  * [Documentation for binutils](https://sourceware.org/binutils/docs/)

* GDB
  * [GDB Documentation](https://www.gnu.org/software/gdb/documentation/)


## Further information

### Calling convention

* System call
  * rax, rdi, rsi, rdx, r10, r8, r9  ->  rax, rdx

* Funcation call
  * rdi, rsi, rdx, rcx, r8, r9, (rsp)  ->  rax, rdx

* see:
  * glibc's sysdeps/unix/sysv/linux/x86_64/syscall.S
  * [x86-64 psABI](https://gitlab.com/x86-psABIs/x86-64-ABI)
