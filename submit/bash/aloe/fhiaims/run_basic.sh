#! /bin/bash

run_basic(){
	cat >&3 <<EOM

mpirun /opt/software/FHIaims/bin/aims.230214.mpi.x < /dev/null > ${i}.out

EOM
}
