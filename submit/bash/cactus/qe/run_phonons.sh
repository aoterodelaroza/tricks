#! /bin/bash

run_phonons(){
    cat >&3 <<EOM
function ssrun {
    export LD_PRELOAD=\$(pwd)/libtrick.so
    time srun \$@
    export LD_PRELOAD=
}

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
export MKL_CBWR=AUTO

## run with srun to prevent overlap
export PMIX_MCA_psec=^munge
export PMIX_MCA_gds=^shmem2

##xx## For phonons: run ph.x and the rest of the programs
ssrun  \$A/ph.x < ${i}.ph.in > ${i}.ph.out
if [ -f "${i}.dynmat.in" ]; then
  ssrun  \$A/dynmat.x < ${i}.dynmat.in > ${i}.dynmat.out
fi
ssrun  \$A/q2r.x < ${i}.q2r.in > ${i}.q2r.out
ssrun  \$A/matdyn.x < ${i}.matdyn.in > ${i}.matdyn.out
rm -f trick.c libtrick.so

EOM
}
