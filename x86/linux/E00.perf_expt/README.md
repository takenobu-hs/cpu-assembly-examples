
Performance experiments
=======================

## Instruction latencies

* latency_add.S
* latency_mul.S
* latency_load.S

```sh
$ make -f ../Makefile latency_add
$ perf stat -e "cycles,instructions" ./latency_add

$ make -f ../Makefile latency_mul
$ perf stat -e "cycles,instructions" ./latency_mul

$ make -f ../Makefile latency_load
$ perf stat -e "cycles,instructions" ./latency_load
```

