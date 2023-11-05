#! /bin/bash

header_omp(){
	cat >&3 <<EOM
#! /bin/bash
#SBATCH -t ${walltime}
#SBATCH -J ${prefix}-${i}
#SBATCH -o ${i}.out
#SBATCH -e ${i}.err
#SBATCH -N 1
#SBATCH --ntasks-per-node 1
#SBATCH -c ${ncpu}
#SBATCH --mem-per-cpu=${mempercpu}
#SBATCH --account=${account}
EOM
	if [ -n "$partition" ] ; then
	    echo "#SBATCH --partition=${partition}" >&3
	fi
	cat >&3 <<EOM
#SBATCH ${sbatchadd}

EOM
}
