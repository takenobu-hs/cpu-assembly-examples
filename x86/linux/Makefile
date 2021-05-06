
# Makefile for x86_64

CC := gcc
OBJDUMP := objdump
LDFLAGS += -no-pie

TARGETS := $(basename $(wildcard *.S))


.PHONY: default
default:
	@echo "Use with arguments"

all : $(TARGETS)

%.disasm : %.S
	$(CC) -c $*.S
	$(OBJDUMP) -M intel -d $*.o

clean:
	rm -f *.o
	rm -f a.out

cleanexe:
	rm -f $(TARGETS)
