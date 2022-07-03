
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
