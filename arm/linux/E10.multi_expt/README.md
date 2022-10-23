
Experiments with multiprocessors
================================

## Cache-line(s) with line-invalidation

### cacheline_different.S

```sh
$ make -f ../Makefile cacheline_different
$ perf stat -e "cycles,instructions,L1-dcache-loads,L1-dcache-load-misses" \
    ./cacheline_different

        20,984,095      L1-dcache-loads
            11,795      L1-dcache-load-misses     #    0.06% of all L1-dcache hits
```


### cacheline_same.S

```sh
$ make -f ../Makefile cacheline_same
$ perf stat -e "cycles,instructions,L1-dcache-loads,L1-dcache-load-misses" \
    ./cacheline_same

        21,080,723      L1-dcache-loads
         4,955,727      L1-dcache-load-misses     #   23.51% of all L1-dcache hits
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
child1(): UNEXPECTED!: x14 == 0 && x15 == 0; loop-variable = 543
child2(): UNEXPECTED!: x14 == 0 && x15 == 0; loop-variable = 543
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
>         dmb     sy                      /* FORCE ORDERING */
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
child1(): finish: loop-variable = 5000000
child2(): finish: loop-variable = 5000000
main(): finish: counter = 5044589
```

diff files:

```sh
$ diff counter_atomic.S counter_bad.S
84c84
<         ldxr    x14, [x10]
---
>         ldr     x14, [x10]
86c86
<         stxr    w2, x14, [x10]
---
>         str     x14, [x10]
88d87
<         cbnz    w2, L1_loop
```
