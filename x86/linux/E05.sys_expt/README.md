
System experiments
==================

## I/O access

### io_read_rtc.S

```sh
$ make -f ../Makefile io_read_rtc

$ sudo ./io_read_rtc
rtc seconds = 51

$ sudo ./io_read_rtc
rtc seconds = 17
```

### io_read_pci.S

```sh
$ make -f ../Makefile io_read_pci

$ sudo ./io_read_pci
Vendor ID = 8086
```

### latency_io_read.S

```sh
$ make -f ../Makefile latency_io_read

$ perf stat -e "cycles,instructions" ./latency_io_read

    87,249,692,746      cycles
       127,360,444      instructions
```


## System call

### syscall_write.S

```sh
$ make -f ../Makefile syscall_write

$ ./syscall_write
hello, world
```


## Execption

### excep_load.S

```sh
$ make -f ../Makefile excep_load

$ ./excep_load
Segmentation fault (core dumped)
```

### excep_div.S

```sh
$ make -f ../Makefile excep_div

$ ./excep_div
Floating point exception (core dumped)
```
