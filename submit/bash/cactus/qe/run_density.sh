#! /bin/bash

run_density(){
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

##xx## For density: use pp.x on .rho.in and on .rhoae.in
ssrun \$A/pp.x < ${i}.rho.in > ${i}.rho.out
ssrun \$A/pp.x < ${i}.rhoae.in > ${i}.rhoae.out
rm -f trick.c libtrick.so

EOM
}
