
# Makefile for Armv8/aarch64

CPU     = $(shell uname -m)
ifeq "$(CPU)" "x86_64"
CC      = aarch64-linux-gnu-gcc
OBJDUMP = aarch64-linux-gnu-objdump
GDB     = gdb-multiarch
else
CC      = gcc
OBJDUMP = objdump
GDB     = gdb
endif


CFLAGS  += -g
ASFLAGS += -g -march=armv8.1-a		# armv8.1 for +lse
LDFLAGS += -static -pthread


include ../../../Makefile
