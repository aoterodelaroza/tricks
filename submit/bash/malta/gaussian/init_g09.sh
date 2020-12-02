#! /bin/bash

init_g09(){
    cat >&3 <<EOM
## g09
export g09root=/opt/uovi/alberto
. \$g09root/g09/bsd/g09.profile
export GAUSS_SCRDIR=\$TMPDIR

## postg
export POSTG_HOME=/opt/uovi/alberto/postg
export PATH=\${PATH}:\${POSTG_HOME}
export OMP_NUM_THREADS=${ncpu}

## name for the run routine
export GAUPROGRAM=g09

EOM
}
