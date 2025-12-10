#! /bin/bash

init_g16a(){
    cat >&3 <<EOM
export LD_PRELOAD=
export g16root="/opt/software/g16A-\${NODETYPE}"
. \$g16root/g16/bsd/g16.profile
export GAUSS_SCRDIR=\${SLURM_TMPDIR}

EOM
}
