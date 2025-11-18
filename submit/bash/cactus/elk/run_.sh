#! /bin/bash

run_(){
    cat >&3 <<EOM
function ssrun {
    export LD_PRELOAD=\$(pwd)/libtrick.so
    time mpirun --bind-to none \$@
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

ssrun /opt/software/elk-10.6.11/src/elk 2>&1 > elk.out ${AMP}
rm -f trick.c libtrick.so

EOM
}
