#! /bin/bash

init_(){
    cat >&3 <<EOM
# gaussian
if [ -f /etc/sie_ladon ] ; then
    export g16root="/opt/software/g16A-sie_ladon"
elif [ -f /etc/sr630 ] ; then
    export g16root="/opt/software/g16A-sr630"
else
    echo "could not found ID file in /etc"
    exit
fi
. \$g16root/g16/bsd/g16.profile
export GAUSS_SCRDIR=\${SLURM_TMPDIR}

# rest
unset I_MPI_PMI_LIBRARY
export OMP_NUM_THREADS=1
export MKL_NUM_THREADS=1
export MKL_DYNAMIC=FALSE
export CRITIC_HOME="/home/alberto/git/critic2"
ulimit -s unlimited

EOM
}
