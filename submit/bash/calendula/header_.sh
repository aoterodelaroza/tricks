#! /bin/bash

header_(){
	cat >&3 <<EOM
#! /bin/bash
#SBATCH --job-name=${prefix}-${i}
#SBATCH --output=${i}.out
#SBATCH --error=${i}.err
#SBATCH --partition=res
#SBATCH --qos=class_a
#SBATCH --nodes=1-1
#SBATCH --ntasks-per-node=${ncpu}
#SBATCH --time=3-00:00:00
#SBATCH --mem=0

EOM
}
