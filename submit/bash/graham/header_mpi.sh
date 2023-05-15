#! /bin/bash

header_mpi(){
	cat >&3 <<EOM
#! /bin/bash
#SBATCH -t ${walltime}
#SBATCH -J ${prefix}-${i}
#SBATCH -D $(pwd)
#SBATCH -o ${i}.out
#SBATCH -e ${i}.err
#SBATCH -N 1
#SBATCH --ntasks-per-node ${ncpu}
#SBATCH -c 1
#SBATCH --mem=${mem}
#SBATCH --account=def-dilabiog-ac
#SBATCH ${sbatchadd}

EOM
}
