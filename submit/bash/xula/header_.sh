#! /bin/bash

header_(){
	cat >&3 <<EOM
#! /bin/bash
#SBATCH --job-name=${prefix}-${i}
#SBATCH --output=${i}.slurmout
#SBATCH --error=${i}.slurmerr
#SBATCH --partition=xulares
#SBATCH --qos=a
#SBATCH -N ${nnode}
#SBATCH -c 1
#SBATCH --ntasks-per-node ${ncpu}
#SBATCH --time=3-00:00:00

EOM
}
