
# Makefile for Armv8/aarch64

CC := gcc
CC := aarch64-linux-gnu-gcc
OBJDUMP := aarch64-linux-gnu-objdump
LDFLAGS += -static

TARGETS := $(basename $(wildcard *.S))


.PHONY: default
default:
	@echo "Use with arguments"

all : $(TARGETS)

%.disasm : %.S
	$(CC) -c $*.S
	$(OBJDUMP) -d $*.o

clean:
	rm -f *.o
	rm -f a.out

cleanexe:
	rm -f $(TARGETS)
