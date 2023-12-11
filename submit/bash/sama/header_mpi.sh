#! /bin/bash

header_mpi(){
	cat >&3 <<EOM
#! /bin/bash
#SBATCH -J ${prefix}-${i}
#SBATCH -o ${i}.sout
#SBATCH -e ${i}.serr
#SBATCH -N ${nnode}
#SBATCH --ntasks-per-node ${ncpu}
#SBATCH -c 1
#SBATCH ${sbatchadd}

export LMOD_SETTARG_CMD=":"
export LMOD_FULL_SETTARG_SUPPORT=no
export LMOD_COLORIZE=no
export LMOD_PREPEND_BLOCK=normal
export MODULEPATH=/opt/ohpc/pub/modulefiles
export BASH_ENV=/opt/ohpc/admin/lmod/lmod/init/bash
. /opt/ohpc/admin/lmod/lmod/init/bash
module try-add ohpc
export MODULEPATH=\${MODULEPATH}:/software/eb/modules/all:/software/eb/modules/toolchain

EOM
}
