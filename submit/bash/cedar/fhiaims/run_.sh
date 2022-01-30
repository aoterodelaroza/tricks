#! /bin/bash

run_(){
	cat >&3 <<EOM

srun /home/alberto/src/FHIaims_XDM/build/aims.210513.scalapack.mpi.x < /dev/null > ${i}.out

EOM
}
