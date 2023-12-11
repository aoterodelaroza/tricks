#! /bin/bash

run_(){
	cat >&3 <<EOM
mpirun /home/alberto/src/vasp-5.4.4.pl2/build/std/vasp

EOM
}
