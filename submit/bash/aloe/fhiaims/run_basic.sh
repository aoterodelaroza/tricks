#! /bin/bash

run_basic(){
	cat >&3 <<EOM
## instructions for MKL
export MKL_DEBUG_CPU_TYPE=5
export MKL_ENABLE_INSTRUCTIONS=AVX512

export PMIX_MCA_psec=^munge
export PMIX_MCA_gds=^shmem2

srun /opt/software/FHIaims/bin/aims.230214.scalapack.mpi.x < /dev/null > ${i}.out

EOM
}
