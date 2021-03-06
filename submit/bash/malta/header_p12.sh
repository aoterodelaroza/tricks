#! /bin/bash

header_p12(){
	cat >&3 <<EOM
#! /bin/bash
#@ initialdir  = $(pwd)
#@ job_type    = mpich
#@ output      = ${i}.out
#@ error       = ${i}.err
#@ class       = p12large
#@ environment = COPY_ALL
#@ node       = 1
#@ tasks_per_node = 12
#@ queue

. /opt/modules/3.2.10/Modules/3.2.10/init/bash

export OMP_NUM_THREADS=${ncpu}
export MKL_NUM_THREADS=1
export TMPDIR=\${SCRATCH}

EOM
}
