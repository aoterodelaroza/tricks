#! /bin/bash

run_density(){
    cat >&3 <<EOM
## instructions for MKL
export MKL_DEBUG_CPU_TYPE=5
export MKL_ENABLE_INSTRUCTIONS=AVX512

## run with srun to prevent overlap
export PMIX_MCA_psec=^munge
export PMIX_MCA_gds=^shmem2

##xx## For density: use pp.x on .rho.in and on .rhoae.in
srun \$A/pp.x < ${i}.rho.in > ${i}.rho.out
srun \$A/pp.x < ${i}.rhoae.in > ${i}.rhoae.out

EOM
}
