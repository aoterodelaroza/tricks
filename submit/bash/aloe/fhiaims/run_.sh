#! /bin/bash

run_(){
	cat >&3 <<EOM

mpirun /opt/software/FHIaims_XDM/bin/aims.210513.scalapack.mpi.x < /dev/null > ${i}.out

EOM
}
