#! /bin/bash

run_(){
	cat >&3 <<EOM

/home/alberto/openmpi-4.0.4/bin/mpirun --mca btl_sm_use_knem 0 --mca btl_vader_single_copy_mechanism none -np ${ncpu} /home/alberto/src/FHIaims_XDM/build/aims.210513.mpi.x < /dev/null > ${i}.out ${AMP}

EOM
}
