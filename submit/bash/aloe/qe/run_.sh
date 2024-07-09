#! /bin/bash

run_(){
    cat >&3 <<EOM
## instructions for MKL
export MKL_DEBUG_CPU_TYPE=5
export MKL_ENABLE_INSTRUCTIONS=AVX512

## run with srun to prevent overlap
export PMIX_MCA_psec=^munge
export PMIX_MCA_gds=^shmem2

srun \$A/pw.x < ${i}.scf.in > ${i}.scf.out ${AMP}

EOM
}
