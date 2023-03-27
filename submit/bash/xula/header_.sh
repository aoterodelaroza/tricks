#! /bin/bash

header_(){
	cat >&3 <<EOM
#! /bin/bash
#SBATCH --job-name=${prefix}-${i}
#SBATCH --output=${i}.slurmout
#SBATCH --error=${i}.slurmerr
#SBATCH --partition=xulares
#SBATCH --qos=a
#SBATCH -N 1
#SBATCH -c 1
#SBATCH -n ${ncpu}
#SBATCH --time=3-00:00:00
#SBATCH --mem=0

EOM
}
