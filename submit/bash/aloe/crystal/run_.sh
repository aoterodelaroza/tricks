#! /bin/bash

run_(){
	cat >&3 <<EOM
export PMIX_MCA_psec=^munge
export PMIX_MCA_gds=^shmem2

cp -f ${i}.fort.34 fort.34 2>&1 > /dev/null

cp -f ${i}.d12 INPUT
srun /opt/software/crystal17/bin/Linux-gfortran_openmpi/v1.0.2/Pcrystal < ${i}.d12 >& ${i}.out
mv fort.34 ${i}.end.fort.34

# cp -f ${i}.d3 INPUT
# srun /opt/software/crystal17/bin/Linux-gfortran_openmpi/v1.0.2/Pproperties < ${i}.d3 >& ${i}.d3out

# cp fort.25 ${i}.f25
# /opt/software/crystal17/crgra2006/band06 ${i}

EOM
}
