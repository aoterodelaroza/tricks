#! /bin/bash

run_(){
	cat >&3 <<EOM

srun /home/alberto/src/XDM_FHIaims_B86b_constant_c6/build/aims.210513.scalapack.mpi.x < /dev/null > ${i}.out

EOM
}
