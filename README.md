
CPU assembly examples
=====================

This is a repo about tiny assembly examples for myself.
This repo focuses on CPU hardware, not assembly notation.


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
