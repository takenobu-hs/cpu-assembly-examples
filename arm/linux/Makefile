
# Makefile for Armv8/aarch64

CC      = aarch64-linux-gnu-gcc
OBJDUMP = aarch64-linux-gnu-objdump
GDB     = gdb-multiarch

CFLAGS  += -g
ASFLAGS += -g -march=armv8.1-a		# armv8.1 for +lse
LDFLAGS += -static


include ../../../Makefile
