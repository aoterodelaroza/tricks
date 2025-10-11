#! /bin/bash

run_(){
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
export MKL_CBWR=AUTO

export PMIX_MCA_psec=^munge
export PMIX_MCA_gds=^shmem2

eval "\$(/opt/software/conda/bin/conda shell.bash hook)"
conda activate mol-cspy

export LD_PRELOAD=\$(pwd)/libtrick.so
cspy-dma ${i}.xyz >& ${i}.dmaout
mpiexec cspy-csp ${i}.xyz -c ${i}_rank0.dma -m ${i}.dma -g fine10 >& ${i}.cspout
export LD_PRELOAD=

rm -f trick.c libtrick.so

EOM
}
