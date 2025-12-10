#! /bin/bash

header_omp(){
	cat >&3 <<EOM
#! /bin/bash
#SBATCH -J ${prefix}-${i}
#SBATCH -o ${i}.sout
#SBATCH -e ${i}.serr
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c ${ncpu}
#SBATCH ${sbatchadd}

if [ -f /etc/sie_ladon ]; then
   NODETYPE=sie_ladon
   export LD_PRELOAD=/opt/software/intel_mkl-2025.3.0.462/libmkl_amd_trick.so
#   export MKL_ENABLE_INSTRUCTIONS=AVX2
else
   NODETYPE=sr630
fi

EOM
}
