BINS=cfromf
OBJS=called_from_fortran.o fortran_uses_c.o flibc.o
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
	$(CC) -c $(CCFLAGS) -o $@ $<

%.mod: %.o
	@if [ ! -f $@ ]; then rm $< ; $(MAKE) $< ; fi

# General targets

all: $(BINS)

clean:
	rm -f core *.mod *.o 

mrproper:
	rm -f core *.mod *.o $(BINS) $(BINS_dbg)

# Binary dependencies
cfromf: $(OBJS)
	$(FC) -o cfromf $(LDFLAGS) $(OBJS)

# Object dependencies
## bleh.o : param.mod
fortran_uses_c.o : flibc.mod

# dummy
dummy: 
	@true
