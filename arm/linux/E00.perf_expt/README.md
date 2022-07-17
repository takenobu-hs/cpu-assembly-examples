
Performance experiments
=======================

## Instruction latencies

### latency_add.S

```sh
$ make -f ../Makefile latency_add
$ perf stat -e "cycles,instructions" ./latency_add

     1,003,740,164      cycles
     1,033,320,563      instructions              #    1.03  insn per cycle
```

### latency_mul.S

```sh
$ make -f ../Makefile latency_mul
$ perf stat -e "cycles,instructions" ./latency_mul

     5,013,165,523      cycles
     1,042,066,873      instructions              #    0.21  insn per cycle
```

### latency_load.S

```sh
$ make -f ../Makefile latency_load
$ perf stat -e "cycles,instructions" ./latency_load

     4,010,823,103      cycles
     1,039,938,754      instructions              #    0.26  insn per cycle
```


## Branch-prediction misses

### branch_miss_few.S

```sh
$ make -f ../Makefile branch_miss_few
$ perf stat -e "cycles,instructions,branch-misses" ./branch_miss_few

             9,382      branch-misses
```

### branch_miss_many.S

```sh
$ make -f ../Makefile branch_miss_many
$ perf stat -e "cycles,instructions,branch-misses" ./branch_miss_many

         5,008,736      branch-misses
```

diff files:

```sh
$ diff branch_miss_few.S branch_miss_many.S
<         cmp     x2, x2                  /* zero(eq) flag is always true */
---
>         cmp     x2, 0                   /* zero(eq) flag changes randomly */
```


## Cache misses (conflict-miss)

### cache_miss_few.S

```sh
$ make -f ../Makefile cache_miss_few
$ perf stat -e "cycles,instructions,L1-dcache-loads,L1-dcache-load-misses" \
    ./cache_miss_few

        10,537,602      L1-dcache-loads
             3,774      L1-dcache-load-misses     #    0.04% of all L1-dcache hits
```

### cache_miss_many.S

```sh
$ make -f ../Makefile cache_miss_many
$ perf stat -e "cycles,instructions,L1-dcache-loads,L1-dcache-load-misses" \
    ./cache_miss_many

        10,623,085      L1-dcache-loads
         9,846,872      L1-dcache-load-misses     #   92.69% of all L1-dcache hits
```

diff files:

```sh
$ diff cache_miss_few.S cache_miss_many.S
<         mov     x13, 64         /* stride is 64byte (cache-line size)   */
---
>         mov     x13, 4096       /* stride is 4Kbyte (cache-macro? size) */
```


## TLB misses (capacity-miss)

### tlb_miss_few.S

```sh
$ make -f ../Makefile tlb_miss_few
$ perf stat -e "cycles,instructions,L1-dcache-loads,dTLB-load-misses" \
    ./tlb_miss_few

       538,288,655      cycles
       802,071,287      instructions
       100,953,436      L1-dcache-loads
            11,671      dTLB-load-misses
```

### tlb_miss_many.S

```sh
$ make -f ../Makefile tlb_miss_many
$ perf stat -e "cycles,instructions,L1-dcache-loads,dTLB-load-misses" \
    ./tlb_miss_many

     4,052,938,587      cycles
       825,978,648      instructions
       109,003,552      L1-dcache-loads
        94,691,845      dTLB-load-misses
```

diff files:

```sh
$ diff tlb_miss_few.S tlb_miss_many.S
<         mov     x14, 0x0f               /* wrap for 16 times            */
---
>         mov     x14, 0x1fff             /* wrap for 8192 times          */
```
