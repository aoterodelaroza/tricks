#! /bin/bash

run_(){
	cat >&3 <<EOM

mpirun /opt/software/vasp-5.4.4.pl2/bin/vasp_std

EOM
}
