#! /bin/bash

run_dos(){
    cat >&3 <<EOM
## instructions for MKL
export MKL_DEBUG_CPU_TYPE=5
export MKL_ENABLE_INSTRUCTIONS=AVX512

## run with srun to prevent overlap
export PMIX_MCA_psec=^munge
export PMIX_MCA_gds=^shmem2

srun  \$A/pw.x < ${i}.nscf.in > ${i}.nscf.out
srun  \$A/dos.x < ${i}.dos.in > ${i}.dos.out

EOM
}
