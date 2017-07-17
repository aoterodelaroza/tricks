FC=gcc
FCFLAGS=-g -fcheck=all -fbounds-check -ffpe-trap=invalid -fbacktrace -fdump-core -ffree-line-length-0 -cpp 
LDFLAGS=-lncursesw -lgfortran # dynamic
OBJS=ncurses.o wcharexample.o setlocale.o

%.o: %.f90
	$(FC) -c $(FCFLAGS) -o $@ $<

%.o: %.c
	$(FC) -c -o $@ $<

%.mod: %.o
	@if [ ! -f $@ ]; then rm $< ; $(MAKE) $< ; fi

all: wcharexample

clean:
	rm -f core *.mod *.o 

veryclean:
	rm -f core *.mod *.o wcharexample

wcharexample: $(OBJS)
	$(FC) -o wcharexample $(OBJS) $(LDFLAGS)

wcharexample.o: ncurses.mod
