
# Makefile for RISC-V/RV64G

CC := riscv64-unknown-linux-gnu-gcc
OBJDUMP := riscv64-unknown-linux-gnu-objdump
LDFLAGS += -static
CFLAGS += -march=rv64g		# without rv64c (compact instruction)

TARGETS := $(basename $(wildcard *.S))


.PHONY: default
default:
	@echo "Use with arguments"

all : $(TARGETS)

%.disasm : %.S
	$(CC) $(CFLAGS) -c $*.S
	$(OBJDUMP) -d $*.o

clean:
	rm -f *.o
	rm -f a.out

cleanexe:
	rm -f $(TARGETS)
