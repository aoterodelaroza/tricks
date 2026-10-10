#! /bin/bash

init_(){
    cat >&3 <<EOM
# MKL trick on AMD gives wrong results unless CBWR is pinned (see /opt/software/vasp-6.5.1_sie_ladon/BUILD_NOTES.md)
if [ "\$NODETYPE" == "sie_ladon" ]; then
   export MKL_CBWR=AVX2
fi

# openmp
export OMP_NUM_THREADS=${ncpu}
export MKL_NUM_THREADS=1
export MKL_DYNAMIC=FALSE
export OMP_STACKSIZE=512m

# critic2 (gfortran + system MKL, no GUI; the /opt/software/critic2 build needs libglfw, absent on the nodes)
export CRITIC_HOME=/home/alberto/git/critic2
CRITIC2=\${CRITIC_HOME}/build/src/critic2

EOM
}
