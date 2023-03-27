#! /bin/bash

header_(){
	cat >&3 <<EOM
#! /bin/bash
#SBATCH -J ${prefix}-${i}
#SBATCH -o ${i}.out
#SBATCH -e ${i}.err
#SBATCH -N ${nnode}
#SBATCH --ntasks-per-node ${ncpu}
#SBATCH -c 1
#SBATCH ${sbatchadd}

rm \${SLURM_TMPDIR}/*
export PATH=./:~/bin:/usr/local/bin:/usr/bin:/bin:/sbin:/usr/sbin

EOM
}
