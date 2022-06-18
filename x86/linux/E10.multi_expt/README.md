
Experiments with multithreading
===============================

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
<         lock xadd [rip + counter], rax  /* increment the shared-counter */
---
>         mov     rax, [rip + counter]
>         add     rax, 1
>         mov     [rip + counter], rax    /* increment the shared-counter */
```



## Cache-line(s) with line-invalidation

### cacheline_different.S

```sh
$ make -f ../Makefile cacheline_different
$ perf stat -e "cycles,instructions,L1-dcache-loads,L1-dcache-load-misses" \
    ./cacheline_different

        20,321,569      L1-dcache-loads
            26,097      L1-dcache-load-misses     #    0.13% of all L1-dcache accesses
```


### cacheline_same.S

```sh
$ make -f ../Makefile cacheline_same
$ perf stat -e "cycles,instructions,L1-dcache-loads,L1-dcache-load-misses" \
    ./cacheline_same

        20,400,035      L1-dcache-loads
         9,191,588      L1-dcache-load-misses     #   45.06% of all L1-dcache accesses
```

diff files:

```sh
$ diff cacheline_different.S cacheline_same.S
<         .space 64               /* padding for different cache-lines */
```
