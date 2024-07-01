#! /bin/bash

run_phonons(){
    cat >&3 <<EOM
## trick for making MKL think this is an intel processor
cat > trick.c <<EOF
int mkl_serv_intel_cpu_true() {
        return 1;
}
EOF
gcc -shared -fPIC -o libtrick.so trick.c

## instructions for MKL
export MKL_DEBUG_CPU_TYPE=5
export MKL_ENABLE_INSTRUCTIONS=AVX512

## run with srun to prevent overlap
export PMIX_MCA_psec=^munge
export PMIX_MCA_gds=^shmem2

##xx## For phonons: run ph.x and the rest of the programs
LD_PRELOAD=./libtrick.so srun  \$A/ph.x < ${i}.ph.in > ${i}.ph.out
if [ -f "${i}.dynmat.in" ]; then
  LD_PRELOAD=./libtrick.so srun  \$A/dynmat.x < ${i}.dynmat.in > ${i}.dynmat.out
fi
LD_PRELOAD=./libtrick.so srun  \$A/q2r.x < ${i}.q2r.in > ${i}.q2r.out
LD_PRELOAD=./libtrick.so srun  \$A/matdyn.x < ${i}.matdyn.in > ${i}.matdyn.out
rm -f trick.c libtrick.so

EOM
}
