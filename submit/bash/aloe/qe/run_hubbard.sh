#! /bin/bash

run_hubbard(){
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

##xx## For hubbard: run the scf, scf2, and hp
LD_PRELOAD=./libtrick.so srun  \$A/pw.x < ${i}.scf2.in > ${i}.scf2.out
LD_PRELOAD=./libtrick.so srun  \$A/hp.x < ${i}.hp.in > ${i}.hp.out
rm -f trick.c libtrick.so

EOM
}
