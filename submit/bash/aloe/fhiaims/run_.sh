#! /bin/bash

run_(){
	cat >&3 <<EOM

mpirun /opt/software/FHIaims-220915_clean/bin/aims.220915.scalapack.mpi.x < /dev/null > ${i}.out

EOM
}
