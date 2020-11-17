#! /bin/bash

init_(){
    cat >&3 <<EOM
export ESPRESSO_TMPDIR=.

module load sandybridge/qespresso_6.6_intel20
export ESPRESSO_HOME=\${ESPRESSO_ROOT}
A=\$ESPRESSO_HOME/bin

EOM
}
