#! /bin/bash

init_(){
    cat >&3 <<EOM
export g16root="/opt/software"
. \$g16root/g16/bsd/g16.profile
export GAUSS_SCRDIR=\${SLURM_TMPDIR}

EOM
}
