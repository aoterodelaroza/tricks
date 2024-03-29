#! /bin/bash

init_aims(){
    cat >&3 <<EOM
module purge
module load StdEnv/2020
module load intel/2020.1.217 intelmpi/2019.7.217 imkl/2020.1.217
module load libxc/5.1.3
module load python/3.8.10
module load scipy-stack/2021a

export OMP_NUM_THREADS=1
export MKL_NUM_THREADS=1
export MKL_DYNAMIC=FALSE
ulimit -s unlimited

export PYTHONPATH=/home/alberto/git/ase:\$PYTHONPATH
export PATH=/home/alberto/git/ase/bin:\$PATH

export ASE_AIMS_COMMAND='srun /home/alberto/src/FHIaims_XDM/build/aims.210513.scalapack.mpi.x'
export AIMS_SPECIES_DIR='/home/alberto/src/FHIaims_XDM/species_defaults/lightdense'

EOM
}
