
# Makefile for common


TARGETS := $(basename $(wildcard *.S))


.PHONY: default
default:
	@echo "Use with arguments"

all : $(TARGETS)

%: %.S
	$(CC) $(ASFLAGS) $(LDFLAGS) $< -o $@

%.s : %.c
	$(CC) $(CFLAGS) -S $<

%.disasm : %
	$(OBJDUMP) $(OBJDUMPFLAGS) -D $<

%.o.disasm : %.o
	$(OBJDUMP) $(OBJDUMPFLAGS) -d $<


%.gdb : %
	$(GDB) -q -ex "layout regs" -ex "b main" $(GDBFLAGS) $<


clean:
	rm -f *.o
	rm -f a.out

cleanexe:
	rm -f $(TARGETS)
