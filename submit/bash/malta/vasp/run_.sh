#! /bin/bash

run_(){
	cat >&3 <<EOM
/opt/openmpi/1.8.4/bin/mpirun -np ${ncpu} /opt/vasp/5.4.1/vasp 2>&1 > ${i}.out ${AMP}

EOM
}
