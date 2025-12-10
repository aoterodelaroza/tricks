#! /bin/bash

header_mpi(){
	cat >&3 <<EOM
#! /bin/bash
#SBATCH -J ${prefix}-${i}
#SBATCH -o ${i}.sout
#SBATCH -e ${i}.serr
#SBATCH -N ${nnode}
#SBATCH --ntasks-per-node ${ncpu}
#SBATCH -c 1
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
