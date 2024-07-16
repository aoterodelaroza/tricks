#! /bin/bash

init_(){
    cat >&3 <<EOM
module purge --force
module load intel
module load mkl
module load impi
module load fftw/3.3.10 
module load quantumespresso/7.3.1

EOM
}
