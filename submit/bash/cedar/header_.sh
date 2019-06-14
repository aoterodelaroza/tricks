#! /bin/bash

header_(){
	cat >&3 <<EOM
#! /bin/bash
#SBATCH -t ${walltime}
#SBATCH -J ${prefix}-${i}
#SBATCH -D $(pwd)
#SBATCH -o ${i}.out
#SBATCH -e ${i}.err
#SBATCH -N 1 
#SBATCH -n ${ncpu}
#SBATCH -c 1
#SBATCH --mem-per-cpu=${mempercpu}
#SBATCH --account=ctb-dilabiog
#SBATCH ${sbatchadd}

EOM
}
