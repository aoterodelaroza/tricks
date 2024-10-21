#! /bin/bash

run_(){
	cat >&3 <<EOM
time srun /home/udo/udo035583/project/FHIaims-241018/build/aims.241018.scalapack.mpi.x < /dev/null > ${i}.out

EOM
}
