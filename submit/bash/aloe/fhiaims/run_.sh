#! /bin/bash

run_(){
	cat >&3 <<EOM

mpirun /opt/software/FHIaims_XDM/bin/aims.220115.scalapack.mpi.x < /dev/null > ${i}.out

EOM
}
