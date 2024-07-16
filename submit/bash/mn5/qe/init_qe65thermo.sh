#! /bin/bash

init_qe65thermo(){
    cat >&3 <<EOM
module purge --force
module load intel/2024.2
module load mkl/2024.2
module load impi/2021.10.0
module load fftw/3.3.10
export PATH=/gpfs/projects/udo97/espresso-6.5_thermo/bin/:\$PATH

EOM
}
