
# Makefile for x86_64

CC      = gcc
OBJDUMP = objdump
GDB     = gdb

CFLAGS       += -g -masm=intel
ASFLAGS      += -g
LDFLAGS      += -no-pie
OBJDUMPFLAGS += -M intel
GDBFLAGS     += -ex "set disassembly-flavor intel"


include ../../../Makefile
