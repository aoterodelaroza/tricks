#! /bin/bash

run_(){
	cat >&3 <<EOM

mpirun /opt/software/FHIaims-220915_clean/build/aims.220915.mpi.x < /dev/null > ${i}.out

EOM
}
