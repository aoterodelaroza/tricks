BINS=main
OBJS=main.o fmod.o c_interface_module.o
FC = gfortran
CC = gcc
FCFLAGS = -g -fbounds-check -Wall -ffpe-trap=invalid -fbacktrace -fdump-core
CCFLAGS = -g -fbounds-check -Wall 
LDFLAGS = -g 

%.o: %.f90
	$(FC) -c $(FCFLAGS) -o $@ $<

%.o: %.f
	$(FC) -c $(FCFLAGS) -o $@ $<

%.o: %.c
	$(CC) -c $(CCFLAGS) -I ./ -o $@ $<

%.mod: %.o
	@if [ ! -f $@ ]; then rm $< ; $(MAKE) $< ; fi

# General targets

all: $(BINS)

clean:
	rm -f core *.mod *.o 

mrproper:
	rm -f core *.mod *.o $(BINS) $(BINS_dbg)

# Binary dependencies
main: $(OBJS)
	$(FC) -o ffromc $(LDFLAGS) $(OBJS)

# Object dependencies
main.o : fmod.mod
fmod.o : c_interface_module.mod

# dummy
dummy: 
	@true
