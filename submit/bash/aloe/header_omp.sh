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

rm \${SLURM_TMPDIR}/*
export PATH=./:~/bin:/usr/local/bin:/usr/bin:/bin:/sbin:/usr/sbin

EOM
}
