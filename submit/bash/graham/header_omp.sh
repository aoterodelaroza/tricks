#! /bin/bash

header_omp(){
	cat >&3 <<EOM
#! /bin/bash
#SBATCH -t ${walltime}
#SBATCH -J ${prefix}-${i}
#SBATCH -D $(pwd)
#SBATCH -o ${i}.out
#SBATCH -e ${i}.err
#SBATCH -N 1 
#SBATCH -n 1
#SBATCH -c ${ncpu}
#SBATCH --mem=${mem}
#SBATCH --account=def-dilabiog-ac
#SBATCH ${sbatchadd}

EOM
}
