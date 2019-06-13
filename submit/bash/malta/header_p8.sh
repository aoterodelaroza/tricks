#! /bin/bash

header_p8(){
	cat >&3 <<EOM
#! /bin/bash
#@ initialdir  = $(pwd)
#@ job_type    = mpich
#@ output      = ${i}.out
#@ error       = ${i}.err
#@ class       = plarge
#@ environment = COPY_ALL
#@ node       = 1
#@ tasks_per_node = 8
#@ ${sbatchadd}
#@ queue

. /opt/modules/3.2.10/Modules/3.2.10/init/bash

export OMP_NUM_THREADS=${nomp}
export MKL_NUM_THREADS=1

EOM
}
