#! /bin/bash

header_(){
	cat >&3 <<EOM
#! /bin/bash
#PBS -S /bin/bash
#PBS -q batch
#PBS -j eo
#PBS -e $(pwd)/${i}.err 
#PBS -N ${prefix}-${i}
#PBS -l nodes=1:n_alberto:ppn=${ncpu}
#PBS -m n
#PBS -V
#PBS ${sbatchadd}

. /opt/modules/3.2.10/Modules/3.2.10/init/bash

export OMP_NUM_THREADS=${ncpu}
export MKL_NUM_THREADS=1
export TMPDIR=\${SCRATCH}

EOM
}
