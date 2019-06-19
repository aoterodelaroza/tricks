#! /bin/bash

init_(){
    cat >&3 <<EOM
export CRY17_ROOT="/opt/uovi/alberto/crystal17"
export CRY17_BIN="bin"
export CRY17_ARCH="Linux-ifort"
export VERSION=""
export CRY17_SCRDIR="\${SCRATCH}"
export CRY17_EXEDIR="\$CRY17_ROOT/\$CRY17_BIN/\$CRY17_ARCH"
export CRY17_UTILS="\$CRY17_ROOT/utils17"
export PATH="\${PATH}:\${CRY17_EXEDIR}:\${CRY17_UTILS}"

EOM
}
