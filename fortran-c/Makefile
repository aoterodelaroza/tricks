BINS=cfromf
OBJS=called_from_fortran.o fortran_uses_c.o
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

varbas.o topcalc.o setvariables.o gnuplot_templates.o gibbs2.o fit.o evfunc.o eos.o debye.o : tools.mod
varbas.o topcalc.o setvariables.o gibbs2.o fit.o eos.o debye.o : evfunc.mod
varbas.o gibbs2.o : fit.mod
topcalc.o setvariables.o gnuplot_templates.o gibbs2.o eos.o debye.o : varbas.mod
topcalc.o gibbs2.o debye.o : eos.mod
topcalc.o gibbs2.o : debye.mod
topcalc.o : gnuplot_templates.mod
gibbs2.o : topcalc.mod

# dummy
dummy: 
	@true
