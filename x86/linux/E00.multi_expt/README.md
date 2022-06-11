
Experiments with multithreading
===============================

## Shared-counter with atomicity

* counter_atomic.S
* counter_bad.S

```sh
$ ./counter_atomic

$ ./counter_bad
```


## Cache-line(s) with line-invalidation

* cacheline_same.S
* cacheline_different.S

```sh
$ perf stat -e "cycles,instructions,L1-dcache-loads,L1-dcache-load-misses" \
    ./cacheline_same 

$ perf stat -e "cycles,instructions,L1-dcache-loads,L1-dcache-load-misses" \
    ./cacheline_different
```

```sh
$ perf stat -e "cycles,instructions,L1-dcache-loads,L1-dcache-load-misses" \
    taskset --cpu-list 0,1 ./cacheline_same

$ perf stat -e "cycles,instructions,L1-dcache-loads,L1-dcache-load-misses" \
    taskset --cpu-list 0 ./cacheline_same
```
