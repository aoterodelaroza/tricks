#! /bin/bash

header_mpi(){
	cat >&3 <<EOM
#! /bin/bash
#PBS -l walltime=${walltime},select=1:ncpus=${ncpu}:mpiprocs=${ncpu}:mem=${mem}
#PBS -N ${prefix}-${i}
#PBS -A dri-dilabio
#PBS -j eo
#PBS -e $(pwd)/${i}.err 
#PBS ${sbatchadd}

EOM
}
