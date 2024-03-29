
Experiments with multiprocessors
================================

## Cache-line(s) with line-invalidation

### cacheline_different.S

```sh
$ make -f ../Makefile cacheline_different
$ perf stat -e "cycles,instructions,L1-dcache-loads,L1-dcache-load-misses" \
    ./cacheline_different

        10,292,444      L1-dcache-loads
            24,106      L1-dcache-load-misses     #    0.23% of all L1-dcache accesses
```


### cacheline_same.S

```sh
$ make -f ../Makefile cacheline_same
$ perf stat -e "cycles,instructions,L1-dcache-loads,L1-dcache-load-misses" \
    ./cacheline_same

        10,331,779      L1-dcache-loads
         2,644,805      L1-dcache-load-misses     #   25.60% of all L1-dcache accesses
```

diff files:

```sh
$ diff cacheline_different.S cacheline_same.S
<         .space 64               /* padding for different cache-lines */
```



## Memory ordering

### ordering_unexpected.S

```sh
$ make -f ../Makefile ordering_unexpected
$ ./ordering_unexpected
child1(): UNEXPECTED!: r14 == 0 && r15 == 0; loop-variable = 342
child2(): UNEXPECTED!: r14 == 0 && r15 == 0; loop-variable = 342
```


### ordering_force.S

```sh
$ make -f ../Makefile ordering_force
$ ./ordering_force
child1(): finish: loop-variable = 5000000
child2(): finish: loop-variable = 5000000
```

diff files:

```sh
$ diff ordering_unexpected.S ordering_force.S
>         mfence                          /* force ordering */
```



## Shared-counter with atomicity

### counter_atomic.S

```sh
$ make -f ../Makefile counter_atomic

$ ./counter_atomic
main(): start
child1(): start
child2(): start
child2(): finish: loop-variable = 5000000
child1(): finish: loop-variable = 5000000
main(): finish: counter = 10000000
```

### counter_bad.S

```sh
$ make -f ../Makefile counter_bad

$ ./counter_bad
main(): start
child1(): start
child2(): start
child2(): finish: loop-variable = 5000000
child1(): finish: loop-variable = 5000000
main(): finish: counter = 7230454
```

diff files:

```sh
$ diff counter_atomic.S counter_bad.S
<         mov     rax, 1
<         lock xadd [rip + counter], rax
---
>         mov     rax, [rip + counter]
>         add     rax, 1
>         mov     [rip + counter], rax
>         sfence                          /* to read from cache (not store-buf)
```
