
# Makefile for RISC-V/RV64G

CC      = riscv64-unknown-linux-gnu-gcc
OBJDUMP = riscv64-unknown-linux-gnu-objdump
GDB     = riscv64-unknown-linux-gnu-gdb

CFLAGS  += -g -march=rv64g		# without rv64c (compact instruction)
ASFLAGS += -g
LDFLAGS += -static -pthread


include ../../../Makefile
