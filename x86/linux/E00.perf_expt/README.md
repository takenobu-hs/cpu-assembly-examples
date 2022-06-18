
Performance experiments
=======================

## Instruction latencies

### latency_add.S

```sh
$ make -f ../Makefile latency_add
$ perf stat -e "cycles,instructions" ./latency_add

     1,001,378,100      cycles
     1,031,040,746      instructions              #    1.03  insn per cycle
```

### latency_mul.S

```sh
$ make -f ../Makefile latency_mul
$ perf stat -e "cycles,instructions" ./latency_mul

     3,002,220,151      cycles
     1,031,501,374      instructions              #    0.34  insn per cycle
```

### latency_load.S

```sh
$ make -f ../Makefile latency_load
$ perf stat -e "cycles,instructions" ./latency_load

     4,002,179,368      cycles
     1,031,642,273      instructions              #    0.26  insn per cycle
```


## Branch-prediction misses

### branch_miss_few.S

```sh
$ make -f ../Makefile branch_miss_few
$ perf stat -e "cycles,instructions,branches,branch-misses" ./branch_miss_few

        20,155,446      branches
             6,666      branch-misses             #    0.03% of all branches
```

### branch_miss_many.S

```sh
$ make -f ../Makefile branch_miss_many
$ perf stat -e "cycles,instructions,branches,branch-misses" ./branch_miss_many

        20,166,111      branches
         5,007,361      branch-misses             #   24.83% of all branches
```

diff files:

```sh
$ diff branch_miss_few.S branch_miss_many.S
<         cmp     r10, r10                /* zero(eq) flag is always true   */
---
>         and     r10, 1                  /* zero(eq) flag changes randomly */

```


## Cache misses (conflict-miss)

### cache_miss_few.S

```sh
$ make -f ../Makefile cache_miss_few
$ perf stat -e "cycles,instructions,L1-dcache-loads,L1-dcache-load-misses" \
    ./cache_miss_few

        10,214,893      L1-dcache-loads
            14,137      L1-dcache-load-misses     #    0.14% of all L1-dcache accesses
```

### cache_miss_many.S

```sh
$ make -f ../Makefile cache_miss_many
$ perf stat -e "cycles,instructions,L1-dcache-loads,L1-dcache-load-misses" \
    ./cache_miss_many

        10,217,855      L1-dcache-loads
         9,569,636      L1-dcache-load-misses     #   93.66% of all L1-dcache accesses
```

diff files:

```sh
$ diff branch_miss_few.S branch_miss_many.S
<         mov     r12, 64         /* stride is 64byte (cache-line size)   */
---
>         mov     r12, 2048       /* stride is 2Kbyte (cache-macro? size) */
```
