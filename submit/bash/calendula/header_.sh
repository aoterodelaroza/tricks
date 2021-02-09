#! /bin/bash

header_(){
	cat >&3 <<EOM
#! /bin/bash
#SBATCH --job-name=${prefix}-${i}
#SBATCH --output=${i}.slurmout
#SBATCH --error=${i}.slurmerr
#SBATCH --partition=res
#SBATCH --qos=class_a
#SBATCH --nodes=1-1
#SBATCH --ntasks-per-node=${ncpu}
#SBATCH --time=3-00:00:00
#SBATCH --mem=0

. /etc/profile.d/modules.sh

EOM
}
