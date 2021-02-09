#! /bin/bash

init_(){
    cat >&3 <<EOM
export OMP_NUM_THREADS=1
export MKL_NUM_THREADS=1

module --force purge
module load nixpkgs/16.09
module load intel/2014.6
module load openmpi/2.1.1

export CRY17_ROOT="/home/alberto/src/crystal17"
export CRY17_BIN="bin"
export CRY17_ARCH="Linux-ifort"
export VERSION=""
export CRY17_SCRDIR="\$HOME/scratch"
export CRY17_EXEDIR="\$CRY17_ROOT/\$CRY17_BIN/\$CRY17_ARCH"
export CRY17_UTILS="\$CRY17_ROOT/utils17"
export CRY2K6_GRA="\$CRY17_ROOT/crgra2006"
export CRY17_TEST="\$CRY17_ROOT/test_cases/inputs"
export GRA6_EXEDIR="\$CRY2K6_GRA/bin/Linux-pgf"
export PATH="\${PATH}:\${CRY17_EXEDIR}:\${CRY17_UTILS}:\${CRY2K6_GRA}"

export TMPDIR=\${SLURM_TMPDIR}

EOM
}
