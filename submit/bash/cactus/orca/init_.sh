#! /bin/bash

init_(){
    cat >&3 <<EOM
## trick for making MKL think this is an intel processor
cat > trick.c <<EOF
int mkl_serv_intel_cpu_true() {
        return 1;
}
EOF
gcc -shared -fPIC -o libtrick.so trick.c
export LD_PRELOAD=\$(pwd)/libtrick.so

## instructions for MKL
export MKL_DEBUG_CPU_TYPE=5
export MKL_ENABLE_INSTRUCTIONS=AVX512
export MKL_CBWR=AUTO

## run with srun to prevent overlap
export PMIX_MCA_psec=^munge
export PMIX_MCA_gds=^shmem2

# the correct version of openmpi for orca
. /opt/software/intel/oneapi/setvars.sh
export PATH=/opt/software/openmpi-4.1.8_intel/bin:\$PATH
export LD_LIBRARY_PATH=/opt/software/openmpi-4.1.8_intel/lib:\$LD_LIBRARY_PATH

# orca
export PATH=/opt/software/orca_6_1_0_avx2/:\$PATH
export LD_LIBRARY_PATH=/opt/software/orca_6_1_0_avx2/:\$LD_LIBRARY_PATH

EOM
}
