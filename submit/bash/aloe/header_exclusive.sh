#! /bin/bash

header_exclusive(){
	cat >&3 <<EOM
#! /bin/bash
#SBATCH -J ${prefix}-${i}
#SBATCH -o ${i}.sout
#SBATCH -e ${i}.serr
#SBATCH -N ${nnode}
#SBATCH --exclusive
#SBATCH ${sbatchadd}

EOM
}
