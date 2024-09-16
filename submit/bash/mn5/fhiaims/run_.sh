#! /bin/bash

run_(){
	cat >&3 <<EOM
time srun /home/udo/udo035583/project/FHIaims-xdm-stable/build/aims.240507.scalapack.mpi.x < /dev/null > ${i}.out

EOM
}
