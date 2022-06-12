
Performance experiments
=======================

## Instruction latencies

* latency_add.S
* latency_mul.S

```sh
$ perf stat -e "cycles,instructions" ./latency_add

$ perf stat -e "cycles,instructions" ./latency_mul
```

