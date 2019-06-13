#! /bin/bash

header_(){
	cat >&3 <<EOM
#! /bin/bash
#PBS -S /bin/bash
#PBS -j eo
#PBS -e $(pwd)/${i}.err 
#PBS -N ${prefix}-${i}
#PBS -l walltime=${walltime},mem=${mem},nodes=1:ppn=${nomp}
#PBS -m n
#PBS ${sbatchadd}

EOM
}
