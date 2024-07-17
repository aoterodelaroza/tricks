#! /bin/bash

init_qe65thermo(){
    cat >&3 <<EOM
module purge --force
module load intel/2024.2
module load mkl/2024.2
module load impi/2021.10.0
module load fftw/3.3.10
module load hdf5/1.14.1-2
module load quantumespresso/6.5

EOM
}
