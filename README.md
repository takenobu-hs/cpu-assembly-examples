
CPU assembly examples
=====================

* This is a repo about tiny assembly examples for various CPUs (x86, Arm, and RISC-V).
* There are examples such as system-calls, library-calls, load/store, if/for/call, barriers, atomics, and threads.
* This repo focuses on CPU hardwares, not assembly notation or ABI conventions.


## Contents

* [x86(x86_64)/linux](x86/linux)
* [Arm(Armv8 aarch64)/linux](arm/linux)
* [RISC-V(RV64G)/linux](riscv/linux)


## An example

100.main/simple_main.S:

```asm
        .global main

main:
        ret
```


## Assemble and excecute

```
$ cd <sample-directory>
$ make -f ../Makefile  <sample>             # assemble
$ ./<sample>                                # execute
```
