#! /bin/bash

run_(){
	cat >&3 <<EOM
time srun /home/udo/udo035583/project/FHIaims/build/aims.230214.scalapack.mpi.x < /dev/null > ${i}.out

EOM
}
