#! /bin/bash

init_g16(){
    cat >&3 <<EOM
## g16
export g16root=/home/alberto/src
. \$g16root/g16/bsd/g16.profile
export GAUSS_SCRDIR=\$TMPDIR

## postg
module load gcc/9.1.0
export POSTG_HOME=/opt/uovi/alberto/postg
export PATH=\${PATH}:\${POSTG_HOME}
export OMP_NUM_THREADS=${ncpu}

## name for the run routine
export GAUPROGRAM=g16

EOM
}
